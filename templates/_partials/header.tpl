{**
 * Outletko Teal — Header partial override
 * - Top USP bar (dark navy) above the Hummingbird header
 * - Custom main horizontal category menu below the header, with the
 *   exact links requested by the store (Prenosniki, Namizni, Monitorji,
 *   Tipkovnice, Dodatki, O nas, Zaščitna stekla, Omrežje).
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
     TOP USP BAR — dark navy, always visible above displayBanner hook
     ================================================================ *}
  <div class="ot-topbar" aria-label="Ključne prednosti nakupa" data-ot-topbar>
    <div class="container">
      <ul class="ot-topbar__usp-list" data-ot-topbar-scroll>
        <li class="ot-topbar__usp-item">
          <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true">
            <rect x="1" y="3" width="15" height="13" rx="1"/><polygon points="16 8 20 8 23 11 23 16 16 16 16 8"/>
            <circle cx="5.5" cy="18.5" r="2.5"/><circle cx="18.5" cy="18.5" r="2.5"/>
          </svg>
          {l s='Brezplačna dostava za naročila nad 100 EUR' d='Shop.Theme.Global'}
        </li>
        <li class="ot-topbar__usp-item">
          <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true">
            <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/>
          </svg>
          {l s='Garancija na vse izdelke' d='Shop.Theme.Global'}
        </li>
        <li class="ot-topbar__usp-item">
          <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true">
            <rect x="1" y="3" width="15" height="13" rx="1"/><polygon points="16 8 20 8 23 11 23 16 16 16 16 8"/>
          </svg>
          {l s='Hitra dostava v 2-3 dneh' d='Shop.Theme.Global'}
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
     adjust the CMS ID in PS9 Admin → Design → Strani.
     ================================================================ *}
  <nav class="ot-main-menu" aria-label="Glavni meni kategorij" data-ot-main-menu>
    <div class="container">
      <ul class="ot-main-menu__list">
        <li><a href="{$link->getCategoryLink(3)|default:'#'|escape:'html':'UTF-8'}" class="ot-main-menu__link">Prenosniki</a></li>
        <li><a href="{$link->getCategoryLink(4)|default:'#'|escape:'html':'UTF-8'}" class="ot-main-menu__link">Namizni</a></li>
        <li><a href="{$link->getCategoryLink(5)|default:'#'|escape:'html':'UTF-8'}" class="ot-main-menu__link">Monitorji</a></li>
        <li><a href="{$link->getCategoryLink(13)|default:'#'|escape:'html':'UTF-8'}" class="ot-main-menu__link">Tipkovnice</a></li>
        <li><a href="{$link->getCategoryLink(9)|default:'#'|escape:'html':'UTF-8'}" class="ot-main-menu__link">Dodatki</a></li>
        <li><a href="{$link->getCMSLink(1)|default:'#'|escape:'html':'UTF-8'}" class="ot-main-menu__link">O nas</a></li>
        <li><a href="{$link->getCategoryLink(14)|default:'#'|escape:'html':'UTF-8'}" class="ot-main-menu__link">Zaščitna stekla</a></li>
        <li><a href="{$link->getCategoryLink(12)|default:'#'|escape:'html':'UTF-8'}" class="ot-main-menu__link">Omrežje</a></li>
      </ul>
    </div>
  </nav>
{/block}
