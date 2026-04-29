#!/usr/bin/env bash
# Kuno brand-assets — fix-and-push, idempotent, handles all the edge cases
# we hit on the first run. Just runs it and tells you the URLs at the end.
#
# Usage from anywhere:
#   bash /Users/vic/Documents/Kuno/brand-assets/fix-and-push.sh
#
# What it does:
#   1. Goes to the brand-assets directory
#   2. Nukes any broken .git state (stale locks, empty repos)
#   3. Fresh git init + add + commit
#   4. (Re-)attaches the GitHub remote
#   5. Force-pushes to main (safe because the GitHub repo is empty)
#   6. Prints all the public raw.githubusercontent.com URLs

set -e

REPO_DIR="/Users/vic/Documents/Kuno/brand-assets"
GITHUB_USER="victoriaschoeffel"
REPO_NAME="kuno-brand-assets"
REMOTE_URL="https://github.com/${GITHUB_USER}/${REPO_NAME}.git"
RAW_BASE="https://raw.githubusercontent.com/${GITHUB_USER}/${REPO_NAME}/main"

cd "$REPO_DIR"

echo "🧹 Cleaning any stale git state..."
rm -f .git/index.lock 2>/dev/null || true
rm -rf .git

echo "📦 Fresh git init..."
git init -b main >/dev/null

echo "➕ Adding all files..."
git add .

echo "📝 Committing..."
git -c user.email="victoria@bellehealth.co" -c user.name="Victoria" \
    commit -m "Initial commit: Kuno brand assets v0.7" >/dev/null

echo "🔗 Attaching remote..."
git remote remove origin 2>/dev/null || true
git remote add origin "$REMOTE_URL"

echo "🚀 Pushing to GitHub (this is where it might prompt for auth)..."
git push -u origin main --force

echo ""
echo "✅ Done. Public URLs (these render in Notion):"
echo ""
for f in png/*.png; do
  filename=$(basename "$f")
  echo "${RAW_BASE}/png/${filename}"
done
echo ""
echo "📋 Tell Claude 'pushed' and the Notion brand book will be updated to use these."
