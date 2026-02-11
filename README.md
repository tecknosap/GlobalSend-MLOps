
---

# **GlobalSend MLOps Project**

A lightweight end‑to‑end MLOps system that trains a fraud‑detection model, deploys it to Azure, and serves predictions to a modern frontend dashboard.

## **Structure**
```
mlops-project/
├── .github/workflows/        # CI/CD pipeline
├── terraform/                # Azure infrastructure (ACR, App Service, Storage)
├── ml/                       # Training code + sample data
├── api/                      # FastAPI model-serving backend
└── frontend/                 # Auditor dashboard UI
```

## **How It Works**
1. **Train model** in `ml/` and save the artifact to Azure Storage.  
2. **CI/CD** builds the API Docker image and pushes it to **Azure Container Registry**.  
3. **Azure App Service** pulls the image from ACR and runs the API.  
4. **API** loads the model + dataset from Azure Storage at runtime.  
5. **Frontend** fetches predictions/data from the API and visualises them.

## **Azure Services**
- **Storage Account** – model + data  
- **Container Registry (ACR)** – API images  
- **App Service** – runs the API  
- **GitHub Actions** – automation  

## **Result**
A deployed fraud‑detection API with a clean dashboard that visualises predictions and sample transactions.

---
