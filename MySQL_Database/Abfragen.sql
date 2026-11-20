
SELECT
    patient_id,
    vorname,
    nachname,
    geburtsdatum
FROM hausarzt_db.patient
WHERE (vorname = 'Lara' AND nachname = 'Studienfall')
   OR (vorname = 'Mara' AND nachname = 'Ster');


SELECT
    p.vorname,
    p.nachname,
    e.untersuchungsgrund,
    e.begonnen_am,
    a.nachname AS arzt
FROM hausarzt_db.encounter e
JOIN hausarzt_db.patient p
    ON e.patient_id = p.patient_id
JOIN hausarzt_db.arzt a
    ON e.arzt_id = a.arzt_id
WHERE (p.vorname = 'Lara' AND p.nachname = 'Studienfall')
   OR (p.vorname = 'Mara' AND p.nachname = 'Ster');


SELECT
    p.vorname,
    p.nachname,
    la.auftrag_id,
    lt.test_name,
    bp.proben_barcode
FROM hausarzt_db.patient p
JOIN hausarzt_db.laborauftrag la
    ON la.patient_id = p.patient_id
JOIN hausarzt_db.laborauftrag_test lt
    ON lt.auftrag_id = la.auftrag_id
JOIN hausarzt_db.blutprobe bp
    ON bp.auftrag_id = la.auftrag_id
WHERE lt.test_code = 'MASERN_IGG';


SELECT
    lp.vorname,
    lp.nachname,
    le.antikoerperart,
    le.messwert,
    le.ergebnis_text,
    le.bewertung
FROM labor_db.labor_patient lp
JOIN labor_db.laborauftrag_lis la
    ON la.labor_patient_id = lp.labor_patient_id
JOIN labor_db.laborprobe bp
    ON bp.labor_auftrag_id = la.labor_auftrag_id
JOIN labor_db.laborergebnis le
    ON le.labor_probe_id = bp.labor_probe_id
WHERE le.test_code = 'MASERN_IGG';


SELECT
    CONCAT(p.vorname, ' ', p.nachname) AS patient,
    le.antikoerperart,
    le.ergebnis_text,
    lb.befundnummer,
    r.rechnungsnummer,
    rp.anzahl * rp.einzelpreis AS rechnungsbetrag
FROM hausarzt_db.patient p
JOIN hausarzt_db.laborauftrag ha
    ON ha.patient_id = p.patient_id
JOIN labor_db.laborauftrag_lis la
    ON la.externe_auftrag_id = ha.auftrag_id
   AND la.quellsystem = 'hausarzt_db'
JOIN labor_db.labor_patient lp
    ON lp.labor_patient_id = la.labor_patient_id
   AND lp.externe_patient_id = p.patient_id
   AND lp.quellsystem = 'hausarzt_db'
JOIN labor_db.laborprobe bp
    ON bp.labor_auftrag_id = la.labor_auftrag_id
JOIN labor_db.laborergebnis le
    ON le.labor_probe_id = bp.labor_probe_id
JOIN labor_db.befund_ergebnis be
    ON be.ergebnis_id = le.ergebnis_id
JOIN labor_db.laborbefund lb
    ON lb.befund_id = be.befund_id
JOIN buchhaltung_db.rechnung r
    ON r.externe_patient_id = p.patient_id
   AND r.externe_auftrag_id = ha.auftrag_id
   AND r.quellsystem = 'hausarzt_db'
JOIN buchhaltung_db.rechnungsposition rp
    ON rp.rechnung_id = r.rechnung_id
WHERE le.test_code = 'MASERN_IGG';
