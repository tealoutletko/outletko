{**
 * Outletko Teal — Category Page (catalog/listing.tpl)
 * Left-column layout: Filters sidebar + product grid
 *
 * Overrides: hummingbird/templates/catalog/listing.tpl
 * Variables: $category, $products, $listing, $breadcrumb,
 *            $facets, $sort_orders, $pagination
 **}
{extends file='page.tpl'}

{block name='page_title'}{* suppress default h1 *}{/block}

{block name='page_content_container'}

  {* ================================================================
     SEO BREADCRUMB
     ================================================================ *}
  {if isset($breadcrumb.links) && $breadcrumb.links|@count > 1}
  <nav aria-label="Krušna pot" class="ot-breadcrumb-wrap">
    <div class="container">
      <ol class="ot-breadcrumb" itemscope itemtype="https://schema.org/BreadcrumbList">
        {foreach from=$breadcrumb.links item='link' name='bc'}
        <li class="ot-breadcrumb__item"
            itemprop="itemListElement"
            itemscope itemtype="https://schema.org/ListItem">
          {if !$smarty.foreach.bc.last}
            <a class="ot-breadcrumb__link"
               href="{$link.url|escape:'html':'UTF-8'}"
               itemprop="item">
              <span itemprop="name">{$link.title|escape:'html':'UTF-8'}</span>
            </a>
            <meta itemprop="position" content="{$smarty.foreach.bc.iteration}">
            <span class="ot-breadcrumb__sep" aria-hidden="true">/</span>
          {else}
            <span class="ot-breadcrumb__current" itemprop="name" aria-current="page">
              {$link.title|escape:'html':'UTF-8'}
            </span>
            <meta itemprop="position" content="{$smarty.foreach.bc.iteration}">
          {/if}
        </li>
        {/foreach}
      </ol>
    </div>
  </nav>
  {/if}

  {* ================================================================
     CATEGORY HERO BANNER
     ================================================================ *}
  <header class="ot-cat-hero" aria-label="Kategorija: {$listing.label|default:$category.name|escape:'html':'UTF-8'}">
    <div class="container">
      <h1 class="ot-cat-hero__title">
        {$listing.label|default:$category.name|escape:'html':'UTF-8'}
      </h1>
      {if isset($category.description) && $category.description}
        <p class="ot-cat-hero__desc">
          {$category.description|strip_tags|truncate:200:'…'|escape:'html':'UTF-8'}
        </p>
      {/if}
      <div class="ot-cat-hero__meta">
        {if isset($listing.products_count)}
          <span class="ot-cat-hero__count">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true">
              <rect x="1" y="3" width="15" height="13" rx="1"/>
              <polygon points="16 8 20 8 23 11 23 16 16 16 16 8"/>
            </svg>
            {$listing.products_count} {if $listing.products_count == 1}izdelek{else}izdelkov{/if}
          </span>
        {/if}
      </div>
    </div>
  </header>

  {* ================================================================
     SUBCATEGORY GRID (if has children)
     ================================================================ *}
  {if isset($subcategories) && $subcategories|@count > 0}
  <div class="container">
    <nav class="ot-subcat-grid" aria-label="Podkategorije">
      {foreach from=$subcategories item='subcat'}
        <a href="{$link->getCategoryLink($subcat.id_category, $subcat.link_rewrite)|escape:'html':'UTF-8'}"
           class="ot-subcat-card">
          {if isset($subcat.image.bySize.medium_default.url)}
            <img src="{$subcat.image.bySize.medium_default.url|escape:'html':'UTF-8'}"
                 alt="{$subcat.name|escape:'html':'UTF-8'}"
                 class="ot-subcat-card__img" width="60" height="60" loading="lazy">
          {else}
            <div class="ot-subcat-card__icon">
              <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6" aria-hidden="true">
                <rect x="2" y="3" width="20" height="14" rx="2"/>
              </svg>
            </div>
          {/if}
          <span class="ot-subcat-card__name">{$subcat.name|escape:'html':'UTF-8'}</span>
          {if isset($subcat.products_count) && $subcat.products_count}
            <span class="ot-subcat-card__count">{$subcat.products_count}</span>
          {/if}
        </a>
      {/foreach}
    </nav>
  </div>
  {/if}

  {* ================================================================
     MAIN LISTING AREA
     ================================================================ *}
  <div class="container">
    <div class="ot-category-layout" id="js-product-list-top">

      {* ---- FILTER SIDEBAR ---- *}
      <aside class="ot-filters-sidebar" id="search_filters_wrapper" aria-label="Filtri">

        <div class="ot-filters__header">
          <h2 class="ot-filters__title">
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true">
              <polygon points="22 3 2 3 10 12.46 10 19 14 21 14 12.46 22 3"/>
            </svg>
            Filtri
          </h2>
          <button class="ot-filters__clear-all {if isset($current_url_without_filters)}is-visible{/if}"
                  data-ot-filters-clear-all
                  type="button"
                  aria-label="Počisti vse filtre">
            Počisti vse
          </button>
        </div>

        {* Active filter chips *}
        <div class="ot-active-filters" data-ot-active-filters aria-label="Aktivni filtri" aria-live="polite"></div>

        {* PS9 faceted search renders here via hook displayLeftColumn *}
        {hook h='displayLeftColumn'}

        {* Manual facets fallback — only if ps_facetedsearch not active *}
        {if isset($facets)}
          {foreach from=$facets item='facet'}
            <div class="ot-filter-group"
                 data-ot-filter-group
                 data-filter-group-id="{$facet.label|lower|replace:' ':'-'}">

              <button class="ot-filter-group__toggle"
                      data-ot-filter-group-toggle
                      aria-expanded="true"
                      aria-controls="facet-{$facet.label|lower|replace:' ':'-'}">
                <span class="ot-filter-group__name">{$facet.label|escape:'html':'UTF-8'}</span>
                <svg class="ot-filter-group__chevron" width="16" height="16" viewBox="0 0 24 24"
                     fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true">
                  <path d="M6 9l6 6 6-6"/>
                </svg>
              </button>

              <div class="ot-filter-group__body"
                   id="facet-{$facet.label|lower|replace:' ':'-'}"
                   data-ot-filter-list>
                {foreach from=$facet.filters item='filter' name='filt'}
                  {if $smarty.foreach.filt.iteration <= 6}
                    <label class="ot-filter-check
                                  {if $facet.label == 'Stanje' && $filter.label == 'Novo'} ot-filter-check--novo{/if}
                                  {if $facet.label == 'Stanje' && $filter.label == 'Outlet'} ot-filter-check--outlet{/if}
                                  {if $facet.label == 'Stanje' && $filter.label == 'Obnovljeno'} ot-filter-check--obnovljeno{/if}"
                           data-ot-filter-item>
                      <input type="checkbox"
                             class="ot-filter-check__input"
                             name="{$filter.facetEncodedName}"
                             value="{$filter.encodedFacetFilters}"
                             {if $filter.active}checked{/if}>
                      <span class="ot-filter-check__label">{$filter.label|escape:'html':'UTF-8'}</span>
                      <span class="ot-filter-check__count">{$filter.count}</span>
                    </label>
                  {/if}
                  {if $smarty.foreach.filt.iteration == 7}
                  {* extra items hidden until "show more" *}
                  {/if}
                  {if $smarty.foreach.filt.iteration > 6}
                    <label class="ot-filter-check ot-filter-item--hidden" data-ot-filter-item>
                      <input type="checkbox"
                             class="ot-filter-check__input"
                             name="{$filter.facetEncodedName}"
                             value="{$filter.encodedFacetFilters}"
                             {if $filter.active}checked{/if}>
                      <span class="ot-filter-check__label">{$filter.label|escape:'html':'UTF-8'}</span>
                      <span class="ot-filter-check__count">{$filter.count}</span>
                    </label>
                  {/if}
                {/foreach}

                {if $facet.filters|@count > 6}
                  <button class="ot-filter-show-more"
                          data-ot-filter-show-more
                          data-limit="6"
                          type="button">
                    <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true">
                      <path d="M6 9l6 6 6-6"/>
                    </svg>
                    <span data-show-text>Pokaži več</span>
                  </button>
                {/if}
              </div>
            </div>
          {/foreach}
        {/if}

      </aside>

      {* ---- PRODUCT LIST AREA ---- *}
      <div class="ot-listing-main">

        {* ---- Sub-header bar ---- *}
        <div class="ot-listing-bar" role="toolbar" aria-label="Sortiranje in pogled">
          <div class="ot-listing-bar__left">
            {* Mobile filter button *}
            <button class="ot-filter-toggle-btn"
                    data-ot-filter-open
                    type="button"
                    aria-expanded="false"
                    aria-controls="ot-filter-sheet"
                    aria-label="Odpri filtre">
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true">
                <polygon points="22 3 2 3 10 12.46 10 19 14 21 14 12.46 22 3"/>
              </svg>
              Filtri
              <span class="ot-filter-toggle-btn__badge"
                    data-ot-filter-badge
                    aria-live="polite"
                    aria-label="Število aktivnih filtrov"></span>
            </button>

            {if isset($listing.products_count)}
              <span class="ot-listing-bar__count">
                <strong>{$listing.products_count}</strong>
                {if $listing.products_count == 1}rezultat{else}rezultatov{/if}
              </span>
            {/if}
          </div>

          <div class="ot-listing-bar__right">
            {* Sort select *}
            {if isset($sort_orders) && $sort_orders|@count > 0}
              <label for="ot-sort-select" class="sr-only">Razvrsti po</label>
              <select id="ot-sort-select"
                      class="ot-sort-select"
                      name="orderby"
                      aria-label="Razvrsti po">
                {foreach from=$sort_orders item='order'}
                  <option value="{$order.urlParameter|escape:'html':'UTF-8'}"
                          {if $order.current}selected{/if}>
                    {$order.label|escape:'html':'UTF-8'}
                  </option>
                {/foreach}
              </select>
            {/if}

            {* Grid/List toggle *}
            <div class="ot-view-toggle" role="group" aria-label="Izberi pogled">
              <button class="ot-view-btn is-active"
                      data-ot-view-btn="grid"
                      type="button"
                      aria-label="Mrežni pogled"
                      aria-pressed="true"
                      title="Mrežni pogled">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true">
                  <rect x="3" y="3" width="7" height="7"/><rect x="14" y="3" width="7" height="7"/>
                  <rect x="14" y="14" width="7" height="7"/><rect x="3" y="14" width="7" height="7"/>
                </svg>
              </button>
              <button class="ot-view-btn"
                      data-ot-view-btn="list"
                      type="button"
                      aria-label="Seznamski pogled"
                      aria-pressed="false"
                      title="Seznamski pogled">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true">
                  <line x1="8" y1="6" x2="21" y2="6"/><line x1="8" y1="12" x2="21" y2="12"/>
                  <line x1="8" y1="18" x2="21" y2="18"/><line x1="3" y1="6" x2="3.01" y2="6"/>
                  <line x1="3" y1="12" x2="3.01" y2="12"/><line x1="3" y1="18" x2="3.01" y2="18"/>
                </svg>
              </button>
            </div>
          </div>
        </div>

        {* ---- Active filter chips (desktop — above grid) ---- *}
        <div class="ot-active-filters ot-active-filters--inline"
             data-ot-active-filters-desktop
             aria-label="Aktivni filtri"
             aria-live="polite"></div>

        {* ---- Product Grid ---- *}
        <div id="js-product-list"
             class="ot-product-grid"
             data-ot-product-grid
             aria-label="Rezultati iskanja"
             aria-live="polite">

          {if isset($products) && $products|@count > 0}
            {foreach from=$products item='product'}
              {include file='catalog/_partials/miniatures/product.tpl' product=$product}
            {/foreach}
          {else}
            <div class="ot-empty-state" role="status">
              <div class="ot-empty-state__icon" aria-hidden="true">
                <svg width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5">
                  <circle cx="11" cy="11" r="8"/><path d="m21 21-4.35-4.35"/>
                  <path d="M8 11h6M11 8v6" stroke-dasharray="2 2"/>
                </svg>
              </div>
              <h2 class="ot-empty-state__title">Ni rezultatov</h2>
              <p class="ot-empty-state__sub">Ni izdelkov, ki ustrezajo vašim filtrom. Poskusite z drugačnimi merili.</p>
              {if isset($current_url_without_filters)}
                <a href="{$current_url_without_filters|escape:'html':'UTF-8'}"
                   class="ot-btn-atc" style="display:inline-flex;margin-top:20px">
                  Počisti filtre
                </a>
              {/if}
            </div>
          {/if}

        </div>

        {* ---- Pagination ---- *}
        {if isset($pagination)}
          <nav id="js-product-list-bottom"
               class="ot-load-more"
               aria-label="Paginacija">
            {include file='_partials/pagination.tpl' pagination=$pagination}
          </nav>
        {/if}

      </div>{* .ot-listing-main *}
    </div>{* .ot-category-layout *}
  </div>{* .container *}

  {* ================================================================
     MOBILE FILTER BOTTOM SHEET
     ================================================================ *}
  <div class="ot-filter-sheet"
       id="ot-filter-sheet"
       data-ot-filter-sheet
       role="dialog"
       aria-modal="true"
       aria-label="Filtri">

    <div class="ot-filter-sheet__backdrop" data-ot-filter-backdrop aria-hidden="true"></div>

    <div class="ot-filter-sheet__panel">
      <div class="ot-filter-sheet__handle" aria-hidden="true"></div>
      <div class="ot-filter-sheet__header">
        <span class="ot-filters__title">
          <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true">
            <polygon points="22 3 2 3 10 12.46 10 19 14 21 14 12.46 22 3"/>
          </svg>
          Filtri
        </span>
        <button class="ot-filters__clear-all" data-ot-filter-close type="button" aria-label="Zapri filtre">✕</button>
      </div>
      <div class="ot-filter-sheet__body">
        {* Same filter content repeated for mobile *}
        {hook h='displayLeftColumn'}
      </div>
      <div class="ot-filter-sheet__footer">
        <button class="btn btn-outline-secondary" data-ot-filter-close type="button">Zapri</button>
        <button class="btn btn-primary" data-ot-filter-apply type="button">
          Prikaži rezultate
          {if isset($listing.products_count)}<span>({$listing.products_count})</span>{/if}
        </button>
      </div>
    </div>
  </div>

{/block}
