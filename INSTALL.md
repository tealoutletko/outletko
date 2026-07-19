# Outletko Teal — Navodila za namestitev
**PrestaShop 9 Hummingbird Child Theme**  
TEAL d.o.o. | v1.0.0

---

## Predpogoji

| Zahteva | Verzija |
|---|---|
| PrestaShop | **9.0.x** (ali novejša) |
| PHP | 8.1+ |
| Starševska tema | **hummingbird** (vključena v PS9) |
| Modul | `ps_facetedsearch` (priporočeno) |

> [!IMPORTANT]
> Tema zahteva, da je **hummingbird** tema nameščena in **aktivna** pred namestitvijo te teme. Brez starševske teme boste dobili napako `parent theme not found`.

---

## Korak 1 — Prenos datotek

### Možnost A: ZIP arhiv (priporočeno)
1. Zapakir mapo `outletko-teal/` v ZIP arhiv:
   ```powershell
   # Windows PowerShell
   Compress-Archive -Path outletko-teal -DestinationPath outletko-teal.zip
   ```
2. V PS9 Admin pojdi na **Design → Teme → Dodaj novo temo**.
3. Naloži `outletko-teal.zip`.

### Možnost B: FTP / direktna kopija
1. Kopiraj mapo `outletko-teal/` v `/themes/` na strežniku:
   ```
   /themes/
   ├── hummingbird/        ← starševska tema (mora obstajati)
   └── outletko-teal/      ← naša tema
       ├── config/
       │   └── theme.yml
       ├── assets/
       │   ├── css/
       │   │   ├── variables.css
       │   │   ├── custom.css
       │   │   └── components/
       │   ├── js/
       │   │   ├── theme.js
       │   │   ├── search-autocomplete.js
       │   │   └── filter-enhancements.js
       │   └── fonts/          ← dodaj Inter + Outfit .woff2 datoteke
       └── templates/
           ├── index.tpl
           ├── _partials/
           │   ├── head.tpl
           │   ├── footer.tpl
           │   └── microdata/
           │       └── product.tpl
           └── catalog/
               ├── listing.tpl
               ├── product.tpl
               └── _partials/
                   └── miniatures/
                       └── product.tpl
   ```

---

## Korak 2 — Namestitev pisav (obvezno)

Tema privzeto naloži **Inter** in **Outfit** iz lokalne poti `assets/fonts/`. Prenesi variabilne pisave:

1. Prenesi `Inter` variable: https://fonts.google.com/specimen/Inter  
   → `Download family` → zapakiraj → vzemi `Inter[wght].woff2`
2. Prenesi `Outfit` variable: https://fonts.google.com/specimen/Outfit  
   → `Download family` → zapakiraj → vzemi `Outfit[wght].woff2`
3. Preimenuj datoteki:
   - `inter-variable.woff2`
   - `outfit-variable.woff2`
4. Naloži v: `/themes/outletko-teal/assets/fonts/`

> [!TIP]
> Alternativno lahko v `assets/css/custom.css` zamenjaj `@font-face` bloke z Google Fonts CDN linki, a to zmanjša performance score.

---

## Korak 3 — Aktivacija teme

1. Pojdi v **PS9 Admin → Design → Teme**.
2. Poišči **Outletko Teal** in klikni **Uporabi to temo**.
3. PS9 bo samodejno preveril `parent: hummingbird` in podedoval vse brez teme.

---

## Korak 4 — Namestitev modulov

### Obvezno:
| Modul | Namen |
|---|---|
| `ps_facetedsearch` | Filter po cenah, atributih, znamkah |
| `ps_searchbar` | Ajax iskanje (naša JS ga kliče) |

### Priporočeno:
| Modul | Namen |
|---|---|
| `ps_featuredproducts` | Priporočeni izdelki na domači strani |
| `ps_emailsubscription` | Newsletter (footer) |
| `ps_shoppingcart` | Mini košarica v headerju |
| `ps_customeraccountlinks` | Meni računa |

---

## Korak 5 — Konfiguracija

### Kategorije (ID-ji)
Odpri `templates/index.tpl` in posodobi ID kategorij glede na vaše dejansko drevo:

