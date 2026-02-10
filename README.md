# GlobalSend-MLOps


```markdown
# 🌐 GlobalSend — DevOps, DevSecOps & MLOps Platform

Automated Multi-Environment Deployment | Terraform | Azure | GitHub Actions | Azure ML

---

## 🚀 Overview

**GlobalSend** is a production-grade money transfer web application demonstrating modern **DevOps, DevSecOps, and MLOps** practices on Azure.

The platform showcases how **application delivery, infrastructure, security, and machine learning** can coexist within a single, governed CI/CD system.

> **Key achievement:** GlobalSend now includes a fully integrated **MLOps forecasting service**, deployed and governed using the same DevSecOps principles as the core application.

---

## 1️⃣ What You Will Be Creating

Here’s a breakdown of the pieces for the MLOps extension:

| Component | Where It Lives | Purpose |
|-----------|---------------|--------|
| Forecasting Model (Baseline) | `/mlops/model/forecaster.py` | Provides deterministic forecasts from CSV data (moving average / linear trend). |
| Data Schema & Validation | `/mlops/data/schema.yaml` + `validation.py` | Enforces CSV structure before running predictions; ensures only valid data reaches the model. |
| Inference Script / Endpoint | `/mlops/inference/score.py` | Azure ML endpoint entrypoint: accepts CSV, validates, runs forecast, returns JSON. |
| Model Deployment Script | `/mlops/deploy/deploy.py` | Registers the model with Azure ML, deploys endpoint, versioned and controlled. |
| CI/CD Pipeline | `.github/workflows/mlops.yml` | Automates testing, deployment, and smoke tests for the forecasting service. |
| App Integration | `/app/forecast_client.py` (or web UI extension) | Lets users upload CSV, call ML endpoint, display forecasts. |
| Monitoring & Logging Hooks | `/mlops/tests/test_smoke.py` + Azure App Insights | Tracks request logs, prediction latency, model versions, optional drift alerts. |
| Terraform Extensions | `/terraform/aml_endpoint.tf` | Creates Azure ML workspace, managed online endpoint, storage, monitoring — reusing your DevSecOps patterns. |

---

## 2️⃣ MLOps Extension Overview

GlobalSend has been extended with a **production-ready MLOps pipeline** that delivers **CSV-based forecasting as a service**.

### Key Capabilities
- Upload CSV time-series data  
- Generate short-term forecasts  
- Consume predictions via a secure Azure ML endpoint  
- Deploy models using CI/CD with full governance  

This demonstrates how **machine learning becomes just another backend service**, fully integrated into the DevSecOps workflow.

---

## 3️⃣ End-to-End Architecture

```

User / GlobalSend UI
↓
Forecast Request (CSV)
↓
Azure ML Managed Endpoint
↓
Forecasting Service (baseline deterministic model)
↓
JSON / CSV Forecast Output

```

---

## 4️⃣ Key Platform Components

| Layer | Technology | Purpose |
|-------|-----------|--------|
| Frontend | HTML, CSS, JavaScript | GlobalSend UI & forecast upload |
| Infrastructure | Terraform | Azure resources & ML infra |
| Hosting | Azure App Service | Web application |
| ML Platform | Azure Machine Learning | Model deployment & inference |
| CI/CD | GitHub Actions | App + ML pipelines |
| Security | CodeQL, Trivy, GitLeaks, Checkov | DevSecOps enforcement |
| Deployment Strategy | Blue-Green | Zero-downtime releases |

---

## 5️⃣ Repository Structure

```

/app                    # GlobalSend frontend
/assets                 # Static assets
/scripts                # PowerShell automation
/terraform              # Infrastructure as Code & modules
/.github/workflows      # CI/CD & DevSecOps pipelines

/mlops                  # MLOps extension
├── data               # CSV schema & validation
├── model              # Forecasting logic
├── inference          # Azure ML scoring entrypoint
├── deploy             # Model registration & deployment
└── tests              # ML smoke & integration tests

```

---

## 6️⃣ MLOps Lifecycle

### 1️⃣ Data Governance
- Strict CSV schema enforcement (`schema.yaml`)  
- Invalid data is rejected before inference  
- Schema is versioned and tested

### 2️⃣ Forecasting Model (Baseline)
- Deterministic, explainable forecasting  
- No heavy training required  
- Quota-safe and production-ready  
- Easily replaceable with advanced models later

### 3️⃣ Inference as a Service
- Azure ML Managed Online Endpoint  
- Stateless, versioned deployments  
- Monitored via Application Insights

### 4️⃣ CI/CD for ML
- Triggered via GitHub Actions on push to `dev`, `staging`, or `main`  
- Automated tests, validation, and deployment  
- Promotion across Dev → Staging → Prod  
- Blue-Green model releases supported

### 5️⃣ Observability & Security
- Request logging & latency metrics  
- Model version tracking  
- DevSecOps gates enforced before deployment

---

## 7️⃣ DevSecOps Controls

Security is enforced **end-to-end** for both application and ML workloads.

### Automated Checks
- **SAST:** CodeQL  
- **SCA:** Trivy, Dependabot  
- **Secrets:** GitLeaks  
- **IaC Policies:** Checkov, Azure Policy

### Deployment Gates
- Failed security checks block deployments  
- Production requires successful validation  
- ML endpoints follow the same security posture as the app

---

## 8️⃣ Multi-Environment Strategy

| Environment | Branch | Purpose |
|-------------|--------|---------|
| Dev | `dev` | Rapid iteration |
| Staging | `staging` | Validation & approval |
| Production | `main` | Blue-Green release |

ML models are promoted **exactly like application releases**.

---

## 9️⃣ Component Interaction Flow

```

User / Web UI / Client
│
▼
Upload CSV & Horizon
│
▼
Azure ML Managed Endpoint
│
├─> CSV Validation (schema.yaml / validation.py)
│
├─> Forecast Logic (forecaster.py)
│
▼
JSON / CSV Forecast Response
│
▼
Display in UI or dashboards

```

**CI/CD + DevSecOps Flow**

```

GitHub Push → GitHub Actions
│
├─ Test Scripts & Validation
├─ Deploy model & endpoint (deploy.py)
├─ Smoke tests (test_smoke.py)
└─ Promote to next environment (Blue-Green)

```

---

## 🔟 Why This Matters

This project demonstrates:

✅ Real-world DevOps  
✅ Enterprise-grade DevSecOps  
✅ Practical, production-ready MLOps  
✅ Infrastructure as Code  
✅ CI/CD for both apps and ML  
✅ No experimental shortcuts  

> **Takeaway:** Machine learning is now governed, automated, and secured like any other production service.

---

## 📬 Contact

For questions about cloud architecture, DevSecOps, or MLOps best practices, feel free to reach out.

**Last Updated:** February 2026  
**License:** MIT License
```

---

This README is now:

* Fully **structured and logical**
* Includes **“What You Will Be Creating”**
* Combines **DevOps, DevSecOps, MLOps** seamlessly
* Shows **end-to-end flow, CI/CD, governance, and monitoring**
* Ready for **audiences, GitHub, and presentations**

---


