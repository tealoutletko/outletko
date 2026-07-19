{**
 * Outletko Teal — Product microdata / JSON-LD
 * Schema.org Product with offers, condition, breadcrumb
 *
 * Available variables: $product, $breadcrumb, $urls
 **}
{block name='microdata_product'}
  {if isset($product)}
    {* Map PS9 condition values to Schema.org *}
    {assign var='schema_condition' value='https://schema.org/NewCondition'}
    {if isset($product.condition)}
      {if $product.condition == 'used' || $product.condition == 'rabljeno'}
        {assign var='schema_condition' value='https://schema.org/UsedCondition'}
      {elseif $product.condition == 'refurbished' || $product.condition == 'obnovljeno'}
        {assign var='schema_condition' value='https://schema.org/RefurbishedCondition'}
      {/if}
    {/if}

    {* Availability *}
    {assign var='schema_availability' value='https://schema.org/OutOfStock'}
    {if $product.availability == 'available'}
      {assign var='schema_availability' value='https://schema.org/InStock'}
    {elseif $product.availability == 'last_remaining_items'}
      {assign var='schema_availability' value='https://schema.org/LimitedAvailability'}
    {/if}

    <script type="application/ld+json">
    {
      "@context": "https://schema.org",
      "@type": "Product",
      "name": "{$product.name|escape:'javascript':'UTF-8'}",
      "description": "{$product.description_short|strip_tags|escape:'javascript':'UTF-8'}",
      "sku": "{$product.reference|escape:'javascript':'UTF-8'}",
      {if isset($product.ean13) && $product.ean13}
      "gtin13": "{$product.ean13|escape:'javascript':'UTF-8'}",
      {/if}
      {if isset($product.cover.bySize.large_default.url)}
      "image": [
        "{$product.cover.bySize.large_default.url|escape:'javascript':'UTF-8'}"
        {foreach from=$product.images item='img' name='imgloop'}
          {if !$smarty.foreach.imgloop.first}
          ,"{$img.bySize.large_default.url|escape:'javascript':'UTF-8'}"
          {/if}
        {/foreach}
      ],
      {/if}
      "brand": {
        "@type": "Brand",
        "name": "{if isset($product.manufacturer_name)}{$product.manufacturer_name|escape:'javascript':'UTF-8'}{else}TEAL d.o.o.{/if}"
      },
      "offers": {
        "@type": "Offer",
        "url": "{$product.url|escape:'javascript':'UTF-8'}",
        "priceCurrency": "{$currency.iso_code|escape:'javascript':'UTF-8'}",
        "price": "{$product.price_amount}",
        "priceValidUntil": "{$smarty.now|date_format:'%Y-%m-%d'|escape:'javascript':'UTF-8'}",
        "itemCondition": "{$schema_condition}",
        "availability": "{$schema_availability}",
        "seller": {
          "@type": "Organization",
          "name": "TEAL d.o.o.",
          "url": "https://outletko.si"
        }
      }
      {if isset($product.quantity_all_versions) && $product.quantity_all_versions > 0}
      ,"inventoryLevel": {
        "@type": "QuantitativeValue",
        "value": {$product.quantity_all_versions|intval}
      }
      {/if}
    }
    </script>

    {* BreadcrumbList schema *}
    {if isset($breadcrumb.links) && $breadcrumb.links|count > 0}
    <script type="application/ld+json">
    {
      "@context": "https://schema.org",
      "@type": "BreadcrumbList",
      "itemListElement": [
        {foreach from=$breadcrumb.links item='link' name='bc'}
        {
          "@type": "ListItem",
          "position": {$smarty.foreach.bc.iteration},
          "name": "{$link.title|escape:'javascript':'UTF-8'}",
          "item": "{$link.url|escape:'javascript':'UTF-8'}"
        }{if !$smarty.foreach.bc.last},{/if}
        {/foreach}
      ]
    }
    </script>
    {/if}
  {/if}
{/block}
