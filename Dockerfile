# Gunakan image Python slim
FROM python:3.9-slim

# Tetapkan direktori kerja di dalam container
WORKDIR /app

# Salin file yang diperlukan ke dalam container
COPY api.py model_svm_prediksi.pkl requirements.txt ./

# Instal dependensi sistem yang diperlukan untuk numpy
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    gcc \
    libatlas-base-dev \
    && rm -rf /var/lib/apt/lists/*

# Instal numpy secara terpisah terlebih dahulu untuk menghindari masalah kompilasi
RUN pip install --no-cache-dir numpy>=1.21,<1.25

# Instal dependensi lain dari requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Ekspos port 5000 (port Flask)
EXPOSE 5000

# Jalankan aplikasi Flask
CMD ["python", "api.py"]
