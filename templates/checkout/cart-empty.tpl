{block name="page_title"}{l s='Your cart is empty' d='Shop.Theme.Checkout'}{/block}
{include file="_partials/content-header.tpl" title=$page.title}
{hook h='displayCart'}
{if isset($guest_checkout_allowed) && $guest_checkout_allowed}
  {include file="_partials/guest-link.tpl"}
{/if}