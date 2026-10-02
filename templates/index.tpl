{**
 * Outletko Elits — Homepage (index.tpl)
 * Matching teal.publishwall.com structure exactly
 *
 * Overrides: hummingbird/templates/index.tpl
 **}
{extends file='page.tpl'}

{block name='page_content_container'}
<main id="main" role="main">

  {* ================================================================
     TRUST BAR — 4 badges right under header (exactly like reference)
     ================================================================ *}
  <section class="ot-trust-bar" aria-label="Razlogi za nakup">
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
            <div class="ot-trust-item__label">Hitra dostava</div>
            <div class="ot-trust-item__sub">Brezplačna nad 100 EUR</div>
          </div>
        </div>

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
              <rect x="1" y="4" width="22" height="16" rx="2"/><path d="M1 10h22"/>
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
  </section>

  {* ================================================================
     STATS BAR — 4 columns with big numbers (exactly like reference)
     ================================================================ *}
  <section class="ot-stats" aria-label="Statistika">
    <div class="container">
      <div class="ot-stats__grid">

        <div class="ot-stats__item">
          <div class="ot-stats__number">11,946+</div>
          <div class="ot-stats__label">Izdelkov</div>
        </div>

        <div class="ot-stats__item">
          <div class="ot-stats__number">496+</div>
          <div class="ot-stats__label">Blagovnih znamk</div>
        </div>

        <div class="ot-stats__item">
          <div class="ot-stats__number">2,832+</div>
          <div class="ot-stats__label">Na zalogi</div>
        </div>

        <div class="ot-stats__item">
          <div class="ot-stats__number">100%</div>
          <div class="ot-stats__label">Z garancijo</div>
        </div>

      </div>
    </div>
  </section>

  {* ================================================================
     CATEGORY GRID — Image cards with overlay (exactly like reference)
     ================================================================ *}
  <section class="ot-section" aria-label="Kategorije">
    <div class="container">
      <div class="ot-section__header">
        <h2 class="ot-section__title">Kategorije</h2>
        <a href="{$link->getCategoryLink(2)|escape:'html':'UTF-8'}" class="ot-section__link">
          Vse kategorije
          <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M5 12h14M12 5l7 7-7 7"/></svg>
        </a>
      </div>
      <div class="ot-category-grid">

        <a href="{$link->getCategoryLink(3)|default:'#'|escape:'html':'UTF-8'}" class="ot-category-card">
          <div class="ot-category-card__img-wrap">
            <svg class="ot-category-card__placeholder" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.2"><rect x="2" y="3" width="20" height="14" rx="2"/><path d="M0 21h24"/></svg>
          </div>
          <div class="ot-category-card__overlay">
            <div class="ot-category-card__name">Prenosniki</div>
          </div>
        </a>

        <a href="{$link->getCategoryLink(4)|default:'#'|escape:'html':'UTF-8'}" class="ot-category-card">
          <div class="ot-category-card__img-wrap">
            <svg class="ot-category-card__placeholder" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.2"><rect x="2" y="3" width="14" height="18" rx="2"/><rect x="18" y="9" width="4" height="8" rx="1"/></svg>
          </div>
          <div class="ot-category-card__overlay">
            <div class="ot-category-card__name">Namizni računalniki</div>
          </div>
        </a>

        <a href="{$link->getCategoryLink(5)|default:'#'|escape:'html':'UTF-8'}" class="ot-category-card">
          <div class="ot-category-card__img-wrap">
            <svg class="ot-category-card__placeholder" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.2"><rect x="2" y="3" width="20" height="14" rx="2"/><path d="M8 21h8M12 17v4"/></svg>
          </div>
          <div class="ot-category-card__overlay">
            <div class="ot-category-card__name">Monitorji</div>
          </div>
        </a>

        <a href="{$link->getCategoryLink(7)|default:'#'|escape:'html':'UTF-8'}" class="ot-category-card">
          <div class="ot-category-card__img-wrap">
            <svg class="ot-category-card__placeholder" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.2"><polyline points="6 9 6 2 18 2 18 9"/><path d="M6 18H4a2 2 0 01-2-2v-5a2 2 0 012-2h16a2 2 0 012 2v5a2 2 0 01-2 2h-2"/><rect x="6" y="14" width="12" height="8"/></svg>
          </div>
          <div class="ot-category-card__overlay">
            <div class="ot-category-card__name">Tiskalniki</div>
          </div>
        </a>

        <a href="{$link->getCategoryLink(9)|default:'#'|escape:'html':'UTF-8'}" class="ot-category-card">
          <div class="ot-category-card__img-wrap">
            <svg class="ot-category-card__placeholder" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.2"><rect x="3" y="11" width="18" height="9" rx="2"/><path d="M7 11V7a5 5 0 0110 0v4"/></svg>
          </div>
          <div class="ot-category-card__overlay">
            <div class="ot-category-card__name">Tipkovnice &amp; Miške</div>
          </div>
        </a>

        <a href="{$link->getCategoryLink(8)|default:'#'|escape:'html':'UTF-8'}" class="ot-category-card">
          <div class="ot-category-card__img-wrap">
            <svg class="ot-category-card__placeholder" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.2"><rect x="2" y="2" width="20" height="8" rx="2"/><rect x="2" y="14" width="20" height="8" rx="2"/><line x1="6" y1="6" x2="6.01" y2="6"/><line x1="6" y1="18" x2="6.01" y2="18"/></svg>
          </div>
          <div class="ot-category-card__overlay">
            <div class="ot-category-card__name">Strežniki</div>
          </div>
        </a>

      </div>
    </div>
  </section>

  {* ================================================================
     FEATURED PRODUCTS — Hook for PS product listing
     ================================================================ *}
  <section class="ot-section" aria-label="Izdelki">
    <div class="container">
      <div class="ot-section__header">
        <h2 class="ot-section__title">Izdelki</h2>
        <a href="{$link->getCategoryLink(2)|escape:'html':'UTF-8'}" class="ot-section__link">
          Vsi izdelki
          <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M5 12h14M12 5l7 7-7 7"/></svg>
        </a>
      </div>

      {hook h='displayHome'}
      {hook h='displayHomeFeaturedProducts'}

    </div>
  </section>

  {* ================================================================
     BRANDS STRIP — Text brand names (exactly like reference)
     ================================================================ *}
  <section class="ot-brands" aria-label="Blagovne znamke">
    <div class="container">
      <h2 class="ot-section__title ot-section__title--center ot-section__title--mb-8">Blagovne znamke</h2>
      <div class="ot-brands__list">
        <a href="#" class="ot-brands__item">Apple</a>
        <a href="#" class="ot-brands__item">Logitech</a>
        <a href="#" class="ot-brands__item">Dell</a>
        <a href="#" class="ot-brands__item">HP</a>
        <a href="#" class="ot-brands__item">Lenovo</a>
        <a href="#" class="ot-brands__item">Samsung</a>
        <a href="#" class="ot-brands__item">Asus</a>
        <a href="#" class="ot-brands__item">Acer</a>
        <a href="#" class="ot-brands__item">MSI</a>
        <a href="#" class="ot-brands__item">Razer</a>
      </div>
    </div>
  </section>

  {* Additional PS9 hooks *}
  {hook h='displayHomeTab'}
  {hook h='displayHomeTabContent'}
  {hook h='displayBanner'}
  {hook h='displayCustomTextBlock'}

