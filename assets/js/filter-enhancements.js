/**
 * Outletko Teal — Filter Enhancements JS
 * Dual-handle price slider, brand search, mobile sheet,
 * Ajax facet refresh, active filter chips
 * ============================================================ */

'use strict';

/* =========================================================
   DUAL-HANDLE PRICE RANGE SLIDER
   ========================================================= */
const PriceSlider = {
  init(container) {
    if (!container) return;

    const minRange = container.querySelector('[data-ot-slider-min]');
    const maxRange = container.querySelector('[data-ot-slider-max]');
    const fill     = container.querySelector('[data-ot-slider-fill]');
    const minInput = container.querySelector('[data-ot-price-min]');
    const maxInput = container.querySelector('[data-ot-price-max]');

    if (!minRange || !maxRange || !fill) return;

    const absMin = parseFloat(minRange.min) || 0;
    const absMax = parseFloat(maxRange.max) || 10000;

    const update = () => {
      const lo = Math.min(parseFloat(minRange.value), parseFloat(maxRange.value) - 1);
      const hi = Math.max(parseFloat(maxRange.value), parseFloat(minRange.value) + 1);

      const leftPct  = ((lo - absMin) / (absMax - absMin)) * 100;
      const rightPct = ((hi - absMin) / (absMax - absMin)) * 100;

      fill.style.left  = leftPct  + '%';
      fill.style.width = (rightPct - leftPct) + '%';

      if (minInput) minInput.value = Math.round(lo);
      if (maxInput) maxInput.value = Math.round(hi);
    };

    minRange.addEventListener('input', () => {
      if (parseFloat(minRange.value) >= parseFloat(maxRange.value)) {
        minRange.value = parseFloat(maxRange.value) - 1;
      }
      update();
    });

    maxRange.addEventListener('input', () => {
      if (parseFloat(maxRange.value) <= parseFloat(minRange.value)) {
        maxRange.value = parseFloat(minRange.value) + 1;
      }
      update();
    });

    // Manual input → update sliders
    const syncFromInput = (input, slider) => {
      if (!input || !slider) return;
      input.addEventListener('change', () => {
        const val = parseFloat(input.value);
        if (!isNaN(val)) {
          slider.value = Math.min(Math.max(val, absMin), absMax);
          update();
          scheduleFilterApply(container);
        }
      });
    };

    syncFromInput(minInput, minRange);
    syncFromInput(maxInput, maxRange);

    // Apply filter after slider release
    minRange.addEventListener('change', () => scheduleFilterApply(container));
    maxRange.addEventListener('change', () => scheduleFilterApply(container));

    update();
  },

  initAll() {
    document.querySelectorAll('[data-ot-price-slider]').forEach(c => this.init(c));
  }
};

/* =========================================================
   DEBOUNCED FILTER APPLY
   ========================================================= */
let filterTimer = null;

function scheduleFilterApply(triggerEl, delayMs = 600) {
  clearTimeout(filterTimer);
  filterTimer = setTimeout(() => {
    const form = triggerEl?.closest('form') ||
                 document.querySelector('[data-ot-filter-form]') ||
                 document.querySelector('#_desktop_search_filters_wrapper form') ||
                 document.querySelector('.facets-filter form');

    if (form) {
      form.dispatchEvent(new Event('submit', { bubbles: true, cancelable: true }));
    } else {
      // Trigger PS9 faceted search module's own ajax refresh
      const event = new CustomEvent('ot:filters:changed', { bubbles: true });
      document.dispatchEvent(event);
    }
  }, delayMs);
}

/* =========================================================
   ACTIVE FILTER CHIPS (above product grid)
   ========================================================= */
