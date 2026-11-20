## Medizinische Informationssysteme – Antikörperbestimmung

## Projektbeschreibung

Dieses Projekt wurde im Rahmen der Lehrveranstaltung **Medizinische Informationssysteme** entwickelt.

Es bildet den Ablauf einer Antikörperuntersuchung zwischen einer Hausarztpraxis, einem Labor und der Buchhaltung ab.

Ein Patient besucht den Hausarzt, um seinen Antikörperstatus gegen Masern, Röteln, Varizellen oder Hepatitis B überprüfen zu lassen. Der Arzt dokumentiert den Besuch, erstellt einen Laborauftrag und veranlasst eine Blutabnahme.

Die Blutprobe wird an das Labor übermittelt. Dort werden die Untersuchungsergebnisse erfasst und in einem Laborbefund zusammengefasst. Anschließend werden die Ergebnisse an die Hausarztpraxis zurückgemeldet. Die Buchhaltung verwaltet die entsprechenden Leistungen und Rechnungen.

## Datenbankstruktur

Das System wurde mit **MySQL 8.0** umgesetzt und besteht aus drei Datenbankschemas mit insgesamt **34 Tabellen**.

- **hausarzt_db:** Verwaltung von Patienten, Ärzten, Benutzern, Arztbesuchen, Laboraufträgen und empfangenen Befunden.
- **labor_db:** Verwaltung von Laboraufträgen, Blutproben, Antikörpermessungen und Laborbefunden.
- **buchhaltung_db:** Verwaltung von Leistungen, Rechnungen und Rechnungspositionen.

Die Tabellen sind durch Primärschlüssel und Fremdschlüssel miteinander verbunden. Zusätzliche Integritätsregeln gewährleisten die Konsistenz der gespeicherten Daten.

## Technische Umsetzung

Die Datenbank läuft auf einem MySQL-Server in einer Docker-Umgebung auf einem Raspberry Pi und wird über MySQL Workbench verwaltet.

Das Projekt enthält ein UML-Domänenmodell, EER-Diagramme, die vollständige Datenbankstruktur, fiktive Beispieldaten und fünf SQL-Abfragen zur Darstellung der Beziehungen zwischen den Tabellen.

## Ausführung

Die vollständige SQL-Datei kann in MySQL Workbench auf einem MySQL-8.0-Server importiert werden. Sie enthält die Datenbankstruktur und die gespeicherten Beispieldaten.

Die SQL-Abfragen befinden sich in `Abfragen.sql` und können nach dem Import ausgeführt werden, um die Daten und ihre Beziehungen zu überprüfen.
