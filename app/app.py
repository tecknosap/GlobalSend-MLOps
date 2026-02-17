# from flask import Flask, send_from_directory, jsonify
# import joblib
# import pandas as pd
# import os

# # Flask app; static_folder points to static/
# app = Flask(__name__, static_folder="static")

# # Load pre-trained model safely
# MODEL_PATH = "fraud_model.pkl"
# if not os.path.exists(MODEL_PATH):
#     raise FileNotFoundError(f"Model file not found at '{MODEL_PATH}'")
# model = joblib.load(MODEL_PATH)

# # Features used by the model (must match training)
# FEATURES = ["amount", "is_international"]

# # Serve index.html
# @app.route("/")
# def index():
#     index_file = os.path.join(app.static_folder, "index.html")
#     if not os.path.exists(index_file):
#         return "index.html not found", 404
#     return send_from_directory(app.static_folder, "index.html")

# # Serve static files
# @app.route("/<path:path>")
# def static_files(path):
#     file_path = os.path.join(app.static_folder, path)
#     if not os.path.exists(file_path):
#         return f"{path} not found", 404
#     return send_from_directory(app.static_folder, path)

# # Endpoint to provide transaction data with predictions
# @app.route("/transactions")
# def transactions():
#     CSV_PATH = "transactions-sample.csv"
    
#     if not os.path.exists(CSV_PATH):
#         return jsonify({"error": f"CSV file '{CSV_PATH}' not found"}), 500

#     try:
#         # Load CSV
#         df = pd.read_csv(CSV_PATH)
        
#         # Ensure required columns exist
#         for col in FEATURES:
#             if col not in df.columns:
#                 df[col] = 0  # default/fallback
        
#         # Predict fraud using trained model
#         df["is_fraud"] = model.predict(df[FEATURES])
        
#         # Return JSON records
#         return jsonify(df.to_dict(orient="records"))
#     except Exception as e:
#         return jsonify({"error": str(e)}), 500

# # Run the Flask app
# if __name__ == "__main__":
#     # Use 0.0.0.0 for container/public access and port 80
#     app.run(host="0.0.0.0", port=80)



# from flask import Flask, send_from_directory, jsonify
# import joblib
# import pandas as pd
# import os

# # Flask app; static_folder points to static/
# app = Flask(__name__, static_folder="static")

# # ---------------- SAFE PATHS FOR DOCKER + AZURE ----------------
# BASE_DIR = os.path.dirname(os.path.abspath(__file__))
# MODEL_PATH = os.path.join(BASE_DIR, "fraud_model.pkl")
# CSV_PATH = os.path.join(BASE_DIR, "transactions-sample.csv")
# # ---------------------------------------------------------------

# # Load pre-trained model safely
# if not os.path.exists(MODEL_PATH):
#     raise FileNotFoundError(f"Model file not found at '{MODEL_PATH}'")
# model = joblib.load(MODEL_PATH)

# # Features used by the model (must match training)
# FEATURES = ["amount", "is_international"]

# # Serve index.html
# @app.route("/")
# def index():
#     index_file = os.path.join(app.static_folder, "index.html")
#     if not os.path.exists(index_file):
#         return "index.html not found", 404
#     return send_from_directory(app.static_folder, "index.html")

# # Serve static files
# @app.route("/<path:path>")
# def static_files(path):
#     file_path = os.path.join(app.static_folder, path)
#     if not os.path.exists(file_path):
#         return f"{path} not found", 404
#     return send_from_directory(app.static_folder, path)

# # Endpoint to provide transaction data with predictions
# @app.route("/transactions")
# def transactions():

#     if not os.path.exists(CSV_PATH):
#         return jsonify({"error": f"CSV file '{CSV_PATH}' not found"}), 500

#     try:
#         # Load CSV
#         df = pd.read_csv(CSV_PATH)

#         # Ensure required columns exist
#         for col in FEATURES:
#             if col not in df.columns:
#                 df[col] = 0  # default/fallback

#         # Predict fraud using trained model
#         df["is_fraud"] = model.predict(df[FEATURES])

#         # Return JSON records
#         return jsonify(df.to_dict(orient="records"))
#     except Exception as e:
#         return jsonify({"error": str(e)}), 500

# # Run the Flask app
# if __name__ == "__main__":
#     # Use 0.0.0.0 for container/public access and port 80
#     app.run(host="0.0.0.0", port=80)







from flask import Flask, send_from_directory, jsonify
import joblib
import pandas as pd
import os
import sys

# Flask app; static_folder points to static/
app = Flask(__name__, static_folder="static")

# ---------------- SAFE PATHS FOR DOCKER + AZURE ----------------
BASE_DIR = os.path.dirname(os.path.abspath(__file__))
MODEL_PATH = os.path.join(BASE_DIR, "fraud_model.pkl")
CSV_PATH = os.path.join(BASE_DIR, "transactions-sample.csv")
# ---------------------------------------------------------------

# Load pre-trained model safely at startup
model = None
if not os.path.exists(MODEL_PATH):
    print(f"WARNING: Model file not found at '{MODEL_PATH}'", file=sys.stderr)
else:
    try:
        model = joblib.load(MODEL_PATH)
        print("Model loaded successfully")
    except Exception as e:
        print(f"ERROR loading model: {e}", file=sys.stderr)

# Features used by the model (must match training)
FEATURES = ["amount", "is_international"]

# Serve index.html
@app.route("/")
def index():
    index_file = os.path.join(app.static_folder, "index.html")
    if not os.path.exists(index_file):
        return "index.html not found", 404
    return send_from_directory(app.static_folder, "index.html")

# Serve static files
@app.route("/<path:path>")
def static_files(path):
    file_path = os.path.join(app.static_folder, path)
    if not os.path.exists(file_path):
        return f"{path} not found", 404
    return send_from_directory(app.static_folder, path)

# Endpoint to provide transaction data with predictions
@app.route("/transactions")
def transactions():
    if model is None:
        return jsonify({"error": "Model not loaded"}), 500

    if not os.path.exists(CSV_PATH):
        return jsonify({"error": f"CSV file '{CSV_PATH}' not found"}), 500

    try:
        # Load CSV
        df = pd.read_csv(CSV_PATH)

        # Ensure required columns exist
        for col in FEATURES:
            if col not in df.columns:
                df[col] = 0  # default/fallback

        # Predict fraud using trained model
        df["is_fraud"] = model.predict(df[FEATURES])

        # Return JSON records
        return jsonify(df.to_dict(orient="records"))
    except Exception as e:
        return jsonify({"error": str(e)}), 500

# Run the Flask app
if __name__ == "__main__":
    # Use 0.0.0.0 for container/public access and port 80
    port = int(os.environ.get("PORT", 80))
    print(f"Starting Flask on port {port}")
    app.run(host="0.0.0.0", port=port)


