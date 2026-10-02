{block name="page_title"}{$page.title}{/block}
{include file="_partials/content-header.tpl" title=$page.title}
{if !empty($cms_bricks)}
  {foreach from=$cms_bricks item=cms_list}
    {foreach from=$cms_list item=cms}
      {include file="cms/page.tpl" cms=$cms}
    {/foreach}
  {/foreach}
{/if}