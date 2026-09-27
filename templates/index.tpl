{**
 * Outletko Teal — Homepage (index.tpl)
 * Full-width layout: Hero → Categories → Featured → Trust
 *
 * Overrides: hummingbird/templates/index.tpl
 * Hooks available: displayHome, displayHomeFeaturedProducts, etc.
 **}
{extends file='page.tpl'}

{block name='page_content_container'}
<main id="main" role="main">

  {* ================================================================
     HERO SECTION — 2 columns, white/light background (no dark blocks)
     ================================================================ *}
  <section class="ot-hero" aria-label="Naslovna slika">
    <div class="container">
      <div class="ot-hero__content">
        <div class="ot-hero__text">

          {* Eyebrow badge *}
          <div class="ot-hero__eyebrow">
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" aria-hidden="true">
              <rect x="1" y="3" width="15" height="13" rx="1"/><polygon points="16 8 20 8 23 11 23 16 16 16 16 8"/>
            </svg>
            IT oprema in prenosniki • 11.946 izdelkov na zalogi
          </div>

          <h1 class="ot-hero__title">
            Profesionalna IT oprema<br>
            <span class="ot-hero__title-accent">po ugodnih cenah</span>
          </h1>

          <p class="ot-hero__subtitle">
            Prenosniki, namizni računalniki, monitorji in dodatki vodilnih znamk.
            Nova in obnovljena oprema z 12-mesečno garancijo.
          </p>

          {* Primary CTA — "Pomagajte mi izbrati" *}
          <div class="ot-hero__cta">
            <a href="{$link->getPageLink('contact')|escape:'html':'UTF-8'}"
               class="ot-btn-hero-primary"
               id="hero-cta-help">
              <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true">
                <circle cx="12" cy="12" r="10"/><path d="M9.09 9a3 3 0 1 1 5.83 1c0 2-3 3-3 3"/><line x1="12" y1="17" x2="12.01" y2="17"/>
              </svg>
              Pomagajte mi izbrati
            </a>
          </div>

          {* Quick filter chips *}
          <div class="ot-hero__quick-filters" aria-label="Hitro filtriranje po kategoriji">
            <span class="ot-hero__quick-label">Hitro filtriraj:</span>
            <a href="{$link->getCategoryLink(3)|default:'#'|escape:'html':'UTF-8'}" class="ot-chip-filter" id="hero-chip-prenosniki">
              <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" aria-hidden="true">
                <rect x="2" y="3" width="20" height="14" rx="2"/><path d="M0 21h24"/>
              </svg>
              Prenosniki
            </a>
            <a href="{$link->getCategoryLink(4)|default:'#'|escape:'html':'UTF-8'}" class="ot-chip-filter" id="hero-chip-namizni">
              <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" aria-hidden="true">
                <rect x="2" y="3" width="14" height="18" rx="2"/><rect x="18" y="9" width="4" height="8" rx="1"/>
              </svg>
              Namizni računalniki
            </a>
          </div>

          {* Key stats *}
          <div class="ot-hero__stats" aria-label="Ključne statistike">
            <div class="ot-hero__stat">
              <span class="ot-hero__stat-num">5000+</span>
              <span class="ot-hero__stat-label">Izdelkov</span>
            </div>
            <div class="ot-hero__stat-divider" aria-hidden="true"></div>
            <div class="ot-hero__stat">
              <span class="ot-hero__stat-num">2</span>
              <span class="ot-hero__stat-label">Fizični trgovini</span>
            </div>
            <div class="ot-hero__stat-divider" aria-hidden="true"></div>
            <div class="ot-hero__stat">
              <span class="ot-hero__stat-num">15+</span>
              <span class="ot-hero__stat-label">Let izkušenj</span>
            </div>
          </div>
        </div>

        {* Hero visual — real product photography, not decorative icon blocks *}
        <div class="ot-hero__visual">
          <img src="{$urls.theme_assets}img/banner-prenosniki.jpg"
               alt="Prenosniki in namizni računalniki na zalogi"
               class="ot-hero__visual-img"
               width="1200" height="250"
               loading="eager"
               fetchpriority="high">
        </div>
      </div>
    </div>
  </section>

  {* ================================================================
     CATEGORY CARD GRID
     Quick cards with product count per category. Replace category IDs
     below with actual IDs from your catalog (PS9 Admin → Katalog → Kategorije).
     $category_product_counts (optional): assoc array [id_category => count].
     Supply it (e.g. from a small hook module on displayHome) for live counts —
     cards gracefully fall back to "Oglejte si izdelke" if not set.
     ================================================================ *}
  <section class="ot-home-cats" aria-label="Kategorije izdelkov">
    <div class="container">
      <h2 class="ot-section-title ot-section-title--underline">Razišči po kategorijah</h2>
      <nav class="ot-cat-card-grid" aria-label="Glavne kategorije">

        <a href="{$link->getCategoryLink(3)|default:'#'|escape:'html':'UTF-8'}"
           class="ot-cat-card" id="cat-prenosniki">
          <span class="ot-cat-card__icon">
            <svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6" aria-hidden="true">
              <rect x="2" y="3" width="20" height="14" rx="2"/><path d="M0 21h24"/>
            </svg>
          </span>
          <span class="ot-cat-card__name">Prenosniki</span>
          <span class="ot-cat-card__count">
            {if isset($category_product_counts.3)}{$category_product_counts.3|escape:'html':'UTF-8'} izdelkov{else}Oglejte si izdelke{/if}
          </span>
          <span class="ot-cat-card__cta">
            Poglej ponudbo
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true"><path d="M5 12h14M12 5l7 7-7 7"/></svg>
          </span>
        </a>

        <a href="{$link->getCategoryLink(4)|default:'#'|escape:'html':'UTF-8'}"
           class="ot-cat-card" id="cat-namizni-racunalniki">
          <span class="ot-cat-card__icon">
            <svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6" aria-hidden="true">
              <rect x="2" y="3" width="14" height="18" rx="2"/><rect x="18" y="9" width="4" height="8" rx="1"/>
            </svg>
          </span>
          <span class="ot-cat-card__name">Namizni računalniki</span>
          <span class="ot-cat-card__count">
            {if isset($category_product_counts.4)}{$category_product_counts.4|escape:'html':'UTF-8'} izdelkov{else}Oglejte si izdelke{/if}
          </span>
          <span class="ot-cat-card__cta">
            Poglej ponudbo
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true"><path d="M5 12h14M12 5l7 7-7 7"/></svg>
          </span>
        </a>

        <a href="{$link->getCategoryLink(5)|default:'#'|escape:'html':'UTF-8'}"
           class="ot-cat-card" id="cat-monitorji">
          <span class="ot-cat-card__icon">
            <svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6" aria-hidden="true">
              <rect x="2" y="3" width="20" height="14" rx="2"/><path d="M8 21h8M12 17v4"/>
            </svg>
          </span>
          <span class="ot-cat-card__name">Monitorji</span>
          <span class="ot-cat-card__count">
            {if isset($category_product_counts.5)}{$category_product_counts.5|escape:'html':'UTF-8'} izdelkov{else}Oglejte si izdelke{/if}
          </span>
          <span class="ot-cat-card__cta">
            Poglej ponudbo
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true"><path d="M5 12h14M12 5l7 7-7 7"/></svg>
          </span>
        </a>

        <a href="{$link->getCategoryLink(9)|default:'#'|escape:'html':'UTF-8'}"
           class="ot-cat-card" id="cat-dodatki">
          <span class="ot-cat-card__icon">
            <svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6" aria-hidden="true">
              <rect x="3" y="11" width="18" height="9" rx="2"/><path d="M7 11V7a5 5 0 0110 0v4"/>
            </svg>
          </span>
          <span class="ot-cat-card__name">Dodatki</span>
          <span class="ot-cat-card__count">
            {if isset($category_product_counts.9)}{$category_product_counts.9|escape:'html':'UTF-8'} izdelkov{else}Oglejte si izdelke{/if}
          </span>
          <span class="ot-cat-card__cta">
            Poglej ponudbo
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true"><path d="M5 12h14M12 5l7 7-7 7"/></svg>
          </span>
        </a>

        <a href="{$link->getCategoryLink(12)|default:'#'|escape:'html':'UTF-8'}"
           class="ot-cat-card" id="cat-omrezna-oprema">
          <span class="ot-cat-card__icon">
            <svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6" aria-hidden="true">
              <path d="M5 12.55a11 11 0 0 1 14.08 0"/><path d="M1.42 9a16 16 0 0 1 21.16 0"/>
              <path d="M8.53 16.11a6 6 0 0 1 6.95 0"/><circle cx="12" cy="20" r="1"/>
            </svg>
          </span>
          <span class="ot-cat-card__name">Omrežna oprema</span>
          <span class="ot-cat-card__count">
            {if isset($category_product_counts.12)}{$category_product_counts.12|escape:'html':'UTF-8'} izdelkov{else}Oglejte si izdelke{/if}
          </span>
          <span class="ot-cat-card__cta">
            Poglej ponudbo
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true"><path d="M5 12h14M12 5l7 7-7 7"/></svg>
          </span>
        </a>

        <a href="{$link->getCategoryLink(8)|default:'#'|escape:'html':'UTF-8'}"
           class="ot-cat-card" id="cat-strezniki">
          <span class="ot-cat-card__icon">
            <svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6" aria-hidden="true">
              <rect x="2" y="2" width="20" height="8" rx="2"/>
              <rect x="2" y="14" width="20" height="8" rx="2"/>
              <line x1="6" y1="6" x2="6.01" y2="6"/><line x1="6" y1="18" x2="6.01" y2="18"/>
            </svg>
          </span>
          <span class="ot-cat-card__name">Strežniki</span>
          <span class="ot-cat-card__count">
            {if isset($category_product_counts.8)}{$category_product_counts.8|escape:'html':'UTF-8'} izdelkov{else}Oglejte si izdelke{/if}
          </span>
          <span class="ot-cat-card__cta">
            Poglej ponudbo
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true"><path d="M5 12h14M12 5l7 7-7 7"/></svg>
          </span>
        </a>

      </nav>
    </div>
  </section>

  {* ================================================================
     FEATURED PRODUCTS HOOK
     ================================================================ *}
  <section class="ot-home-featured" aria-label="Priporočeni izdelki">
    <div class="container">
      <div class="ot-section-header">
        <h2 class="ot-section-title ot-section-title--underline">Priporočeni izdelki</h2>
        <a href="{$link->getCategoryLink(2)|escape:'html':'UTF-8'}" class="ot-section-view-all">
          Vsi izdelki
          <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true">
            <path d="M5 12h14M12 5l7 7-7 7"/>
          </svg>
        </a>
      </div>
      {hook h='displayHome'}
      {hook h='displayHomeFeaturedProducts'}
    </div>
  </section>

  {* ================================================================
     CONDITION PROMO STRIP
     ================================================================ *}
  <section class="ot-condition-strip" aria-label="Vrsta blaga">
    <div class="container">
      <div class="ot-condition-strip__grid">

        <a href="{$link->getCategoryLink(2, null, null, null, null, 'novo')|escape:'html':'UTF-8'}"
           class="ot-condition-strip__card ot-condition-strip__card--novo"
           id="strip-novo">
          <div class="ot-condition-strip__icon">
            <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true">
              <polyline points="20 6 9 17 4 12"/>
            </svg>
          </div>
          <div>
            <div class="ot-condition-strip__title">Novo</div>
            <div class="ot-condition-strip__sub">Originalno embalirani izdelki</div>
          </div>
          <span class="ot-badge ot-badge--solid-novo" aria-hidden="true">NOVO</span>
        </a>

        <a href="{$link->getCategoryLink(2, null, null, null, null, 'obnovljeno')|escape:'html':'UTF-8'}"
           class="ot-condition-strip__card ot-condition-strip__card--obnovljeno"
           id="strip-obnovljeno">
          <div class="ot-condition-strip__icon">
            <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true">
              <polyline points="23 4 23 10 17 10"/><polyline points="1 20 1 14 7 14"/>
              <path d="M3.51 9a9 9 0 0 1 14.85-3.36L23 10M1 14l4.64 4.36A9 9 0 0 0 20.49 15"/>
            </svg>
          </div>
          <div>
            <div class="ot-condition-strip__title">Obnovljeno</div>
            <div class="ot-condition-strip__sub">Testirano in zajamčeno</div>
          </div>
          <span class="ot-badge ot-badge--solid-obnovljeno" aria-hidden="true">REFURBISHED</span>
        </a>

        <a href="{$link->getCategoryLink(2, null, null, null, null, 'outlet')|escape:'html':'UTF-8'}"
           class="ot-condition-strip__card ot-condition-strip__card--outlet"
           id="strip-outlet">
          <div class="ot-condition-strip__icon">
            <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true">
              <line x1="19" y1="5" x2="5" y2="19"/>
              <circle cx="6.5" cy="6.5" r="2.5"/><circle cx="17.5" cy="17.5" r="2.5"/>
            </svg>
          </div>
          <div>
            <div class="ot-condition-strip__title">Neprodano / Outlet</div>
            <div class="ot-condition-strip__sub">Novo po znižani ceni</div>
          </div>
          <span class="ot-badge ot-badge--solid-outlet" aria-hidden="true">OUTLET</span>
        </a>

        <a href="{$link->getCategoryLink(2, null, null, null, null, 'rabljeno')|escape:'html':'UTF-8'}"
           class="ot-condition-strip__card ot-condition-strip__card--rabljeno"
           id="strip-rabljeno">
          <div class="ot-condition-strip__icon">
            <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true">
              <path d="M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z"/>
            </svg>
          </div>
          <div>
            <div class="ot-condition-strip__title">Rabljeno</div>
            <div class="ot-condition-strip__sub">Preverjeno delujočo opremo</div>
          </div>
          <span class="ot-badge ot-badge--rabljeno" aria-hidden="true">RABLJENO</span>
        </a>

      </div>
    </div>
  </section>

  {* ================================================================
     TRUST BAR — 4 stebri zaupanja
     ================================================================ *}
  <aside class="ot-trust-bar" aria-label="Razlogi za nakup">
    <div class="container">
      <div class="ot-trust-bar__grid">
        <div class="ot-trust-item">
          <div class="ot-trust-item__icon" aria-hidden="true">
            <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8">
              <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/>
            </svg>
          </div>
          <div>
            <div class="ot-trust-item__label">12 mesecev garancije</div>
            <div class="ot-trust-item__sub">Na vse izdelke</div>
          </div>
        </div>

        <div class="ot-trust-item">
          <div class="ot-trust-item__icon" aria-hidden="true">
            <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8">
              <rect x="1" y="3" width="15" height="13" rx="1"/><polygon points="16 8 20 8 23 11 23 16 16 16 16 8"/>
              <circle cx="5.5" cy="18.5" r="2.5"/><circle cx="18.5" cy="18.5" r="2.5"/>
            </svg>
          </div>
          <div>
            <div class="ot-trust-item__label">Hitra dostava</div>
            <div class="ot-trust-item__sub">Brezplačna nad 100 EUR</div>
          </div>
        </div>

        <div class="ot-trust-item">
          <div class="ot-trust-item__icon" aria-hidden="true">
            <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8">
              <rect x="3" y="11" width="18" height="10" rx="2"/><path d="M7 11V8a5 5 0 0 1 10 0v3"/>
              <circle cx="12" cy="16" r="1.5"/>
            </svg>
          </div>
          <div>
            <div class="ot-trust-item__label">Varno plačilo</div>
            <div class="ot-trust-item__sub">Kartično ali po povzetju</div>
          </div>
        </div>

        <div class="ot-trust-item">
          <div class="ot-trust-item__icon" aria-hidden="true">
            <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8">
              <polyline points="23 4 23 10 17 10"/><polyline points="1 20 1 14 7 14"/>
              <path d="M3.51 9a9 9 0 0 1 14.85-3.36L23 10M1 14l4.64 4.36A9 9 0 0 0 20.49 15"/>
            </svg>
          </div>
          <div>
            <div class="ot-trust-item__label">14 dni za vračilo</div>
            <div class="ot-trust-item__sub">Brez vprašanj, po zakonu</div>
          </div>
        </div>
      </div>
    </div>
  </aside>

  {* Additional PS9 display hooks *}
  {hook h='displayHomeTab'}
  {hook h='displayHomeTabContent'}
  {hook h='displayBanner'}
  {hook h='displayCustomTextBlock'}

