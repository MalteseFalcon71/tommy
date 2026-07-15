#!/bin/zsh
set -e
cd "$(dirname "$0")"

if [ -x "/Applications/LibreOffice.app/Contents/MacOS/soffice" ]; then
  export SOFFICE="/Applications/LibreOffice.app/Contents/MacOS/soffice"
fi

export FIRSTDRAFT_HOST="127.0.0.1"
export FIRSTDRAFT_PUBLIC_ORIGIN="http://127.0.0.1:8000"
export FIRSTDRAFT_ACCOUNT_DATABASE="$(pwd)/private/firstdraft-accounts.sqlite3"

echo "Firstdraft will open at http://127.0.0.1:8000"
echo "Keep this window open while you use the website."
python3 outputs/server.py
