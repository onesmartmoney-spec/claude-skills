# Claude Skills Library 🚀

Eine kuratierte Sammlung von **13 produktiven Claude Skills** für E-Mail, Schreiben, Entscheidungen, Lernen, Planung, Kreativität, Karriere, Social Media, Meetings, Geschäft und Utilities.

**Gesamt: 127 Befehle** – Alle kategorisiert, durchsuchbar und einsatzbereit.

---

## 📦 Skills Kategorien

| Kategorie | Skills | Befehle |
|-----------|--------|---------|
| **💬 Communication** | email-messages | 11 |
| **✍️ Writing** | write-edit | 11 |
| **🎯 Decision Making** | think-decide | 10 |
| **📚 Learning** | learn-understand | 11 |
| **⏱️ Productivity** | plan-organize, meetings-notes | 23 |
| **💡 Creativity** | brainstorm | 11 |
| **💼 Career** | work-career | 11 |
| **📱 Marketing** | content-social | 11 |
| **🏢 Business** | small-business | 12 |
| **🔧 Utilities** | pdf-reader-skill, video-lesen | 8 |
| **👨‍💻 Development** | summarize-changes | 1 |

---

## 🎯 Quick Start

### Installation (via npx skills)

```bash
# Skill-Registry durchsuchen
npx skills find

# Unsere Skills installieren (wenn auf GitHub)
npx skills add onesmartmoney/claude-skills

# Spezifische Skill installieren
npx skills add onesmartmoney/claude-skills --skill email-messages
```

### Lokale Nutzung

Alle Skills sind in `~/.claude/skills/` sofort verfügbar. Beispiele:

```bash
# E-Mail optimieren
/WARMER "Meine E-Mail ist zu formell"

# Text kürzen
/CUTHALF "Ein langer Blogbeitrag..."

# Entscheidung treffen
/CHOOSE "Job A vs Job B"

# Rechnungen schreiben
/INVOICE "Acme Corp, €2500, Juni 2026"

# Meetings dokumentieren
/MEETINGNOTES "Rohe Meeting-Notizen..."
```

---

## 📖 Skills im Detail

### 💬 Email & Messages
Optimiert E-Mail-Kommunikation, macht schwierige Nachrichten professionell.

**Befehle:** `/DECLINE`, `/SHORTEN`, `/WARMER`, `/FOLLOWUP`, `/SAYNO`, `/BULLETZEMAIL`, `/THANKS`, `/CONFIDENT`, `/OOO`, `/HARASS`, `/INTRO`

**Beispiel:**
```bash
/WARMER "Hi, I need the report by Friday. Thanks"
→ Generates: "Hey! Hope you're having a great week. Would you be able to get 
   the report over by Friday? Really appreciate it! 😊"
```

---

### ✍️ Write & Edit
Poliert Texte, vereinfacht Sprache, optimiert für Impact.

**Befehle:** `/PROOF`, `/REWRITES`, `/CUTHALF`, `/OPENERS`, `/FILLER`, `/ACTIVE`, `/HUMAN`, `/EXAMPLES`, `/SIMPLIFY`, `/TITLES`, `/TONE`

**Beispiel:**
```bash
/SIMPLIFY "Anthropic's Constitutional AI methodology leverages..."
→ Erklärt auf Niveau eines 12-Jährigen
```

---

### 🎯 Think & Decide
Strukturierte Entscheidungshilfe mit Risikoanalyse.

**Befehle:** `/CHOOSE`, `/REALPC`, `/BLINDSPOT`, `/STEELMAN`, `/DEVIL`, `/SKEPTIC`, `/STEPS`, `/RIPPLE`, `/PREMORTEM`, `/MINTEST`

**Beispiel:**
```bash
/PREMORTEM "Neue App lancieren"
→ Identifiziert mögliche Fehlerszenarien im Voraus
```

---

### 📚 Learn & Understand
Erklärt komplexe Konzepte verständlich.

**Befehle:** `/ELI10`, `/PRIMER`, `/MYTHS`, `/ANALOGY`, `/QUIZ`, `/COMPARE`, `/PREREQ`, `/SUM3`, `/GLOSSARY`, `/ASKBETTER`, `/MENTALMODEL`

**Beispiel:**
```bash
/ELI10 "Machine Learning"
→ Erklärt für einen 10-Jährigen, wirklich einfach
```

---

### ⏱️ Plan & Organize
Strukturiert Zeit, Aufgaben, Projekte.

