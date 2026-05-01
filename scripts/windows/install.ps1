param(
    [switch]$Prune,
    [switch]$WithGlobalAgents,
    [switch]$NoGlobalAgents
)

$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$RootDir = Split-Path -Parent (Split-Path -Parent $ScriptDir)

if ($env:CODEX_HOME) {
    $CodexHome = $env:CODEX_HOME
} else {
    $CodexHome = Join-Path $HOME ".codex"
}

$SkillsDir = Join-Path $CodexHome "skills"
$ReferencesDir = Join-Path $CodexHome "references"
New-Item -ItemType Directory -Force -Path $SkillsDir, $ReferencesDir | Out-Null

$InstallGlobalAgents = $true
if ($NoGlobalAgents) {
    $InstallGlobalAgents = $false
}
if ($WithGlobalAgents) {
    $InstallGlobalAgents = $true
}

function Remove-PathIfExists {
    param([string]$Path)
    if (Test-Path -LiteralPath $Path) {
        Remove-Item -LiteralPath $Path -Recurse -Force
    }
}

if ($Prune) {
    $PrunedSkills = @(
        "algorithmic-art", "auto-skill", "brand-guidelines", "browser", "canvas-design", "ccxt",
        "claude-code-guide", "claude-cookbooks", "code-guardrails", "codeagent", "coingecko",
        "cryptofeed", "dev", "do", "doc-coauthoring", "docx", "frontend-design",
        "headless-cli", "hummingbot", "internal-comms",
        "markdown-to-epub", "mcp-builder", "myclaude-product-workflow", "omo",
        "pdf", "polymarket", "pptx", "product-requirements",
        "prototype-prompt-generator", "proxychains", "skill-install",
        "slack-gif-creator", "snapdom", "sparv", "test-cases", "theme-factory",
        "web-artifacts-builder", "webapp-testing", "xlsx"
    )

    foreach ($Name in $PrunedSkills) {
        Remove-PathIfExists (Join-Path $SkillsDir $Name)
    }
}

Remove-PathIfExists (Join-Path $SkillsDir "myclaude-product-workflow")

$SourceSkills = Join-Path $RootDir "skills"
Get-ChildItem -LiteralPath $SourceSkills -Directory | ForEach-Object {
    $Target = Join-Path $SkillsDir $_.Name
    Remove-PathIfExists $Target
    Copy-Item -LiteralPath $_.FullName -Destination $Target -Recurse -Force
}

foreach ($Name in @("gh-flow", "vibe-coding-cn", "engineering-templates", "myclaude-skills")) {
    Remove-PathIfExists (Join-Path $ReferencesDir $Name)
}

$SourceReferences = Join-Path $RootDir "references"
Get-ChildItem -LiteralPath $SourceReferences -Directory | ForEach-Object {
    $Target = Join-Path $ReferencesDir $_.Name
    Remove-PathIfExists $Target
    Copy-Item -LiteralPath $_.FullName -Destination $Target -Recurse -Force
}

if ($InstallGlobalAgents) {
    $SourceAgents = Join-Path $RootDir "config\codex\global-agents.template.md"
    $DestAgents = Join-Path $CodexHome "AGENTS.md"

    if ((Test-Path -LiteralPath $DestAgents)) {
        $Existing = Get-Content -LiteralPath $DestAgents -Raw
        $Incoming = Get-Content -LiteralPath $SourceAgents -Raw
        if ($Existing -ne $Incoming) {
            $Backup = Join-Path $CodexHome ("AGENTS.md.backup." + (Get-Date -Format "yyyyMMddHHmmss"))
            Copy-Item -LiteralPath $DestAgents -Destination $Backup -Force
            Write-Host "已备份原全局 AGENTS.md: $Backup"
        }
    }

    Copy-Item -LiteralPath $SourceAgents -Destination $DestAgents -Force
    Write-Host "已安装全局 AGENTS.md: $DestAgents"
}

Write-Host "mycodex 已安装到: $CodexHome"
