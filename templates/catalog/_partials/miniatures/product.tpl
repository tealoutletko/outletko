{**
 * Outletko Teal — Product Miniature Card
 * Used in category grids, search results, related products
 *
 * Overrides: hummingbird/templates/catalog/_partials/miniatures/product.tpl
 * Variables: $product (from ProductLazyArray)
 **}

{* ---- Determine condition ---- *}
{assign var='condition_key' value=$product.condition|lower}
{assign var='condition_label' value=''}
{assign var='condition_class' value=''}
{if $condition_key == 'new' || $condition_key == 'novo'}
  {assign var='condition_label' value='Novo'}
  {assign var='condition_class' value='novo'}
{elseif $condition_key == 'used' || $condition_key == 'rabljeno'}
  {assign var='condition_label' value='Rabljeno'}
  {assign var='condition_class' value='rabljeno'}
{elseif $condition_key == 'refurbished' || $condition_key == 'obnovljeno'}
  {assign var='condition_label' value='Obnovljeno'}
  {assign var='condition_class' value='obnovljeno'}
{elseif $condition_key == 'outlet' || $condition_key == 'neprodano'}
  {assign var='condition_label' value='Outlet'}
  {assign var='condition_class' value='outlet'}
{/if}

{* ---- Discount percent ---- *}
{assign var='discount_pct' value=0}
{if isset($product.regular_price_amount) && $product.regular_price_amount > $product.price_amount}
  {assign var='discount_pct' value=(($product.regular_price_amount - $product.price_amount) / $product.regular_price_amount * 100)|round}
{/if}

