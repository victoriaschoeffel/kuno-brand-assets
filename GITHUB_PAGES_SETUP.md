# Kuno brand-assets — GitHub Pages Setup Guide

*Why this matters: Notion's image proxy refuses to load images from catbox.moe (the host Belle Health uses for Brevo emails). Notion **does** reliably load images from `raw.githubusercontent.com`. This sets up a free, persistent, public host for every brand asset — and after this one-time setup, every visual I generate auto-publishes.*

---

## TL;DR — three steps, ~5 minutes

```bash
# 1. Install GitHub CLI (one-time, if you don't have it)
brew install gh

# 2. Run the setup script
cd /Users/vic/Documents/Kuno/brand-assets
chmod +x setup-github-pages.sh
./setup-github-pages.sh
```

The script will:
- Check that `gh` is installed
- Open your browser to log into GitHub if you're not already authed
- Create a public repo called `kuno-brand-assets` under your GitHub account
- Push everything in this folder
- Print the public URLs you can use in Notion

---

## What you need before running it

1. A **macOS Terminal** (built in)
2. **Homebrew** installed (test with `brew --version` — if not, install from [brew.sh](https://brew.sh))
3. A **GitHub account** (free is fine — sign up at github.com if you don't have one)

That's it. No paid plan, no API keys, no DNS.

---

## What the script produces

For every PNG in `brand-assets/png/`, you get a public URL of the form:

```
https://raw.githubusercontent.com/<your-username>/kuno-brand-assets/main/png/<filename>.png
```

Examples (after you run the script with username `victoriaschoeppe`):

```
https://raw.githubusercontent.com/victoriaschoeppe/kuno-brand-assets/main/png/master-palette.png
https://raw.githubusercontent.com/victoriaschoeppe/kuno-brand-assets/main/png/edition-heidelberg.png
https://raw.githubusercontent.com/victoriaschoeppe/kuno-brand-assets/main/png/icon-options.png
```

These URLs:
- Render in Notion image blocks ✅
- Render in any markdown viewer ✅
- Render in Brevo emails ✅
- Render in Slack ✅
- Are persistent (forever, free, unless you delete the repo)

---

## After the first run — updating assets

Whenever I generate new visuals (or you edit existing ones), the update flow is:

```bash
cd /Users/vic/Documents/Kuno/brand-assets
git add -A
git commit -m "update brand assets"
git push
```

Three commands, ~10 seconds. The Notion images update automatically because the URL stays the same — only the image at that URL changes.

---

## Once it's done — tell me

After the script finishes, **paste the username it printed** back into our chat (e.g. *"my GitHub username is victoriaschoeppe"*). I'll:

1. Update the Notion brand book to swap all `files.catbox.moe/...png` URLs for the new `raw.githubusercontent.com/...` URLs
2. Add the icon-options visualization (and any future ones) to Notion as real image blocks
3. Push any new assets I generate from then on directly to the repo

You won't have to drag-and-drop again.

---

## Troubleshooting

**"gh: command not found"** — Run `brew install gh` first.

**"gh auth login" fails** — Try `gh auth login --web` and follow the browser flow.

**"Repository already exists"** — That's fine. The script will use the existing repo and push to it.

**"Permission denied (publickey)"** — Switch the auth protocol: `gh auth refresh -h github.com -s repo --git-protocol https`. The script prefers HTTPS over SSH for this reason.

**Images still don't load in Notion** — Wait 30 seconds and refresh the Notion page. Notion caches image proxy results; sometimes a fresh fetch is needed after a URL change.

---

## What this folder contains *(once committed)*

- `svg/` — source SVG files (master palette, editions, lockup, icons, recording state)
- `png/` — exported PNGs at 1400px wide, ready for Notion / web / email
- `*.html` — full-fidelity browser previews of the wordmark options and lockup
- `catbox-urls.md` — old URL manifest (deprecated after GitHub setup; kept for reference)
- `setup-github-pages.sh` — the one-time setup script
- `GITHUB_PAGES_SETUP.md` — this guide