</main>
{/block}

{* ================================================================
   HOMEPAGE CSS (scoped to this page)
   ================================================================ *}
{block name='head' append}
<style>
/* ---- Hero — 2 columns, white/very light background, no dark blocks ---- */
.ot-hero { background: linear-gradient(180deg,#ffffff 0%,#f8fafc 100%); color:var(--ot-text-primary); padding: 64px 0 56px; overflow:hidden; position:relative; }
.ot-hero__content { display:grid;grid-template-columns:1.05fr 1fr;gap:48px;align-items:center; }
.ot-hero__eyebrow { display:inline-flex;align-items:center;gap:8px;padding:7px 14px 7px 12px;background:var(--ot-primary-subtle);border:1px solid var(--ot-border);border-radius:999px;font-size:0.8125rem;font-weight:600;color:var(--ot-primary);margin-bottom:22px; }
.ot-hero__eyebrow svg { color:var(--ot-primary);flex-shrink:0; }
.ot-hero__title { font-family:var(--font-display);font-size:clamp(2rem,4vw,3.25rem);font-weight:800;line-height:1.1;letter-spacing:-0.03em;color:var(--ot-text-primary);margin:0 0 16px; }
.ot-hero__title-accent { color:var(--ot-primary); }
.ot-hero__subtitle { font-size:1.125rem;color:var(--ot-text-secondary);line-height:1.6;max-width:480px;margin:0 0 28px; }
.ot-hero__cta { display:flex;gap:12px;flex-wrap:wrap;margin-bottom:18px; }
.ot-btn-hero-primary { display:inline-flex;align-items:center;gap:10px;height:52px;padding:0 28px;background:var(--ot-primary);color:#fff;border-radius:var(--radius-lg);font-weight:700;font-size:1rem;text-decoration:none;transition:all 0.2s;border:2px solid transparent; }
.ot-btn-hero-primary:hover { background:var(--ot-primary-dark);transform:translateY(-2px);box-shadow:0 8px 24px rgba(15,23,42,0.25);text-decoration:none;color:#fff; }
.ot-hero__quick-filters { display:flex;align-items:center;gap:10px;flex-wrap:wrap;margin-bottom:32px; }
.ot-hero__quick-label { font-size:0.8125rem;font-weight:600;color:var(--ot-text-muted); }
.ot-chip-filter { display:inline-flex;align-items:center;gap:7px;padding:9px 16px;background:#fff;border:1.5px solid var(--ot-border);border-radius:999px;font-size:0.875rem;font-weight:600;color:var(--ot-text-primary);text-decoration:none;transition:all 0.2s; }
.ot-chip-filter:hover { border-color:var(--ot-primary);background:var(--ot-primary-subtle);color:var(--ot-primary);text-decoration:none; }
.ot-hero__stats { display:flex;align-items:center;gap:20px; }
.ot-hero__stat { text-align:center; }
.ot-hero__stat-num { display:block;font-family:var(--font-display);font-size:1.75rem;font-weight:800;color:var(--ot-text-primary); }
.ot-hero__stat-label { font-size:0.75rem;color:var(--ot-text-muted);text-transform:uppercase;letter-spacing:0.08em; }
.ot-hero__stat-divider { width:1px;height:40px;background:var(--ot-border); }
/* Hero visual — real product photo, rounded + shadow */
.ot-hero__visual { border-radius:var(--radius-2xl);overflow:hidden;box-shadow:var(--shadow-xl);aspect-ratio:4/3; }
.ot-hero__visual-img { width:100%;height:100%;object-fit:cover;display:block; }

/* ---- Category card grid (with product counts) ---- */
.ot-home-cats { padding:60px 0 40px; }
.ot-cat-card-grid { display:grid;grid-template-columns:repeat(3,1fr);gap:16px;margin-top:28px; }
.ot-cat-card {
  display:flex;flex-direction:column;align-items:flex-start;gap:4px;
  padding:24px 20px;background:var(--ot-bg);border:1px solid var(--ot-border);
  border-radius:var(--radius-xl);text-decoration:none;color:var(--ot-text-secondary);
  position:relative;overflow:hidden;transition:all 0.2s var(--ease-out);
}
.ot-cat-card:hover {
  border-color:var(--ot-primary);box-shadow:var(--shadow-lg);
  transform:translateY(-3px);text-decoration:none;
}
.ot-cat-card__icon {
  width:48px;height:48px;background:var(--ot-primary-subtle);border-radius:var(--radius-md);
  display:flex;align-items:center;justify-content:center;color:var(--ot-primary);
  margin-bottom:8px;transition:background 0.2s;
}
.ot-cat-card:hover .ot-cat-card__icon { background:var(--ot-primary); color:#fff; }
.ot-cat-card__name { font-size:1.0625rem;font-weight:700;color:var(--ot-text-primary);font-family:var(--font-display); }
.ot-cat-card__count { font-size:0.8125rem;color:var(--ot-text-muted);font-weight:500; }
.ot-cat-card__cta {
  display:flex;align-items:center;gap:6px;margin-top:14px;padding-top:14px;
  border-top:1px solid var(--ot-border-subtle);width:100%;
  font-size:0.8125rem;font-weight:700;color:var(--ot-primary);
  transition:gap 0.2s;
}
.ot-cat-card:hover .ot-cat-card__cta { gap:10px; }
.ot-cat-card__cta svg { transition:transform 0.2s; }
.ot-cat-card:hover .ot-cat-card__cta svg { transform:translateX(2px); }

/* ---- Section header ---- */
.ot-section-header { display:flex;align-items:center;justify-content:space-between;margin-bottom:24px; }
.ot-section-header .ot-section-title { margin-bottom:0; }
.ot-section-view-all { display:inline-flex;align-items:center;gap:6px;font-size:0.875rem;font-weight:600;color:var(--ot-primary);text-decoration:none;transition:gap 0.2s; }
.ot-section-view-all:hover { text-decoration:none;gap:10px; }
.ot-home-featured { padding:0 0 60px; }

/* ---- Condition strip ---- */
.ot-condition-strip { padding:20px 0 60px; }
.ot-condition-strip__grid { display:grid;grid-template-columns:repeat(4,1fr);gap:12px; }
.ot-condition-strip__card { display:flex;align-items:center;gap:14px;padding:20px;border-radius:var(--radius-xl);border:1.5px solid transparent;text-decoration:none;transition:all 0.2s; }
.ot-condition-strip__card:hover { transform:translateY(-3px);box-shadow:var(--shadow-lg);text-decoration:none; }
.ot-condition-strip__card--novo { background:var(--badge-novo-bg);border-color:var(--badge-novo-border);color:var(--badge-novo-text); }
.ot-condition-strip__card--obnovljeno { background:var(--badge-obnovljeno-bg);border-color:var(--badge-obnovljeno-border);color:var(--badge-obnovljeno-text); }
.ot-condition-strip__card--outlet { background:var(--badge-outlet-bg);border-color:var(--badge-outlet-border);color:var(--badge-outlet-text); }
.ot-condition-strip__card--rabljeno { background:var(--badge-rabljeno-bg);border-color:var(--badge-rabljeno-border);color:var(--badge-rabljeno-text); }
.ot-condition-strip__icon { width:48px;height:48px;border-radius:var(--radius-md);background:rgba(255,255,255,0.4);display:flex;align-items:center;justify-content:center;flex-shrink:0; }
.ot-condition-strip__title { font-family:var(--font-display);font-size:1rem;font-weight:700;line-height:1.2; }
.ot-condition-strip__sub { font-size:0.75rem;opacity:0.8;margin-top:2px; }

/* ---- Responsive ---- */
@media (max-width:1023px) { .ot-hero__content{grid-template-columns:1fr;gap:32px} .ot-hero__visual{order:-1;aspect-ratio:16/7} .ot-cat-card-grid{grid-template-columns:repeat(2,1fr)} .ot-condition-strip__grid{grid-template-columns:repeat(2,1fr)} }
@media (max-width:767px) { .ot-hero{padding:40px 0 36px} .ot-cat-card-grid{grid-template-columns:1fr} .ot-condition-strip__grid{grid-template-columns:1fr} .ot-hero__stats{display:none} .ot-hero__quick-filters{gap:8px} }
</style>
{/block}
