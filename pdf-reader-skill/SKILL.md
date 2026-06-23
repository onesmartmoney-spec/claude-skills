---
name: pdf-reader-skill
description: "Liest und verarbeitet PDF-Dokumente zuverlässig. Extrahiert Text und Tabellen aus PDF-Dateien, fasst sie zusammen, hebt Abschnitte hervor und erkennt gescannte Seiten (OCR-Hinweis). Nutze diesen Skill, wenn der Nutzer ein PDF lesen, zusammenfassen, durchsuchen, bestimmte Seiten/Abschnitte oder Tabellen extrahieren oder eine Textanalyse in einer PDF-Datei durchführen will."
---

## Zweck
Robustes Auslesen von PDF-Dokumenten — Text, Tabellen, Seitenbereiche — inkl. Erkennung gescannter Seiten.

## Bester Standardweg (zuerst verwenden)
Im Skill-Ordner liegt ein fertiges Skript `extract_pdf.py`. Es nutzt **PyMuPDF (fitz)** für sauberen Text und **pdfplumber** für Tabellen. Diese Bibliotheken sind bereits installiert.

```bash
# Ganzes Dokument lesen
python "C:\Users\KON-01\.claude\skills\pdf-reader-skill\extract_pdf.py" "PFAD.pdf"

# Nur Metadaten / Seitenzahl (erst orientieren, dann gezielt lesen)
python "...\extract_pdf.py" "PFAD.pdf" --info

# Bestimmter Seitenbereich
python "...\extract_pdf.py" "PFAD.pdf" --pages 1-5
python "...\extract_pdf.py" "PFAD.pdf" --pages 3

# Zusätzlich Tabellen als Markdown
python "...\extract_pdf.py" "PFAD.pdf" --tables
```

Das Skript markiert jede Seite (`===== Seite n/total =====`) und meldet am Ende, welche Seiten **kein extrahierbares Textmaterial** haben (→ Scan, OCR nötig).

## Ablauf
1. **Orientieren:** bei großen/unbekannten PDFs zuerst `--info`, dann gezielt Seitenbereiche lesen — nicht blind alles in den Kontext laden.
2. **Lesen:** Standardaufruf (oben). Bei Tabellen `--tables` ergänzen.
3. **Gescannte Seiten:** Wenn das Skript Seiten ohne Text meldet, ist es ein Bild-/Scan-PDF → OCR nötig (Tesseract ist aktuell **nicht** installiert; bei Bedarf einrichten oder den `anthropic-skills:pdf`-Skill für OCR nutzen).
4. **Aufbereiten:** Zusammenfassen/analysieren; bei Zitaten Seitenzahl angeben; Tabellen als Markdown ausgeben; wörtliches Zitat klar von eigener Zusammenfassung trennen.

## Anwendungsfälle
- Vollständige PDFs lesen und zusammenfassen
- Bestimmte Seiten, Abschnitte oder Tabellen extrahieren
- Stichwortsuche und Textanalyse im PDF

## Fallbacks
- **Bearbeiten** statt nur lesen (mergen, splitten, Formulare ausfüllen, signieren, OCR): Skill **`anthropic-skills:pdf`** und die **PDF-Tools-MCP** verwenden.
- Immer prüfen, ob plausibler Text herauskam; bei Leerergebnis Scan annehmen und auf OCR wechseln (häufigster Fehler).
