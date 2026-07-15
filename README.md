# Firstdraft — VS Code and hosting folder

This folder contains the complete Firstdraft preview website: the home page, legal
page, three editable CV templates, private update-file controls, animations and the
Python service that creates one-page PDFs from the protected Word masters.

Do not upload only `outputs/` to a static website host. PDF creation needs the
included Python server, LibreOffice and the protected files in `private/`.

## Quickest local start with Docker

1. Install Docker Desktop.
2. Open this folder in Visual Studio Code.
3. Open **Terminal → Run Task** and choose **Firstdraft: start with Docker**.
4. Open `http://localhost:8000` in Safari, Chrome or Edge.
5. Stop it with the **Firstdraft: stop Docker** task.

The same result can be started in a terminal with:

```sh
docker compose up --build
```

## Local start without Docker

Install Python 3, LibreOffice and the package in `outputs/requirements.txt`. On a
Mac, double-click `Start Firstdraft.command`. On Windows, double-click
`Start Firstdraft.bat`. The PDF button needs LibreOffice to be installed.

## Put it on the internet

Use a web host that can deploy a Dockerfile and keep a persistent disk. Upload this
whole folder, select the included `Dockerfile`, expose the host's `PORT`, and mount
a persistent disk at `/data`.

Set these values in the host's private environment-variable dashboard:

```text
FIRSTDRAFT_PUBLIC_ORIGIN=https://your-real-domain.example
FIRSTDRAFT_ACCOUNT_DATABASE=/data/firstdraft-accounts.sqlite3
FIRSTDRAFT_COOKIE_SECURE=1
FIRSTDRAFT_MAX_EXPORTS=2
```

The host must also set `FIRSTDRAFT_HOST=0.0.0.0`. The Dockerfile already does this.
Use `/healthz` as the host's health-check path.

## Google account setup

Google buttons activate only after these server-side values are supplied:

```text
FIRSTDRAFT_GOOGLE_CLIENT_ID=your-web-client-id
FIRSTDRAFT_GOOGLE_CLIENT_SECRET=your-web-client-secret
FIRSTDRAFT_GOOGLE_REDIRECT_URI=https://your-real-domain.example/auth/google/callback
FIRSTDRAFT_LIVE_MODE=1
```

Add the exact redirect address to the Google Cloud web OAuth client. Never put the
client secret in HTML or commit a real `.env` file.

## Before real sales or search indexing

The website currently runs as a working preview and does not take payment. Stripe
Checkout and a verified Stripe webhook still need to be added before
`FIRSTDRAFT_LIVE_MODE=1` is used for customers. A webhook must grant a template
only after Stripe confirms payment.

Because the founder is under 18, a parent, guardian or other responsible adult will
need to handle payment-provider and hosting contracts. Complete the trader contact,
privacy, refund and complaint details in `outputs/legal.html` before selling.

Search indexing is safely off by default. Only after the public-launch checklist is
complete should the host set:

```text
FIRSTDRAFT_ALLOW_INDEXING=1
```

## What stays private

- CV answers are processed only to make the PDF and are not saved by the server.
- Saved update files are created in the student's browser and remain on their device.
- Word masters remain in `private/` and are never served as public website files.
- The account database stores only a Google account identifier, sessions and template access.

Keep `private/firstdraft-accounts.sqlite3`, `.env` and all secrets out of source
control and public downloads.

## Final launch tests

- Home page, legal page and finished CV example open successfully.
- Every template editor opens and closes with mouse, touch, Escape and keyboard.
- Private update files save and restore.
- All three templates download as one-page PDFs.
- iPhone Safari, Android Chrome, Windows Edge/Chrome and macOS Safari are tested.
- Google sign-in, sign-out and account deletion work on the real HTTPS domain.
- Stripe success, cancellation and webhook verification work before payment is enabled.