**Befehle:** `/WEEK`, `/MILESTONES`, `/PACK`, `/SCHEDULE`, `/ROUTINE`, `/PRIORITIZE`, `/MEALS`, `/AGENDA`, `/PREPTIME`, `/ORDER`, `/CHECKLIST`

**Beispiel:**
```bash
/MILESTONES "Startup gründen, 6 Monate Deadline"
→ Zeigt wöchentliche Meilensteine bis zum Ziel
```

---

### 💡 Brainstorm
Kreative Ideengenerierung aus mehreren Blickwinkeln.

**Befehle:** `/IDEAS20`, `/GIFTS`, `/NAMES`, `/UNUSUAL`, `/ANGLE`, `/COMBINE`, `/METAPHOR`, `/STARTERS`, `/JOURNALSO`, `/AS`, `/CHILD`

**Beispiel:**
```bash
/NAMES "Fitness-App" "motivierend"
→ Generiert 10-15 kreative Namen im gewünschten Style
```

---

### 💼 Work & Career
Karriere-Support: Interviews, Bewerbungen, Gehaltsverhandlungen.

**Befehle:** `/INTERVIEW`, `/RESUMEBULLET`, `/ASKINTERVIEWER`, `/NEGOTIATE`, `/RECONNECT`, `/GAP`, `/WINS`, `/CHECKONE`, `/SELFREVIEW`, `/IDON'TKNOW`, `/RAISE`

**Beispiel:**
```bash
/RAISE "Manager, 3 Jahre dabei, Performance gut"
→ Skript zur Gehaltserhöhungs-Forderung
```

---

### 📱 Content & Social
Social-Media-Optimierung: Hooks, Captions, Threads, CTAs.

**Befehle:** `/HOOK`, `/CAPTION`, `/THREAD`, `/CAROUSEL`, `/REPURPOSE`, `/CTA`, `/BIO`, `/SUBJECT`, `/CONTRARIAN`, `/SHORTPOST`, `/COMMENT`

**Beispiel:**
```bash
/HOOK "Produktivitäts-Tipps"
→ Fünf Scroll-stoppierende Öffner für LinkedIn
```

---

### 📋 Meetings & Notes
Meetings in Protokolle, Action Items, Status-Updates.

**Befehle:** `/MEETINGNOTES`, `/ACTIONITEMS`, `/STANDUP`, `/RECAP`, `/DECISIONS`, `/QUESTIONS`, `/STATUS`, `/BRIEFME`, `/REWIND`, `/DEBRIEF`, `/TLDR`, `/RETRO`

**Beispiel:**
```bash
/ACTIONITEMS "Rohe Meeting-Notizen..."
→ Extrahiert To-Dos mit verantwortlichen Personen
```

---

### 🏢 Small Business
KMU-Workflows: Rechnungen, Kundenmail, Verträge, Angebote, Cashflow.

**Befehle:** `/INVOICE`, `/CUSTOMER-EMAIL`, `/CASHFLOW`, `/CONTRACT`, `/PROPOSAL`, `/REMINDER`, `/FEEDBACK`, `/ONBOARDING`, `/UPSELL`, `/RETENTION`, `/FOLLOWUP`, `/EXPENSE`

**Beispiel:**
```bash
/INVOICE "Acme Corp, €2500, Juni 2026"
→ Professionelle Rechnungsstruktur

/CASHFLOW "€15k Revenue, €8k Ausgaben"
→ Monatliche Liquiditäts-Planung
```

---

### 🔧 Utilities
PDF-Verarbeitung, Video-Analyse, Git-Diffs.

**pdf-reader-skill:**
```bash
python extract_pdf.py "datei.pdf"              # Ganzes PDF
python extract_pdf.py "datei.pdf" --pages 1-5 # Bereichs-Extraktion
python extract_pdf.py "datei.pdf" --tables     # Tabellen als Markdown
```

**video-lesen:**
```bash
& video-tools.ps1 subs "<YouTube-URL>" "ordner"   # Untertitel
& video-tools.ps1 frames "datei.mp4" "ordner" 8   # Frames extrahieren
& video-tools.ps1 transcribe "datei.mp4" "ordner" # Transkript
```

**summarize-changes:**
```bash
# Git Diffs summarizen
git diff HEAD
```

---

## 🔍 Skill-Suche

### Via REGISTRY.json

```bash
# JSON durchsuchen (lokal)
cat ~/.claude/skills/REGISTRY.json | jq '.skills[] | select(.name == "email-messages")'

# Alle Skills einer Kategorie
cat ~/.claude/skills/REGISTRY.json | jq '.categories.productivity'

# Nach Keyword suchen
cat ~/.claude/skills/REGISTRY.json | jq '.searchIndex.email'
```

