Die Mitglieder-Datenbank ist mit einem symmetrischen GPG-Passwort verschlüsselt. Das Passwort ist in der ```pass```-Datenbank abgelegt.

## Benutzung

Zur einfachen Benutzung (entschlüsseln, Mitglied hinzufügen und verschlüsseln) kann das Skript `add_member.py` verwendet werden. (python >= 3.5!)

```bash
./add_member.py
```

## Manuelle Schritte

```bash
# Entschlüsseln
gpg2 --output memberdb.sqlite --decrypt memberdb.sqlite.gpg

# Bearbeiten
sqlite memberdb.sqlite

# Verschlüsseln
gpg2 --symmetric memberdb.sqlite
```

```sql
-- Neues Mitglied hinzufügen
INSERT INTO members (first_name,last_name,email,gender,github,active)
  VALUES ("Vorname", "Nachname", "die@mail", "m/w", "GITHUBUSER", 1);
```