</main>
{/block}

{** ================================================================
    HOMEPAGE CSS — Scoped, matching teal.publishwall.com exactly
    ================================================================ *}
{block name='head' append}
<style>
{literal}

/* ---- Container ---- */
.ot-container,
.ot-trust-bar .container,
.ot-stats .container,
.ot-section .container,
.ot-brands .container {
  max-width: 1280px;
  margin: 0 auto;
  padding: 0 clamp(1rem, 4vw, 2rem);
}

/* ---- Trust Bar ---- */
.ot-trust-bar {
  background: #ffffff;
  border-bottom: 1px solid #e5e7eb;
  padding: 1.25rem 0;
}

.ot-trust-bar__grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 1rem;
}

.ot-trust-item {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  text-align: left;
}

.ot-trust-item__icon {
  width: 44px;
  height: 44px;
  flex-shrink: 0;
  background: #f0f7ff;
  border-radius: 10px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #005a9c;
}

.ot-trust-item__icon svg {
  width: 22px;
  height: 22px;
}

.ot-trust-item__label {
  font-size: 0.8125rem;
  font-weight: 600;
  color: #1a202c;
  line-height: 1.2;
}

.ot-trust-item__sub {
  font-size: 0.75rem;
  color: #6b7280;
  margin-top: 1px;
}

/* ---- Stats Bar ---- */
.ot-stats {
  background: #ffffff;
  border-bottom: 1px solid #e5e7eb;
  padding: 2rem 0;
}

.ot-stats__grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 1.5rem;
  text-align: center;
}

.ot-stats__number {
  font-family: 'Outfit', 'Inter', sans-serif;
  font-size: clamp(1.5rem, 3vw, 2rem);
  font-weight: 800;
  color: #005a9c;
  letter-spacing: -0.03em;
  line-height: 1.1;
}

.ot-stats__label {
  font-size: 0.8125rem;
  color: #6b7280;
  font-weight: 500;
  margin-top: 0.25rem;
}

/* ---- Section ---- */
.ot-section {
  padding: 3rem 0;
}

.ot-section__header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 1.5rem;
}

