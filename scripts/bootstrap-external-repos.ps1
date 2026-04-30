param(
    [string]$TargetDir
)

$ErrorActionPreference = "Stop"

if (-not $TargetDir) {
    if ($env:CODEX_HOME) {
        $TargetDir = Join-Path $env:CODEX_HOME "repos"
    } else {
        $TargetDir = Join-Path $HOME ".codex\repos"
    }
}

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    throw "缺少 git，请先安装 Git for Windows。"
}

New-Item -ItemType Directory -Force -Path $TargetDir | Out-Null

function Clone-Or-Checkout {
    param(
        [string]$Name,
        [string]$Url,
        [string]$Commit
    )

    $Path = Join-Path $TargetDir $Name
    if ((Test-Path -LiteralPath $Path) -and -not (Test-Path -LiteralPath (Join-Path $Path ".git"))) {
        throw "目标已存在但不是 Git 仓库: $Path"
    }

    if (-not (Test-Path -LiteralPath (Join-Path $Path ".git"))) {
        git clone $Url $Path
    }

    git -C $Path fetch --all --tags --prune
    git -C $Path checkout $Commit
}

Clone-Or-Checkout ".tmux" "https://github.com/gpakosz/.tmux.git" "87dcd13a28aeb5f18baee630e24b3f5765ae3a4f"
Clone-Or-Checkout "tmux" "https://github.com/tmux/tmux.git" "615c27c11789948df2db09e113e882f82dfb3e1c"

Write-Host "外部依赖已准备完成: $TargetDir"