<article class="ot-product-card {if isset($product.id_product)}product-miniature{/if}"
         data-ot-product-card
         data-id-product="{$product.id_product}"
         data-id-product-attribute="{$product.id_product_attribute|default:0}"
         itemscope
         itemtype="https://schema.org/Product"
         aria-label="{$product.name|escape:'html':'UTF-8'}">

  {* ---- Image ---- *}
  <div class="ot-product-card__img-wrap">

    {* Condition badge — top-left *}
    {if $condition_label}
      <div class="ot-product-card__badges" style="position:absolute;top:8px;left:8px;z-index:2;display:flex;gap:4px">
        <span class="ot-badge ot-badge--{$condition_class}">{$condition_label}</span>
      </div>
    {/if}

    {* Discount badge — top-right *}
    {if $discount_pct > 0}
      <div class="ot-product-card__discount-badge"
           style="position:absolute;top:8px;right:8px;z-index:2;background:#dc2626;color:#fff;padding:3px 8px;border-radius:var(--radius-full);font-size:var(--text-xs);font-weight:var(--fw-bold)">
        -{$discount_pct}%
      </div>
    {/if}

    {* Product image with lazy loading *}
    <a href="{$product.url|escape:'html':'UTF-8'}"
       tabindex="-1"
       aria-hidden="true"
       class="ot-product-card__img-link">
      {if isset($product.cover.bySize.home_default.url)}
        <img class="ot-product-card__img"
             src="{$product.cover.bySize.home_default.url|escape:'html':'UTF-8'}"
             alt="{$product.cover.legend|default:$product.name|escape:'html':'UTF-8'}"
             width="{$product.cover.bySize.home_default.width}"
             height="{$product.cover.bySize.home_default.height}"
             loading="lazy"
             itemprop="image">
      {else}
        <img class="ot-product-card__img"
             src="{$urls.no_picture_image.bySize.home_default.url|escape:'html':'UTF-8'}"
             alt="{$product.name|escape:'html':'UTF-8'}"
             width="250" height="250" loading="lazy">
      {/if}
    </a>

    {* Quick action overlay *}
    <div class="ot-product-card__overlay" aria-hidden="true">
      <div class="ot-product-card__quick-actions">
        {* Quick view (link to product page on mobile-first) *}
        <a href="{$product.url|escape:'html':'UTF-8'}"
           class="ot-quick-btn"
           title="Hitri pogled"
           aria-label="Hitri pogled: {$product.name|escape:'html':'UTF-8'}">
          <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true">
            <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/>
            <circle cx="12" cy="12" r="3"/>
          </svg>
        </a>

        {* Wishlist *}
        <button class="ot-quick-btn ot-quick-btn--wishlist"
                data-ot-wishlist-btn
                data-product-id="{$product.id_product}"
                type="button"
                title="Dodaj k željam"
                aria-label="Dodaj k željam: {$product.name|escape:'html':'UTF-8'}">
          <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true">
            <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"/>
          </svg>
        </button>
      </div>
    </div>

  </div>{* .ot-product-card__img-wrap *}

  {* ---- Card body ---- *}
  <div class="ot-product-card__body">

    {* Product name *}
    <a class="ot-product-card__name"
       href="{$product.url|escape:'html':'UTF-8'}"
       itemprop="name"
       title="{$product.name|escape:'html':'UTF-8'}">
      {$product.name|escape:'html':'UTF-8'}
    </a>

    {* Key specs (from product features) *}
    {if isset($product.features) && $product.features|@count > 0}
      <div class="ot-product-card__specs">
        {foreach from=$product.features item='feature' name='feat'}
          {if $smarty.foreach.feat.iteration <= 3}
            <div class="ot-product-card__spec-row">
              <span class="ot-product-card__spec-key">{$feature.name|truncate:12:'.'|escape:'html':'UTF-8'}</span>
              <span class="ot-product-card__spec-val">{$feature.value|escape:'html':'UTF-8'}</span>
            </div>
          {/if}
        {/foreach}
      </div>
    {/if}

    {* Price + ATC *}
    <div class="ot-product-card__price-block">
      <div class="ot-product-card__prices">
        {if isset($product.regular_price_amount) && $product.regular_price_amount > $product.price_amount}
          <span class="ot-product-card__price-old"
                itemprop="offers"
                itemscope itemtype="https://schema.org/Offer">
            {$product.regular_price|escape:'html':'UTF-8'}
          </span>
        {/if}
        <span class="ot-product-card__price" itemprop="price" content="{$product.price_amount}">
          {$product.price|escape:'html':'UTF-8'}
        </span>
        <span class="ot-product-card__price-tax">{l s='z DDV' d='Shop.Theme.Checkout'}</span>
        <meta itemprop="priceCurrency" content="{$currency.iso_code}">
        <meta itemprop="availability" content="{if $product.availability == 'available'}https://schema.org/InStock{else}https://schema.org/OutOfStock{/if}">
      </div>

      {* Add to cart or View button *}
      {if $product.add_to_cart_url}
        <form action="{$product.add_to_cart_url|escape:'html':'UTF-8'}" method="post">
          <input type="hidden" name="qty" value="1">
          <input type="hidden" name="add" value="1">
          <input type="hidden" name="action" value="update">
          <input type="hidden" name="token" value="{$static_token}">
          <button type="submit"
                  class="ot-product-card__atc"
                  data-button-action="add-to-cart"
                  aria-label="{l s='Dodaj v košarico' d='Shop.Theme.Actions'}: {$product.name|escape:'html':'UTF-8'}"
                  {if !$product.add_to_cart_url}disabled{/if}>
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true">
              <circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/>
              <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/>
            </svg>
            <span class="sr-only">{l s='V košarico' d='Shop.Theme.Actions'}</span>
          </button>
        </form>
      {else}
        <a href="{$product.url|escape:'html':'UTF-8'}"
           class="ot-product-card__atc"
           style="background:var(--ot-surface-2);color:var(--ot-text-muted)">
          <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true">
            <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/>
          </svg>
          <span class="sr-only">{l s='Pogled na izdelek' d='Shop.Theme.Actions'}</span>
        </a>
      {/if}
    </div>

  </div>{* .ot-product-card__body *}

</article>
