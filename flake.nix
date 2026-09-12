{
  description = "verein devshell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nele = {
      url = "github:omega-800/nele";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nele,
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
            typst
            typstyle
            nele.packages.${pkgs.stdenv.hostPlatform.system}.nele
            (pkgs.writeShellScriptBin "sqlite-wrapped" ''
              ${pkgs.lib.getExe pkgs.rlwrap} ${pkgs.lib.getExe pkgs.sqlite} "$@"
            '')
            # banana-accounting
          ];
          shellHook = ''
            unset SOURCE_DATE_EPOCH
          '';
        };
      });
    };
}
