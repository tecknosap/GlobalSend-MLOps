# Base Python image
FROM python:3.11-slim

# Set working directory
WORKDIR /usr/src/app

# Copy Python dependencies and install
COPY app/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy Flask app and supporting files
COPY app/app.py .
COPY app/fraud_model.pkl .
COPY app/static/ ./static/
COPY ml/data/transactions-sample.csv .

# Expose port 80 for Azure App Service
EXPOSE 80

# Start Flask app
CMD ["python", "app.py"]
