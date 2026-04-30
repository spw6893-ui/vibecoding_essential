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
Clone-Or-Checkout "Skill_Seekers-development" "https://github.com/yusufkaraaslan/Skill_Seekers.git" "26638b248279a3b001b651475e0f28975f5ff069"
Clone-Or-Checkout "claude-official-skills" "https://github.com/anthropics/skills.git" "1ed29a03dc852d30fa6ef2ca53a67dc2c2c563"
Clone-Or-Checkout "tmux" "https://github.com/tmux/tmux.git" "615c27c11789948df2db09e113e882f82dfb3e1c"

$SkillSeekers = Join-Path $TargetDir "Skill_Seekers-development"
if (Test-Path -LiteralPath (Join-Path $SkillSeekers ".git")) {
    git -C $SkillSeekers submodule update --init --recursive
}

Write-Host "外部依赖已准备完成: $TargetDir"
