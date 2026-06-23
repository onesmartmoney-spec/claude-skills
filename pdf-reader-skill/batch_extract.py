import sys, pathlib, fitz
src = pathlib.Path(r"C:\Users\KON-01\Desktop\scan\Übersicht Unterlagen\001 Fertig\OCR")
out = pathlib.Path(r"C:\Users\KON-01\Desktop\scan\Übersicht Unterlagen\001 Fertig\_TXT")
out.mkdir(exist_ok=True)
pdfs = sorted(src.glob("*.pdf"))
total_chars = 0
rows = []
for p in pdfs:
    try:
        doc = fitz.open(p)
        parts = []
        scan_pages = 0
        for i in range(doc.page_count):
            t = doc[i].get_text("text")
            if len(t.strip()) < 3:
                scan_pages += 1
            parts.append(f"\n===== Seite {i+1}/{doc.page_count} =====\n{t}")
        txt = "".join(parts)
        (out / (p.stem + ".txt")).write_text(txt, encoding="utf-8")
        total_chars += len(txt)
        rows.append((p.name, doc.page_count, len(txt), scan_pages))
    except Exception as e:
        rows.append((p.name, -1, 0, -1))
        print("FEHLER:", p.name, e, file=sys.stderr)

print(f"Dateien: {len(pdfs)}")
print(f"Gesamt-Seiten: {sum(r[1] for r in rows if r[1]>0)}")
print(f"Gesamt-Zeichen: {total_chars:,}  (~ {total_chars//4:,} Tokens grob)")
print(f"Dateien mit leeren/Scan-Seiten: {sum(1 for r in rows if r[3]>0)}")
print("\nGroesste/auffaellige Dateien (Name | Seiten | Zeichen | LeerSeiten):")
for r in sorted(rows, key=lambda x:-x[2])[:15]:
    print(f"  {r[0][:55]:55} | {r[1]:>3} S | {r[2]:>7} Z | {r[3]} leer")
