from flask_cors import CORS
from flask import Flask, request, jsonify
import pickle

app = Flask(__name__)

# Izinkan CORS untuk origin tertentu dan metode yang sesuai
CORS(app, resources={r"/predict": {"origins": "https://maproove.netlify.app", "methods": ["OPTIONS", "GET", "POST"]}})

# Muat model prediksi
with open('model_svm_prediksi.pkl', 'rb') as f:
    model = pickle.load(f)

@app.route('/predict', methods=['POST'])
def predict():
    data = request.get_json()
    tahun = data['year']  # Ambil data tahun
    prediksi = model.predict([[tahun]])[0]  # Prediksi
    return jsonify({'prediction': prediksi})  # Kembalikan hasil prediksi

@app.route('/')  # Rute untuk URL root
def index():
    return jsonify({'message': 'Selamat datang di API Prediksi Luasan!'})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
