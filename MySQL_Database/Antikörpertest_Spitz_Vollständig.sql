
CREATE DATABASE IF NOT EXISTS hausarzt_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE DATABASE IF NOT EXISTS labor_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE DATABASE IF NOT EXISTS buchhaltung_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;


USE hausarzt_db;

CREATE TABLE IF NOT EXISTS patient (
 patient_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
 titel VARCHAR(40) NULL,
 vorname VARCHAR(100) NOT NULL,
 zweiter_vorname VARCHAR(100) NULL,
 dritter_vorname VARCHAR(100) NULL,
 vierter_vorname VARCHAR(100) NULL,
 nachname VARCHAR(100) NOT NULL,
 geburtsdatum DATE NOT NULL,
 geburtsort VARCHAR(150) NULL,
 sozialversicherungsnummer VARCHAR(20) NULL,
 patientenstatus VARCHAR(20) NOT NULL DEFAULT 'aktiv',
 sterbedatum DATE NULL,
 created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 PRIMARY KEY (patient_id),
 UNIQUE KEY uq_patient_svnr (sozialversicherungsnummer),
 CONSTRAINT chk_patient_status CHECK (patientenstatus IN ('aktiv','inaktiv','verstorben'))
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS benutzer (
 user_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
 benutzername VARCHAR(80) NOT NULL,
 anzeige_name VARCHAR(160) NOT NULL,
 rolle VARCHAR(40) NOT NULL,
 aktiv BOOLEAN NOT NULL DEFAULT TRUE,
 created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 PRIMARY KEY (user_id),
 UNIQUE KEY uq_benutzername (benutzername)
) ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS arzt (
 arzt_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
 titel VARCHAR(40) NULL,
 vorname VARCHAR(100) NOT NULL,
 nachname VARCHAR(100) NOT NULL,
 fachrichtung VARCHAR(100) NULL,
 telefon VARCHAR(40) NULL,
 email VARCHAR(254) NULL,
 created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 PRIMARY KEY (arzt_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS ort (
 ort_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
 einrichtungsname VARCHAR(150) NOT NULL,
 ort_typ VARCHAR(40) NOT NULL,
 raum VARCHAR(50) NULL,
 strasse VARCHAR(120) NULL,
 hausnummer VARCHAR(20) NULL,
 plz VARCHAR(15) NULL,
 stadt VARCHAR(100) NULL,
 land VARCHAR(80) NULL,
 created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 PRIMARY KEY (ort_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS patient_details (
 details_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
 patient_id BIGINT UNSIGNED NOT NULL,
 geschlecht VARCHAR(40) NULL,
 religion VARCHAR(80) NULL,
 gueltig_ab DATETIME NULL,
 gueltig_bis DATETIME NULL,
 created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 PRIMARY KEY (details_id),
 KEY idx_details_patient (patient_id),
 CONSTRAINT fk_details_patient FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
 CONSTRAINT chk_details_gueltigkeit CHECK (gueltig_bis IS NULL OR gueltig_ab IS NULL OR gueltig_bis >= gueltig_ab)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS patient_adresse (
 adresse_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
 patient_id BIGINT UNSIGNED NOT NULL,
 strasse VARCHAR(120) NOT NULL,
 hausnummer VARCHAR(20) NOT NULL,
 stiege VARCHAR(20) NULL,
 stockwerk VARCHAR(20) NULL,
 tuernummer VARCHAR(20) NULL,
 plz VARCHAR(15) NOT NULL,
 stadt VARCHAR(100) NOT NULL,
 ort VARCHAR(100) NULL,
 bezirk VARCHAR(100) NULL,
 bundesland VARCHAR(100) NULL,
 land VARCHAR(80) NOT NULL DEFAULT 'Oesterreich',
 gueltig_ab DATETIME NULL,
 gueltig_bis DATETIME NULL,
 created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 PRIMARY KEY (adresse_id),
 KEY idx_adresse_patient (patient_id),
 CONSTRAINT fk_adresse_patient FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
 CONSTRAINT chk_adresse_gueltigkeit CHECK (gueltig_bis IS NULL OR gueltig_ab IS NULL OR gueltig_bis >= gueltig_ab)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS patient_kontakt (
 kontakt_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
 patient_id BIGINT UNSIGNED NOT NULL,
 telefon VARCHAR(40) NULL,
 telefon_weitere VARCHAR(40) NULL,
 email VARCHAR(254) NULL,
 bevorzugter_kontaktweg VARCHAR(30) NULL,
 gueltig_ab DATETIME NULL,
 gueltig_bis DATETIME NULL,
 created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 PRIMARY KEY (kontakt_id),
 KEY idx_kontakt_patient (patient_id),
 CONSTRAINT fk_kontakt_patient FOREIGN KEY (patient_id) REFERENCES patient(patient_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS patient_notfallkontakt (
 notfallkontakt_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
 patient_id BIGINT UNSIGNED NOT NULL,
 name VARCHAR(180) NOT NULL,
 beziehung VARCHAR(100) NULL,
 telefon VARCHAR(40) NULL,
 erreichbarkeit TEXT NULL,
 email VARCHAR(254) NULL,
 created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 PRIMARY KEY (notfallkontakt_id),
 CONSTRAINT fk_notfall_patient FOREIGN KEY (patient_id) REFERENCES patient(patient_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS patient_vertretung (
 vertretung_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
 patient_id BIGINT UNSIGNED NOT NULL,
 vorname VARCHAR(100) NOT NULL,
 nachname VARCHAR(100) NOT NULL,
 beziehung VARCHAR(100) NULL,
 vertretungsart VARCHAR(80) NULL,
 vertretungsumfang TEXT NULL,
 strasse VARCHAR(120) NULL,
 hausnummer VARCHAR(20) NULL,
 plz VARCHAR(15) NULL,
 stadt VARCHAR(100) NULL,
 land VARCHAR(80) NULL,
 telefon VARCHAR(40) NULL,
 email VARCHAR(254) NULL,
 gueltig_ab DATE NULL,
 gueltig_bis DATE NULL,
 created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 PRIMARY KEY (vertretung_id),
 CONSTRAINT fk_vertretung_patient FOREIGN KEY (patient_id) REFERENCES patient(patient_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS patient_versicherung (
 versicherung_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
 patient_id BIGINT UNSIGNED NOT NULL,
 versicherungstraeger VARCHAR(160) NOT NULL,
 versicherungsart VARCHAR(80) NULL,
 versicherungsstatus VARCHAR(40) NULL,
 anspruch_geprueft_am DATETIME NULL,
 gueltig_ab DATE NULL,
 gueltig_bis DATE NULL,
 mitversichert_bei VARCHAR(160) NULL,
 created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 PRIMARY KEY (versicherung_id),
 CONSTRAINT fk_versicherung_patient FOREIGN KEY (patient_id) REFERENCES patient(patient_id)
) ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS patient_allergie (
 allergie_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
 patient_id BIGINT UNSIGNED NOT NULL,
 allergen VARCHAR(160) NOT NULL,
 reaktion TEXT NULL,
 schweregrad VARCHAR(40) NULL,
 status VARCHAR(40) NULL,
 festgestellt_am DATE NULL,
 notiz TEXT NULL,
 created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 PRIMARY KEY (allergie_id),
 CONSTRAINT fk_allergie_patient FOREIGN KEY (patient_id) REFERENCES patient(patient_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS patient_krankengeschichte (
 krankengeschichte_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
 patient_id BIGINT UNSIGNED NOT NULL,
 krankheit VARCHAR(200) NULL,
 diagnosecode VARCHAR(40) NULL,
 chronisch BOOLEAN NULL,
 diagnose_am DATE NULL,
 krankheitsstatus VARCHAR(50) NULL,
 fruehere_operationen TEXT NULL,
 krankenhausaufenthalte TEXT NULL,
 familiaere_vorgeschichte TEXT NULL,
 fruehere_behandlungen TEXT NULL,
 medizinische_besonderheiten TEXT NULL,
 notiz TEXT NULL,
 dokumentiert_am DATETIME NULL,
 created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 PRIMARY KEY (krankengeschichte_id),
 CONSTRAINT fk_krankengeschichte_patient FOREIGN KEY (patient_id) REFERENCES patient(patient_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS patient_medikament (
 medikament_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
 patient_id BIGINT UNSIGNED NOT NULL,
 medikamentenname VARCHAR(160) NOT NULL,
 wirkstoff VARCHAR(160) NULL,
 dosierung VARCHAR(100) NULL,
 einnahmehaeufigkeit VARCHAR(100) NULL,
 beginn_am DATE NULL,
 ende_am DATE NULL,
 status VARCHAR(40) NULL,
 notiz TEXT NULL,
 created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 PRIMARY KEY (medikament_id),
 CONSTRAINT fk_medikament_patient FOREIGN KEY (patient_id) REFERENCES patient(patient_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS patient_impfung (
 impfung_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
 patient_id BIGINT UNSIGNED NOT NULL,
 impfstoff VARCHAR(160) NOT NULL,
 zielkrankheit VARCHAR(160) NULL,
 impfdatum DATE NULL,
 dosis_nummer SMALLINT UNSIGNED NULL,
 chargennummer VARCHAR(80) NULL,
 impfstelle VARCHAR(160) NULL,
 dokumentationsquelle VARCHAR(100) NULL,
 notiz TEXT NULL,
 created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 PRIMARY KEY (impfung_id),
 CONSTRAINT fk_impfung_patient FOREIGN KEY (patient_id) REFERENCES patient(patient_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS encounter (
 encounter_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
 patient_id BIGINT UNSIGNED NOT NULL,
 arzt_id BIGINT UNSIGNED NOT NULL,
 ort_id BIGINT UNSIGNED NULL,
 untersuchungsgrund VARCHAR(250) NOT NULL,
 beschwerden TEXT NULL,
 aktuelle_untersuchung TEXT NULL,
 aerztliche_beurteilung TEXT NULL,
 status VARCHAR(30) NOT NULL DEFAULT 'offen',
 begonnen_am DATETIME NOT NULL,
 beendet_am DATETIME NULL,
 dokumentiert_von BIGINT UNSIGNED NULL,
 dokumentiert_am DATETIME NULL,
 created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 PRIMARY KEY (encounter_id),
 CONSTRAINT fk_encounter_patient FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
 CONSTRAINT fk_encounter_arzt FOREIGN KEY (arzt_id) REFERENCES arzt(arzt_id),
 CONSTRAINT fk_encounter_ort FOREIGN KEY (ort_id) REFERENCES ort(ort_id),
 CONSTRAINT fk_encounter_user FOREIGN KEY (dokumentiert_von) REFERENCES benutzer(user_id),
 CONSTRAINT chk_encounter_zeiten CHECK (beendet_am IS NULL OR beendet_am >= begonnen_am)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS laborauftrag (
 auftrag_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
 patient_id BIGINT UNSIGNED NOT NULL,
 encounter_id BIGINT UNSIGNED NOT NULL,
 arzt_id BIGINT UNSIGNED NOT NULL,
 klinische_fragestellung TEXT NULL,
 aerztliche_anordnung TEXT NULL,
 prioritaet VARCHAR(30) NOT NULL DEFAULT 'normal',
 status VARCHAR(30) NOT NULL DEFAULT 'erstellt',
 angeordnet_am DATETIME NOT NULL,
 ans_labor_uebermittelt_am DATETIME NULL,
 created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 PRIMARY KEY (auftrag_id),
 CONSTRAINT fk_auftrag_patient FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
 CONSTRAINT fk_auftrag_encounter FOREIGN KEY (encounter_id) REFERENCES encounter(encounter_id),
 CONSTRAINT fk_auftrag_arzt FOREIGN KEY (arzt_id) REFERENCES arzt(arzt_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS laborauftrag_test (
 auftrag_test_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
 auftrag_id BIGINT UNSIGNED NOT NULL,
 test_code VARCHAR(50) NULL,
 test_name VARCHAR(160) NOT NULL,
 test_status VARCHAR(30) NOT NULL DEFAULT 'angefordert',
 bemerkung TEXT NULL,
 created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 PRIMARY KEY (auftrag_test_id),
 CONSTRAINT fk_auftrag_test_auftrag FOREIGN KEY (auftrag_id) REFERENCES laborauftrag(auftrag_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS blutprobe (
 probe_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
 auftrag_id BIGINT UNSIGNED NOT NULL,
 entnahme_ort_id BIGINT UNSIGNED NULL,
 entnommen_von BIGINT UNSIGNED NULL,
 proben_barcode VARCHAR(100) NOT NULL,
 probenart VARCHAR(80) NOT NULL DEFAULT 'Blut',
 roehrchentyp VARCHAR(100) NULL,
 status VARCHAR(30) NOT NULL DEFAULT 'entnommen',
 entnommen_am DATETIME NOT NULL,
 dokumentiert_am DATETIME NULL,
 created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 PRIMARY KEY (probe_id),
 UNIQUE KEY uq_probe_barcode (proben_barcode),
 CONSTRAINT fk_probe_auftrag FOREIGN KEY (auftrag_id) REFERENCES laborauftrag(auftrag_id),
 CONSTRAINT fk_probe_ort FOREIGN KEY (entnahme_ort_id) REFERENCES ort(ort_id),
 CONSTRAINT fk_probe_user FOREIGN KEY (entnommen_von) REFERENCES benutzer(user_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS empfangener_befund (
 befund_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
 patient_id BIGINT UNSIGNED NOT NULL,
 encounter_id BIGINT UNSIGNED NOT NULL,
 auftrag_id BIGINT UNSIGNED NOT NULL,
 externe_befund_id VARCHAR(100) NOT NULL,
 labor_name VARCHAR(160) NULL,
 gesamtbewertung TEXT NULL,
 befund_freitext TEXT NULL,
 befundstatus VARCHAR(30) NOT NULL,
 labor_freigegeben_am DATETIME NULL,
 empfangen_am DATETIME NOT NULL,
 erstellt_am TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 PRIMARY KEY (befund_id),
 UNIQUE KEY uq_empfangener_befund_extern (labor_name, externe_befund_id),
 CONSTRAINT fk_empfbef_patient FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
 CONSTRAINT fk_empfbef_encounter FOREIGN KEY (encounter_id) REFERENCES encounter(encounter_id),
 CONSTRAINT fk_empfbef_auftrag FOREIGN KEY (auftrag_id) REFERENCES laborauftrag(auftrag_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS empfangenes_laborergebnis (
 ergebnis_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
 befund_id BIGINT UNSIGNED NOT NULL,
 probe_id BIGINT UNSIGNED NOT NULL,
 auftrag_test_id BIGINT UNSIGNED NULL,
 externe_ergebnis_id VARCHAR(100) NULL,
 test_code VARCHAR(50) NULL,
 antikoerperart VARCHAR(160) NOT NULL,
 messwert DECIMAL(14,4) NULL,
 ergebnis_text VARCHAR(160) NULL,
 einheit VARCHAR(50) NULL,
 referenz_min DECIMAL(14,4) NULL,
 referenz_max DECIMAL(14,4) NULL,
 referenz_text VARCHAR(255) NULL,
 bewertung VARCHAR(160) NULL,
 messmethode VARCHAR(160) NULL,
 gemessen_am DATETIME NULL,
 created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 PRIMARY KEY (ergebnis_id),
 CONSTRAINT fk_empferg_befund FOREIGN KEY (befund_id) REFERENCES empfangener_befund(befund_id),
 CONSTRAINT fk_empferg_probe FOREIGN KEY (probe_id) REFERENCES blutprobe(probe_id),
 CONSTRAINT fk_empferg_test FOREIGN KEY (auftrag_test_id) REFERENCES laborauftrag_test(auftrag_test_id),
 CONSTRAINT chk_ergebnis_wert CHECK (messwert IS NOT NULL OR ergebnis_text IS NOT NULL)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS aenderungshistorie (
 aenderung_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
 tabellenname VARCHAR(100) NOT NULL,
 datensatz_id BIGINT UNSIGNED NOT NULL,
 feldname VARCHAR(100) NOT NULL,
 alter_wert TEXT NULL,
 neuer_wert TEXT NULL,
 geaendert_von BIGINT UNSIGNED NULL,
 geaendert_am TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 aenderungsgrund TEXT NULL,
 PRIMARY KEY (aenderung_id),
 KEY idx_audit_objekt (tabellenname, datensatz_id),
 CONSTRAINT fk_audit_user FOREIGN KEY (geaendert_von) REFERENCES benutzer(user_id)
) ENGINE=InnoDB;

USE labor_db;

CREATE TABLE IF NOT EXISTS labor (
 labor_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
 labor_name VARCHAR(160) NOT NULL,
 strasse VARCHAR(120) NULL,
 hausnummer VARCHAR(20) NULL,
 plz VARCHAR(15) NULL,
 stadt VARCHAR(100) NULL,
 telefon VARCHAR(40) NULL,
 email VARCHAR(254) NULL,
 created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 PRIMARY KEY (labor_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS laborant (
 laborant_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
 labor_id BIGINT UNSIGNED NOT NULL,
 name VARCHAR(160) NOT NULL,
 email VARCHAR(254) NULL,
 telefon VARCHAR(40) NULL,
 created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 PRIMARY KEY (laborant_id),
 CONSTRAINT fk_laborant_labor FOREIGN KEY (labor_id) REFERENCES labor(labor_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS labor_patient (
 labor_patient_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
 quellsystem VARCHAR(80) NOT NULL DEFAULT 'hausarzt_db',
 externe_patient_id BIGINT UNSIGNED NOT NULL,
 vorname VARCHAR(100) NOT NULL,
 zweiter_vorname VARCHAR(100) NULL,
 dritter_vorname VARCHAR(100) NULL,
 vierter_vorname VARCHAR(100) NULL,
 nachname VARCHAR(100) NOT NULL,
 geburtsdatum DATE NOT NULL,
 geschlecht VARCHAR(40) NULL,
 created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 PRIMARY KEY (labor_patient_id),
 UNIQUE KEY uq_labor_patient_extern (quellsystem, externe_patient_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS laborauftrag_lis (
 labor_auftrag_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
 labor_patient_id BIGINT UNSIGNED NOT NULL,
 labor_id BIGINT UNSIGNED NOT NULL,
 quellsystem VARCHAR(80) NOT NULL DEFAULT 'hausarzt_db',
 externe_auftrag_id BIGINT UNSIGNED NOT NULL,
 externe_arzt_id BIGINT UNSIGNED NULL,
 anfordernder_arzt_name VARCHAR(160) NULL,
 anfordernde_praxis VARCHAR(160) NULL,
 anfordernde_praxis_kontakt VARCHAR(160) NULL,
 aerztliche_anordnung TEXT NULL,
 klinische_angaben TEXT NULL,
 prioritaet VARCHAR(30) NOT NULL DEFAULT 'normal',
 status VARCHAR(30) NOT NULL DEFAULT 'eingegangen',
 angeordnet_am DATETIME NULL,
 im_labor_eingegangen_am DATETIME NULL,
 created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 PRIMARY KEY (labor_auftrag_id),
 UNIQUE KEY uq_laborauftrag_extern (quellsystem, externe_auftrag_id),
 CONSTRAINT fk_lisauftrag_patient FOREIGN KEY (labor_patient_id) REFERENCES labor_patient(labor_patient_id),
 CONSTRAINT fk_lisauftrag_labor FOREIGN KEY (labor_id) REFERENCES labor(labor_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS laborauftrag_test_lis (
 labor_test_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
 labor_auftrag_id BIGINT UNSIGNED NOT NULL,
 externe_auftrag_test_id BIGINT UNSIGNED NULL,
 test_code VARCHAR(50) NULL,
 test_name VARCHAR(160) NOT NULL,
 test_status VARCHAR(30) NOT NULL DEFAULT 'angefordert',
 created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 PRIMARY KEY (labor_test_id),
 CONSTRAINT fk_listest_auftrag FOREIGN KEY (labor_auftrag_id) REFERENCES laborauftrag_lis(labor_auftrag_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS laborprobe (
 labor_probe_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
 labor_auftrag_id BIGINT UNSIGNED NOT NULL,
 externe_probe_id BIGINT UNSIGNED NOT NULL,
 proben_barcode VARCHAR(100) NOT NULL,
 probenart VARCHAR(80) NOT NULL,
 roehrchentyp VARCHAR(100) NULL,
 entnommen_am DATETIME NOT NULL,
 eingegangen_am DATETIME NULL,
 probenzustand VARCHAR(100) NULL,
 status VARCHAR(30) NOT NULL DEFAULT 'eingegangen',
 ablehnungsgrund TEXT NULL,
 geprueft_von BIGINT UNSIGNED NULL,
 geprueft_am DATETIME NULL,
 created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 PRIMARY KEY (labor_probe_id),
 UNIQUE KEY uq_laborprobe_barcode (proben_barcode),
 CONSTRAINT fk_laborprobe_auftrag FOREIGN KEY (labor_auftrag_id) REFERENCES laborauftrag_lis(labor_auftrag_id),
 CONSTRAINT fk_laborprobe_laborant FOREIGN KEY (geprueft_von) REFERENCES laborant(laborant_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS laborergebnis (
 ergebnis_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
 labor_probe_id BIGINT UNSIGNED NOT NULL,
 labor_test_id BIGINT UNSIGNED NOT NULL,
 laborant_id BIGINT UNSIGNED NULL,
 antikoerperart VARCHAR(160) NOT NULL,
 test_code VARCHAR(50) NULL,
 messwert DECIMAL(14,4) NULL,
 ergebnis_text VARCHAR(160) NULL,
 einheit VARCHAR(50) NULL,
 referenz_min DECIMAL(14,4) NULL,
 referenz_max DECIMAL(14,4) NULL,
 referenz_text VARCHAR(255) NULL,
 bewertung VARCHAR(160) NULL,
 messmethode VARCHAR(160) NULL,
 ergebnis_status VARCHAR(30) NOT NULL DEFAULT 'vorlaeufig',
 gemessen_am DATETIME NOT NULL,
 created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 PRIMARY KEY (ergebnis_id),
 CONSTRAINT fk_laborergebnis_probe FOREIGN KEY (labor_probe_id) REFERENCES laborprobe(labor_probe_id),
 CONSTRAINT fk_laborergebnis_test FOREIGN KEY (labor_test_id) REFERENCES laborauftrag_test_lis(labor_test_id),
 CONSTRAINT fk_laborergebnis_laborant FOREIGN KEY (laborant_id) REFERENCES laborant(laborant_id),
 CONSTRAINT chk_laborergebnis_wert CHECK (messwert IS NOT NULL OR ergebnis_text IS NOT NULL)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS laborbefund (
 befund_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
 labor_auftrag_id BIGINT UNSIGNED NOT NULL,
 labor_id BIGINT UNSIGNED NOT NULL,
 befundnummer VARCHAR(100) NOT NULL,
 gesamtbewertung TEXT NULL,
 befund_freitext TEXT NULL,
 freigabestatus VARCHAR(30) NOT NULL DEFAULT 'vorlaeufig',
 freigegeben_von BIGINT UNSIGNED NULL,
 freigegeben_am DATETIME NULL,
 an_hausarzt_gesendet_am DATETIME NULL,
 created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 PRIMARY KEY (befund_id),
 UNIQUE KEY uq_befundnummer (befundnummer),
 CONSTRAINT fk_befund_lisauftrag FOREIGN KEY (labor_auftrag_id) REFERENCES laborauftrag_lis(labor_auftrag_id),
 CONSTRAINT fk_befund_labor FOREIGN KEY (labor_id) REFERENCES labor(labor_id),
 CONSTRAINT fk_befund_freigabe FOREIGN KEY (freigegeben_von) REFERENCES laborant(laborant_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS befund_ergebnis (
 befund_id BIGINT UNSIGNED NOT NULL,
 ergebnis_id BIGINT UNSIGNED NOT NULL,
 PRIMARY KEY (befund_id, ergebnis_id),
 CONSTRAINT fk_befunderg_befund FOREIGN KEY (befund_id) REFERENCES laborbefund(befund_id),
 CONSTRAINT fk_befunderg_ergebnis FOREIGN KEY (ergebnis_id) REFERENCES laborergebnis(ergebnis_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS aenderungshistorie (
 aenderung_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
 tabellenname VARCHAR(100) NOT NULL,
 datensatz_id BIGINT UNSIGNED NOT NULL,
 feldname VARCHAR(100) NOT NULL,
 alter_wert TEXT NULL,
 neuer_wert TEXT NULL,
 geaendert_von_laborant_id BIGINT UNSIGNED NULL,
 geaendert_am TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 aenderungsgrund TEXT NULL,
 PRIMARY KEY (aenderung_id),
 CONSTRAINT fk_lis_audit_laborant FOREIGN KEY (geaendert_von_laborant_id) REFERENCES laborant(laborant_id)
) ENGINE=InnoDB;


USE buchhaltung_db;

CREATE TABLE IF NOT EXISTS leistung (
 leistung_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
 leistungscode VARCHAR(60) NULL,
 beschreibung VARCHAR(250) NOT NULL,
 preis DECIMAL(10,2) NOT NULL,
 created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 PRIMARY KEY (leistung_id),
 CONSTRAINT chk_leistung_preis CHECK (preis >= 0)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS rechnung (
 rechnung_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
 rechnungsnummer VARCHAR(60) NOT NULL,
 quellsystem VARCHAR(80) NOT NULL DEFAULT 'hausarzt_db',
 externe_patient_id BIGINT UNSIGNED NOT NULL,
 externe_encounter_id BIGINT UNSIGNED NULL,
 externe_auftrag_id BIGINT UNSIGNED NULL,
 rechnungsempfaenger_name VARCHAR(200) NOT NULL,
 rechnungsanschrift TEXT NULL,
 status VARCHAR(30) NOT NULL DEFAULT 'entwurf',
 rechnungsdatum DATE NOT NULL,
 faellig_am DATE NULL,
 bezahlt_am DATETIME NULL,
 bemerkung TEXT NULL,
 created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 PRIMARY KEY (rechnung_id),
 UNIQUE KEY uq_rechnungsnummer (rechnungsnummer)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS rechnungsposition (
 position_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
 rechnung_id BIGINT UNSIGNED NOT NULL,
 leistung_id BIGINT UNSIGNED NULL,
 beschreibung VARCHAR(250) NOT NULL,
 anzahl DECIMAL(10,2) NOT NULL DEFAULT 1,
 einzelpreis DECIMAL(10,2) NOT NULL,
 created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 PRIMARY KEY (position_id),
 CONSTRAINT fk_pos_rechnung FOREIGN KEY (rechnung_id) REFERENCES rechnung(rechnung_id),
 CONSTRAINT fk_pos_leistung FOREIGN KEY (leistung_id) REFERENCES leistung(leistung_id),
 CONSTRAINT chk_pos_anzahl CHECK (anzahl > 0),
 CONSTRAINT chk_pos_preis CHECK (einzelpreis >= 0)
) ENGINE=InnoDB;


SELECT 'hausarzt_db' AS datenbank, COUNT(*) AS tabellen FROM information_schema.tables WHERE table_schema = 'hausarzt_db'
UNION ALL SELECT 'labor_db', COUNT(*) FROM information_schema.tables WHERE table_schema = 'labor_db'
UNION ALL SELECT 'buchhaltung_db', COUNT(*) FROM information_schema.tables WHERE table_schema = 'buchhaltung_db';