const ActiveFilters = {
  containerSel: '[data-ot-active-filters]',
  chipSel: '[data-ot-filter-chip]',

  init() {
    this._buildFromURL();
    this._bindRemove();

    // Refresh after PS9 facets ajax update
    document.addEventListener('updateFacets', () => this._buildFromURL());
    document.addEventListener('ot:filters:changed', () => this._buildFromURL());
  },

  _buildFromURL() {
    const container = document.querySelector(this.containerSel);
    if (!container) return;

    const params = new URLSearchParams(window.location.search);
    const chips  = [];

    // PrestaShop faceted search uses q param or individual feature params
    params.forEach((value, key) => {
      if (['controller', 'id_category', 's'].includes(key)) return;
      if (!value) return;

      const label = this._labelFor(key, value);
      chips.push({ key, value, label });
    });

    // Also parse from active facets rendered by PS9
    document.querySelectorAll('.facet .facet-label.active').forEach(el => {
      const text = el.textContent.trim();
      if (text && !chips.find(c => c.label === text)) {
        chips.push({ key: 'ps-facet', value: text, label: text, el });
      }
    });

    container.innerHTML = chips.length
      ? chips.map(c => this._renderChip(c)).join('')
      : '';

    this._updateToggleBtn(chips.length);
    this._bindRemove();
  },

  _labelFor(key, value) {
    const map = {
      'orderby':    null,
      'orderway':   null,
      'resultsPerPage': null,
    };
    if (map[key] === null) return null;

    // Decode encoded filter names
    const humanKey = key.replace(/_/g, ' ').replace('feature', '').trim();
    return `${humanKey}: ${decodeURIComponent(value)}`;
  },

  _renderChip({ key, value, label, el }) {
    if (!label) return '';
    return `
      <button class="ot-filter-chip"
              data-ot-filter-chip
              data-chip-key="${key}"
              data-chip-value="${encodeURIComponent(value)}"
              aria-label="Odstrani filter: ${label}"
              type="button">
        ${label}
        <span class="ot-filter-chip__remove" aria-hidden="true">
          <svg viewBox="0 0 10 10" fill="currentColor">
            <path d="M2 2L8 8M8 2L2 8" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"/>
          </svg>
        </span>
      </button>`;
  },

  _updateToggleBtn(count) {
    const badge = document.querySelector('[data-ot-filter-badge]');
    if (badge) {
      badge.textContent = count > 0 ? count : '';
      badge.classList.toggle('has-filters', count > 0);
    }

    const clearAll = document.querySelector('[data-ot-filters-clear-all]');
    if (clearAll) clearAll.classList.toggle('is-visible', count > 0);
  },

  _bindRemove() {
    document.querySelectorAll('[data-ot-filter-chip]').forEach(chip => {
      chip.addEventListener('click', () => {
        const key   = chip.dataset.chipKey;
        const value = decodeURIComponent(chip.dataset.chipValue || '');

        if (key === 'ps-facet') {
          // Find and click the active PS9 facet label
          document.querySelectorAll('.facet .facet-label.active').forEach(el => {
            if (el.textContent.trim() === value) el.click();
          });
        } else {
          // Remove from URL params and reload
          const url = new URL(window.location.href);
          url.searchParams.delete(key);
          window.location.href = url.toString();
        }
      });
    });

    // Clear all
    const clearAll = document.querySelector('[data-ot-filters-clear-all]');
    if (clearAll) {
      clearAll.addEventListener('click', () => {
        const url = new URL(window.location.href);
        // Keep only essential params
        const keep = ['controller', 'id_category', 'id_lang'];
        [...url.searchParams.keys()].forEach(k => {
          if (!keep.includes(k)) url.searchParams.delete(k);
        });
        window.location.href = url.toString();
      });
    }
  }
};

/* =========================================================
   BRAND / ATTRIBUTE SEARCHABLE LIST
   ========================================================= */
const FilterSearch = {
  init() {
    document.querySelectorAll('[data-ot-filter-search]').forEach(input => {
      const list = document.querySelector(input.dataset.otFilterSearch);
      if (!list) return;

      const items = [...list.querySelectorAll('[data-ot-filter-item]')];

      input.addEventListener('input', () => {
        const q = input.value.toLowerCase().trim();
        let visible = 0;

        items.forEach(item => {
          const label = (item.textContent || '').toLowerCase();
          const show  = !q || label.includes(q);
          item.style.display = show ? '' : 'none';
          if (show) visible++;
        });

        // Show no-results hint
        let hint = list.querySelector('.ot-filter-no-results');
        if (!visible && q) {
          if (!hint) {
            hint = document.createElement('div');
            hint.className = 'ot-filter-no-results';
            hint.style.cssText = 'font-size:0.75rem;color:var(--ot-text-muted);padding:4px 0;';
            list.appendChild(hint);
          }
          hint.textContent = `Ni zadetkov za "${input.value}"`;
        } else if (hint) {
          hint.remove();
        }
      });
    });
  }
};

/* =========================================================
   FILTER GROUP ACCORDION
   ========================================================= */
const FilterAccordion = {
  init() {
    document.querySelectorAll('[data-ot-filter-group-toggle]').forEach(toggle => {
      // Skip if already initialized (e.g. re-init after Ajax)
      if (toggle.dataset.initialized) return;
      toggle.dataset.initialized = '1';

      const group = toggle.closest('[data-ot-filter-group]');
      if (!group) return;

      // Restore collapsed state from localStorage
      const id = group.dataset.filterGroupId;
      const stored = id && localStorage.getItem(`ot-fg-${id}`);
      if (stored === 'collapsed') group.classList.add('is-collapsed');

      toggle.addEventListener('click', () => {
        group.classList.toggle('is-collapsed');
        if (id) {
          localStorage.setItem(
            `ot-fg-${id}`,
            group.classList.contains('is-collapsed') ? 'collapsed' : 'open'
          );
        }
      });
    });
  }
};

/* =========================================================
   SHOW MORE / LESS IN FILTER LISTS
   ========================================================= */
