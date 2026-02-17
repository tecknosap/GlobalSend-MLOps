import os
import pandas as pd
import joblib
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier

# Paths
BASE_DIR = os.path.dirname(__file__)
CSV_PATH = os.path.join(BASE_DIR, "transactions-sample.csv")
MODEL_PATH = os.path.join(BASE_DIR, "../../app/fraud_model.pkl")

# Load CSV
df = pd.read_csv(CSV_PATH)

# Features & target
FEATURES = ["amount", "is_international"]
TARGET = "is_fraud"

X = df[FEATURES].apply(pd.to_numeric, errors="coerce").fillna(0)
y = df[TARGET]

# Train/test split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Train model
model = RandomForestClassifier(n_estimators=100, random_state=42, n_jobs=-1)
model.fit(X_train, y_train)

# Evaluate
accuracy = model.score(X_test, y_test)
print(f"Model accuracy: {accuracy:.2%}")

# Save model locally
joblib.dump(model, MODEL_PATH)
print(f"Model saved locally: {MODEL_PATH}")
