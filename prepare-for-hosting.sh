#!/bin/bash
# Skrypt przygotowujący mapę ambasadorów do wrzucenia na hosting

echo "🎯 Przygotowywanie mapy ambasadorów do deploymentu..."
echo ""

# Utwórz folder deployment
DEPLOY_DIR="$HOME/ambassador-map-ready-to-upload"
rm -rf "$DEPLOY_DIR"
mkdir -p "$DEPLOY_DIR/data"

# Skopiuj niezbędne pliki
echo "📦 Kopiowanie plików..."
cp ambassador-map.html "$DEPLOY_DIR/"
cp data/ambassadors.json "$DEPLOY_DIR/data/"
cp data/locations.json "$DEPLOY_DIR/data/"
cp data/config.json "$DEPLOY_DIR/data/"

# Utwórz README z instrukcjami
cat > "$DEPLOY_DIR/README.txt" << 'EOF'
╔════════════════════════════════════════════════════════════════╗
║          MAPA AMBASADORÓW - INSTRUKCJA INSTALACJI              ║
╚════════════════════════════════════════════════════════════════╝

📦 Zawartość folderu:
├── ambassador-map.html    ← Główny plik aplikacji
└── data/                  ← Dane JSON
    ├── ambassadors.json   ← Lista ambasadorów (105 placówek)
    ├── locations.json     ← Współrzędne geograficzne
    └── config.json        ← Konfiguracja kolorów

🚀 INSTALACJA NA HOSTINGU:

1. Połącz się z FTP (FileZilla, Cyberduck, cPanel)

2. Przejdź do katalogu: /public_html/

3. Utwórz nowy folder: ambassador-map/

4. Wrzuć CAŁĄ zawartość tego folderu zachowując strukturę:
   /public_html/ambassador-map/
   ├── ambassador-map.html
   └── data/
       ├── ambassadors.json
       ├── locations.json
       └── config.json

5. Sprawdź czy działa:
   https://TWOJA-DOMENA.pl/ambassador-map/ambassador-map.html

📝 OSADZENIE W WORDPRESS:

W edytorze artykułu dodaj blok "Własny HTML" i wklej:

<iframe
  src="https://TWOJA-DOMENA.pl/ambassador-map/ambassador-map.html"
  width="100%"
  height="800px"
  frameborder="0"
  style="border: none; border-radius: 12px;"
  loading="lazy">
</iframe>

🎨 RESPONSYWNOŚĆ (opcjonalne):

W WordPress: Wygląd → Dostosuj → Dodatkowy CSS:

.wp-block-html iframe[src*="ambassador-map"] {
    width: 100%;
    min-height: 600px;
    border-radius: 12px;
}

@media (max-width: 768px) {
    .wp-block-html iframe[src*="ambassador-map"] {
        min-height: 500px;
    }
}

🔧 AKTUALIZACJA DANYCH:

Aby zaktualizować listę ambasadorów:
1. Edytuj plik: data/ambassadors.json
2. Wrzuć przez FTP (nadpisz stary plik)
3. Gotowe! Zmiany widoczne od razu

📊 DANE:
- 105 placówek dyplomatycznych
- 13 przedstawicielstw przy organizacjach międzynarodowych
- Dane aktualne na grudzień 2024

✅ WYMAGANIA:
- Przeglądarka z JavaScript
- Połączenie internetowe (dla mapy Leaflet.js)
- Brak dodatkowych zależności

🆘 PROBLEMY?
- Sprawdź Console (F12) w przeglądarce
- Upewnij się że struktura folderów jest poprawna
- Sprawdź uprawnienia: pliki 644, foldery 755

═══════════════════════════════════════════════════════════════
Autor: Claude Code
Licencja: Wolne użycie
═══════════════════════════════════════════════════════════════
EOF

# Utwórz .htaccess dla lepszej wydajności (opcjonalnie)
cat > "$DEPLOY_DIR/.htaccess" << 'EOF'
# Kompresja GZIP
<IfModule mod_deflate.c>
    AddOutputFilterByType DEFLATE text/html text/plain text/xml text/css application/json application/javascript
</IfModule>

# Cache dla statycznych plików
<IfModule mod_expires.c>
    ExpiresActive On
    ExpiresByType application/json "access plus 1 day"
    ExpiresByType text/html "access plus 1 hour"
</IfModule>

# CORS headers (jeśli potrzebne)
<IfModule mod_headers.c>
    <FilesMatch "\.(json)$">
        Header set Access-Control-Allow-Origin "*"
    </FilesMatch>
</IfModule>

# Bezpieczeństwo
<FilesMatch "\.(json)$">
    <IfModule mod_headers.c>
        Header set X-Content-Type-Options "nosniff"
    </IfModule>
</FilesMatch>
EOF

# Policz rozmiar
TOTAL_SIZE=$(du -sh "$DEPLOY_DIR" | cut -f1)

echo "✅ Gotowe!"
echo ""
echo "📁 Lokalizacja: $DEPLOY_DIR"
echo "💾 Rozmiar: $TOTAL_SIZE"
echo ""
echo "📋 Zawartość:"
ls -lh "$DEPLOY_DIR"
echo ""
ls -lh "$DEPLOY_DIR/data"
echo ""
echo "═══════════════════════════════════════════════════════════"
echo "🚀 NASTĘPNE KROKI:"
echo "═══════════════════════════════════════════════════════════"
echo ""
echo "1. Otwórz folder:"
echo "   open '$DEPLOY_DIR'  # macOS"
echo "   xdg-open '$DEPLOY_DIR'  # Linux"
echo "   explorer '$DEPLOY_DIR'  # Windows Git Bash"
echo ""
echo "2. Połącz się z FTP i wrzuć całą zawartość do:"
echo "   /public_html/ambassador-map/"
echo ""
echo "3. Sprawdź czy działa:"
echo "   https://TWOJA-DOMENA.pl/ambassador-map/ambassador-map.html"
echo ""
echo "4. Osadź w WordPress (kod w README.txt)"
echo ""
echo "═══════════════════════════════════════════════════════════"
echo ""
echo "📖 Pełna dokumentacja: DEPLOYMENT_GUIDE.md"
echo ""
