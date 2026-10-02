{block name="page_title"}{l s='Checkout' d='Shop.Theme.Checkout'}{/block}
{include file="_partials/content-header.tpl" title=$page.title}
{hook h='displayCheckoutProgress'}
{include file='checkout/steps.tpl' steps=$steps}