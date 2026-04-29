#!/usr/bin/env bash
# Kuno brand-assets — GitHub Pages one-time setup
# Run this ONCE from /Users/vic/Documents/Kuno/brand-assets/
# After this, every PNG in png/ is publicly accessible at:
#   https://raw.githubusercontent.com/<your-username>/kuno-brand-assets/main/png/<filename>.png
# Notion fetches raw.githubusercontent.com URLs reliably.

set -e  # exit on any error

cd "$(dirname "$0")"

echo "🎙️  Kuno brand-assets → GitHub Pages setup"
echo "==========================================="
echo ""

# Step 1 — check gh CLI
if ! command -v gh &> /dev/null; then
  echo "❌ GitHub CLI (gh) is not installed."
  echo "   Install it with:  brew install gh"
  echo "   Then re-run this script."
  exit 1
fi

# Step 2 — check auth
if ! gh auth status &> /dev/null; then
  echo "🔐 Not authenticated. Opening browser to log into GitHub..."
  gh auth login --git-protocol https --web
fi

# Step 3 — git init if needed
if [ ! -d .git ]; then
  echo "📦 Initializing git repository..."
  git init -b main
  git add .
  git commit -m "Initial commit: Kuno brand assets v0.6"
else
  echo "📦 Git repo already exists, skipping init."
fi

# Step 4 — create the public repo if it doesn't exist
USERNAME=$(gh api user --jq .login)
REPO_NAME="kuno-brand-assets"

if ! gh repo view "${USERNAME}/${REPO_NAME}" &> /dev/null; then
  echo "🌐 Creating public repo ${USERNAME}/${REPO_NAME}..."
  gh repo create "${REPO_NAME}" --public --description "Kuno Intelligence — brand assets (palette, editions, wordmarks, icons, recording state)" --source=. --remote=origin --push
else
  echo "🌐 Repo ${USERNAME}/${REPO_NAME} already exists. Pushing latest..."
  if ! git remote | grep -q origin; then
    git remote add origin "https://github.com/${USERNAME}/${REPO_NAME}.git"
  fi
  git add -A
  git commit -m "Update brand assets" 2>/dev/null || true
  git push -u origin main
fi

# Step 5 — print the public URLs for Notion
echo ""
echo "✅ Done. Your assets are now publicly accessible at:"
echo ""
for f in png/*.png; do
  filename=$(basename "$f")
  echo "   https://raw.githubusercontent.com/${USERNAME}/${REPO_NAME}/main/png/${filename}"
done
echo ""
echo "📋 The brand book in Notion can now use these URLs as image embeds."
echo "    They render in Notion reliably (unlike catbox.moe which Notion blocks)."
echo ""
echo "🔄 To update assets going forward, just run:"
echo "    cd /Users/vic/Documents/Kuno/brand-assets && git add -A && git commit -m \"update\" && git push"
echo ""
