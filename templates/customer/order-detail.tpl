{block name="page_title"}{l s='Order #%1$d'|sprintf:$order.id_order d='Shop.Theme.Customeraccount'}{/block}
{include file="_partials/content-header.tpl" title=$page.title}
{hook h='displayCustomerAccount'}