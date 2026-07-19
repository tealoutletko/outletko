# Font Files — Download Required

This directory requires two self-hosted variable font files.

## Required Files

| Filename | Source | License |
|---|---|---|
| `inter-variable.woff2` | [Google Fonts — Inter](https://fonts.google.com/specimen/Inter) | OFL 1.1 (free) |
| `outfit-variable.woff2` | [Google Fonts — Outfit](https://fonts.google.com/specimen/Outfit) | OFL 1.1 (free) |

## Download Steps

1. Go to [fonts.google.com/specimen/Inter](https://fonts.google.com/specimen/Inter)
2. Click **"Download family"**
3. Unzip → find `Inter[wght].woff2` in the `static/` folder
4. Rename it to `inter-variable.woff2` and place it here

Repeat for Outfit.

## Alternative (CDN)

Replace `@font-face` declarations in `../css/custom.css` with:
```html
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=Outfit:wght@400;600;700;800&display=swap">
```
Add this to `templates/_partials/head.tpl` in the `head_links` block.
