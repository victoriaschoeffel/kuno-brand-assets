#!/usr/bin/env bash
# Final push — creates the GitHub repo if it doesn't exist, then pushes.
# Uses gh CLI auth (which is already set up), so no password prompts.

set -e
cd /Users/vic/Documents/Kuno/brand-assets

echo "🔐 Confirming GitHub auth..."
gh auth status 2>&1 | head -5

echo ""
echo "🌐 Ensuring kuno-brand-assets exists on GitHub..."
if gh repo view kuno-brand-assets >/dev/null 2>&1; then
  echo "✓ Repo already exists on GitHub"
else
  echo "  Creating public repo..."
  gh repo create kuno-brand-assets --public --description "Kuno Intelligence — brand assets (palette, editions, wordmarks, icons, recording state)"
fi

echo ""
echo "🚀 Pushing to GitHub..."
git push -u origin main

echo ""
echo "✅ Done. Test that this URL loads in your browser:"
echo "   https://raw.githubusercontent.com/victoriaschoeffel/kuno-brand-assets/main/png/master-palette.png"
echo ""
echo "All seven assets:"
for f in png/*.png; do
  echo "   https://raw.githubusercontent.com/victoriaschoeffel/kuno-brand-assets/main/$f"
done
