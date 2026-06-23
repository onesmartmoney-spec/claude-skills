# Claude Skills Setup for PowerShell
# Installiert Aliases und Funktionen fuer Skills Management

Write-Host "PowerShell Skills Setup"
Write-Host "======================"

$SKILLS_DIR = "$HOME\.claude\skills"

if (-not (Test-Path $SKILLS_DIR)) {
    Write-Host "Fehler: Skills directory nicht gefunden"
    exit 1
}

Write-Host "OK: Skills directory gefunden"

# Function: Find skill locally
function Find-SkillLocal {
    param([string]$Query)

    if ([string]::IsNullOrEmpty($Query)) {
        Write-Host "Usage: Find-SkillLocal QueryString"
        $registry = Get-Content "$SKILLS_DIR\REGISTRY.json" | ConvertFrom-Json
        Write-Host "Available skills:"
        $registry.skills | ForEach-Object { Write-Host ("  - " + $_.name) }
        return
    }

    Write-Host ("Searching for: " + $Query)
    $registry = Get-Content "$SKILLS_DIR\REGISTRY.json" | ConvertFrom-Json
    $registry.skills | Where-Object {
        $_.name -like ("*" + $Query + "*") -or $_.description -like ("*" + $Query + "*")
    } | ForEach-Object {
        Write-Host ($_.name)
        Write-Host ("  " + $_.description)
        Write-Host ""
    }
}

# Function: List all skills
function List-SkillsAll {
    Write-Host "Claude Skills Library"
    Write-Host "====================="

    $registry = Get-Content "$SKILLS_DIR\REGISTRY.json" | ConvertFrom-Json
    $registry.skills | ForEach-Object {
        $skillLine = $_.name + " (" + $_.commands + " commands)"
        Write-Host $skillLine
        Write-Host ("  " + $_.description)
        Write-Host ""
    }
}

# Function: Show skill details
function Get-SkillDetails {
    param([string]$SkillName)

    if ([string]::IsNullOrEmpty($SkillName)) {
        Write-Host "Usage: Get-SkillDetails SkillName"
        return
    }

    $registry = Get-Content "$SKILLS_DIR\REGISTRY.json" | ConvertFrom-Json
    $skill = $registry.skills | Where-Object { $_.name -eq $SkillName }

    if ($null -eq $skill) {
        Write-Host ("Skill not found: " + $SkillName)
        return
    }

    Write-Host ($skill.name)
    Write-Host "================================"
    Write-Host ("Description: " + $skill.description)
    Write-Host ("Category: " + $skill.category)
    Write-Host ("Commands: " + $skill.commands)
    Write-Host ""
    Write-Host "Available Commands:"
    $skill.commandList | ForEach-Object {
        Write-Host ("  " + $_)
    }
}

# Function: Search by category
function Get-SkillsByCategory {
    param([string]$Category)

    if ([string]::IsNullOrEmpty($Category)) {
        Write-Host "Usage: Get-SkillsByCategory CategoryName"
        $registry = Get-Content "$SKILLS_DIR\REGISTRY.json" | ConvertFrom-Json
        Write-Host "Available categories:"
        $registry.categories.PSObject.Properties | ForEach-Object {
            Write-Host ("  " + $_.Name)
        }
        return
    }

    $registry = Get-Content "$SKILLS_DIR\REGISTRY.json" | ConvertFrom-Json
    $skills = $registry.categories.$Category

    if ($null -eq $skills) {
        Write-Host ("Category not found: " + $Category)
        return
    }

    Write-Host ("Skills in category: " + $Category)
    $skills | ForEach-Object {
        $skill = $registry.skills | Where-Object { $_.name -eq $_ }
        Write-Host ("  " + $skill.name + " - " + $skill.description)
    }
}

# Create aliases
Set-Alias -Name find-skill -Value Find-SkillLocal -Force
Set-Alias -Name list-skills -Value List-SkillsAll -Force
Set-Alias -Name skill-info -Value Get-SkillDetails -Force
Set-Alias -Name skill-category -Value Get-SkillsByCategory -Force

Write-Host ""
Write-Host "Aliases installed:"
Write-Host "  find-skill QueryString"
Write-Host "  list-skills"
Write-Host "  skill-info SkillName"
Write-Host "  skill-category CategoryName"
Write-Host ""
Write-Host "Setup complete!"
