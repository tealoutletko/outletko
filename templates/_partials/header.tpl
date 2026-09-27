{**
 * Outletko DCC — Header partial override
 * - Top B2B info bar (subtle dark graphite) above the Hummingbird header
 * - Custom main horizontal category menu below the header, with the
 *   exact links requested by the store (Prenosniki, Računalniki,
 *   Monitorji, Strežniki, Krožna IT ponudba, O nas).
 *
 * Overrides: hummingbird/templates/_partials/header.tpl
 * Block reference (Hummingbird): header_banner, header_nav, header_bottom
 * Real module markup kept intact (search/account/cart still render via
 * their own PS modules through the `displayTop` hook) — only visual
 * polish is applied via CSS (see components/header.css).
 **}
{extends file='parent:_partials/header.tpl'}

{block name='header_banner'}

  {* ================================================================
     TOP B2B INFO BAR — subtle dark graphite, always visible above
     the displayBanner hook
     ================================================================ *}
  <div class="ot-topbar" aria-label="B2B prednosti" data-ot-topbar>
    <div class="container">
      <ul class="ot-topbar__usp-list" data-ot-topbar-scroll>
        <li class="ot-topbar__usp-item">
          <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true">
            <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/>
          </svg>
          {l s='Pooblaščeni partner za obnovljeno IT opremo' d='Shop.Theme.Global'}
        </li>
        <li class="ot-topbar__usp-item">
          <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true">
            <polyline points="23 4 23 10 17 10"/><polyline points="1 20 1 14 7 14"/>
            <path d="M3.51 9a9 9 0 0 1 14.85-3.36L23 10M1 14l4.64 4.36A9 9 0 0 0 20.49 15"/>
          </svg>
          {l s='Garancija do 24 mesecev' d='Shop.Theme.Global'}
        </li>
        <li class="ot-topbar__usp-item">
          <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true">
            <rect x="1" y="3" width="15" height="13" rx="1"/><polygon points="16 8 20 8 23 11 23 16 16 16 16 8"/>
          </svg>
          {l s='Hitra B2B dostava' d='Shop.Theme.Global'}
        </li>
      </ul>
    </div>
  </div>

  {* Preserve default Hummingbird banner (hook displayBanner) below our bar *}
  {$smarty.block.parent}
{/block}

{block name='header_bottom'}
  {* Keep Hummingbird's real header markup intact — logo + search + account
     + cart are all rendered by their own PS modules (search_widget,
     header-block, etc.) via the displayTop hook. We only add visual
     polish through CSS (see components/header.css). *}
  {$smarty.block.parent}

  {* ================================================================
     MAIN CATEGORY MENU — hardcoded per store requirements.
     Replace category IDs with the actual IDs from your catalog
     (PS9 Admin → Katalog → Kategorije). "O nas" points to a CMS page —
     adjust the CMS ID in PS9 Admin → Design → Strani. "Krožna IT
     ponudba" should point to the category collecting all Grade A/B
     circular/refurbished products (e.g. category 2, or a dedicated one).
     ================================================================ *}
  <nav class="ot-main-menu" aria-label="Glavni meni kategorij" data-ot-main-menu>
    <div class="container">
      <ul class="ot-main-menu__list">
        <li><a href="{$link->getCategoryLink(3)|default:'#'|escape:'html':'UTF-8'}" class="ot-main-menu__link">Prenosniki</a></li>
        <li><a href="{$link->getCategoryLink(4)|default:'#'|escape:'html':'UTF-8'}" class="ot-main-menu__link">Računalniki</a></li>
        <li><a href="{$link->getCategoryLink(5)|default:'#'|escape:'html':'UTF-8'}" class="ot-main-menu__link">Monitorji</a></li>
        <li><a href="{$link->getCategoryLink(8)|default:'#'|escape:'html':'UTF-8'}" class="ot-main-menu__link">Strežniki</a></li>
        <li><a href="{$link->getCategoryLink(2)|default:'#'|escape:'html':'UTF-8'}" class="ot-main-menu__link ot-main-menu__link--highlight">Krožna IT ponudba</a></li>
        <li><a href="{$link->getCMSLink(1)|default:'#'|escape:'html':'UTF-8'}" class="ot-main-menu__link">O nas</a></li>
      </ul>
    </div>
  </nav>
{/block}
