/**
 * Outletko Teal — Main Theme JavaScript
 * Vanilla ES6+, no jQuery, no external dependencies
 * PrestaShop 9 Hummingbird child theme
 * ================================================== */

'use strict';

/* =========================================================
   UTILITY FUNCTIONS
   ========================================================= */
const $ = (sel, ctx = document) => ctx.querySelector(sel);
const $$ = (sel, ctx = document) => [...ctx.querySelectorAll(sel)];
const on = (el, evt, fn, opts) => el && el.addEventListener(evt, fn, opts);
const off = (el, evt, fn) => el && el.removeEventListener(evt, fn);

function debounce(fn, ms = 200) {
  let t;
  return (...args) => { clearTimeout(t); t = setTimeout(() => fn(...args), ms); };
}

function throttle(fn, ms = 100) {
  let last = 0;
  return (...args) => {
    const now = Date.now();
    if (now - last >= ms) { last = now; fn(...args); }
  };
}

/* =========================================================
   DARK MODE TOGGLE
   ========================================================= */
const DarkMode = {
  STORAGE_KEY: 'ot-dark-mode',

  init() {
    const stored = localStorage.getItem(this.STORAGE_KEY);
    const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
    const isDark = stored !== null ? stored === '1' : prefersDark;

    if (isDark) document.documentElement.classList.add('dark-mode');

    $$('[data-ot-dark-toggle]').forEach(btn => {
      this._updateBtn(btn, isDark);
      on(btn, 'click', () => this.toggle());
    });

    window.matchMedia('(prefers-color-scheme: dark)')
      .addEventListener('change', e => {
        if (localStorage.getItem(this.STORAGE_KEY) === null) {
          this._apply(e.matches);
        }
      });
  },

  toggle() {
    const isDark = document.documentElement.classList.toggle('dark-mode');
    localStorage.setItem(this.STORAGE_KEY, isDark ? '1' : '0');
    $$('[data-ot-dark-toggle]').forEach(btn => this._updateBtn(btn, isDark));
  },

  _apply(isDark) {
    document.documentElement.classList.toggle('dark-mode', isDark);
    $$('[data-ot-dark-toggle]').forEach(btn => this._updateBtn(btn, isDark));
  },

  _updateBtn(btn, isDark) {
    const moonIcon = btn.querySelector('[data-icon="moon"]');
    const sunIcon  = btn.querySelector('[data-icon="sun"]');
    if (moonIcon) moonIcon.style.display = isDark ? 'none' : '';
    if (sunIcon)  sunIcon.style.display  = isDark ? '' : 'none';
    btn.setAttribute('aria-label', isDark ? 'Vklopi svetli način' : 'Vklopi temni način');
    btn.setAttribute('title', isDark ? 'Vklopi svetli način' : 'Vklopi temni način');
  }
};

/* =========================================================
   HEADER: STICKY SCROLL BEHAVIOUR
   ========================================================= */
const StickyHeader = {
  init() {
    const header = $('[data-ot-header]');
    if (!header) return;

    const onScroll = throttle(() => {
      header.classList.toggle('ot-header--scrolled', window.scrollY > 8);
    }, 50);

    on(window, 'scroll', onScroll, { passive: true });
    onScroll();
  }
};

/* =========================================================
   MOBILE DRAWER
   ========================================================= */
const MobileDrawer = {
  drawer: null,
  trigger: null,
  focusable: [],
  firstFocus: null,
  lastFocus: null,

  init() {
    this.drawer  = $('[data-ot-drawer]');
    this.trigger = $('[data-ot-hamburger]');
    if (!this.drawer || !this.trigger) return;

    const backdrop = this.drawer.querySelector('[data-ot-drawer-backdrop]');
    const closeBtn = this.drawer.querySelector('[data-ot-drawer-close]');

    on(this.trigger, 'click', () => this.open());
    if (backdrop) on(backdrop, 'click', () => this.close());
    if (closeBtn) on(closeBtn, 'click', () => this.close());

    // Accordion subcategories
    $$('[data-ot-drawer-parent]', this.drawer).forEach(item => {
      on(item, 'click', () => this._toggleAccordion(item));
    });

    // Keyboard navigation
    on(document, 'keydown', e => {
      if (e.key === 'Escape' && this.drawer.classList.contains('is-open')) {
        this.close();
      }
    });
  },

  open() {
    this.drawer.classList.add('is-open');
    this.trigger.classList.add('is-open');
    document.body.style.overflow = 'hidden';
    this.drawer.removeAttribute('inert');
    // Focus first focusable element
    const first = $('a, button:not([disabled])', this.drawer);
    first && first.focus();
    this.trigger.setAttribute('aria-expanded', 'true');
  },

  close() {
    this.drawer.classList.remove('is-open');
    this.trigger.classList.remove('is-open');
    document.body.style.overflow = '';
    this.drawer.setAttribute('inert', '');
    this.trigger.focus();
    this.trigger.setAttribute('aria-expanded', 'false');
  },

  _toggleAccordion(item) {
    const sub = item.nextElementSibling;
    if (!sub) return;
    const isOpen = sub.classList.contains('is-open');
    // Close all
    $$('[data-ot-drawer-sub]', this.drawer).forEach(s => s.classList.remove('is-open'));
    $$('[data-ot-drawer-parent]', this.drawer).forEach(p => p.classList.remove('is-expanded'));
    // Open clicked (if was closed)
    if (!isOpen) {
      sub.classList.add('is-open');
      item.classList.add('is-expanded');
    }
  }
};

