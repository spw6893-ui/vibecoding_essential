param(
    [switch]$Prune,
    [switch]$WithExternalRepos
)

$ErrorActionPreference = "Stop"

$RepoUrl = if ($env:MYCODEX_REPO_URL) { $env:MYCODEX_REPO_URL } else { "https://github.com/spw6893-ui/vibecoding_essential.git" }
$RepoRef = if ($env:MYCODEX_REF) { $env:MYCODEX_REF } else { "main" }
$CodexHome = if ($env:CODEX_HOME) { $env:CODEX_HOME } else { Join-Path $HOME ".codex" }
$InstallDir = if ($env:MYCODEX_INSTALL_DIR) { $env:MYCODEX_INSTALL_DIR } else { Join-Path $CodexHome "repos\vibecoding_essential" }

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    throw "缺少 git，请先安装 Git for Windows。"
}

New-Item -ItemType Directory -Force -Path (Split-Path -Parent $InstallDir), $CodexHome | Out-Null

if ((Test-Path -LiteralPath $InstallDir) -and -not (Test-Path -LiteralPath (Join-Path $InstallDir ".git"))) {
    throw "安装目录已存在但不是 Git 仓库: $InstallDir"
}

if (-not (Test-Path -LiteralPath (Join-Path $InstallDir ".git"))) {
    git clone $RepoUrl $InstallDir
} else {
    git -C $InstallDir remote set-url origin $RepoUrl
}

git -C $InstallDir fetch origin --tags --prune
git -C $InstallDir checkout $RepoRef
git -C $InstallDir pull --ff-only origin $RepoRef

$InstallScript = Join-Path $InstallDir "scripts\windows\install.ps1"
if ($Prune) {
    & $InstallScript -Prune
} else {
    & $InstallScript
}

if ($WithExternalRepos) {
    & (Join-Path $InstallDir "scripts\windows\bootstrap-external-repos.ps1")
}

Write-Host ""
Write-Host "安装完成。"
Write-Host "仓库目录: $InstallDir"
Write-Host "Codex 目录: $CodexHome"
Write-Host "请重开 Codex 会话，让 skill 列表刷新。"
