/**
 * Outletko Teal — Search Autocomplete
 * Enhanced search with live suggestions, categories,
 * recent searches, and keyboard navigation
 * ================================================== */

'use strict';

const SearchAutocomplete = (() => {

  /* ---- Config ---- */
  const CONFIG = {
    minChars:      2,
    debounceMs:    280,
    maxProducts:   5,
    maxCategories: 3,
    maxRecent:     5,
    storageKey:    'ot-recent-searches',
    // PrestaShop search controller URL (relative)
    searchUrl:     '/search?s={query}&resultsPerPage=6&ajax=true&controller=search',
    // PS9 module search endpoint
    ajaxUrl:       '/index.php?fc=module&module=ps_searchbar&controller=ajax',
  };

  /* ---- State ---- */
  let activeIdx  = -1;
  let allItems   = [];
  let abortCtrl  = null;
  let recentSearches = [];

  /* ---- Category icons map ---- */
  const CATEGORY_ICONS = {
    'prenosniki':         `<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><rect x="2" y="3" width="20" height="14" rx="2"/><path d="M0 21h24"/></svg>`,
    'računalniki':        `<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><rect x="2" y="3" width="14" height="18" rx="2"/><rect x="18" y="9" width="4" height="8" rx="1"/></svg>`,
    'zasloni':            `<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><rect x="2" y="3" width="20" height="14" rx="2"/><path d="M8 21h8M12 17v4"/></svg>`,
    'tablice':            `<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><rect x="5" y="2" width="14" height="20" rx="2"/><circle cx="12" cy="18" r="1"/></svg>`,
    'tiskalniki':         `<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><polyline points="6 9 6 2 18 2 18 9"/><path d="M6 18H4a2 2 0 01-2-2v-5a2 2 0 012-2h16a2 2 0 012 2v5a2 2 0 01-2 2h-2"/><rect x="6" y="14" width="12" height="8"/></svg>`,
    'periferija':         `<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><rect x="3" y="11" width="18" height="9" rx="2"/><path d="M7 11V7a5 5 0 0110 0v4"/></svg>`,
    'strežniki':          `<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><rect x="2" y="2" width="20" height="8" rx="2"/><rect x="2" y="14" width="20" height="8" rx="2"/><line x1="6" y1="6" x2="6.01" y2="6"/><line x1="6" y1="18" x2="6.01" y2="18"/></svg>`,
    'default':            `<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><circle cx="11" cy="11" r="8"/><path d="m21 21-4.35-4.35"/></svg>`,
  };

  /* ---- Helpers ---- */
  const $ = (sel, ctx = document) => ctx.querySelector(sel);
  const $$ = (sel, ctx = document) => [...ctx.querySelectorAll(sel)];

  function getCategoryIcon(name = '') {
    const key = name.toLowerCase();
    for (const [k, v] of Object.entries(CATEGORY_ICONS)) {
      if (key.includes(k)) return v;
    }
    return CATEGORY_ICONS.default;
  }

  function escHtml(str) {
    const d = document.createElement('div');
    d.appendChild(document.createTextNode(str));
    return d.innerHTML;
  }

  function highlight(text, query) {
    if (!query) return escHtml(text);
    const re = new RegExp(`(${query.replace(/[.*+?^${}()|[\]\\]/g, '\\$&')})`, 'gi');
    return escHtml(text).replace(re, '<mark style="background:transparent;color:var(--ot-primary);font-weight:700">$1</mark>');
  }

  function getRecentSearches() {
    try {
      return JSON.parse(localStorage.getItem(CONFIG.storageKey) || '[]');
    } catch { return []; }
  }

  function saveRecentSearch(query) {
    let recent = getRecentSearches().filter(r => r !== query);
    recent.unshift(query);
    recent = recent.slice(0, CONFIG.maxRecent);
    localStorage.setItem(CONFIG.storageKey, JSON.stringify(recent));
  }

  function removeRecentSearch(query) {
    const recent = getRecentSearches().filter(r => r !== query);
    localStorage.setItem(CONFIG.storageKey, JSON.stringify(recent));
  }

  /* =========================================================
     RENDER FUNCTIONS
     ========================================================= */
  function renderEmpty(query) {
    return `
      <div class="ot-search-empty">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5"><circle cx="11" cy="11" r="8"/><path d="m21 21-4.35-4.35"/><path d="M8 11h6M11 8v6" stroke-dasharray="2 2"/></svg>
        <div class="ot-search-empty__title">Ni zadetkov za "${escHtml(query)}"</div>
        <div class="ot-search-empty__hint">Preverite črkovanje ali poskusite z drugim iskalnim nizom.</div>
      </div>
    `;
  }

  function renderSkeletons() {
    const sk = `
      <div class="ot-search-skeleton">
        <div class="ot-skeleton-block ot-skeleton-block--img"></div>
        <div style="flex:1;display:flex;flex-direction:column;gap:6px">
          <div class="ot-skeleton-block ot-skeleton-block--title"></div>
          <div class="ot-skeleton-block ot-skeleton-block--title-sm"></div>
        </div>
      </div>`;
    return sk.repeat(3);
  }

  function renderRecentSearches(items) {
    if (!items.length) return '';
    const rows = items.map(q => `
      <div class="ot-search-recent" data-ot-recent-item="${escHtml(q)}" tabindex="-1" role="option">
        <svg class="ot-search-recent__icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
        <span class="ot-search-recent__text">${escHtml(q)}</span>
        <button class="ot-search-recent__remove" data-ot-remove-recent="${escHtml(q)}" aria-label="Odstrani" tabindex="-1">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg>
        </button>
      </div>
    `).join('');

    return `<div class="ot-search-section__title">Nedavna iskanja</div>${rows}`;
  }

  function renderCategories(categories, query) {
    if (!categories.length) return '';
    const rows = categories.slice(0, CONFIG.maxCategories).map(cat => `
      <a class="ot-search-cat" href="${escHtml(cat.url)}" data-ot-item tabindex="-1" role="option">
        <span class="ot-search-cat__icon">${getCategoryIcon(cat.name)}</span>
        <span class="ot-search-cat__label">${highlight(cat.name, query)}</span>
        ${cat.count ? `<span class="ot-search-cat__count">${cat.count}</span>` : ''}
      </a>
    `).join('');

    return `<div class="ot-search-section__title">Kategorije</div>${rows}`;
  }

  function renderProducts(products, query) {
    if (!products.length) return '';

    const conditionBadge = (condition) => {
      const map = {
        'new':          ['Novo', 'ot-badge--novo'],
        'novo':         ['Novo', 'ot-badge--novo'],
        'used':         ['Rabljeno', 'ot-badge--rabljeno'],
        'rabljeno':     ['Rabljeno', 'ot-badge--rabljeno'],
        'refurbished':  ['Obnovljeno', 'ot-badge--obnovljeno'],
        'obnovljeno':   ['Obnovljeno', 'ot-badge--obnovljeno'],
        'outlet':       ['Outlet', 'ot-badge--outlet'],
        'neprodano':    ['Outlet', 'ot-badge--outlet'],
      };
      const key = (condition || '').toLowerCase();
      const [label, cls] = map[key] || ['', ''];
      return label ? `<span class="ot-badge ${cls}">${label}</span>` : '';
    };

    const rows = products.slice(0, CONFIG.maxProducts).map(p => `
      <a class="ot-search-product" href="${escHtml(p.url)}" data-ot-item tabindex="-1" role="option">
        <img class="ot-search-product__img" 
             src="${escHtml(p.cover?.bySize?.['home_default']?.url || p.cover_image_source || '/img/p/en-default-home_default.jpg')}" 
             alt="${escHtml(p.name)}" 
             width="52" height="52" 
             loading="lazy">
        <div class="ot-search-product__info">
          <div class="ot-search-product__name">${highlight(p.name, query)}</div>
          <div class="ot-search-product__condition">${conditionBadge(p.condition)}</div>
          <div class="ot-search-product__price">${p.price_formatted || p.price}</div>
        </div>
      </a>
    `).join('');

    return `<div class="ot-search-section__title">Izdelki</div>${rows}`;
  }

  function renderViewAll(query, total) {
    return `
      <a class="ot-search-view-all" href="/search?s=${encodeURIComponent(query)}" data-ot-item tabindex="-1" role="option">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="11" cy="11" r="8"/><path d="m21 21-4.35-4.35"/></svg>
        ${total > 0 ? `Prikaži vseh ${total} zadetkov za "${escHtml(query)}"` : `Išči "${escHtml(query)}"`}
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M5 12h14M12 5l7 7-7 7"/></svg>
      </a>
    `;
  }

  /* =========================================================
     FETCH SUGGESTIONS
     ========================================================= */
  async function fetchSuggestions(query) {
    if (abortCtrl) abortCtrl.abort();
    abortCtrl = new AbortController();

    try {
      const url = `/index.php?fc=module&module=ps_searchbar&controller=ajax&s=${encodeURIComponent(query)}`;
      const res = await fetch(url, {
        signal: abortCtrl.signal,
        headers: { 'Accept': 'application/json', 'X-Requested-With': 'XMLHttpRequest' }
      });

      if (!res.ok) throw new Error('Search fetch failed');
      return await res.json();
    } catch (err) {
      if (err.name === 'AbortError') return null;
      console.warn('[OT Search] Fetch error:', err);
      return null;
    }
  }

  /* =========================================================
     KEYBOARD NAVIGATION
     ========================================================= */
  function updateActiveItem(dropdown) {
    allItems = $$('[data-ot-item]', dropdown);
    allItems.forEach((item, i) => {
      item.classList.toggle('is-highlighted', i === activeIdx);
      if (i === activeIdx) item.scrollIntoView({ block: 'nearest' });
    });
  }

  function handleKeydown(e, input, dropdown) {
    const isOpen = dropdown.classList.contains('is-visible');

    if (e.key === 'Escape') {
      dropdown.classList.remove('is-visible');
      input.blur();
      return;
    }

    if (e.key === 'Enter' && isOpen) {
      e.preventDefault();
      if (activeIdx >= 0 && allItems[activeIdx]) {
        allItems[activeIdx].click();
      } else {
        // Submit search form
        input.closest('form')?.submit();
        saveRecentSearch(input.value.trim());
      }
      return;
    }

    if (!isOpen) return;

    if (e.key === 'ArrowDown') {
      e.preventDefault();
      activeIdx = Math.min(activeIdx + 1, allItems.length - 1);
      updateActiveItem(dropdown);
    } else if (e.key === 'ArrowUp') {
      e.preventDefault();
      activeIdx = Math.max(activeIdx - 1, 0);
      updateActiveItem(dropdown);
    }
  }

  /* =========================================================
     INITIALISE
     ========================================================= */
  function init() {
    const form     = $('[data-ot-search-form]');
    const input    = $('[data-ot-search-input]');
    const dropdown = $('[data-ot-search-dropdown]');
    const clearBtn = $('[data-ot-search-clear]');

    if (!input || !dropdown) return;

    const showDropdown = () => dropdown.classList.add('is-visible');
    const hideDropdown = () => {
      dropdown.classList.remove('is-visible');
      activeIdx = -1;
    };

    const render = (html) => { dropdown.innerHTML = html; activeIdx = -1; };

    /* ---- Input events ---- */
    const onInput = debounce(async () => {
      const query = input.value.trim();

      if (query.length < CONFIG.minChars) {
        const recent = getRecentSearches();
        if (recent.length) {
          render(renderRecentSearches(recent));
          showDropdown();
        } else {
          hideDropdown();
        }
        return;
      }

      // Show skeletons while loading
      render(`<div class="ot-search-section__title">Iščem…</div>${renderSkeletons()}`);
      showDropdown();

      const data = await fetchSuggestions(query);
      if (data === null) return; // Aborted

      const products   = data.products   || [];
      const categories = data.categories || [];
      const total      = data.total      || products.length;

      if (!products.length && !categories.length) {
        render(renderEmpty(query));
      } else {
        render(
          renderCategories(categories, query) +
          renderProducts(products, query) +
          renderViewAll(query, total)
        );
      }
    }, CONFIG.debounceMs);

    input.addEventListener('input', onInput);

    /* ---- Focus: show recent or dropdown ---- */
    input.addEventListener('focus', () => {
      if (input.value.trim().length >= CONFIG.minChars) {
        showDropdown();
      } else {
        const recent = getRecentSearches();
        if (recent.length) {
          render(renderRecentSearches(recent));
          showDropdown();
        }
      }
    });

    /* ---- Clear button ---- */
    if (clearBtn) {
      clearBtn.addEventListener('click', () => {
        input.value = '';
        hideDropdown();
        input.focus();
      });
    }

    /* ---- Keyboard ---- */
    input.addEventListener('keydown', e => handleKeydown(e, input, dropdown));

    /* ---- Click on recent search ---- */
    dropdown.addEventListener('click', e => {
      // Remove recent
      const removeBtn = e.target.closest('[data-ot-remove-recent]');
      if (removeBtn) {
        e.preventDefault();
        e.stopPropagation();
        removeRecentSearch(removeBtn.dataset.otRemoveRecent);
        const recent = getRecentSearches();
        if (recent.length) {
          render(renderRecentSearches(recent));
        } else {
          hideDropdown();
        }
        return;
      }

      // Click on recent item → fill input
      const recentItem = e.target.closest('[data-ot-recent-item]');
      if (recentItem) {
        input.value = recentItem.dataset.otRecentItem;
        input.dispatchEvent(new Event('input'));
      }
    });

    /* ---- Form submit ---- */
    if (form) {
      form.addEventListener('submit', () => {
        const q = input.value.trim();
        if (q.length >= CONFIG.minChars) saveRecentSearch(q);
      });
    }

    /* ---- Close on outside click ---- */
    document.addEventListener('click', e => {
      if (!e.target.closest('[data-ot-search-form]') && !e.target.closest('[data-ot-search-dropdown]')) {
        hideDropdown();
      }
    });

    /* ---- Close on scroll ---- */
    window.addEventListener('scroll', hideDropdown, { passive: true });
  }

  return { init };

})();

/* ---- Auto-init ---- */
if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', () => SearchAutocomplete.init());
} else {
  SearchAutocomplete.init();
}
