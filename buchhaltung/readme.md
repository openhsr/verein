Die Buchhaltung ist mit einem symmetrischen GPG-Passwort verschlüsselt. Das Passwort ist in der ```pass```-Datenbank abgelegt.

## Benutzung

Die Buchhaltung kann nach dem entschlüsseln mittels der Banana Softwarei (www.banana.ch) geöffnet werden.

```bash
# Entschlüsseln
gpg2 --output buchhaltung_2019-2020.ac2 --decrypt buchhaltung_2019-2020.ac2.gpg

# Verschlüsseln
gpg2 --symmetric buchhaltung_2019-2020.ac2
```

