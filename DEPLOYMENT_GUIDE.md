# 🚀 Przewodnik wdrożenia mapy ambasadorów

## 📋 Spis treści
1. [Podgląd lokalny](#podgląd-lokalny)
2. [Pobranie z GitHuba](#pobranie-z-githuba)
3. [Upload na hosting](#upload-na-hosting)
4. [Konfiguracja WordPress](#konfiguracja-wordpress)
5. [Troubleshooting](#troubleshooting)

---

## 🎨 Podgląd lokalny

### Metoda 1: Python (zainstalowany domyślnie)
```bash
# W katalogu projektu:
python3 -m http.server 8080

# Otwórz w przeglądarce:
http://localhost:8080/ambassador-map.html
```

### Metoda 2: PHP (jeśli masz zainstalowane)
```bash
php -S localhost:8080

# Otwórz:
http://localhost:8080/ambassador-map.html
```

### Metoda 3: Node.js (live-server z auto-refresh)
```bash
npx live-server --port=8080

# Otworzy się automatycznie w przeglądarce
```

**Zatrzymanie serwera:** `Ctrl+C` w terminalu

---

## 📥 Pobranie z GitHuba

### Opcja A: Sklonuj repozytorium
```bash
# Sklonuj na swój komputer:
git clone https://github.com/JJ24-collab/skills-communicate-using-markdown.git

# Przejdź do folderu:
cd skills-communicate-using-markdown

# Przełącz na właściwą gałąź:
git checkout claude/ambassador-manager-map-QJ3uE
```

### Opcja B: Pobierz jako ZIP
1. Otwórz: https://github.com/JJ24-collab/skills-communicate-using-markdown
2. Przełącz branch na `claude/ambassador-manager-map-QJ3uE`
3. Kliknij **Code** → **Download ZIP**
4. Rozpakuj na swoim komputerze

### Opcja C: Pobierz tylko niezbędne pliki (wget/curl)
```bash
# Utwórz katalog:
mkdir ambassador-map && cd ambassador-map

# Pobierz główny plik HTML:
curl -O https://raw.githubusercontent.com/JJ24-collab/skills-communicate-using-markdown/claude/ambassador-manager-map-QJ3uE/ambassador-map.html

# Pobierz dane JSON:
mkdir data && cd data
curl -O https://raw.githubusercontent.com/JJ24-collab/skills-communicate-using-markdown/claude/ambassador-manager-map-QJ3uE/data/ambassadors.json
curl -O https://raw.githubusercontent.com/JJ24-collab/skills-communicate-using-markdown/claude/ambassador-manager-map-QJ3uE/data/locations.json
curl -O https://raw.githubusercontent.com/JJ24-collab/skills-communicate-using-markdown/claude/ambassador-manager-map-QJ3uE/data/config.json
cd ..
```

---

## 📤 Upload na hosting

### Przez FTP (FileZilla, Cyberduck, itp.)

**Struktura do wrzucenia:**
```
/public_html/                    ← Twój główny katalog
└── ambassador-map/              ← Nowy folder
    ├── ambassador-map.html      ← Główny plik
    └── data/                    ← Folder z danymi
        ├── ambassadors.json
        ├── locations.json
        └── config.json
```

**Kroki:**
1. Połącz się z FTP:
   - Host: `ftp.twoja-domena.pl`
   - Username: `twoj-login`
   - Password: `twoje-haslo`
   - Port: `21` (lub `22` dla SFTP)

2. Przejdź do katalogu `public_html/` lub `www/`

3. Utwórz folder `ambassador-map/`

4. Wrzuć pliki zachowując strukturę folderów

5. Ustaw uprawnienia (jeśli trzeba):
   - Pliki `.html` i `.json`: `644` (rw-r--r--)
   - Foldery: `755` (rwxr-xr-x)

6. Sprawdź czy działa:
   ```
   https://twoja-domena.pl/ambassador-map/ambassador-map.html
   ```

### Przez cPanel File Manager

1. Zaloguj się do cPanel
2. Otwórz **File Manager**
3. Przejdź do `public_html/`
4. Kliknij **+ Folder** → Nazwa: `ambassador-map`
5. Wejdź do folderu `ambassador-map/`
6. Kliknij **Upload** → Wybierz `ambassador-map.html`
7. Utwórz podfolder `data/`
8. Wrzuć pliki JSON do `data/`
9. Gotowe! Sprawdź URL w przeglądarce

### Przez SSH (dla zaawansowanych)

```bash
# Połącz się z serwerem:
ssh twoj-login@twoja-domena.pl

# Przejdź do katalogu WWW:
cd public_html

# Utwórz folder:
mkdir -p ambassador-map/data

# Skopiuj pliki z lokalnego komputera (w nowym terminalu):
scp ambassador-map.html twoj-login@twoja-domena.pl:~/public_html/ambassador-map/
scp data/*.json twoj-login@twoja-domena.pl:~/public_html/ambassador-map/data/
```

---

## 🔧 Konfiguracja WordPress

### Po wrzuceniu plików na hosting:

**1. Skopiuj URL mapy:**
```
https://twoja-domena.pl/ambassador-map/ambassador-map.html
```

**2. W WordPressie:**
- Edytuj artykuł/stronę
- Dodaj blok **"Własny HTML"** (Custom HTML)
- Wklej kod:

```html
<div style="margin: 2rem 0;">
    <iframe
        src="https://twoja-domena.pl/ambassador-map/ambassador-map.html"
        width="100%"
        height="800px"
        frameborder="0"
        style="border: none; border-radius: 12px; box-shadow: 0 4px 20px rgba(0,0,0,0.15);"
        loading="lazy"
        title="Interaktywna mapa ambasadorów Rzeczypospolitej Polskiej"
        allowfullscreen>
    </iframe>
</div>
```

**3. Dodaj CSS dla responsywności:**

W **Wygląd → Dostosuj → Dodatkowy CSS**:
```css
/* Mapa ambasadorów - responsywność */
.wp-block-html iframe[src*="ambassador-map"] {
    width: 100%;
    min-height: 600px;
    border-radius: 12px;
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
    transition: box-shadow 0.3s ease;
}

.wp-block-html iframe[src*="ambassador-map"]:hover {
    box-shadow: 0 6px 25px rgba(0, 0, 0, 0.2);
}

@media (max-width: 1024px) {
    .wp-block-html iframe[src*="ambassador-map"] {
        min-height: 550px;
    }
}

@media (max-width: 768px) {
    .wp-block-html iframe[src*="ambassador-map"] {
        min-height: 500px;
    }
}

@media (max-width: 480px) {
    .wp-block-html iframe[src*="ambassador-map"] {
        min-height: 450px;
        border-radius: 8px;
    }
}
```

**4. Opublikuj artykuł!** ✅

---

## 🌐 Alternatywa: GitHub Pages (Darmowy hosting)

### Zalety:
- ✅ Całkowicie darmowe
- ✅ HTTPS włączone automatycznie
- ✅ CDN (szybkie ładowanie na całym świecie)
- ✅ Proste aktualizacje (git push)

### Konfiguracja:

**1. Utwórz nowe repo na GitHubie:**
```bash
# W folderze projektu:
git init
git add ambassador-map.html data/
git commit -m "Initial commit: Ambassador map"

# Utwórz repo na GitHub (https://github.com/new)
# Nazwa: ambassador-map

# Połącz i wyślij:
git remote add origin https://github.com/TWOJ-USERNAME/ambassador-map.git
git branch -M gh-pages
git push -u origin gh-pages
```

**2. Włącz GitHub Pages:**
- Otwórz repo na GitHubie
- **Settings** → **Pages**
- Source: `gh-pages` branch
- Save

**3. Poczekaj 1-2 minuty**

**4. Mapa będzie dostępna pod:**
```
https://TWOJ-USERNAME.github.io/ambassador-map/ambassador-map.html
```

**5. Osadź w WordPress** używając tego URL w iframe.

### Aktualizacja danych na GitHub Pages:
```bash
# Edytuj plik JSON:
nano data/ambassadors.json

# Wyślij zmiany:
git add data/ambassadors.json
git commit -m "Aktualizacja danych ambasadorów"
git push

# Po 1-2 minutach zmiany są live!
```

---

## 🔍 Troubleshooting

### ❌ Problem: "Mapa się nie ładuje"

**Rozwiązanie:**
1. Sprawdź Console (F12 → Console) w przeglądarce
2. Szukaj błędów typu:
   - `Failed to load resource` → Zła ścieżka do plików
   - `CORS error` → Problem z serwerem

**Fix:**
```bash
# Sprawdź czy pliki JSON są dostępne:
curl https://twoja-domena.pl/ambassador-map/data/ambassadors.json
# Powinien zwrócić zawartość JSON
```

Jeśli błąd CORS, dodaj w `.htaccess`:
```apache
<IfModule mod_headers.c>
    <FilesMatch "\.(json)$">
        Header set Access-Control-Allow-Origin "*"
    </FilesMatch>
</IfModule>
```

### ❌ Problem: "Piny się nie pokazują"

**Przyczyna:** Błąd w pliku `locations.json`

**Rozwiązanie:**
```bash
# Sprawdź poprawność JSON:
cat data/locations.json | python3 -m json.tool

# Jeśli błąd, napraw formatowanie
```

### ❌ Problem: "WordPress usuwa kod iframe"

**Rozwiązanie:**
1. Użyj bloku **"Własny HTML"** zamiast edytora wizualnego
2. Lub zainstaluj plugin: **"Insert Headers and Footers"**
3. Lub użyj metody shortcode (zobacz `wordpress-shortcode.php`)

### ❌ Problem: "Mapa jest za mała na mobile"

**Rozwiązanie:** Dodaj CSS z sekcji "Konfiguracja WordPress" powyżej

### ❌ Problem: "404 Not Found"

**Sprawdź:**
1. Czy ścieżka w URL jest poprawna
2. Czy nazwa pliku to dokładnie `ambassador-map.html`
3. Czy plik jest w katalogu `public_html/ambassador-map/`
4. Czy uprawnienia pliku to `644`

---

## 📊 Statystyki wydajności

Po wdrożeniu możesz sprawdzić:
- **PageSpeed Insights:** https://pagespeed.web.dev/
- **GTmetrix:** https://gtmetrix.com/

**Oczekiwane wyniki:**
- Performance Score: 90-95
- First Contentful Paint: < 1.5s
- Largest Contentful Paint: < 2.5s

---

## 🎯 Quick Start - Szybkie polecenia

### Scenariusz 1: Mam własny hosting
```bash
# 1. Pobierz pliki z GitHub:
git clone https://github.com/JJ24-collab/skills-communicate-using-markdown.git
cd skills-communicate-using-markdown
git checkout claude/ambassador-manager-map-QJ3uE

# 2. Wrzuć przez FTP folder "ambassador-map/" do public_html/

# 3. Sprawdź: https://twoja-domena.pl/ambassador-map/ambassador-map.html

# 4. Osadź w WordPress (iframe)
```

### Scenariusz 2: Chcę GitHub Pages (darmowy)
```bash
# 1. Przygotuj pliki:
bash deploy-github-pages.sh

# 2. Postępuj według instrukcji na ekranie

# 3. Osadź w WordPress używając URL GitHub Pages
```

---

## 📞 Wsparcie

Jeśli coś nie działa:
1. Sprawdź Console (F12) w przeglądarce
2. Sprawdź Network tab - czy wszystkie pliki się ładują
3. Upewnij się, że struktura folderów jest poprawna
4. Sprawdź uprawnienia plików (644 dla plików, 755 dla folderów)

---

**Gotowe!** Teraz możesz cieszyć się interaktywną mapą ambasadorów na swojej stronie! 🎉
