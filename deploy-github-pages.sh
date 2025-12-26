#!/bin/bash
# Skrypt do wrzucenia mapy ambasadorów na GitHub Pages (darmowy hosting)

echo "🚀 Deployment mapy ambasadorów na GitHub Pages"
echo ""

# Stwórz folder do deployment
mkdir -p gh-pages-deploy
cd gh-pages-deploy

# Skopiuj niezbędne pliki
echo "📦 Kopiowanie plików..."
cp ../ambassador-map.html index.html
mkdir -p data
cp ../data/*.json data/

# Dodaj README
cat > README.md << 'EOF'
# Mapa Ambasadorów RP

Interaktywna mapa polskich placówek dyplomatycznych na świecie.

## Live Demo
https://[TWOJ-USERNAME].github.io/ambassador-map/

## Aktualizacja danych
1. Edytuj pliki w folderze `data/`
2. Commit i push do GitHub
3. Strona zaktualizuje się automatycznie

## Osadzanie w WordPress
```html
<iframe
  src="https://[TWOJ-USERNAME].github.io/ambassador-map/"
  width="100%"
  height="800px"
  frameborder="0"
  loading="lazy">
</iframe>
```
EOF

# Inicjalizuj git repo
echo "🔧 Konfiguracja Git..."
git init
git add .
git commit -m "Initial deploy: Interactive ambassador map"

echo ""
echo "✅ Pliki przygotowane!"
echo ""
echo "📋 Następne kroki:"
echo "1. Stwórz nowe repozytorium na GitHub: https://github.com/new"
echo "   Nazwa: ambassador-map"
echo ""
echo "2. Uruchom te komendy:"
echo "   git remote add origin https://github.com/TWOJ-USERNAME/ambassador-map.git"
echo "   git branch -M gh-pages"
echo "   git push -u origin gh-pages"
echo ""
echo "3. Włącz GitHub Pages:"
echo "   Settings → Pages → Source: gh-pages branch → Save"
echo ""
echo "4. Po 1-2 minutach mapa będzie dostępna pod:"
echo "   https://TWOJ-USERNAME.github.io/ambassador-map/"
echo ""
echo "5. Osadź w WordPressie używając iframe z URL powyżej"
