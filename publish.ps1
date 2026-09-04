$ErrorActionPreference = "Continue"
$src  = "E:\desk\_notes\陨落之铭世界设定库"
$dest = Join-Path $PSScriptRoot "content"

if (-not (Test-Path $src)) {
    Write-Host "[错误] 找不到源目录：$src"
    Write-Host '       请检查路径，或编辑本文件顶部 $src 一行。'
    exit 1
}

Write-Host "[1/3] 镜像源目录到 content ..."
robocopy $src $dest *.md /MIR /NFL /NDL /NJH | Out-Null
if ($LASTEXITCODE -ge 8) { Write-Host "[错误] robocopy 失败，请检查目录权限。"; exit 1 }

Push-Location $PSScriptRoot
Write-Host "[2/3] git 提交 ..."
git add -A
git diff --cached --quiet
if ($LASTEXITCODE -eq 0) {
    Write-Host "      没有内容变化，跳过提交。"
} else {
    git commit -m "更新设定库" | Out-Null
    Write-Host "      已提交。"
}

Write-Host "[3/3] git push ..."
git push
if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "完成！GitHub Actions 会自动重新构建并上线，稍等片刻即可查看。"
} else {
    Write-Host ""
    Write-Host "[提示] push 失败：请确认网络、git remote -v 与登录，或参照 SETUP-说明.md。"
}
Pop-Location
