@echo off
chcp 65001 >nul
title Android 安全清理 - ADB
setlocal

echo ============================================================
echo   Android 安全清理脚本
echo   只做两件事：输出存储占用报告 + 清理应用缓存
echo   不会删除聊天记录、照片、文档等个人数据
echo ============================================================
echo.

where adb >nul 2>nul
if errorlevel 1 (
  echo [错误] 未找到 adb，请先安装 Android Platform-Tools 并加入 PATH
  echo   下载: https://developer.android.com/studio/releases/platform-tools
  echo   解压后把目录加入系统环境变量 PATH，重开一个窗口再运行本脚本
  echo.
  pause
  exit /b 1
)

adb start-server >nul 2>nul

echo [1/5] 检查设备连接...
adb devices | findstr /r /c:"device$" >nul
if errorlevel 1 (
  echo [错误] 没有检测到已授权的设备
  echo   1. 手机: 设置 - 关于手机 - 连点「版本号」7 次，开启开发者选项
  echo   2. 开发者选项里打开「USB 调试」
  echo   3. 用数据线连接电脑，手机上弹出「允许 USB 调试」点允许
  echo.
  echo 当前设备列表:
  adb devices
  echo.
  pause
  exit /b 1
)
echo   设备已连接
echo.

echo [2/5] 存储空间总览
echo ------------------------------------------------------------
adb shell df -h /data /storage/emulated 2>nul
echo.
echo 分类占用（App 本体 / App 数据 / 缓存 / 照片视频等）:
adb shell dumpsys diskstats 2>nul | findstr /i "size"
echo.

echo [3/5] 内部存储各一级目录占用大小
echo ------------------------------------------------------------
adb shell du -h -d 1 /sdcard 2>nul
echo   说明: 数值大的目录就是占空间的主要来源，可自行到手机上查看
echo.

echo [4/5] 已安装的第三方应用列表（供参考，脚本不会卸载）
echo ------------------------------------------------------------
adb shell pm list packages -3 2>nul
echo.

echo [5/5] 清理应用缓存
echo ------------------------------------------------------------
echo 该操作只会清掉各 App 的缓存（如临时图片、缩略图、网页缓存），
echo 不影响登录状态、聊天记录和已保存的文件。
echo.
choice /c YN /m "确认清理缓存吗"
if errorlevel 2 goto skip
echo 正在清理，较慢，请耐心等待...
adb shell pm trim-caches 100000000000
if errorlevel 1 (
  echo [提示] 清理命令执行失败，部分机型不支持此命令
  echo   可改用手机自带「手机管家 / 存储空间」清理缓存
) else (
  echo 缓存清理完成
)
:skip

echo.
echo 清理后的可用空间:
adb shell df -h /data /storage/emulated 2>nul
echo.
echo 全部完成。建议重启手机一次，可进一步释放运行内存。
echo.
pause
