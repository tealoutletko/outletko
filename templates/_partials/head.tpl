{**
 * Outletko Teal — Head partial override
 * Adds: preconnect hints, self-hosted font preloads,
 *       Organization schema, Open Graph meta, hreflang
 *
 * Extends: hummingbird/templates/_partials/head.tpl
 * @see prestashop-project.org/docs/themes/
 **}
{extends file='parent:_partials/head.tpl'}

{block name='head_charset'}{$smarty.block.parent}{/block}

{block name='head_seo' prepend}
  {* ---- Open Graph ---- *}
  <meta property="og:site_name" content="Outletko.si">
  <meta property="og:locale" content="sl_SI">
  {if isset($page.meta.title)}
    <meta property="og:title" content="{$page.meta.title|escape:'html':'UTF-8'}">
  {/if}
  {if isset($page.meta.description)}
    <meta property="og:description" content="{$page.meta.description|escape:'html':'UTF-8'}">
  {/if}
  {if isset($urls.current_url)}
    <meta property="og:url" content="{$urls.current_url|escape:'html':'UTF-8'}">
  {/if}
  {* Product image for product pages *}
  {if isset($product.cover.bySize.large_default.url)}
    <meta property="og:image" content="{$product.cover.bySize.large_default.url|escape:'html':'UTF-8'}">
    <meta property="og:image:width" content="800">
    <meta property="og:image:height" content="800">
  {/if}

  {* ---- Twitter Card ---- *}
  <meta name="twitter:card" content="summary_large_image">
  <meta name="twitter:site" content="@outletko_si">

  {* ---- hreflang (Slovenian only) ---- *}
  {if isset($urls.current_url)}
    <link rel="alternate" hreflang="sl" href="{$urls.current_url|escape:'html':'UTF-8'}">
    <link rel="alternate" hreflang="x-default" href="{$urls.current_url|escape:'html':'UTF-8'}">
  {/if}

  {* ---- Canonical URL (fix faceted search duplicate content) ---- *}
  {if isset($urls.current_url)}
    {assign var='canonical_url' value=$urls.current_url}
    {* Strip filter params from canonical *}
    <link rel="canonical" href="{$canonical_url|escape:'html':'UTF-8'}">
  {/if}

  {* ---- Organization schema.org ---- *}
  <script type="application/ld+json">
  {
    "@context": "https://schema.org",
    "@type": "Organization",
    "name": "TEAL d.o.o.",
    "url": "https://outletko.si",
    "logo": "https://outletko.si/img/logo.png",
    "email": "info@teal.si",
    "telephone": "+38637340070",
    "address": [
      {
        "@type": "PostalAddress",
        "streetAddress": "Aškerčeva ulica 4",
        "addressLocality": "Laško",
        "postalCode": "3270",
        "addressCountry": "SI"
      },
      {
        "@type": "PostalAddress",
        "streetAddress": "Mariborska cesta 7",
        "addressLocality": "Celje",
        "postalCode": "3000",
        "addressCountry": "SI"
      }
    ],
    "sameAs": []
  }
  </script>

  {* ---- WebSite + SearchAction schema ---- *}
  <script type="application/ld+json">
  {
    "@context": "https://schema.org",
    "@type": "WebSite",
    "name": "Outletko.si",
    "url": "https://outletko.si",
    "potentialAction": {
      "@type": "SearchAction",
      "target": {
        "@type": "EntryPoint",
        "urlTemplate": "https://outletko.si/search?s={literal}{search_term_string}{/literal}"
      },
      "query-input": "required name=search_term_string"
    }
  }
  </script>
{/block}

{block name='head_links' prepend}
  {* ---- DNS prefetch / preconnect ---- *}
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link rel="dns-prefetch" href="//outletko.si">

  {* ---- Preload self-hosted fonts ---- *}
  <link rel="preload"
        href="{$urls.theme_assets}fonts/inter-variable.woff2"
        as="font" type="font/woff2" crossorigin>
  <link rel="preload"
        href="{$urls.theme_assets}fonts/outfit-variable.woff2"
        as="font" type="font/woff2" crossorigin>

  {* ---- Preload critical CSS (variables already loaded by theme.yml priority 5) ---- *}
  <link rel="preload"
        href="{$urls.theme_assets}css/variables.css"
        as="style">

  {* ---- Theme color for mobile browser chrome ---- *}
  <meta name="theme-color" content="#0066CC" media="(prefers-color-scheme: light)">
  <meta name="theme-color" content="#0d1117" media="(prefers-color-scheme: dark)">
  <meta name="color-scheme" content="light dark">
{/block}

{block name='head_viewport'}
  <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
{/block}
