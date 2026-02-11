# GlobalSend – Fraud Detection MLOps PoC (Auditor Version)

**One-line summary:** Auditor searches transaction ID → gets fraud prediction from auto-trained model deployed on Azure ML.

---

## Project Structure

```
globalsend-mlops/
├── .github/workflows/
│   ├── ml-training.yml      # Train on code push → log metrics → register model
│   └── ml-deploy.yml        # Auto-deploy registered model to endpoint
│
├── terraform/
│   └── modules/aml/         # Azure ML workspace + managed endpoint (B1s)
│
├── scripts/
│   └── promote-model.ps1    # Promote model dev→staging→prod
│
├── app/                     # Auditor dashboard
│   ├── index.html           # Search by transaction/user ID
│   ├── script.js            # Calls AML endpoint
│   └── style.css
│
├── ml/
│   ├── data/
│   │   └── transactions-sample.csv  # GlobalSend transaction history
│   ├── training/
│   │   ├── train.py         # Train + log params/metrics + register
│   │   └── requirements.txt
│   └── endpoint/
│       └── scoring.py       # Scoring script for managed endpoint
│
└── README.md
```

---

## Azure Resources Created

| Resource | Purpose |
|---------|---------|
| **Resource Group** | Container for all resources |
| **Azure ML Workspace** | Central hub for experiments, models, endpoints |
| **Storage Account (Blob)** | Stores GlobalSend transaction CSV |
| **Container Registry (ACR)** | Stores endpoint container images |
| **Managed Endpoint** | REST API endpoint for fraud predictions |
| **B1s Compute** | Minimal compute for training + scoring |

**Provisioned via:** Terraform (`terraform/modules/aml/`)

---

## What It Does

| Step | What |
|------|------|
| 1 | Push code → GitHub Action triggers training |
| 2 | Train model on GlobalSend transaction data → log accuracy/F1 to AML |
| 3 | Register model to AML registry |
| 4 | Auto-deploy to dev endpoint |
| 5 | Auditor opens web app → enters transaction ID |
| 6 | Frontend calls AML endpoint → returns fraud score |
| 7 | Promote to staging/prod via script |

---

## Flow

**Auditor → Web App → AML Endpoint → Model → Prediction → Auditor**

---

**GlobalSend MLOps Extension. Auditor-ready. 4 days.** ✅