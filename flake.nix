{
  description = "verein devshell";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs =
    {
      nixpkgs,
      ...
    }:
    let
      systems = nixpkgs.lib.platforms.unix;
      eachSystem =
        f:
        nixpkgs.lib.genAttrs systems (
          system:
          f (
            import nixpkgs {
              inherit system;
              config = {
                allowUnfreePredicate =
                  pkg:
                  builtins.elem (nixpkgs.lib.getName pkg) [
                    "banana-accounting"
                  ];
              };
              overlays = [ ];
            }
          )
        );
    in
    {
      devShells = eachSystem (pkgs: {
        default = pkgs.mkShell {
          TYPST_FONT_PATHS = "${pkgs.lib.escapeShellArg pkgs.ubuntu-sans}";
          packages = with pkgs; [
            (writeShellScriptBin "sqlite-wrapped" ''
              ${lib.getExe rlwrap} ${lib.getExe sqlite} "$@"
            '')
            typst
            typstyle
            banana-accounting
          ];
          shellHook = ''
            unset SOURCE_DATE_EPOCH
          '';
        };
      });
    };
}
