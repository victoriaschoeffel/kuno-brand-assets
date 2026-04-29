# Kuno Brand Assets — Public URL Manifest

*Updated 2026-04-29. Same hosting pattern as the [Belle Avatar Library](https://app.notion.com/p/350b2afb5d7481eab684fe1093996ddb): catbox.moe is free, persistent, no-auth. URLs are stable.*

| Asset | Public URL |
|---|---|
| Master palette (5 swatches) | https://files.catbox.moe/y77wns.png |
| Kuno Heidelberg edition | https://files.catbox.moe/mno03j.png |
| Kuno Tegernsee edition | https://files.catbox.moe/gqg5yb.png |
| Kuno Berlin Mitte edition | https://files.catbox.moe/e6refs.png |
| Horizontal lockup (KUNO INTELLIGENCE) | https://files.catbox.moe/cudl99.png |
| Recording state UI | https://files.catbox.moe/r655ox.png |

**Source SVGs** in `./svg/` · **PNG exports** in `./png/` · **HTML previews** in `./` (use a browser for full font fidelity).

To re-upload after edits:

```bash
cd /Users/vic/Documents/Kuno/brand-assets/png
for f in master-palette edition-heidelberg edition-tegernsee edition-berlin-mitte horizontal-lockup recording-state; do
  url=$(curl -s -F "reqtype=fileupload" -F "fileToUpload=@${f}.png" https://catbox.moe/user/api.php)
  echo "${f}=${url}"
done
```
