@echo off
cd /d "%~dp0"
set FIRSTDRAFT_HOST=127.0.0.1
set FIRSTDRAFT_PUBLIC_ORIGIN=http://127.0.0.1:8000
set FIRSTDRAFT_ACCOUNT_DATABASE=%CD%\private\firstdraft-accounts.sqlite3
if exist "C:\Program Files\LibreOffice\program\soffice.exe" set SOFFICE=C:\Program Files\LibreOffice\program\soffice.exe
echo Firstdraft will open at http://127.0.0.1:8000
echo Keep this window open while you use the website.
python outputs\server.py