/* =========================================================
   MEGA MENU (keyboard / hover gap fix)
   ========================================================= */
const MegaMenu = {
  init() {
    const navItems = $$('[data-ot-nav-item]');
    navItems.forEach(item => {
      const link = item.querySelector('[data-ot-nav-link]');
      if (!link) return;

      // Keyboard: toggle on Enter/Space for buttons
      on(link, 'keydown', e => {
        if (e.key === 'Enter' || e.key === ' ') {
          e.preventDefault();
          const mega = item.querySelector('[data-ot-mega]');
          if (mega) {
            const isOpen = mega.classList.contains('is-open');
            // Close others
            $$('[data-ot-mega].is-open').forEach(m => m.classList.remove('is-open'));
            mega.classList.toggle('is-open', !isOpen);
          }
        }
        if (e.key === 'Escape') {
          $$('[data-ot-mega].is-open').forEach(m => m.classList.remove('is-open'));
          link.focus();
        }
      });
    });

    // Close mega on outside click
    on(document, 'click', e => {
      if (!e.target.closest('[data-ot-nav-item]')) {
        $$('[data-ot-mega].is-open').forEach(m => m.classList.remove('is-open'));
      }
    });
  }
};

/* =========================================================
   CART BADGE ANIMATION
   ========================================================= */
const CartBadge = {
  init() {
    // Listen for PS9 cart update events
    document.addEventListener('updateCart', (e) => {
      const count = e.detail?.cart?.products_count || 0;
      $$('[data-ot-cart-count]').forEach(el => {
        el.textContent = count > 0 ? count : '';
        el.classList.add('ot-icon-btn__badge--pulse');
        el.addEventListener('animationend', () => {
          el.classList.remove('ot-icon-btn__badge--pulse');
        }, { once: true });
      });
    });
  }
};

/* =========================================================
   PRODUCT GALLERY (detail page)
   ========================================================= */