const FilterShowMore = {
  init() {
    document.querySelectorAll('[data-ot-filter-show-more]').forEach(btn => {
      if (btn.dataset.initialized) return;
      btn.dataset.initialized = '1';

      const limit = parseInt(btn.dataset.limit || '5', 10);
      // Find the sibling list container
      const list  = btn.closest('[data-ot-filter-group]')?.querySelector('[data-ot-filter-list]');
      if (!list) return;

      const items = [...list.querySelectorAll('[data-ot-filter-item]')];
      const extra = items.slice(limit);
      if (!extra.length) { btn.style.display = 'none'; return; }

      // Initially hide extras
      extra.forEach(i => i.classList.add('ot-filter-item--hidden'));
      list.insertAdjacentCSS?.('.ot-filter-item--hidden{display:none}');

      // Use a style rule instead
      if (!document.getElementById('ot-filter-hidden-style')) {
        const s = document.createElement('style');
        s.id = 'ot-filter-hidden-style';
        s.textContent = '.ot-filter-item--hidden{display:none!important}';
        document.head.appendChild(s);
      }

      btn.addEventListener('click', () => {
        const expanded = btn.classList.contains('is-expanded');
        extra.forEach(i => i.classList.toggle('ot-filter-item--hidden', expanded));
        btn.classList.toggle('is-expanded');
        const textEl = btn.querySelector('[data-show-text]');
        if (textEl) textEl.textContent = expanded ? 'Pokaži več' : 'Pokaži manj';
      });
    });
  }
};

/* =========================================================
   PILL FILTER TOGGLE (RAM / SSD / CPU)
   ========================================================= */
const PillFilter = {
  init() {
    document.querySelectorAll('[data-ot-pill-filter]').forEach(group => {
      const pills  = group.querySelectorAll('[data-ot-filter-pill]');
      const hidden = group.querySelector('[data-ot-pill-value]');
      const multi  = group.dataset.otPillFilter === 'multi';

      pills.forEach(pill => {
        pill.addEventListener('click', () => {
          if (multi) {
            pill.classList.toggle('is-selected');
          } else {
            pills.forEach(p => p.classList.remove('is-selected'));
            pill.classList.add('is-selected');
          }

          // Collect selected values
          const selected = [...group.querySelectorAll('.is-selected')]
            .map(p => p.dataset.value)
            .filter(Boolean);

          if (hidden) hidden.value = selected.join(',');

          // Trigger filter form submit
          scheduleFilterApply(group, 300);
        });
      });
    });
  }
};

/* =========================================================
   PS9 FACETED SEARCH INTEGRATION
   PrestaShop 9 uses its own AJAX for facets via ps_facetedsearch module.
   We hook into its events and enhance the UI.
   ========================================================= */
const PS9FacetsIntegration = {
  init() {
    // PS9 fires 'updateFacets' after Ajax reload
    document.addEventListener('updateFacets', (e) => {
      // Re-initialize filter enhancements after PS9 replaces DOM
      setTimeout(() => {
        FilterAccordion.init();
        FilterSearch.init();
        FilterShowMore.init();
        PillFilter.init();
        PriceSlider.initAll();
        ActiveFilters._buildFromURL();
        // Re-style native PS9 checkboxes
        this._styleNativeFacets();
      }, 100);
    });

    // Initial styling
    this._styleNativeFacets();
  },

  _styleNativeFacets() {
    // PS9 faceted search renders its own checkboxes — apply our CSS classes
    document.querySelectorAll('.facet').forEach(facet => {
      facet.querySelectorAll('.custom-checkbox input[type="checkbox"]').forEach(cb => {
        cb.classList.add('ot-filter-check__input');
        const row = cb.closest('.facet-label') || cb.parentElement;
        if (row && !row.classList.contains('ot-filter-check')) {
          row.classList.add('ot-filter-check');
        }
      });
    });
  }
};

/* =========================================================
   FILTER COUNT BADGE (mobile toggle button)
   ========================================================= */
const FilterCountBadge = {
  init() {
    const badge = document.querySelector('[data-ot-filter-badge]');
    if (!badge) return;

    const countActive = () => {
      const url    = new URL(window.location.href);
      const ignore = new Set(['controller', 'id_category', 's', 'id_lang', 'id_currency']);
      let count = 0;
      url.searchParams.forEach((v, k) => { if (!ignore.has(k) && v) count++; });

      // Also count active PS9 facets
      count += document.querySelectorAll('.facet .facet-label.active').length;

      badge.textContent = count > 0 ? count : '';
      badge.classList.toggle('has-filters', count > 0);
    };

    countActive();
    document.addEventListener('updateFacets', countActive);
  }
};

/* =========================================================
   INIT ALL
   ========================================================= */
function initFilterEnhancements() {
  FilterAccordion.init();
  FilterSearch.init();
  FilterShowMore.init();
  PillFilter.init();
  PriceSlider.initAll();
  ActiveFilters.init();
  PS9FacetsIntegration.init();
  FilterCountBadge.init();
}

if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', initFilterEnhancements);
} else {
  initFilterEnhancements();
}
