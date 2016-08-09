Die Mitglieder-Datenbank ist mit einem symmetrischen GPG-Passwort verschlüsselt. Das Passwort ist in der ```pass```-Datenbank abgelegt.

## Benutzung:

```bash
# Entschlüsseln
gpg2 --output memberdb.sqlite --decrypt memberdb.sqlite.gpg

# Bearbeiten
sqlite memberdb.sqlite

# Verschlüsseln
gpg2 --symmetric memberdb.sqlite
```
