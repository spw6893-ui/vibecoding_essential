param(
    [switch]$Prune
)

$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$RootDir = Split-Path -Parent $ScriptDir

if ($env:CODEX_HOME) {
    $CodexHome = $env:CODEX_HOME
} else {
    $CodexHome = Join-Path $HOME ".codex"
}

$SkillsDir = Join-Path $CodexHome "skills"
$ReferencesDir = Join-Path $CodexHome "references"
New-Item -ItemType Directory -Force -Path $SkillsDir, $ReferencesDir | Out-Null

function Remove-PathIfExists {
    param([string]$Path)
    if (Test-Path -LiteralPath $Path) {
        Remove-Item -LiteralPath $Path -Recurse -Force
    }
}

if ($Prune) {
    $PrunedSkills = @(
        "algorithmic-art", "brand-guidelines", "browser", "canvas-design", "ccxt",
        "claude-code-guide", "claude-cookbooks", "codeagent", "coingecko",
        "cryptofeed", "dev", "do", "doc-coauthoring", "docx", "frontend-design",
        "gh-issue-implement", "gh-pr-review", "hummingbot", "internal-comms",
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

Write-Host "mycodex 已安装到: $CodexHome"
