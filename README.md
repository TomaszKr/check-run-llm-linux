# LLM Diagnostic Lite

**LLM Diagnostic Lite** to lekkie narzędzie do weryfikacji, czy Twój komputer jest w stanie uruchomić modele LLM (Large Language Models) dla aplikacji takich jak Jan AI. Skrypt sprawdza CPU, RAM, dysk oraz GPU i generuje prostą ocenę „tak/nie” dla możliwości uruchomienia modeli.

---

## Funkcjonalności

- Sprawdza **CPU** i obsługę instrukcji AVX/AVX2 (niezbędne dla LLM).  
- Sprawdza ilość **RAM** i sugeruje, jakie modele mogą działać.  
- Sprawdza typ **dysku** (SSD/HDD).  
- Weryfikuje obecność **GPU NVIDIA** i możliwość użycia CUDA.  
- Generuje **proste podsumowanie**: czy Twój komputer nadaje się do uruchomienia LLM.  
- **Ultra lekki** – nie pobiera modeli, nie instaluje dodatkowego oprogramowania.

---

## Wymagania

- System Linux (Ubuntu/Debian i pochodne)  
- `bash`  
- Polecenia: `lscpu`, `free`, `lsblk`, `grep`  
- Opcjonalnie NVIDIA GPU z zainstalowanym sterownikiem CUDA  

---

## Instalacja

1. Sklonuj repozytorium lub pobierz plik `llm-diagnostic-lite.sh`:

```bash
git clone https://github.com/twoj-repo/llm-diagnostic-lite.git
cd llm-diagnostic-lite
```

2. Nadaj prawa do uruchomienia:

```bash
chmod +x llm-diagnostic-lite.sh
```

---

## Użycie

Uruchom skrypt w terminalu:

```bash
./llm-diagnostic-lite.sh
```

Skrypt wyświetli informacje o CPU, RAM, dysku i GPU oraz podsumowanie:

```bash
✅ Twój komputer prawdopodobnie uruchomi LLM (małe/średnie modele)
❌ Twój komputer raczej nie nadaje się do LLM lub będzie bardzo wolny
```

---

## Uwagi

- Skrypt nie instaluje ani nie pobiera modeli – jest w pełni bezpieczny i lekki.
- Dla starych komputerów zalecane jest użycie wersji ultra lekkiej.