const ProductGallery = {
  mainImg: null,
  thumbs: [],
  lightbox: null,
  currentIdx: 0,

  init() {
    this.mainImg = $('[data-ot-gallery-main]');
    this.thumbs  = $$('[data-ot-gallery-thumb]');
    this.lightbox = $('[data-ot-lightbox]');

    if (!this.mainImg) return;

    this.thumbs.forEach((thumb, i) => {
      on(thumb, 'click', () => this.setActive(i));
    });

    // Lightbox
    if (this.lightbox) {
      on(this.mainImg.closest('[data-ot-gallery-main-wrap]'), 'click', () => {
        this.openLightbox(this.currentIdx);
      });

      const closeBtn = $('[data-ot-lightbox-close]', this.lightbox);
      const prevBtn  = $('[data-ot-lightbox-prev]', this.lightbox);
      const nextBtn  = $('[data-ot-lightbox-next]', this.lightbox);

      if (closeBtn) on(closeBtn, 'click', () => this.closeLightbox());
      if (prevBtn)  on(prevBtn,  'click', () => this.navigate(-1));
      if (nextBtn)  on(nextBtn,  'click', () => this.navigate(1));

      on(this.lightbox, 'click', e => {
        if (e.target === this.lightbox) this.closeLightbox();
      });
    }

    // Keyboard lightbox navigation
    on(document, 'keydown', e => {
      if (!this.lightbox || !this.lightbox.classList.contains('is-open')) return;
      if (e.key === 'Escape')     this.closeLightbox();
      if (e.key === 'ArrowLeft')  this.navigate(-1);
      if (e.key === 'ArrowRight') this.navigate(1);
    });

    // Touch swipe on gallery
    this._initSwipe(this.mainImg.closest('[data-ot-gallery-main-wrap]'));
  },

  setActive(idx) {
    this.currentIdx = idx;
    const thumb = this.thumbs[idx];
    if (!thumb) return;

    const src    = thumb.dataset.src    || thumb.querySelector('img')?.src;
    const srcset = thumb.dataset.srcset || thumb.querySelector('img')?.srcset;

    if (src) this.mainImg.src = src;
    if (srcset) this.mainImg.srcset = srcset;

    this.thumbs.forEach(t => t.classList.remove('is-active'));
    thumb.classList.add('is-active');
    thumb.scrollIntoView({ behavior: 'smooth', block: 'nearest', inline: 'center' });
  },

  navigate(dir) {
    const next = (this.currentIdx + dir + this.thumbs.length) % this.thumbs.length;
    this.setActive(next);
    if (this.lightbox && this.lightbox.classList.contains('is-open')) {
      const lightImg = $('[data-ot-lightbox-img]', this.lightbox);
      if (lightImg) lightImg.src = this.mainImg.src;
    }
  },

  openLightbox(idx) {
    if (!this.lightbox) return;
    const lightImg = $('[data-ot-lightbox-img]', this.lightbox);
    if (lightImg) lightImg.src = this.mainImg.src;
    this.lightbox.classList.add('is-open');
    document.body.style.overflow = 'hidden';
  },

  closeLightbox() {
    if (!this.lightbox) return;
    this.lightbox.classList.remove('is-open');
    document.body.style.overflow = '';
  },

  _initSwipe(el) {
    if (!el) return;
    let startX = 0;
    on(el, 'touchstart', e => { startX = e.touches[0].clientX; }, { passive: true });
    on(el, 'touchend', e => {
      const diff = startX - e.changedTouches[0].clientX;
      if (Math.abs(diff) > 50) this.navigate(diff > 0 ? 1 : -1);
    }, { passive: true });
  }
};

/* =========================================================
   QUANTITY CONTROLS
   ========================================================= */
const QuantityControl = {
  init() {
    on(document, 'click', e => {
      const btn = e.target.closest('[data-ot-qty-btn]');
      if (!btn) return;

      const wrap  = btn.closest('[data-ot-qty-wrap]');
      const input = wrap?.querySelector('[data-ot-qty-input]');
      if (!input) return;

      const step = parseInt(btn.dataset.step || 1);
      const min  = parseInt(input.min || 1);
      const max  = parseInt(input.max || Infinity);
      const val  = parseInt(input.value || 1);
      const dir  = btn.dataset.otQtyBtn === 'inc' ? 1 : -1;
      const next = Math.max(min, Math.min(max, val + dir * step));

      input.value = next;
      input.dispatchEvent(new Event('change', { bubbles: true }));
    });
  }
};

/* =========================================================
   STICKY ADD-TO-CART BAR
   ========================================================= */
const StickyATC = {
  init() {
    const bar    = $('[data-ot-sticky-atc]');
    const trigger = $('[data-ot-atc-trigger]');
    if (!bar || !trigger) return;

    const obs = new IntersectionObserver(
      ([entry]) => bar.classList.toggle('is-visible', !entry.isIntersecting),
      { rootMargin: `-${getComputedStyle(document.documentElement).getPropertyValue('--header-h')} 0px 0px 0px` }
    );

    obs.observe(trigger);
  }
};

/* =========================================================
   WISHLIST TOGGLE (visual only — integrate with PS wishlist module)
   ========================================================= */
const Wishlist = {
  STORAGE_KEY: 'ot-wishlist',

  init() {
    this.ids = new Set(JSON.parse(localStorage.getItem(this.STORAGE_KEY) || '[]'));

    // Mark active buttons
    $$('[data-ot-wishlist-btn]').forEach(btn => {
      const id = btn.dataset.productId;
      if (id && this.ids.has(id)) btn.classList.add('is-active');
    });

    on(document, 'click', e => {
      const btn = e.target.closest('[data-ot-wishlist-btn]');
      if (!btn) return;
      e.preventDefault();
      this.toggle(btn);
    });
  },

  toggle(btn) {
    const id = btn.dataset.productId;
    if (!id) return;

    if (this.ids.has(id)) {
      this.ids.delete(id);
      btn.classList.remove('is-active');
    } else {
      this.ids.add(id);
      btn.classList.add('is-active');
    }

    localStorage.setItem(this.STORAGE_KEY, JSON.stringify([...this.ids]));

    // Sync all buttons for same product
    $$(`[data-ot-wishlist-btn][data-product-id="${id}"]`).forEach(b => {
      b.classList.toggle('is-active', this.ids.has(id));
    });
  }
};

