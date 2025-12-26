# Instrukcja osadzenia mapy ambasadorów w WordPressie

## Metoda 1: iframe (zalecana)

### Krok 1: Upload plików na hosting
Wrzuć folder `ambassador-map` z plikami do katalogu publicznego hostingu (np. przez FTP/cPanel).

```
/public_html/
└── ambassador-map/
    ├── ambassador-map.html
    └── data/
        ├── ambassadors.json
        ├── locations.json
        └── config.json
```

### Krok 2: Osadź w WordPressie
W edytorze Gutenberg dodaj blok **"Własny HTML"** i wklej:

```html
<iframe
  src="https://twoja-domena.pl/ambassador-map/ambassador-map.html"
  width="100%"
  height="800px"
  frameborder="0"
  style="border: none; border-radius: 8px; box-shadow: 0 4px 6px rgba(0,0,0,0.1);"
  loading="lazy"
  title="Mapa ambasadorów RP">
</iframe>
```

---

## Metoda 2: Shortcode WordPress

### Krok 1: Dodaj shortcode do `functions.php`
W Appearance → Theme Editor → functions.php dodaj:

```php
function ambassador_map_shortcode($atts) {
    $atts = shortcode_atts(array(
        'height' => '800px',
        'width' => '100%'
    ), $atts);

    $iframe = '<iframe
        src="' . get_site_url() . '/ambassador-map/ambassador-map.html"
        width="' . esc_attr($atts['width']) . '"
        height="' . esc_attr($atts['height']) . '"
        frameborder="0"
        style="border: none; border-radius: 8px;"
        loading="lazy"
        title="Mapa ambasadorów RP">
    </iframe>';

    return $iframe;
}
add_shortcode('mapa_ambasadorow', 'ambassador_map_shortcode');
```

### Krok 2: Użyj w artykule
```
[mapa_ambasadorow]
```

Lub z parametrami:
```
[mapa_ambasadorow height="600px" width="100%"]
```

---

## Metoda 3: Bezpośrednie osadzenie (dla zaawansowanych)

⚠️ **Wymaga:** Plugin "Insert Headers and Footers" lub dostęp do `header.php`

### Krok 1: Wrzuć dane JSON do WordPress
Upload plików JSON do Media Library lub `/wp-content/uploads/ambassador-data/`

### Krok 2: Zmodyfikuj ścieżki w `ambassador-map.html`
Zmień w kodzie JavaScript:
```javascript
// Przed:
fetch('./data/ambassadors.json')

// Po:
fetch('/wp-content/uploads/ambassador-data/ambassadors.json')
```

### Krok 3: Wklej cały kod HTML
W edytorze Classic lub bloku "Własny HTML" wklej zawartość `ambassador-map.html`

**Uwaga:** Ta metoda może być zablokowana przez zabezpieczenia WordPress.

---

## Metoda 4: GitHub Pages + iframe (Darmowa)

### Krok 1: Utwórz repozytorium GitHub
```bash
git init
git add .
git commit -m "Ambassador map"
git branch -M gh-pages
git remote add origin https://github.com/twoj-user/ambassador-map.git
git push -u origin gh-pages
```

### Krok 2: Włącz GitHub Pages
Settings → Pages → Source: `gh-pages` branch

### Krok 3: Osadź w WordPressie
```html
<iframe
  src="https://twoj-user.github.io/ambassador-map/ambassador-map.html"
  width="100%"
  height="800px"
  frameborder="0">
</iframe>
```

**Zalety:**
- Całkowicie darmowe
- CDN GitHub (szybkie)
- Łatwe aktualizacje (git push)

---

## Responsive Design - dodatkowy CSS dla WordPress

Aby mapa ładnie wyglądała na mobile, dodaj w Theme Customizer → Additional CSS:

```css
/* Responsive iframe dla mapy ambasadorów */
.wp-block-html iframe[src*="ambassador-map"] {
    width: 100%;
    min-height: 600px;
    border-radius: 8px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

@media (max-width: 768px) {
    .wp-block-html iframe[src*="ambassador-map"] {
        min-height: 500px;
    }
}

@media (max-width: 480px) {
    .wp-block-html iframe[src*="ambassador-map"] {
        min-height: 400px;
    }
}
```

---

## Najlepsze praktyki

1. **Performance:**
   - Użyj `loading="lazy"` w iframe
   - Kompresuj pliki JSON (minify)
   - Włącz GZIP na serwerze

2. **Security:**
   - Użyj HTTPS
   - Sprawdź CORS headers jeśli dane są na innej domenie

3. **SEO:**
   - Dodaj atrybut `title` do iframe
   - Dodaj `<noscript>` fallback z linkiem

4. **Aktualizacje:**
   - Najłatwiej: edytuj tylko pliki JSON
   - Mapa automatycznie załaduje nowe dane

---

## Troubleshooting

### Problem: "Nie ładuje się mapa"
- Sprawdź ścieżki do plików JSON (Console → Network)
- Upewnij się, że serwer obsługuje CORS
- Sprawdź czy pliki są dostępne publicznie

### Problem: "WordPress usuwa kod HTML"
- Użyj pluginu "Insert Headers and Footers"
- Lub zmień na iframe (bezpieczniejsze)

### Problem: "Mapa nie jest responsywna"
- Dodaj wrapper div:
```html
<div style="position: relative; padding-bottom: 56.25%; height: 0; overflow: hidden;">
    <iframe
        src="..."
        style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;">
    </iframe>
</div>
```
