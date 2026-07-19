{**
 * Outletko Teal — Product Detail Page
 * Full gallery, specs, price, ATC, tabs, related products
 *
 * Overrides: hummingbird/templates/catalog/product.tpl
 * Variables: $product, $breadcrumb, $currency
 **}
{extends file='page.tpl'}

{block name='head' append}
  {* Product JSON-LD schema *}
  {include file='_partials/microdata/product.tpl' product=$product}
{/block}

{block name='page_title'}{* Suppress default h1 — we render our own *}{/block}

{block name='page_content_container'}
<div class="ot-product-page">
  <div class="container">

    {* ---- Breadcrumb ---- *}
    {if isset($breadcrumb.links) && $breadcrumb.links|@count > 1}
    <nav aria-label="Krušna pot" class="ot-breadcrumb-wrap" style="padding:12px 0 24px">
      <ol class="ot-breadcrumb" itemscope itemtype="https://schema.org/BreadcrumbList">
        {foreach from=$breadcrumb.links item='link' name='bc'}
        <li class="ot-breadcrumb__item"
            itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
          {if !$smarty.foreach.bc.last}
            <a class="ot-breadcrumb__link" href="{$link.url|escape:'html':'UTF-8'}" itemprop="item">
              <span itemprop="name">{$link.title|escape:'html':'UTF-8'}</span>
            </a>
            <meta itemprop="position" content="{$smarty.foreach.bc.iteration}">
            <span class="ot-breadcrumb__sep" aria-hidden="true">/</span>
          {else}
            <span class="ot-breadcrumb__current" aria-current="page" itemprop="name">
              {$link.title|escape:'html':'UTF-8'}
            </span>
            <meta itemprop="position" content="{$smarty.foreach.bc.iteration}">
          {/if}
        </li>
        {/foreach}
      </ol>
    </nav>
    {/if}

    {* ================================================================
       PRODUCT MAIN: Gallery + Info
       ================================================================ *}
    <div class="ot-product-main" id="main">

      {* ---- LEFT: GALLERY ---- *}
      <div class="ot-gallery">

        {* Main image *}
        <div class="ot-gallery__main-wrap" data-ot-gallery-main-wrap>
          {if isset($product.cover.bySize.large_default.url)}
            <img class="ot-gallery__main-img"
                 id="ot-main-img"
                 data-ot-gallery-main
                 src="{$product.cover.bySize.large_default.url|escape:'html':'UTF-8'}"
                 alt="{$product.cover.legend|default:$product.name|escape:'html':'UTF-8'}"
                 width="800" height="800"
                 loading="eager"
                 fetchpriority="high">
          {/if}
          <div class="ot-gallery__zoom-hint" aria-hidden="true">
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="11" cy="11" r="8"/><path d="m21 21-4.35-4.35"/><line x1="11" y1="8" x2="11" y2="14"/><line x1="8" y1="11" x2="14" y2="11"/></svg>
            Zoom
          </div>
        </div>

        {* Thumbnails *}
        {if isset($product.images) && $product.images|@count > 1}
          <div class="ot-gallery__thumbs" role="list" aria-label="Slike izdelka">
            {foreach from=$product.images item='image' name='img'}
              <div class="ot-gallery__thumb {if $smarty.foreach.img.first}is-active{/if}"
                   data-ot-gallery-thumb
                   data-src="{$image.bySize.large_default.url|escape:'html':'UTF-8'}"
                   role="listitem"
                   tabindex="0"
                   aria-label="Slika {$smarty.foreach.img.iteration}">
                <img src="{$image.bySize.small_default.url|escape:'html':'UTF-8'}"
                     alt="{$image.legend|default:$product.name|escape:'html':'UTF-8'}"
                     width="72" height="72"
                     loading="lazy">
              </div>
            {/foreach}
          </div>
        {/if}

        {* Lightbox *}
        <div class="ot-lightbox" data-ot-lightbox role="dialog" aria-modal="true" aria-label="Povečava slike">
          <img class="ot-lightbox__img" data-ot-lightbox-img src="" alt="">
          <button class="ot-lightbox__close" data-ot-lightbox-close aria-label="Zapri">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true">
              <line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/>
            </svg>
          </button>
          <button class="ot-lightbox__nav ot-lightbox__nav--prev" data-ot-lightbox-prev aria-label="Prejšnja slika">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true"><path d="M15 18l-6-6 6-6"/></svg>
          </button>
          <button class="ot-lightbox__nav ot-lightbox__nav--next" data-ot-lightbox-next aria-label="Naslednja slika">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true"><path d="M9 18l6-6-6-6"/></svg>
          </button>
        </div>

      </div>{* .ot-gallery *}

      {* ---- RIGHT: PRODUCT INFO ---- *}
      <div class="ot-product-info">

        {* Badges row *}
        <div class="ot-product-info__badges">
          {if isset($product.condition) && $product.condition}
            {assign var='cond' value=$product.condition|lower}
            {if $cond == 'new' || $cond == 'novo'}
              <span class="ot-badge ot-badge--novo">✓ Novo</span>
            {elseif $cond == 'refurbished' || $cond == 'obnovljeno'}
              <span class="ot-badge ot-badge--obnovljeno">↺ Obnovljeno</span>
            {elseif $cond == 'used' || $cond == 'rabljeno'}
              <span class="ot-badge ot-badge--rabljeno">♻ Rabljeno</span>
            {elseif $cond == 'outlet' || $cond == 'neprodano'}
              <span class="ot-badge ot-badge--outlet">% Outlet</span>
            {/if}
          {/if}
          {if isset($product.new) && $product.new}
            <span class="ot-badge ot-badge--promo">NOVOST</span>
          {/if}
          {if isset($product.on_sale) && $product.on_sale}
            <span class="ot-badge ot-badge--promo">AKCIJA</span>
          {/if}
        </div>

        {* Title *}
        <h1 class="ot-product-info__title" itemprop="name">
          {$product.name|escape:'html':'UTF-8'}
        </h1>

        {* Reference *}
        {if isset($product.reference) && $product.reference}
          <p class="ot-product-ref" style="font-size:var(--text-xs);color:var(--ot-text-muted);margin:0">
            {l s='Ref.' d='Shop.Theme.Catalog'}: <strong>{$product.reference|escape:'html':'UTF-8'}</strong>
          </p>
        {/if}

        {* Price block *}
        <div class="ot-product-info__price-block">
          {if isset($product.regular_price_amount) && $product.regular_price_amount > $product.price_amount}
            <div class="ot-product-price__old">
              <span class="ot-product-price__old-val">{$product.regular_price|escape:'html':'UTF-8'}</span>
              {assign var='saving_pct' value=(($product.regular_price_amount - $product.price_amount) / $product.regular_price_amount * 100)|round}
              <span class="ot-product-price__saving">-{$saving_pct}%</span>
            </div>
          {/if}
          <div class="ot-product-price__current" itemprop="price" content="{$product.price_amount}">
            {$product.price|escape:'html':'UTF-8'}
          </div>
          <div class="ot-product-price__tax">{l s='z DDV' d='Shop.Theme.Checkout'}</div>
          <meta itemprop="priceCurrency" content="{$currency.iso_code}">
        </div>

        {* Condition explanation box *}
        {if isset($product.condition) && $product.condition}
          {assign var='cond' value=$product.condition|lower}
          <div class="ot-condition-box ot-condition-box--{if $cond == 'new' || $cond == 'novo'}novo{elseif $cond == 'refurbished' || $cond == 'obnovljeno'}obnovljeno{elseif $cond == 'used' || $cond == 'rabljeno'}rabljeno{else}outlet{/if}">
            <div class="ot-condition-box__icon">
              {if $cond == 'new' || $cond == 'novo'}
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true"><polyline points="20 6 9 17 4 12"/></svg>
              {elseif $cond == 'refurbished' || $cond == 'obnovljeno'}
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true"><polyline points="23 4 23 10 17 10"/><polyline points="1 20 1 14 7 14"/><path d="M3.51 9a9 9 0 0 1 14.85-3.36L23 10M1 14l4.64 4.36A9 9 0 0 0 20.49 15"/></svg>
              {else}
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true"><path d="M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z"/></svg>
              {/if}
            </div>
            <div>
              <div class="ot-condition-box__title">
                {if $cond == 'new' || $cond == 'novo'}Originalno novo{elseif $cond == 'refurbished' || $cond == 'obnovljeno'}Profesionalno obnovljeno{elseif $cond == 'used' || $cond == 'rabljeno'}Rabljeno — preverjena oprema{else}Outlet — novo po znižani ceni{/if}
              </div>
              <p class="ot-condition-box__desc">
                {if $cond == 'new' || $cond == 'novo'}Originalna embalaža, nikoli ni bil v uporabi. Polna garancija proizvajalca.
                {elseif $cond == 'refurbished' || $cond == 'obnovljeno'}Preverjen, očiščen in testiran s strani naših tehnikov. Garancija TEAL d.o.o.
                {elseif $cond == 'used' || $cond == 'rabljeno'}Deluje brezhibno. Vidni znaki staranja so možni. Vizualno preverjen pred prodajo.
                {else}Novo blago, ki ni bilo prodano v redni prodaji. Polna garancija, znižana cena.{/if}
              </p>
            </div>
          </div>
        {/if}

        {* ATC Group *}
        {block name='product_add_to_cart'}
        <div class="ot-product-atc">
          {if $product.availability == 'available' || $product.availability == 'last_remaining_items'}

            <div class="ot-product-atc__qty">
              <span class="ot-product-atc__qty-label">{l s='Količina' d='Shop.Theme.Catalog'}:</span>
              <div class="ot-qty-control" data-ot-qty-wrap>
                <button class="ot-qty-btn"
                        data-ot-qty-btn="dec"
                        type="button"
                        aria-label="Zmanjšaj količino">−</button>
                <input class="ot-qty-input"
                       data-ot-qty-input
                       type="number"
                       name="qty"
                       value="1"
                       min="1"
                       max="{$product.quantity}"
                       aria-label="Količina">
                <button class="ot-qty-btn"
                        data-ot-qty-btn="inc"
                        type="button"
                        aria-label="Povečaj količino">+</button>
              </div>
            </div>

            <div class="ot-product-atc__main">
              <form action="{$product.add_to_cart_url|escape:'html':'UTF-8'}"
                    method="post"
                    id="add-to-cart-or-refresh"
                    style="flex:1">
                <input type="hidden" name="add" value="1">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="token" value="{$static_token}">
                <input type="hidden" id="product_page_product_id"
                       name="id_product" value="{$product.id_product}">
                <input type="hidden" id="product_page_product_id_attribute"
                       name="id_product_attribute"
                       value="{$product.id_product_attribute|default:0}">

                <button type="submit"
                        id="add-to-cart-button"
                        data-button-action="add-to-cart"
                        class="ot-btn-atc"
                        data-ot-atc-trigger>
                  <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true">
                    <circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/>
                    <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/>
                  </svg>
                  {l s='Dodaj v košarico' d='Shop.Theme.Actions'}
                </button>
              </form>

              <button class="ot-btn-wishlist-full"
                      data-ot-wishlist-btn
                      data-product-id="{$product.id_product}"
                      type="button"
                      aria-label="{l s='Dodaj k željam' d='Shop.Theme.Actions'}">
                <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true">
                  <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"/>
                </svg>
              </button>
            </div>

          {else}
            <div class="ot-product-unavail" style="padding:16px;background:var(--ot-surface);border-radius:var(--radius-lg);text-align:center;color:var(--ot-text-muted);font-size:var(--text-sm)">
              <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="margin-bottom:8px" aria-hidden="true"><circle cx="12" cy="12" r="10"/><line x1="8" y1="12" x2="16" y2="12"/></svg>
              <br>
              {l s='Izdelek je trenutno nedosegljiv' d='Shop.Theme.Catalog'}
            </div>
          {/if}
        </div>
        {/block}

        {* Trust row *}
        <div class="ot-product-trust">
          <div class="ot-product-trust__item">
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" aria-hidden="true">
              <rect x="1" y="3" width="15" height="13" rx="1"/><polygon points="16 8 20 8 23 11 23 16 16 16 16 8"/>
              <circle cx="5.5" cy="18.5" r="2.5"/><circle cx="18.5" cy="18.5" r="2.5"/>
            </svg>
            <span class="ot-product-trust__label">Brezplačna dostava nad 100 €</span>
          </div>
          <div class="ot-product-trust__item">
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" aria-hidden="true">
              <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/>
            </svg>
            <span class="ot-product-trust__label">Garancija vključena</span>
          </div>
          <div class="ot-product-trust__item">
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" aria-hidden="true">
              <polyline points="23 4 23 10 17 10"/><polyline points="1 20 1 14 7 14"/>
              <path d="M3.51 9a9 9 0 0 1 14.85-3.36L23 10M1 14l4.64 4.36A9 9 0 0 0 20.49 15"/>
            </svg>
            <span class="ot-product-trust__label">14-dnevni umik</span>
          </div>
        </div>

        {* Share / hook *}
        {hook h='displayProductButtons'}

      </div>{* .ot-product-info *}
    </div>{* .ot-product-main *}

    {* ================================================================
       PRODUCT TABS: Description, Specs, Shipping
       ================================================================ *}
    <div class="ot-specs-tabs" id="product-details">

      <div class="ot-tabs__list" data-ot-tabs role="tablist" aria-label="Podrobnosti izdelka">
        <button class="ot-tab-btn is-active"
                data-ot-tab="description"
                role="tab"
                aria-selected="true"
                aria-controls="tab-description"
                id="tab-btn-description">
          Opis
        </button>
        <button class="ot-tab-btn"
                data-ot-tab="specs"
                role="tab"
                aria-selected="false"
                aria-controls="tab-specs"
                id="tab-btn-specs">
          Specifikacije
        </button>
        <button class="ot-tab-btn"
                data-ot-tab="shipping"
                role="tab"
                aria-selected="false"
                aria-controls="tab-shipping"
                id="tab-btn-shipping">
          Dostava &amp; vračilo
        </button>
      </div>

      {* Description tab *}
      <div class="ot-tab-panel is-active"
           id="tab-description"
           data-ot-tab-panel="description"
           role="tabpanel"
           aria-labelledby="tab-btn-description"
           itemprop="description">
        {if isset($product.description) && $product.description}
          <div class="ot-product-description">
            {$product.description nofilter}
          </div>
        {else}
          <p style="color:var(--ot-text-muted)">{l s='Opis ni na voljo.' d='Shop.Theme.Catalog'}</p>
        {/if}
      </div>

      {* Specs tab *}
      <div class="ot-tab-panel"
           id="tab-specs"
           data-ot-tab-panel="specs"
           role="tabpanel"
           aria-labelledby="tab-btn-specs">
        {if isset($product.features) && $product.features|@count > 0}
          <table class="ot-specs-table" aria-label="Tehnične specifikacije">
            <tbody>
              {foreach from=$product.features item='feature'}
                <tr>
                  <td class="spec-key">{$feature.name|escape:'html':'UTF-8'}</td>
                  <td class="spec-val">{$feature.value|escape:'html':'UTF-8'}</td>
                </tr>
              {/foreach}
            </tbody>
          </table>
        {else}
          <p style="color:var(--ot-text-muted)">{l s='Specifikacije niso na voljo.' d='Shop.Theme.Catalog'}</p>
        {/if}
      </div>

      {* Shipping tab *}
      <div class="ot-tab-panel"
           id="tab-shipping"
           data-ot-tab-panel="shipping"
           role="tabpanel"
           aria-labelledby="tab-btn-shipping">
        <div class="ot-shipping-info">
          {* PS9: displayProductDeliveryTime renders delivery info from carrier settings *}
          {hook h='displayProductDeliveryTime' product=$product}
          {* Fallback static text — always shown; if hook renders too, admin can disable via module *}
          <p><strong>Dostava:</strong> Standardna dostava 2–5 delovnih dni. Brezplačno za naročila nad 100 €.</p>
          <p><strong>Prevzem v trgovini:</strong> Laško (Aškerčeva 4) in Celje (Mariborska 7). Brezplačno.</p>
          <p><strong>Vračilo:</strong> 14-dnevni umik brez navajanja razlogov v skladu z ZVPK.</p>
        </div>
      </div>

    </div>{* .ot-specs-tabs *}

    {* ================================================================
       RELATED PRODUCTS
       ================================================================ *}
    <section class="ot-related" aria-label="Sorodne izdelke">
      <h2 class="ot-section-title ot-section-title--underline">Sorodne izdelke</h2>
      <div class="ot-related__grid">
        {hook h='displayCrossSelling'}
        {hook h='displayFooterProduct'}
      </div>
    </section>

    {* Product hooks *}
    {hook h='displayProductAdditionalInfo'}

  </div>{* .container *}

  {* ================================================================
     STICKY ADD-TO-CART BAR (appears when main ATC scrolls out)
     ================================================================ *}
  <div class="ot-sticky-atc" data-ot-sticky-atc aria-label="Hitro dodaj v košarico">
    <div class="container">
      <div class="ot-sticky-atc__product">
        {if isset($product.cover.bySize.small_default.url)}
          <img class="ot-sticky-atc__img"
               src="{$product.cover.bySize.small_default.url|escape:'html':'UTF-8'}"
               alt="{$product.name|escape:'html':'UTF-8'}"
               width="44" height="44">
        {/if}
        <span class="ot-sticky-atc__name">{$product.name|escape:'html':'UTF-8'}</span>
      </div>
      <span class="ot-sticky-atc__price">{$product.price|escape:'html':'UTF-8'}</span>
      <button class="ot-btn-atc"
              id="ot-sticky-atc-btn"
              type="button"
              onclick="document.getElementById('add-to-cart-button').click()">
        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true">
          <circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/>
          <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/>
        </svg>
        {l s='V košarico' d='Shop.Theme.Actions'}
      </button>
    </div>
  </div>

</div>{* .ot-product-page *}
{/block}
