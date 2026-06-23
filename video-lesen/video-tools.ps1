<#
  video-tools.ps1 - Helfer-Script fuer das Skill "video-lesen"
  Aufruf:  video-tools.ps1 <befehl> [argumente]

  Befehle:
    info       <videopfad>
    frames     <videopfad> <ausgabeordner> [anzahl=8]
    audio      <videopfad> <ausgabeordner>
    subs       <url>       <ausgabeordner> [sprache=de,en]
    download   <url>       <ausgabeordner>
    transcribe <videopfad> <ausgabeordner> [modell=base]
#>

param(
    [Parameter(Mandatory=$true)][string]$Command,
    [Parameter(Mandatory=$false)][string]$Path = "",
    [Parameter(Mandatory=$false)][string]$OutDir = "",
    [Parameter(Mandatory=$false)][string]$Extra = ""
)

$ErrorActionPreference = "Stop"

# PATH auffrischen (ffmpeg/python aus winget/PyManager sicher finden)
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" +
            [System.Environment]::GetEnvironmentVariable("Path","User")

function Ensure-Dir([string]$d) {
    if ($d -and -not (Test-Path $d)) { New-Item -ItemType Directory -Path $d -Force | Out-Null }
}
function Need-File([string]$p) {
    if (-not (Test-Path $p -PathType Leaf)) { Write-Error "Datei nicht gefunden: $p"; exit 1 }
}

switch ($Command.ToLower()) {

    "info" {
        Need-File $Path
        Write-Host "== Metadaten: $Path =="
        & ffprobe -v error -show_entries `
            "format=duration,size,bit_rate:stream=codec_type,codec_name,width,height,r_frame_rate" `
            -of default=noprint_wrappers=1 -- "$Path"
    }

    "frames" {
        Need-File $Path
        if (-not $OutDir) { Write-Error "Ausgabeordner fehlt."; exit 1 }
        Ensure-Dir $OutDir
        $count = if ($Extra) { [int]$Extra } else { 8 }

        # Gesamtdauer ermitteln
        $dur = & ffprobe -v error -show_entries format=duration -of csv=p=0 -- "$Path"
        $dur = [double]($dur -replace ',', '.')
        if ($dur -le 0) { Write-Error "Dauer nicht lesbar."; exit 1 }

        $step = $dur / ($count + 1)
        for ($i = 1; $i -le $count; $i++) {
            $t = [math]::Round($step * $i, 2)
            $tStr = ($t.ToString([System.Globalization.CultureInfo]::InvariantCulture))
            $out = Join-Path $OutDir ("frame_{0:D3}.jpg" -f $i)
            & ffmpeg -loglevel error -y -ss $tStr -i "$Path" -frames:v 1 -q:v 3 -- "$out"
            if (Test-Path $out) { Write-Host "  [OK] $out  (t=${tStr}s)" }
        }
        Write-Host "Fertig: $count Frames in $OutDir"
    }

    "audio" {
        Need-File $Path
        if (-not $OutDir) { Write-Error "Ausgabeordner fehlt."; exit 1 }
        Ensure-Dir $OutDir
        $out = Join-Path $OutDir "audio.mp3"
        & ffmpeg -loglevel error -y -i "$Path" -vn -acodec libmp3lame -q:a 4 -- "$out"
        Write-Host "Audio: $out"
    }

    "subs" {
        if (-not $Path)   { Write-Error "URL fehlt."; exit 1 }
        if (-not $OutDir) { Write-Error "Ausgabeordner fehlt."; exit 1 }
        Ensure-Dir $OutDir
        $lang = if ($Extra) { $Extra } else { "de,en" }
        $tmpl = Join-Path $OutDir "%(title)s.%(ext)s"
        Write-Host "Versuche Untertitel ($lang) zu laden..."
        & python -m yt_dlp --skip-download --write-subs --write-auto-subs `
            --sub-langs $lang --convert-subs srt -o "$tmpl" -- "$Path"
        $srt = Get-ChildItem -Path $OutDir -Filter *.srt -ErrorAction SilentlyContinue
        if ($srt) {
            Write-Host "Untertitel gespeichert:"
            $srt | ForEach-Object { Write-Host "  $($_.FullName)" }
        } else {
            Write-Host "KEINE Untertitel gefunden. -> 'download' nutzen und transkribieren."
        }
    }

    "download" {
        if (-not $Path)   { Write-Error "URL fehlt."; exit 1 }
        if (-not $OutDir) { Write-Error "Ausgabeordner fehlt."; exit 1 }
        Ensure-Dir $OutDir
        $tmpl = Join-Path $OutDir "%(title)s.%(ext)s"
        # Begrenzt auf 720p mp4 fuer handliche Dateigroesse
        & python -m yt_dlp -f "bv*[height<=720]+ba/b[height<=720]" `
            --merge-output-format mp4 -o "$tmpl" -- "$Path"
        Write-Host "Download fertig in: $OutDir"
    }

    "transcribe" {
        Need-File $Path
        if (-not $OutDir) { Write-Error "Ausgabeordner fehlt."; exit 1 }
        Ensure-Dir $OutDir
        $model = if ($Extra) { $Extra } else { "base" }

        # Pruefen ob whisper verfuegbar ist
        $hasWhisper = $false
        try { & python -c "import whisper" 2>$null; if ($LASTEXITCODE -eq 0) { $hasWhisper = $true } } catch {}

        if (-not $hasWhisper) {
            Write-Host "Whisper ist NICHT installiert."
            Write-Host "Installation (nach Ruecksprache mit Nutzer):"
            Write-Host "    pip install -U openai-whisper"
            exit 2
        }
        Write-Host "Transkribiere mit Whisper ($model)... das kann dauern."
        & python -m whisper "$Path" --model $model --output_format srt --output_dir "$OutDir"
        Write-Host "Transkript (SRT) in: $OutDir"
    }

    default {
        Write-Error "Unbekannter Befehl: $Command  (info|frames|audio|subs|download|transcribe)"
        exit 1
    }
}
