#!/usr/bin/env python
"""
PDF-Extraktor fuer pdf-reader-skill.

Bestes Allround-Verfahren:
  - PyMuPDF (fitz) fuer schnellen, sauberen Text pro Seite
  - Erkennung gescannter/leerer Seiten (Hinweis auf noetiges OCR)
  - pdfplumber nur bei Bedarf fuer Tabellen (--tables)

Benutzung:
  python extract_pdf.py "PFAD.pdf"                 # ganzes Dokument
  python extract_pdf.py "PFAD.pdf" --pages 1-5     # Seitenbereich
  python extract_pdf.py "PFAD.pdf" --pages 3       # einzelne Seite
  python extract_pdf.py "PFAD.pdf" --tables        # zusaetzlich Tabellen (Markdown)
  python extract_pdf.py "PFAD.pdf" --info          # nur Metadaten/Seitenzahl
"""
import argparse
import sys

import fitz  # PyMuPDF


def parse_pages(spec, total):
    """'1-5' / '3' / None -> 0-basierte Seitenindizes."""
    if not spec:
        return list(range(total))
    if "-" in spec:
        a, b = spec.split("-", 1)
        start, end = int(a), int(b)
    else:
        start = end = int(spec)
    start = max(1, start)
    end = min(total, end)
    return list(range(start - 1, end))


def md_table(rows):
    rows = [[("" if c is None else str(c)).replace("\n", " ").strip() for c in r] for r in rows if r]
    if not rows:
        return ""
    width = max(len(r) for r in rows)
    rows = [r + [""] * (width - len(r)) for r in rows]
    out = ["| " + " | ".join(rows[0]) + " |", "| " + " | ".join(["---"] * width) + " |"]
    for r in rows[1:]:
        out.append("| " + " | ".join(r) + " |")
    return "\n".join(out)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("pdf")
    ap.add_argument("--pages", default=None, help="z.B. 1-5 oder 3")
    ap.add_argument("--tables", action="store_true", help="Tabellen via pdfplumber als Markdown")
    ap.add_argument("--info", action="store_true", help="nur Metadaten anzeigen")
    args = ap.parse_args()

    doc = fitz.open(args.pdf)
    total = doc.page_count
    meta = doc.metadata or {}

    if args.info:
        print(f"Datei : {args.pdf}")
        print(f"Seiten: {total}")
        print(f"Titel : {meta.get('title') or '-'}")
        print(f"Autor : {meta.get('author') or '-'}")
        return

    indices = parse_pages(args.pages, total)
    scanned = []

    for i in indices:
        page = doc[i]
        text = page.get_text("text").strip()
        if len(text) < 3:  # praktisch kein Text -> wahrscheinlich Scan/Bildseite
            scanned.append(i + 1)
            text = "[Seite enthaelt kaum/keinen extrahierbaren Text - vermutlich Scan. OCR noetig.]"
        print(f"\n===== Seite {i + 1}/{total} =====")
        print(text)

    if args.tables:
        import pdfplumber
        with pdfplumber.open(args.pdf) as pdf:
            for i in indices:
                for t in (pdf.pages[i].extract_tables() or []):
                    print(f"\n----- Tabelle auf Seite {i + 1} -----")
                    print(md_table(t))

    if scanned:
        print(f"\n[HINWEIS] Gescannte/leere Seiten ohne Text: {scanned}. "
              f"Fuer diese Seiten OCR verwenden (Tesseract noetig).", file=sys.stderr)


if __name__ == "__main__":
    main()
