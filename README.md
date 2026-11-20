# README – Antikörperbestimmung

## 1. Projektbeschreibung

Dieses Projekt wurde im Rahmen der Lehrveranstaltung *Programming Lab I – From Domain Model to Relational Database* entwickelt.

Das Projekt bildet den medizinischen Ablauf einer Antikörperuntersuchung ab. Ein Patient besucht einen Hausarzt, um seinen Immunstatus gegen Masern, Röteln, Varizellen und Hepatitis B überprüfen zu lassen.

Der Arzt dokumentiert den Arztbesuch (Encounter), erstellt einen Laborauftrag und veranlasst die Blutabnahme. Die Blutprobe und die benötigten Patienteninformationen werden an das Laborinformationssystem (LIS) übermittelt.

Im Labor werden die Antikörperwerte untersucht, dokumentiert und in einem Laborbefund zusammengefasst. Anschließend wird der freigegebene Befund an die Hausarztpraxis zurückübermittelt. Die Buchhaltung verwaltet die erbrachten Leistungen und erstellt die entsprechende Rechnung.

## 2. Datenbankstruktur

Die relationale Datenbank wurde mit **MySQL 8.0** implementiert und besteht aus drei getrennten Datenbankschemas mit insgesamt **34 Tabellen**.

**hausarzt_db – 21 Tabellen**

Enthält Patientenstammdaten, Ärzte, Benutzer, Arztbesuche, Laboraufträge, Blutproben sowie empfangene Laborergebnisse und Befunde. Zusätzlich werden beispielsweise Adressen, Allergien, Impfungen und Krankengeschichte verwaltet.

**labor_db – 10 Tabellen**

Verwaltet die im Labor eingehenden Aufträge, Laborpatienten, Blutproben, Antikörpermessungen, Laboranten und Laborbefunde.

**buchhaltung_db – 3 Tabellen**

Enthält die abrechenbaren Leistungen, Rechnungen und die zugehörigen Rechnungspositionen.

## 3. Verwendete Technologien

- MySQL Server 8.0
- MySQL Workbench
- Docker
- Raspberry Pi 4
- SQL


## 4. Projektumfang

Bei diesem Projekt handelt es sich um einen Datenbankprototyp für Studienzwecke.

Die Implementierung bildet die Datenstruktur und die Beziehungen zwischen Hausarztpraxis, Labor und Buchhaltung ab.

Die Kommunikation zwischen den Systemen wird über externe Identifikatoren modelliert. Eine automatisierte Anbindung an echte medizinische Informationssysteme, Laborgeräte oder Abrechnungssysteme ist nicht Bestandteil dieser Implementierung.

Alle verwendeten Patientendaten sind fiktiv und dienen ausschließlich der Demonstration und Überprüfung der Datenbank.
