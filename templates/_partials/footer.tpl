{**
 * Outletko Teal — Mobile Bottom Navigation
 * Fixed bottom nav bar for mobile (< 768px)
 * Included via hook displayBeforeBodyClosingTag via module, or directly in layout.tpl
 *
 * Overrides: hummingbird/templates/_partials/footer.tpl (append block)
 **}
{extends file='parent:_partials/footer.tpl'}

{block name='footer_container' append}

{* ================================================================
   MOBILE BOTTOM NAVIGATION BAR
   Hidden on desktop via CSS
   ================================================================ *}
<nav class="ot-bottom-nav" aria-label="Mobilna navigacija" role="navigation">

  {* Home *}
  <a class="ot-bottom-nav__item {if $page.page_name == 'index'}is-active{/if}"
     href="{$urls.base_url|escape:'html':'UTF-8'}"
     data-ot-bottom-nav-item
     data-href="/"
     aria-label="Domov">
    <span class="ot-bottom-nav__icon" aria-hidden="true">
      <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
        <path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/>
        <polyline points="9 22 9 12 15 12 15 22"/>
      </svg>
    </span>
    <span class="ot-bottom-nav__label">Domov</span>
  </a>

  {* Categories *}
  <a class="ot-bottom-nav__item {if $page.page_name == 'category'}is-active{/if}"
     href="{$link->getCategoryLink(2)|escape:'html':'UTF-8'}"
     data-ot-bottom-nav-item
     aria-label="Kategorije">
    <span class="ot-bottom-nav__icon" aria-hidden="true">
      <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
        <rect x="3" y="3" width="7" height="7"/><rect x="14" y="3" width="7" height="7"/>
        <rect x="14" y="14" width="7" height="7"/><rect x="3" y="14" width="7" height="7"/>
      </svg>
    </span>
    <span class="ot-bottom-nav__label">Kategorije</span>
  </a>

  {* Search *}
  <a class="ot-bottom-nav__item {if $page.page_name == 'search'}is-active{/if}"
     href="{$link->getPageLink('search')|escape:'html':'UTF-8'}"
     data-ot-bottom-nav-item
     aria-label="Iskanje">
    <span class="ot-bottom-nav__icon" aria-hidden="true">
      <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
        <circle cx="11" cy="11" r="8"/><path d="m21 21-4.35-4.35"/>
      </svg>
    </span>
    <span class="ot-bottom-nav__label">Iskanje</span>
  </a>

  {* Cart *}
  <a class="ot-bottom-nav__item {if $page.page_name == 'cart'}is-active{/if}"
     href="{$link->getPageLink('cart', null, null, ['action' => 'show'])|escape:'html':'UTF-8'}"
     data-ot-bottom-nav-item
     aria-label="Košarica {if isset($cart.products_count) && $cart.products_count > 0}({$cart.products_count}){/if}">
    <span class="ot-bottom-nav__icon" aria-hidden="true" style="position:relative">
      <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
        <circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/>
        <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/>
      </svg>
      {if isset($cart.products_count) && $cart.products_count > 0}
        <span class="ot-icon-btn__badge"
              data-ot-cart-count
              aria-hidden="true"
              style="position:absolute;top:-6px;right:-6px">
          {$cart.products_count}
        </span>
      {/if}
    </span>
    <span class="ot-bottom-nav__label">Košarica</span>
  </a>

  {* Account *}
  <a class="ot-bottom-nav__item {if $page.page_name == 'my-account' || $page.page_name == 'authentication'}is-active{/if}"
     href="{if $customer.is_logged}
               {$link->getPageLink('my-account')|escape:'html':'UTF-8'}
             {else}
               {$link->getPageLink('authentication', null, null, ['back' => $urls.current_url|escape:'html':'UTF-8'])|escape:'html':'UTF-8'}
             {/if}"
     data-ot-bottom-nav-item
     aria-label="{if $customer.is_logged}Moj račun{else}Prijava{/if}">
    <span class="ot-bottom-nav__icon" aria-hidden="true">
      <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
        <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/>
        <circle cx="12" cy="7" r="4"/>
      </svg>
    </span>
    <span class="ot-bottom-nav__label">{if $customer.is_logged}Račun{else}Prijava{/if}</span>
  </a>

</nav>

{* Back-to-top button *}
<button class="ot-back-top"
        data-ot-back-top
        type="button"
        aria-label="Nazaj na vrh">
  <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" aria-hidden="true">
    <path d="M18 15l-6-6-6 6"/>
  </svg>
</button>

{/block}