/* =========================================================
   LAZY IMAGE LOADING
   ========================================================= */
const LazyImages = {
  init() {
    if ('loading' in HTMLImageElement.prototype) {
      // Native lazy loading — just set the attribute
      $$('img[data-src]').forEach(img => {
        img.src = img.dataset.src;
        if (img.dataset.srcset) img.srcset = img.dataset.srcset;
      });
      return;
    }

    // Fallback: IntersectionObserver
    const obs = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (!entry.isIntersecting) return;
        const img = entry.target;
        if (img.dataset.src) { img.src = img.dataset.src; delete img.dataset.src; }
        if (img.dataset.srcset) { img.srcset = img.dataset.srcset; delete img.dataset.srcset; }
        obs.unobserve(img);
      });
    }, { rootMargin: '200px 0px' });

    $$('img[data-src]').forEach(img => obs.observe(img));
  }
};

/* =========================================================
   GRID/LIST VIEW TOGGLE
   ========================================================= */
const ViewToggle = {
  STORAGE_KEY: 'ot-listing-view',

  init() {
    const grid     = $('[data-ot-product-grid]');
    const btnsGrid = $$('[data-ot-view-btn]');
    if (!grid || !btnsGrid.length) return;

    const saved = localStorage.getItem(this.STORAGE_KEY) || 'grid';
    this._setView(grid, btnsGrid, saved);

    btnsGrid.forEach(btn => {
      on(btn, 'click', () => {
        const view = btn.dataset.otViewBtn;
        this._setView(grid, btnsGrid, view);
        localStorage.setItem(this.STORAGE_KEY, view);
      });
    });
  },

  _setView(grid, btns, view) {
    grid.classList.toggle('view-list', view === 'list');
    // Update card layouts
    $$('[data-ot-product-card]', grid).forEach(card => {
      card.classList.toggle('ot-product-card--list', view === 'list');
    });
    btns.forEach(b => b.classList.toggle('is-active', b.dataset.otViewBtn === view));
  }
};

/* =========================================================
   FILTER MOBILE SHEET
   ========================================================= */
const FilterSheet = {
  sheet: null,

  init() {
    this.sheet = $('[data-ot-filter-sheet]');
    if (!this.sheet) return;

    const openBtn  = $('[data-ot-filter-open]');
    const backdrop = $('[data-ot-filter-backdrop]', this.sheet);
    const closeBtn = $('[data-ot-filter-close]', this.sheet);

    if (openBtn)  on(openBtn, 'click', () => this.open());
    if (backdrop) on(backdrop, 'click', () => this.close());
    if (closeBtn) on(closeBtn, 'click', () => this.close());

    on(document, 'keydown', e => {
      if (e.key === 'Escape' && this.sheet.classList.contains('is-open')) this.close();
    });

    // Handle filter group accordion
    $$('[data-ot-filter-group-toggle]').forEach(toggle => {
      on(toggle, 'click', () => {
        const group = toggle.closest('[data-ot-filter-group]');
        if (group) group.classList.toggle('is-collapsed');
      });
    });

    // Show more/less in filter lists
    $$('[data-ot-filter-show-more]').forEach(btn => {
      const container = btn.previousElementSibling;
      if (!container) return;
      const items = $$('[data-ot-filter-item]', container);
      const limit = parseInt(btn.dataset.limit || 5);

      items.slice(limit).forEach(i => i.style.display = 'none');

      on(btn, 'click', () => {
        const isExpanded = btn.classList.contains('is-expanded');
        items.slice(limit).forEach(i => { i.style.display = isExpanded ? 'none' : ''; });
        btn.classList.toggle('is-expanded');
        btn.querySelector('[data-show-text]') && (
          btn.querySelector('[data-show-text]').textContent = isExpanded ? 'Pokaži več' : 'Pokaži manj'
        );
      });
    });
  },

  open() {
    this.sheet.classList.add('is-open');
    document.body.style.overflow = 'hidden';
  },

  close() {
    this.sheet.classList.remove('is-open');
    document.body.style.overflow = '';
  }
};

