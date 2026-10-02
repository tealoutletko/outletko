{block name="page_title"}{l s='Your order is confirmed' d='Shop.Theme.Checkout'}{/block}
{include file="_partials/content-header.tpl" title=$page.title}
{hook h='displayOrderConfirmation'}
{if isset($order)}
  <h2>{l s='Your order #'}{$order.id_order}</h2>
{/if}