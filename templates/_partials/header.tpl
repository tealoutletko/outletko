{**
 * Outletko Teal — Header partial override
 * Adds a dark/contrast "Top USP bar" above the Hummingbird header with the
 * store's key purchase benefits (free shipping, warranty, delivery, returns).
 *
 * Overrides: hummingbird/templates/_partials/header.tpl
 * Block reference (Hummingbird): header_banner, header_nav, header_bottom
 **}
{extends file='parent:_partials/header.tpl'}

{block name='header_banner'}

  {* ================================================================
     TOP USP BAR — always visible, above displayBanner hook content
     ================================================================ *}
  <div class="ot-topbar" aria-label="Ključne prednosti nakupa" data-ot-topbar>
    <div class="container">
      <ul class="ot-topbar__usp-list" data-ot-topbar-scroll>
        <li class="ot-topbar__usp-item">
          <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true">
            <rect x="1" y="3" width="15" height="13" rx="1"/><polygon points="16 8 20 8 23 11 23 16 16 16 16 8"/>
            <circle cx="5.5" cy="18.5" r="2.5"/><circle cx="18.5" cy="18.5" r="2.5"/>
          </svg>
          {l s='Brezplačna dostava nad 100 €' d='Shop.Theme.Global'}
        </li>
        <li class="ot-topbar__usp-item">
          <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true">
            <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/>
          </svg>
          {l s='12 mesecev garancije na vse izdelke' d='Shop.Theme.Global'}
        </li>
        <li class="ot-topbar__usp-item">
          <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true">
            <rect x="1" y="3" width="15" height="13" rx="1"/><polygon points="16 8 20 8 23 11 23 16 16 16 16 8"/>
          </svg>
          {l s='Hitra dostava 2-3 dni' d='Shop.Theme.Global'}
        </li>
        <li class="ot-topbar__usp-item">
          <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true">
            <polyline points="23 4 23 10 17 10"/><polyline points="1 20 1 14 7 14"/>
            <path d="M3.51 9a9 9 0 0 1 14.85-3.36L23 10M1 14l4.64 4.36A9 9 0 0 0 20.49 15"/>
          </svg>
          {l s='14 dni za vračilo' d='Shop.Theme.Global'}
        </li>
      </ul>
    </div>
  </div>

  {* Preserve default Hummingbird banner (hook displayBanner) below our bar *}
  {$smarty.block.parent}
{/block}
