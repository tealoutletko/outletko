{block name="page_title"}{l s='Your cart' d='Shop.Theme.Checkout'}{/block}
{include file="_partials/content-header.tpl" title=$page.title}
{hook h='displayCheckoutProgress'}
{include file='checkout/steps.tpl' steps=$steps}
{foreach from=$products item=product}
  {include file='checkout/product-line.tpl' product=$product}
{/foreach}