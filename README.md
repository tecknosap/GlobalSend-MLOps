
```markdown
# GlobalSend Transaction Audit POC

## Overview
This is a **proof-of-concept** for **GlobalSend** demonstrating a secure, auditable, and observable transaction logging system.  
It tracks user logins and money transfer events, optionally evaluates transactions with an **ML endpoint**, and stores all events in an **append-only CSV** for auditing.

**Core Flow:**  
**Frontend → ML Endpoint → CSV Audit Log ← Auditor**

---

## Features

- **Frontend events**: captures logins and transaction actions (initiated, success, failed, declined)  
- **ML Endpoint**: optional fraud/risk scoring  
- **Audit Log**: CSV stores timestamp, user, transaction details, status, reason, environment, and deployment version  
- **Auditor access**: reviewers safely read logs for compliance or debugging  
- **Append-only**: logs are never modified or deleted  
- **Environment-aware**: logs include dev, staging, or production info  

---

## CSV Schema

| Column             | Description |
|-------------------|-------------|
| timestamp          | Event timestamp (ISO format) |
| event_type         | LOGIN_SUCCESS / LOGIN_FAILED / TRANSACTION_INITIATED / TRANSACTION_SUCCESS / TRANSACTION_FAILED / TRANSACTION_DECLINED |
| user_id            | User identifier |
| transaction_id     | Transaction ID (empty for login events) |
| amount             | Transaction amount (empty for login events) |
| currency           | Transaction currency (empty for login events) |
| reason             | Failure or decline reason (empty if successful) |
| ip_address         | User IP (for login events) |
| environment        | Dev / Staging / Production |
| deployment_version | Commit SHA / app version |

---

## Architecture / Flow

```

```
   (Event Generation Flow)
```

Frontend → ML Endpoint → CSV Audit Log ← Auditor

````

**Explanation:**

- **Frontend**: captures user actions  
- **ML Endpoint**: evaluates or flags transactions  
- **CSV Audit Log**: append-only storage (Azure Blob Storage recommended)  
- **Auditor**: reads CSV for auditing, compliance, and traceability  

> Note: Auditors do **not interact directly with the frontend**. They access logs only.

---

## Getting Started

1. Install dependencies (Node.js / Python / preferred stack)  
2. Configure environment variables:  
   - `ENVIRONMENT` → dev / staging / prod  
   - `DEPLOYMENT_VERSION` → commit SHA or release version  
3. Create storage for CSV logs (local `/logs` or Azure Blob Storage)  
4. Run frontend/backend and trigger login or transaction events  
5. Logs are appended to CSV in real-time  
6. Auditors can open CSVs in **Excel** or **Power BI**  

---

## Example Log Entries

```csv
2026-02-10T14:25:32Z,LOGIN_SUCCESS,user123,,,"","",192.168.1.10,dev,abc123
2026-02-10T14:26:01Z,TRANSACTION_INITIATED,user123,txn001,100,USD,,"",dev,abc123
2026-02-10T14:26:05Z,TRANSACTION_SUCCESS,user123,txn001,100,USD,,"",dev,abc123
2026-02-10T14:30:10Z,TRANSACTION_FAILED,user124,txn002,250,USD,Insufficient Funds,"",staging,def456
````

---

## Benefits

* Demonstrates **end-to-end MLOps**: user → ML → logs → audit
* Provides **observability and traceability** for all actions
* **Safe**: no real money is transferred
* **Compliance-ready**: append-only logs, environment/versioned
* **Extendable**: easy to integrate real ML models, dashboards, or alerting

---

## Next Steps

* Integrate **Azure Blob Storage** for production audit logs
* Implement **daily CSV rotation** and retention policy
* Connect to **Power BI / Excel dashboards** for auditing
* Optionally, **hash rows** for tamper-proof auditing
* Extend ML endpoint for **fraud scoring or anomaly detection**

---

## License

MIT License

