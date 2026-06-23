---
name: video-lesen
description: Liest und analysiert Videodateien und Video-URLs (YouTube etc.). Nutze dieses Skill, wenn der Nutzer den Inhalt eines Videos verstehen, transkribieren, zusammenfassen oder durchsuchen will - egal ob lokale Datei (.mp4, .mkv, .mov, .avi, .webm) oder URL (YouTube, Vimeo). Holt Metadaten, Untertitel/Transkript und Einzelbilder (Frames) zur visuellen Analyse.
---

# Video lesen & analysieren

Dieses Skill macht Videoinhalte für Claude lesbar: **Transkript** (was gesagt wird),
**Frames** (was zu sehen ist) und **Metadaten** (Technik). Alle Befehle laufen über
das Helfer-Script `video-tools.ps1` im selben Ordner.

## Werkzeuge (bereits installiert)
- `ffmpeg` / `ffprobe` — Frames, Audio, Metadaten
- `yt-dlp` (via `python -m yt_dlp`) — Download + YouTube-Untertitel
- `whisper` — **optional**, nur für lokale Videos ohne Untertitel (siehe unten)

## Entscheidungs-Logik (WICHTIG: in dieser Reihenfolge)

### Fall A — YouTube / URL-Video
1. **Zuerst Untertitel versuchen** (kostenlos, sofort, kein Download):
   ```powershell
   & "$SKILL/video-tools.ps1" subs "<URL>" "<arbeitsordner>"
   ```
   Lädt vorhandene oder automatische Untertitel als `.srt`. Diese Datei dann mit
   `Read` öffnen → das ist das komplette gesprochene Transkript.
2. **Nur wenn keine Untertitel da sind** → Video herunterladen und wie Fall B behandeln:
   ```powershell
   & "$SKILL/video-tools.ps1" download "<URL>" "<arbeitsordner>"
   ```

### Fall B — Lokale Videodatei
1. **Metadaten** (Dauer, Auflösung, Codec):
   ```powershell
   & "$SKILL/video-tools.ps1" info "<pfad>"
   ```
2. **Frames extrahieren** (visueller Inhalt) — Standard 8 gleichmäßig verteilte Bilder:
   ```powershell
   & "$SKILL/video-tools.ps1" frames "<pfad>" "<arbeitsordner>" 8
   ```
   Die erzeugten `frame_001.jpg` ... dann **einzeln mit `Read` öffnen** und beschreiben.
3. **Transkript** (gesprochenes Wort) — braucht Whisper:
   ```powershell
   & "$SKILL/video-tools.ps1" transcribe "<pfad>" "<arbeitsordner>"
   ```
   Falls Whisper nicht installiert ist, meldet das Script den Installationsbefehl.
   Dann den Nutzer fragen, ob installiert werden soll (großer Download ~2 GB).

## Whisper (optional) installieren
Nur bei Bedarf und nach Rückfrage beim Nutzer:
```powershell
pip install -U openai-whisper
```
Kleinere/schnellere Alternative: `pip install faster-whisper`

## Arbeitsordner-Konvention
Lege pro Auftrag einen Unterordner an, z.B. `<video-ordner>\_video_analyse\`,
damit Frames/Transkripte nicht das Original-Verzeichnis zumüllen.

## Typische Aufträge & Vorgehen
- **"Fasse dieses YouTube-Video zusammen"** → Fall A, Untertitel lesen, zusammenfassen.
- **"Was passiert in diesem Video?"** (lokal) → Fall B: Frames + Transkript, dann beschreiben.
- **"Finde die Stelle wo X gesagt wird"** → Transkript holen, durchsuchen, Zeitstempel nennen.
- **"Wie lang/welche Auflösung?"** → nur `info`.

## Grenzen (ehrlich benennen)
- Claude sieht keinen Bewegtbild-Stream, sondern nur die extrahierten Einzelbilder.
- Ohne Untertitel und ohne Whisper gibt es kein Transkript.
- Bei sehr langen Videos: Frames-Anzahl erhöhen oder gezielt Zeitbereiche extrahieren.