.ot-section__title {
  font-family: 'Outfit', 'Inter', sans-serif;
  font-size: 1.5rem;
  font-weight: 700;
  color: #1a202c;
  letter-spacing: -0.02em;
  margin: 0;
}

.ot-section__title--center {
  text-align: center;
}

.ot-section__title--mb-8 {
  margin-bottom: 2rem;
}

.ot-section__link {
  display: inline-flex;
  align-items: center;
  gap: 0.25rem;
  font-size: 0.8125rem;
  font-weight: 600;
  color: #005a9c;
  text-decoration: none;
  transition: gap 0.2s;
}

.ot-section__link:hover {
  gap: 0.5rem;
  text-decoration: none;
}

.ot-section__link svg {
  width: 16px;
  height: 16px;
}

/* ---- Category Grid ---- */
.ot-category-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 1rem;
}

.ot-category-card {
  position: relative;
  border-radius: 12px;
  overflow: hidden;
  text-decoration: none;
  aspect-ratio: 4 / 3;
  background: #f0f4f8;
}

.ot-category-card__img-wrap {
  width: 100%;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  background: linear-gradient(135deg, #f0f4f8 0%, #e2e8f0 100%);
  transition: transform 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.ot-category-card:hover .ot-category-card__img-wrap {
  transform: scale(1.06);
}

.ot-category-card__placeholder {
  width: 64px;
  height: 64px;
  color: #94a3b8;
}

.ot-category-card__overlay {
  position: absolute;
  inset: 0;
  background: linear-gradient(to top, rgba(0,0,0,0.6) 0%, rgba(0,0,0,0.05) 50%, transparent 100%);
  display: flex;
  flex-direction: column;
  justify-content: flex-end;
  padding: 1.25rem;
}

.ot-category-card__name {
  font-family: 'Outfit', 'Inter', sans-serif;
  font-size: 1.0625rem;
  font-weight: 700;
  color: #ffffff;
}

/* ---- Product Grid (PS9 hook renders this) ---- */
#product-listing,
.product-listing,
[data-hook="displayHome"] {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 1rem;
}

/* Style PS product cards to match reference */
.product-card,
.col-xs-12.col-sm-6.col-md-4.col-lg-4 {
  background: #ffffff;
  border: 1px solid #e5e7eb;
  border-radius: 12px;
  overflow: hidden;
  transition: transform 0.2s cubic-bezier(0.4, 0, 0.2, 1),
              box-shadow 0.2s cubic-bezier(0.4, 0, 0.2, 1);
  height: 100%;
  display: flex;
  flex-direction: column;
}

.product-card:hover,
.col-xs-12.col-sm-6.col-md-4.col-lg-4:hover {
  transform: translateY(-3px);
  box-shadow: 0 8px 24px rgba(0,0,0,0.1);
}

/* ---- Brands ---- */
.ot-brands {
  padding: 3rem 0;
  border-top: 1px solid #e5e7eb;
}

.ot-brands__list {
  display: flex;
  align-items: center;
  justify-content: center;
  flex-wrap: wrap;
  gap: 1.5rem;
}

.ot-brands__item {
  font-family: 'Outfit', 'Inter', sans-serif;
  font-size: 1.25rem;
  font-weight: 700;
  color: #9ca3af;
  text-decoration: none;
  transition: color 0.15s;
  letter-spacing: -0.02em;
}

.ot-brands__item:hover {
  color: #1a202c;
  text-decoration: none;
}

/* ---- Responsive ---- */
@media (max-width: 1023px) {
  .ot-trust-bar__grid {
    grid-template-columns: repeat(2, 1fr);
    gap: 1rem;
  }
  .ot-stats__grid {
    grid-template-columns: repeat(2, 1fr);
    gap: 1rem;
  }
  .ot-category-grid {
    grid-template-columns: repeat(2, 1fr);
  }
  #product-listing,
  .product-listing,
  [data-hook="displayHome"] {
    grid-template-columns: repeat(3, 1fr);
  }
}

@media (max-width: 767px) {
  .ot-trust-bar__grid {
    grid-template-columns: 1fr;
  }
  .ot-stats__grid {
    grid-template-columns: repeat(2, 1fr);
  }
  .ot-category-grid {
    grid-template-columns: 1fr;
  }
  #product-listing,
  .product-listing,
  [data-hook="displayHome"] {
    grid-template-columns: repeat(2, 1fr);
    gap: 0.75rem;
  }
  .ot-section {
    padding: 2rem 0;
  }
  .ot-section__header {
    flex-direction: column;
    align-items: flex-start;
    gap: 0.5rem;
  }
}

@media (max-width: 479px) {
  #product-listing,
  .product-listing,
  [data-hook="displayHome"] {
    grid-template-columns: 1fr;
  }
}

{/literal}
</style>
{/block}