/* =========================================================
   BOTTOM NAVIGATION ACTIVE STATE
   ========================================================= */
const BottomNav = {
  init() {
    const path = window.location.pathname;
    $$('[data-ot-bottom-nav-item]').forEach(item => {
      const href = item.getAttribute('href') || item.dataset.href;
      if (href && path.startsWith(href) && href !== '/') {
        item.classList.add('is-active');
      }
    });
  }
};

/* =========================================================
   TOAST NOTIFICATIONS
   ========================================================= */
const Toast = {
  container: null,

  init() {
    this.container = document.createElement('div');
    this.container.id = 'ot-toast-container';
    this.container.setAttribute('aria-live', 'polite');
    this.container.setAttribute('aria-atomic', 'false');
    Object.assign(this.container.style, {
      position: 'fixed',
      bottom: '80px',
      right: '16px',
      zIndex: '500',
      display: 'flex',
      flexDirection: 'column',
      gap: '8px',
      pointerEvents: 'none',
    });
    document.body.appendChild(this.container);

    // Listen for PS9 notifications
    document.addEventListener('addedToCart',   () => this.show('Dodano v košarico!', 'success'));
    document.addEventListener('removeFromCart', () => this.show('Odstranjeno iz košarice', 'info'));
  },

  show(message, type = 'info', duration = 3000) {
    const toast = document.createElement('div');
    toast.textContent = message;
    Object.assign(toast.style, {
      background: type === 'success' ? '#059669' : type === 'error' ? '#dc2626' : '#0066CC',
      color: '#fff',
      padding: '10px 16px',
      borderRadius: '8px',
      fontSize: '14px',
      fontWeight: '500',
      boxShadow: '0 4px 12px rgba(0,0,0,0.15)',
      opacity: '0',
      transform: 'translateX(20px)',
      transition: 'opacity 0.2s, transform 0.2s',
      pointerEvents: 'auto',
      fontFamily: 'var(--font-body)',
      maxWidth: '280px',
    });

    this.container.appendChild(toast);

    requestAnimationFrame(() => {
      toast.style.opacity = '1';
      toast.style.transform = 'translateX(0)';
    });

    setTimeout(() => {
      toast.style.opacity = '0';
      toast.style.transform = 'translateX(20px)';
      toast.addEventListener('transitionend', () => toast.remove(), { once: true });
    }, duration);
  }
};

/* =========================================================
   SMOOTH SCROLL TO TOP
   ========================================================= */
const BackToTop = {
  init() {
    const btn = $('[data-ot-back-top]');
    if (!btn) return;

    const onScroll = throttle(() => {
      btn.classList.toggle('is-visible', window.scrollY > 400);
    }, 100);

    on(window, 'scroll', onScroll, { passive: true });
    on(btn, 'click', () => window.scrollTo({ top: 0, behavior: 'smooth' }));
  }
};

/* =========================================================
   PRODUCT TABS (detail page)
   ========================================================= */
const ProductTabs = {
  init() {
    const tabLists = $$('[data-ot-tabs]');
    tabLists.forEach(list => {
      const tabs    = $$('[data-ot-tab]', list);
      const panels  = $$(`[data-ot-tab-panel]`);

      tabs.forEach(tab => {
        on(tab, 'click', () => {
          const target = tab.dataset.otTab;
          tabs.forEach(t => t.classList.remove('is-active'));
          panels.forEach(p => p.classList.remove('is-active'));
          tab.classList.add('is-active');
          const panel = $(`[data-ot-tab-panel="${target}"]`);
          if (panel) panel.classList.add('is-active');
        });
      });
    });
  }
};

/* =========================================================
   INITIALISE ALL MODULES
   ========================================================= */
function init() {
  DarkMode.init();
  StickyHeader.init();
  MobileDrawer.init();
  MegaMenu.init();
  CartBadge.init();
  ProductGallery.init();
  QuantityControl.init();
  StickyATC.init();
  Wishlist.init();
  LazyImages.init();
  ViewToggle.init();
  FilterSheet.init();
  BottomNav.init();
  Toast.init();
  BackToTop.init();
  ProductTabs.init();
}

// Run on DOM ready
if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', init);
} else {
  init();
}

// Expose for external use
window.OTTheme = { DarkMode, Toast, Wishlist };