```smarty
{* Zamenjaj ID-je z dejanskimi iz tvojega PS9 kataloga *}
{$link->getCategoryLink(3)}   {* Prenosniki *}
{$link->getCategoryLink(4)}   {* Računalniki *}
{$link->getCategoryLink(5)}   {* Zasloni *}
...
```

Da ugotoviš pravilne ID-je:
- Pojdi v **PS9 Admin → Katalog → Kategorije**.
- ID je prikazan v URL-ju ko urejuješ kategorijo.

### Pogoji blaga (Condition)
PS9 ima privzete vrednosti: `new`, `used`, `refurbished`.  
Naša tema jih preslika na slovensko:

| PS9 vrednost | Prikazano |
|---|---|
| `new` | Novo ✓ |
| `refurbished` | Obnovljeno ↺ |
| `used` | Rabljeno ♻ |
| `outlet` / `neprodano` | Outlet % |

Vrednosti nastavi v **PS9 Admin → Katalog → Izdelki → [Izdelek] → Stanje**.

### SEO nastavitve
Posodobi `config/theme.yml` meta sekcijo z dejanskimi opisi.

---

## Korak 6 — Čiščenje predpomnilnika (Cache)

> [!CAUTION]
> Vedno počisti predpomnilnik po namestitvi/spremembi teme!

```
PS9 Admin → Napredno → Zmogljivost → Počisti predpomnilnik
```

Oziroma via CLI (PrestaShop Console, PS9):
```bash
php bin/console prestashop:cache:clear
```

Za razvijalce — brisanje Smarty predpomnilnika:
```bash
rm -rf var/cache/prod/smarty/compile/*
rm -rf var/cache/prod/smarty/cache/*
```

---

## Korak 7 — Preveritev

Po namestitvi preveri naslednje strani:

- [ ] **Domača stran** (`/`) — hero, kategorije, priporočeni
- [ ] **Kategorija** (`/[kategorija]`) — filtri, mreža/seznam, sortiranje
- [ ] **Produkt** (`/[kategorija]/[produkt]`) — galerija, cena, ATC, specifikacije
- [ ] **Iskanje** (`/search?s=test`) — rezultati
- [ ] **Košarica** (`/kosarica`) — produkt miniature, skupaj
- [ ] **Mobilna** — bottom nav, filter sheet, responsive slike

---

## Razvoj in prilagajanje

### Struktura datotek
```
assets/css/variables.css      → Vse CSS spremenljivke (barve, pisave, prostori)
assets/css/custom.css         → Globalni slogi + @font-face
assets/css/components/        → Komponenta po komponenta
assets/js/theme.js            → Glavni JS (dark mode, drawer, gallery, itd.)
assets/js/search-autocomplete.js → Iskanje z avtodopolnjevanjem
assets/js/filter-enhancements.js → Filter slider, chips, accordion
templates/                    → Smarty predloge (override Hummingbird)
config/theme.yml              → Konfiguracija teme + asset registracija
```

### Dark mode
Tema podpira sistem dark mode samodejno. Uporabnik ga lahko tudi ročno preklopi z gumbom v headerju (`data-ot-dark-toggle`). Nastavitev se shrani v `localStorage`.

### Dodajanje novih CSS spremenljivk
Vse spremenljivke dodaj v `assets/css/variables.css` znotraj `:root` in `.dark-mode` blokov.

### Prevajanje stringov
Vsi vidni nizi v `.tpl` datotekah so oviti v `{l s='...' d='Shop.Theme.*'}` za prevajalce.

---

## Znane omejitve

- Tema NE vključuje dejanskih `.woff2` font datotek (copyright) — prenesi jih ročno (korak 2).
- `preview.png` (400×300px) je placeholder — zamenjaj z dejanskim posnetkom zaslona.
- ID-ji kategorij v `index.tpl` so privzeti primeri — prilagodi jih svojemu katalogu.
- Checkout strani (`order.tpl`, `order-confirmation.tpl`) podedujemo od Hummingbird; naš `checkout.css` stilizira elemente znotraj teh strani.

---

## Podpora

**TEAL d.o.o.**  
📧 info@teal.si  
🌐 https://outletko.si  
📍 Aškerčeva ulica 4, 3270 Laško | Mariborska cesta 7, 3000 Celje
