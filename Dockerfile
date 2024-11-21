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
    liblapack-dev \
    gfortran \
    && rm -rf /var/lib/apt/lists/*

# Instal dependensi dari requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Instal Gunicorn untuk server produksi
RUN pip install gunicorn

# Ekspos port 5000 (port Flask)
EXPOSE 5000

# Gunakan Gunicorn untuk menjalankan aplikasi Flask
CMD ["gunicorn", "-b", "0.0.0.0:5000", "api:app"]
