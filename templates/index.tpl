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
     HERO SECTION
     ================================================================ *}
  <section class="ot-hero" aria-label="Naslovna slika">
    <div class="ot-hero__inner">
      {* Background grid pattern *}
      <div class="ot-hero__bg" aria-hidden="true"></div>

      <div class="container">
        <div class="ot-hero__content">
          <div class="ot-hero__text">
            {* Condition pill badges *}
            <div class="ot-hero__badges">
              <a href="{$link->getCategoryLink(2, null, null, null, null, 'novo')|escape:'html':'UTF-8'}"
                 class="ot-badge ot-badge--novo">✓ Novo</a>
              <a href="{$link->getCategoryLink(2, null, null, null, null, 'obnovljeno')|escape:'html':'UTF-8'}"
                 class="ot-badge ot-badge--obnovljeno">↺ Obnovljeno</a>
              <a href="{$link->getCategoryLink(2, null, null, null, null, 'outlet')|escape:'html':'UTF-8'}"
                 class="ot-badge ot-badge--outlet">% Outlet</a>
              <a href="{$link->getCategoryLink(2, null, null, null, null, 'rabljeno')|escape:'html':'UTF-8'}"
                 class="ot-badge ot-badge--rabljeno">♻ Rabljeno</a>
            </div>

            <h1 class="ot-hero__title">
              IT oprema za<br>
              <span class="ot-hero__title-accent">vsak proračun</span>
            </h1>

            <p class="ot-hero__subtitle">
              Nova, obnovljena in rabljena IT oprema po najboljših cenah.
              Prenosniki, računalniki, zasloni, tiskalniki in več.
              Laško &amp; Celje.
            </p>

            <div class="ot-hero__cta">
              <a href="{$link->getCategoryLink(2)|escape:'html':'UTF-8'}"
                 class="ot-btn-hero-primary"
                 id="hero-cta-shop">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true">
                  <circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/>
                  <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/>
                </svg>
                Nakupuj zdaj
              </a>
              <a href="{$link->getPageLink('stores')|escape:'html':'UTF-8'}"
                 class="ot-btn-hero-secondary"
                 id="hero-cta-stores">
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true">
                  <path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"/><circle cx="12" cy="10" r="3"/>
                </svg>
                Naše trgovine
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

          {* Hero visual - decorative product grid *}
          <div class="ot-hero__visual" aria-hidden="true">
            <div class="ot-hero__visual-grid">
              <div class="ot-hero__visual-card ot-hero__visual-card--1">
                <div class="ot-hero__visual-icon">💻</div>
                <span>Prenosniki</span>
              </div>
              <div class="ot-hero__visual-card ot-hero__visual-card--2">
                <div class="ot-hero__visual-icon">🖥️</div>
                <span>Računalniki</span>
              </div>
              <div class="ot-hero__visual-card ot-hero__visual-card--3">
                <div class="ot-hero__visual-icon">🖨️</div>
                <span>Tiskalniki</span>
              </div>
              <div class="ot-hero__visual-card ot-hero__visual-card--4">
                <div class="ot-hero__visual-icon">📱</div>
                <span>Tablice</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>

  {* ================================================================
     CATEGORY ICON GRID
     ================================================================ *}
  <section class="ot-home-cats" aria-label="Kategorije izdelkov">
    <div class="container">
      <h2 class="ot-section-title ot-section-title--underline">Kategorije</h2>
      <nav class="ot-cat-icon-grid" aria-label="Glavne kategorije">

        <a href="{$link->getCategoryLink(3)|default:'#'|escape:'html':'UTF-8'}"
           class="ot-cat-icon-card" id="cat-prenosniki">
          <div class="ot-cat-icon-card__icon">
            <svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6" aria-hidden="true">
              <rect x="2" y="3" width="20" height="14" rx="2"/><path d="M0 21h24"/>
            </svg>
          </div>
          <span class="ot-cat-icon-card__name">Prenosniki</span>
          <span class="ot-cat-icon-card__arrow" aria-hidden="true">→</span>
        </a>

        <a href="{$link->getCategoryLink(4)|default:'#'|escape:'html':'UTF-8'}"
           class="ot-cat-icon-card" id="cat-racunalniki">
          <div class="ot-cat-icon-card__icon">
            <svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6" aria-hidden="true">
              <rect x="2" y="3" width="14" height="18" rx="2"/><rect x="18" y="9" width="4" height="8" rx="1"/>
            </svg>
          </div>
          <span class="ot-cat-icon-card__name">Računalniki</span>
          <span class="ot-cat-icon-card__arrow" aria-hidden="true">→</span>
        </a>

        <a href="{$link->getCategoryLink(5)|default:'#'|escape:'html':'UTF-8'}"
           class="ot-cat-icon-card" id="cat-zasloni">
          <div class="ot-cat-icon-card__icon">
            <svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6" aria-hidden="true">
              <rect x="2" y="3" width="20" height="14" rx="2"/><path d="M8 21h8M12 17v4"/>
            </svg>
          </div>
          <span class="ot-cat-icon-card__name">Zasloni</span>
          <span class="ot-cat-icon-card__arrow" aria-hidden="true">→</span>
        </a>

        <a href="{$link->getCategoryLink(6)|default:'#'|escape:'html':'UTF-8'}"
           class="ot-cat-icon-card" id="cat-tablice">
          <div class="ot-cat-icon-card__icon">
            <svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6" aria-hidden="true">
              <rect x="5" y="2" width="14" height="20" rx="2"/><circle cx="12" cy="18" r="1"/>
            </svg>
          </div>
          <span class="ot-cat-icon-card__name">Tablice &amp; Telefoni</span>
          <span class="ot-cat-icon-card__arrow" aria-hidden="true">→</span>
        </a>

        <a href="{$link->getCategoryLink(7)|default:'#'|escape:'html':'UTF-8'}"
           class="ot-cat-icon-card" id="cat-tiskalniki">
          <div class="ot-cat-icon-card__icon">
            <svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6" aria-hidden="true">
              <polyline points="6 9 6 2 18 2 18 9"/>
              <path d="M6 18H4a2 2 0 01-2-2v-5a2 2 0 012-2h16a2 2 0 012 2v5a2 2 0 01-2 2h-2"/>
              <rect x="6" y="14" width="12" height="8"/>
            </svg>
          </div>
          <span class="ot-cat-icon-card__name">Tiskalniki</span>
          <span class="ot-cat-icon-card__arrow" aria-hidden="true">→</span>
        </a>

        <a href="{$link->getCategoryLink(8)|default:'#'|escape:'html':'UTF-8'}"
           class="ot-cat-icon-card" id="cat-strezniki">
          <div class="ot-cat-icon-card__icon">
            <svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6" aria-hidden="true">
              <rect x="2" y="2" width="20" height="8" rx="2"/>
              <rect x="2" y="14" width="20" height="8" rx="2"/>
              <line x1="6" y1="6" x2="6.01" y2="6"/><line x1="6" y1="18" x2="6.01" y2="18"/>
            </svg>
          </div>
          <span class="ot-cat-icon-card__name">Strežniki</span>
          <span class="ot-cat-icon-card__arrow" aria-hidden="true">→</span>
        </a>

        <a href="{$link->getCategoryLink(9)|default:'#'|escape:'html':'UTF-8'}"
           class="ot-cat-icon-card" id="cat-periferija">
          <div class="ot-cat-icon-card__icon">
            <svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6" aria-hidden="true">
              <rect x="3" y="11" width="18" height="9" rx="2"/><path d="M7 11V7a5 5 0 0110 0v4"/>
            </svg>
          </div>
          <span class="ot-cat-icon-card__name">Periferija</span>
          <span class="ot-cat-icon-card__arrow" aria-hidden="true">→</span>
        </a>

        <a href="{$link->getCategoryLink(10)|default:'#'|escape:'html':'UTF-8'}"
           class="ot-cat-icon-card" id="cat-programska">
          <div class="ot-cat-icon-card__icon">
            <svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6" aria-hidden="true">
              <rect x="3" y="3" width="18" height="18" rx="2"/>
              <path d="M9 9l3 3-3 3M13 15h3"/>
            </svg>
          </div>
          <span class="ot-cat-icon-card__name">Programska oprema</span>
          <span class="ot-cat-icon-card__arrow" aria-hidden="true">→</span>
        </a>

        <a href="{$link->getCategoryLink(11)|default:'#'|escape:'html':'UTF-8'}"
           class="ot-cat-icon-card ot-cat-icon-card--pos" id="cat-pos">
          <div class="ot-cat-icon-card__icon">
            <svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6" aria-hidden="true">
              <rect x="1" y="4" width="22" height="16" rx="2"/>
              <path d="M1 10h22"/>
            </svg>
          </div>
          <span class="ot-cat-icon-card__name">POS oprema</span>
          <span class="ot-cat-icon-card__arrow" aria-hidden="true">→</span>
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
     TRUST BAR
     ================================================================ *}
  <aside class="ot-trust-bar" aria-label="Razlogi za nakup">
    <div class="container">
      <div class="ot-trust-bar__grid">
        <div class="ot-trust-item">
          <div class="ot-trust-item__icon" aria-hidden="true">
            <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8">
              <rect x="1" y="3" width="15" height="13" rx="1"/><polygon points="16 8 20 8 23 11 23 16 16 16 16 8"/>
              <circle cx="5.5" cy="18.5" r="2.5"/><circle cx="18.5" cy="18.5" r="2.5"/>
            </svg>
          </div>
          <div>
            <div class="ot-trust-item__label">Brezplačna dostava</div>
            <div class="ot-trust-item__sub">Za naročila nad 100 €</div>
          </div>
        </div>

        <div class="ot-trust-item">
          <div class="ot-trust-item__icon" aria-hidden="true">
            <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8">
              <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/>
            </svg>
          </div>
          <div>
            <div class="ot-trust-item__label">Garancija vključena</div>
            <div class="ot-trust-item__sub">1–24 mesecev glede na stanje</div>
          </div>
        </div>

        <div class="ot-trust-item">
          <div class="ot-trust-item__icon" aria-hidden="true">
            <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8">
              <path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"/><circle cx="12" cy="10" r="3"/>
            </svg>
          </div>
          <div>
            <div class="ot-trust-item__label">Prevzem v trgovini</div>
            <div class="ot-trust-item__sub">Laško &amp; Celje</div>
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
            <div class="ot-trust-item__label">Enostavna vrnitev</div>
            <div class="ot-trust-item__sub">14-dnevni umik</div>
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
/* ---- Hero ---- */
.ot-hero { background: linear-gradient(135deg,#0d1117 0%,#1a2744 60%,#0d2247 100%); color:#fff; padding: 80px 0 60px; overflow:hidden; position:relative; }
.ot-hero__bg { position:absolute;inset:0;background-image:radial-gradient(circle at 20% 50%,rgba(0,102,204,0.15) 0%,transparent 60%),radial-gradient(circle at 80% 20%,rgba(0,102,204,0.08) 0%,transparent 50%);pointer-events:none; }
.ot-hero__inner { position:relative; }
.ot-hero__content { display:grid;grid-template-columns:1fr 1fr;gap:60px;align-items:center; }
.ot-hero__badges { display:flex;gap:8px;flex-wrap:wrap;margin-bottom:20px; }
.ot-hero__title { font-family:var(--font-display);font-size:clamp(2rem,4vw,3.5rem);font-weight:800;line-height:1.1;letter-spacing:-0.03em;color:#fff;margin:0 0 16px; }
.ot-hero__title-accent { color:var(--ot-primary-light); }
.ot-hero__subtitle { font-size:1.125rem;color:rgba(255,255,255,0.75);line-height:1.6;max-width:460px;margin:0 0 32px; }
.ot-hero__cta { display:flex;gap:12px;flex-wrap:wrap;margin-bottom:36px; }
.ot-btn-hero-primary { display:inline-flex;align-items:center;gap:10px;height:52px;padding:0 28px;background:var(--ot-primary);color:#fff;border-radius:var(--radius-lg);font-weight:700;font-size:1rem;text-decoration:none;transition:all 0.2s;border:2px solid transparent; }
.ot-btn-hero-primary:hover { background:var(--ot-primary-dark);transform:translateY(-2px);box-shadow:0 8px 24px rgba(0,102,204,0.4);text-decoration:none;color:#fff; }
.ot-btn-hero-secondary { display:inline-flex;align-items:center;gap:8px;height:52px;padding:0 24px;background:transparent;color:rgba(255,255,255,0.85);border:2px solid rgba(255,255,255,0.25);border-radius:var(--radius-lg);font-weight:600;font-size:1rem;text-decoration:none;transition:all 0.2s;backdrop-filter:blur(4px); }
.ot-btn-hero-secondary:hover { border-color:rgba(255,255,255,0.6);color:#fff;background:rgba(255,255,255,0.08);text-decoration:none; }
.ot-hero__stats { display:flex;align-items:center;gap:20px; }
.ot-hero__stat { text-align:center; }
.ot-hero__stat-num { display:block;font-family:var(--font-display);font-size:1.75rem;font-weight:800;color:#fff; }
.ot-hero__stat-label { font-size:0.75rem;color:rgba(255,255,255,0.55);text-transform:uppercase;letter-spacing:0.08em; }
.ot-hero__stat-divider { width:1px;height:40px;background:rgba(255,255,255,0.15); }
/* Hero visual */
.ot-hero__visual-grid { display:grid;grid-template-columns:1fr 1fr;gap:16px; }
.ot-hero__visual-card { background:rgba(255,255,255,0.07);border:1px solid rgba(255,255,255,0.1);border-radius:16px;padding:24px;display:flex;flex-direction:column;align-items:center;gap:12px;color:rgba(255,255,255,0.8);font-size:0.875rem;font-weight:500;backdrop-filter:blur(8px);transition:all 0.3s; }
.ot-hero__visual-card:hover { background:rgba(0,102,204,0.2);border-color:rgba(0,102,204,0.4);transform:translateY(-4px); }
.ot-hero__visual-icon { font-size:2.5rem; }
.ot-hero__visual-card--1 { animation:floatCard 3s ease-in-out infinite; }
.ot-hero__visual-card--2 { animation:floatCard 3s ease-in-out infinite 0.5s; }
.ot-hero__visual-card--3 { animation:floatCard 3s ease-in-out infinite 1s; }
.ot-hero__visual-card--4 { animation:floatCard 3s ease-in-out infinite 1.5s; }
@keyframes floatCard { 0%,100%{transform:translateY(0)} 50%{transform:translateY(-6px)} }

/* ---- Category icon grid ---- */
.ot-home-cats { padding:60px 0 40px; }
.ot-cat-icon-grid { display:grid;grid-template-columns:repeat(3,1fr);gap:12px;margin-top:28px; }
.ot-cat-icon-card { display:flex;align-items:center;gap:14px;padding:16px 20px;background:var(--ot-bg);border:1px solid var(--ot-border);border-radius:var(--radius-lg);text-decoration:none;color:var(--ot-text-secondary);font-size:0.9rem;font-weight:500;transition:all 0.2s;position:relative;overflow:hidden; }
.ot-cat-icon-card:hover { border-color:var(--ot-primary);background:var(--ot-primary-subtle);color:var(--ot-primary);transform:translateX(4px);text-decoration:none; }
.ot-cat-icon-card__icon { width:44px;height:44px;background:var(--ot-surface);border-radius:var(--radius-md);display:flex;align-items:center;justify-content:center;flex-shrink:0;transition:background 0.2s; }
.ot-cat-icon-card:hover .ot-cat-icon-card__icon { background:var(--ot-primary-subtle-2); }
.ot-cat-icon-card__icon svg { color:var(--ot-text-muted);transition:color 0.2s; }
.ot-cat-icon-card:hover .ot-cat-icon-card__icon svg { color:var(--ot-primary); }
.ot-cat-icon-card__name { flex:1;font-weight:600; }
.ot-cat-icon-card__arrow { color:var(--ot-text-muted);transition:transform 0.2s; }
.ot-cat-icon-card:hover .ot-cat-icon-card__arrow { transform:translateX(4px);color:var(--ot-primary); }

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
@media (max-width:1023px) { .ot-hero__content{grid-template-columns:1fr;gap:40px} .ot-hero__visual{display:none} .ot-cat-icon-grid{grid-template-columns:repeat(2,1fr)} .ot-condition-strip__grid{grid-template-columns:repeat(2,1fr)} }
@media (max-width:767px) { .ot-hero{padding:48px 0 40px} .ot-cat-icon-grid{grid-template-columns:1fr} .ot-condition-strip__grid{grid-template-columns:1fr} .ot-hero__stats{display:none} }
</style>
{/block}
