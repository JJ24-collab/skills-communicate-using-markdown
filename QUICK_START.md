# ⚡ SZYBKI START - Mapa Ambasadorów

## 🎯 Cel: Wrzucić mapę na hosting i osadzić w WordPress

---

## Krok 1: Pobierz pliki (wybierz jedną metodę)

### Opcja A: Z GitHuba (ZIP)
1. Otwórz: https://github.com/JJ24-collab/skills-communicate-using-markdown
2. Kliknij **Code** → **Download ZIP**
3. Rozpakuj na swoim komputerze

### Opcja B: Git clone
```bash
git clone https://github.com/JJ24-collab/skills-communicate-using-markdown.git
cd skills-communicate-using-markdown
git checkout claude/ambassador-manager-map-QJ3uE
```

### Opcja C: Użyj gotowego folderu (jeśli masz dostęp)
Folder znajduje się w: `/root/ambassador-map-ready-to-upload/`

---

## Krok 2: Wrzuć na hosting przez FTP

### Co potrzebujesz:
- Program FTP (FileZilla, Cyberduck, WinSCP)
- Dane dostępowe do hostingu

### Kroki:
1. **Połącz się z FTP:**
   - Host: `ftp.twoja-domena.pl`
   - Username: `twój-login`
   - Password: `twoje-hasło`
   - Port: `21`

2. **Przejdź do katalogu:**
   ```
   /public_html/
   ```

3. **Utwórz folder:**
   ```
   ambassador-map/
   ```

4. **Wrzuć pliki zachowując strukturę:**
   ```
   /public_html/ambassador-map/
   ├── ambassador-map.html
   └── data/
       ├── ambassadors.json
       ├── locations.json
       └── config.json
   ```

5. **Sprawdź czy działa:**
   Otwórz w przeglądarce:
   ```
   https://TWOJA-DOMENA.pl/ambassador-map/ambassador-map.html
   ```

---

## Krok 3: Osadź w WordPressie

### A) Edytuj artykuł/stronę w WordPress

### B) Dodaj blok "Własny HTML" (Custom HTML)

### C) Wklej ten kod:

```html
<div style="margin: 2rem 0;">
    <iframe
        src="https://TWOJA-DOMENA.pl/ambassador-map/ambassador-map.html"
        width="100%"
        height="800px"
        frameborder="0"
        style="border: none; border-radius: 12px; box-shadow: 0 4px 20px rgba(0,0,0,0.15);"
        loading="lazy"
        title="Mapa ambasadorów RP"
        allowfullscreen>
    </iframe>
</div>
```

**WAŻNE:** Zamień `TWOJA-DOMENA.pl` na swoją prawdziwą domenę!

### D) Opublikuj artykuł

---

## ✨ Opcjonalnie: Dodaj responsywność

W **WordPress → Wygląd → Dostosuj → Dodatkowy CSS** wklej:

```css
/* Responsywność mapy ambasadorów */
.wp-block-html iframe[src*="ambassador-map"] {
    width: 100%;
    min-height: 600px;
    border-radius: 12px;
    transition: all 0.3s ease;
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

---

## 🎉 Gotowe!

Twoja mapa jest teraz live na stronie!

---

## 🔄 Aktualizacja danych w przyszłości

Jeśli chcesz zaktualizować listę ambasadorów:

1. Edytuj plik `data/ambassadors.json`
2. Wrzuć przez FTP (nadpisz stary plik)
3. Odśwież stronę - zmiany widoczne natychmiast!

---

## 🆘 Problemy?

### Mapa się nie ładuje
- Sprawdź Console (F12) w przeglądarce
- Upewnij się że ścieżka do plików jest poprawna
- Sprawdź czy pliki JSON są dostępne publicznie

### WordPress usuwa kod
- Użyj bloku "Własny HTML" zamiast edytora wizualnego
- Lub zainstaluj plugin "Insert Headers and Footers"

### Mapa jest za mała
- Zmień `height="800px"` na większą wartość
- Dodaj CSS z sekcji "Responsywność" powyżej

---

## 📊 Co masz w mapie?

- ✅ 105 placówek dyplomatycznych
- ✅ 13 przedstawicielstw przy organizacjach międzynarodowych
- ✅ Interaktywna mapa świata (Leaflet.js)
- ✅ Filtrowanie po płci i wieku
- ✅ Wyszukiwarka
- ✅ Biografie ambasadorów
- ✅ Pełna responsywność (mobile-friendly)

---

## 📖 Więcej informacji

- Pełna dokumentacja: `DEPLOYMENT_GUIDE.md`
- Kod shortcode WordPress: `wordpress-shortcode.php`
- Skrypt GitHub Pages: `deploy-github-pages.sh`

---

**Powodzenia!** 🚀

Jeśli masz pytania, sprawdź pełną dokumentację w `DEPLOYMENT_GUIDE.md`