### Via CLI (wenn on GitHub)

```bash
npx skills find email       # Findet email-messages
npx skills find social      # Findet content-social
npx skills list -a claude   # Alle für claude-code Agent
```

---

## 📁 Struktur

```
~/.claude/skills/
├── REGISTRY.json                    # Zentrale Metadaten-DB
├── README.md                        # Diese Datei
├── SETUP.sh                         # Installation & Aliases
│
├── email-messages/
│   └── SKILL.md                     # /DECLINE, /WARMER, ...
├── write-edit/
│   └── SKILL.md                     # /PROOF, /SIMPLIFY, ...
├── think-decide/
│   └── SKILL.md                     # /CHOOSE, /PREMORTEM, ...
├── learn-understand/
│   └── SKILL.md                     # /ELI10, /PRIMER, ...
├── plan-organize/
│   └── SKILL.md                     # /WEEK, /MILESTONES, ...
├── brainstorm/
│   └── SKILL.md                     # /IDEAS20, /NAMES, ...
├── work-career/
│   └── SKILL.md                     # /INTERVIEW, /RAISE, ...
├── content-social/
│   └── SKILL.md                     # /HOOK, /THREAD, ...
├── meetings-notes/
│   └── SKILL.md                     # /MEETINGNOTES, /RECAP, ...
├── small-business/
│   └── SKILL.md                     # /INVOICE, /CASHFLOW, ...
├── pdf-reader-skill/
│   ├── SKILL.md
│   └── extract_pdf.py               # PDF-Extraktion
├── video-lesen/
│   ├── SKILL.md
│   └── video-tools.ps1              # Video-Analyse
└── summarize-changes/
    └── SKILL.md                     # Git-Diffs
```

---

## 🛠️ Installation & Setup

### Lokal (~ Minute)

1. **Repo klonen:**
   ```bash
   git clone https://github.com/onesmartmoney/claude-skills ~/.claude/skills
   ```

2. **Setup laufen:**
   ```bash
   bash ~/.claude/skills/SETUP.sh
   ```

3. **Bash-Alias aktivieren:**
   ```bash
   source ~/.bash_aliases
   # oder
   source ~/.zshrc
   ```

4. **Skills testen:**
   ```bash
   # In Claude Code:
   /email-messages
   /WARMER "test"
   ```

### via npx skills (Vercel Labs)

```bash
# Wenn auf npm/GitHub registriert
npx skills add onesmartmoney/claude-skills

# Skill installieren
npx skills use onesmartmoney/claude-skills@email-messages
```

---

## 📊 Statistiken

- **13 Skills**
- **127 Befehle total**
- **11 Kategorien**
- **Durchschnitt: 9.8 Befehle pro Skill**
- **0 externe Dependencies** (alle native Claude prompts)

---

## 🚀 Use Cases

### Für Einzelunternehmer/Freelancer
- `/INVOICE` + `/REMINDER` für Kundenbilling
- `/CASHFLOW` für Finanzplanung
- `/PROPOSAL` + `/FOLLOWUP` für Verkauf
- `/CUSTOMER-EMAIL` für Kundenservice

### Für Content Creator
- `/HOOK` + `/THREAD` für Social Media
- `/CAPTION` + `/CTA` für Engagement
- `/REPURPOSE` für Multi-Channel
- `/SUBJECT` für Newsletter

### Für Projektmanager
- `/WEEK` + `/MILESTONES` für Planung
- `/MEETINGNOTES` + `/ACTIONITEMS` für Meetings
- `/STATUS` + `/RECAP` für Updates
- `/RETRO` für Retrospektiven

### Für Entwickler/Technical
- `/SUMMARIZE-CHANGES` für Commits
- `/PDF-READER` für Dokumentation
- `/VIDEO-LESEN` für Tutorials
- `/THINK` für Architektur-Entscheidungen

---

## 📝 Lizenz

MIT — Frei nutzbar, Modifizierbar, Teilbar.

---

## 🤝 Contributing

Neue Skills oder Verbesserungen?

1. Fork das Repo
2. Neue Skill im Ordner anlegen
3. REGISTRY.json updaten
4. PR stellen

---

## 📧 Support

**onesmartmoney@gmail.com**

Questions? Suggestions? Let's build better workflows together! 💪

---

**Built with ❤️ by onesmartmoney**
