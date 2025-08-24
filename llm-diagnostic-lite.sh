#!/bin/bash
echo "=== 🔍 Ultra lekka diagnostyka pod LLM (Jan AI) ==="

# -------------------
# CPU
# -------------------
echo -e "\n== CPU =="
CPU_MODEL=$(lscpu | grep "Model name" | sed 's/Model name:\s*//')
CPU_FLAGS=$(grep -m 1 flags /proc/cpuinfo)
echo "Procesor: $CPU_MODEL"

if echo "$CPU_FLAGS" | grep -qw avx2; then
    echo "✅ Obsługuje AVX2 (dobrze dla LLM)"
elif echo "$CPU_FLAGS" | grep -qw avx; then
    echo "⚠️ Obsługuje tylko AVX (modele uruchomią się, ale wolno)"
else
    echo "❌ Brak AVX – większość LLM nie zadziała"
fi

# -------------------
# RAM
# -------------------
echo -e "\n== Pamięć RAM =="
TOTAL_RAM=$(free -h | awk '/Mem:/ {print $2}')
TOTAL_RAM_GB=$(free -g | awk '/Mem:/ {print $2}')
echo "Dostępna pamięć RAM: $TOTAL_RAM"

if [ "$TOTAL_RAM_GB" -ge 16 ]; then
    echo "✅ Min. 16 GB RAM – wszystkie modele OK"
elif [ "$TOTAL_RAM_GB" -ge 8 ]; then
    echo "⚠️ 8 GB RAM – tylko małe/średnie modele"
else
    echo "❌ <8 GB RAM – tylko bardzo małe modele"
fi

# -------------------
# Dysk
# -------------------
echo -e "\n== Dysk =="
if lsblk -d -o NAME,ROTA | grep -q " 1"; then
    echo "⚠️ Dysk HDD – może być wolno"
else
    echo "✅ Dysk SSD – OK"
fi

# -------------------
# GPU
# -------------------
echo -e "\n== GPU =="
if command -v nvidia-smi &> /dev/null; then
    nvidia-smi --query-gpu=name,memory.total,driver_version --format=csv,noheader
    echo "✅ NVIDIA CUDA dostępna – przyspieszenie możliwe"
else
    GPU_INFO=$(lspci | grep -i vga)
    echo "GPU: $GPU_INFO"
    echo "⚠️ Brak NVIDIA CUDA – tylko CPU"
fi

# -------------------
# Podsumowanie
# -------------------
echo -e "\n== Podsumowanie =="

# upewniamy się, że TOTAL_RAM_GB jest liczbą całkowitą
TOTAL_RAM_GB_NUM=$(echo "$TOTAL_RAM_GB" | sed 's/[^0-9]//g')

if echo "$CPU_FLAGS" | grep -qw avx; then
    CPU_OK=1
else
    CPU_OK=0
fi

if [ -n "$TOTAL_RAM_GB_NUM" ] && [ "$TOTAL_RAM_GB_NUM" -ge 8 ]; then
    RAM_OK=1
else
    RAM_OK=0
fi

if [ "$CPU_OK" -eq 1 ] && [ "$RAM_OK" -eq 1 ]; then
    echo "✅ Twój komputer prawdopodobnie uruchomi LLM (małe/średnie modele)"
else
    echo "❌ Twój komputer raczej nie nadaje się do LLM lub będzie bardzo wolny"
fi

