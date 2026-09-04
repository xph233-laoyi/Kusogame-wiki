@echo off
rem ============================================================
rem  一键同步 + 发布：把 Obsidian 设定库镜像到 content/ 并推上 GitHub
rem  用法：在 Obsidian 里改完稿后，双击本文件即可。
rem ============================================================
chcp 65001 >nul
setlocal

rem ---- 你的真源：Obsidian 里的设定库文件夹（改动此处请同步改 SETUP-说明.md）----
set "SRC=E:\desk\_notes\陨落之铭世界设定库"
set "DEST=%~dp0content"

if not exist "%SRC%" (
  echo [错误] 找不到源目录：%SRC%
  echo        请检查路径，或编辑本文件顶部的 SRC 一行。
  pause & exit /b 1
)

echo [1/3] 镜像源目录到 content ...
robocopy "%SRC%" "%DEST%" *.md /MIR /NFL /NDL /NJH >nul
if %errorlevel% GEQ 8 (
  echo [错误] robocopy 失败，请检查目录权限。
  pause & exit /b 1
)

echo [2/3] git 提交 ...
git add -A
git diff --cached --quiet
if %errorlevel% EQU 0 (
  echo       没有内容变化，跳过提交。
) else (
  for /f "tokens=1-3 delims=/ " %%a in ('date /t') do set "d=%%a-%%b-%%c"
  for /f "tokens=1-2 delims=: " %%a in ('time /t') do set "t=%%a%%b"
  git commit -m "更新设定库 %d% %t%" >nul
  echo       已提交。
)

echo [3/3] git push ...
git push
if %errorlevel% EQU 0 (
  echo.
  echo 完成！GitHub Actions 会在几分钟内自动重新构建并上线。
) else (
  echo.
  echo [提示] push 失败：请确认已连接 GitHub（git remote -v）
  echo        并按 SETUP-说明.md 的“首次上线”步骤配置 origin。
)
pause
