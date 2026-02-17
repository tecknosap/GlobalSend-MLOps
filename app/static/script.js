const DEFAULT_VISIBLE_ROWS = 3;
let data = []; // will hold transactions from backend

const TABLE_COLUMNS = ["Tx ID","User","Amount","Currency","Country","Category","International","Status"];

/* ---------------- TABLE ---------------- */
function loadTable(rows) {
    const tbody = document.querySelector("#resultsTable tbody");
    tbody.innerHTML = "";

    if (!rows || rows.length === 0) {
        tbody.innerHTML = `<tr><td colspan="8" style="text-align:center; padding:20px; color:#777;">No transactions found</td></tr>`;
        return;
    }

    rows.forEach(r => {
        const tr = document.createElement("tr");

        if (r["is_fraud"] === 1) tr.classList.add("fraud-row");

        TABLE_COLUMNS.forEach(col => {
            const td = document.createElement("td");
            let value;

            switch(col) {
                case "Tx ID": value = r["transaction_id"] ?? "—"; break;
                case "User": value = r["user_id"] ?? "—"; break;
                case "Amount": value = r["amount"] ?? 0; td.textContent = `$${Number(value).toLocaleString()}`; break;
                case "Currency": value = r["currency"] ?? "—"; break;
                case "Country": value = r["country"] ?? "—"; break;
                case "Category": value = r["merchant_category"] ?? "—"; break;
                case "International": value = r["is_international"] ?? false; td.textContent = value ? "🌍 Yes" : "—"; break;
                case "Status": value = r["is_fraud"] ?? 0; td.textContent = value ? "🚨 Fraud" : "OK"; break;
                default: value = r[col] ?? "—"; break;
            }

            td.textContent = td.textContent || value;
            tr.appendChild(td);
        });

        tr.addEventListener("click", () => {
            alert(
`Transaction: ${r["transaction_id"] ?? "N/A"}
User: ${r["user_id"] ?? "N/A"}
Amount: $${Number(r["amount"] ?? 0).toLocaleString()}
Country: ${r["country"] ?? "N/A"}
Status: ${r["is_fraud"] ? "FRAUD" : "OK"}`
            );
        });

        tbody.appendChild(tr);
    });
}

/* ---------------- STATS ---------------- */
function loadStats() {
    if (!data.length) {
        document.getElementById("totalTx").textContent = "0";
        document.getElementById("fraudCount").textContent = "0";
        document.getElementById("intlCount").textContent = "0";
        document.getElementById("fraudRate").textContent = "0.0%";
        return;
    }

    const frauds = data.filter(r => r["is_fraud"] === 1);
    const intl = data.filter(r => r["is_international"]);

    document.getElementById("totalTx").textContent = data.length;
    document.getElementById("fraudCount").textContent = frauds.length;
    document.getElementById("intlCount").textContent = intl.length;
    document.getElementById("fraudRate").textContent = ((frauds.length / data.length) * 100).toFixed(1) + "%";
}

/* ---------------- HIGH RISK ---------------- */
function loadHighRisk() {
    const container = document.getElementById("riskContainer");
    container.innerHTML = "";

    const fraudCases = data.filter(r => r["is_fraud"] === 1);
    if (!fraudCases.length) {
        container.innerHTML = '<div class="risk-box">No high-risk transactions</div>';
        return;
    }

    fraudCases.slice(0, 3).forEach(f => {
        const tx = f["transaction_id"] ?? "N/A";
        const country = f["country"] ?? "N/A";
        const amount = f["amount"] ?? 0;
        const div = document.createElement("div");
        div.className = "risk-box";
        div.textContent = `${tx} | ${country} | $${Number(amount).toLocaleString()}`;
        container.appendChild(div);
    });
}

/* ---------------- SEARCH ---------------- */
function searchData() {
    const input = document.getElementById("searchInput");
    const q = input.value.toLowerCase().trim();
    const filtered = q ? data.filter(row => Object.values(row).some(val => String(val).toLowerCase().includes(q))) : data.slice(0, DEFAULT_VISIBLE_ROWS);
    loadTable(filtered);
}

/* ---------------- INITIAL LOAD ---------------- */
async function initDashboard() {
    try {
        const res = await fetch("/transactions");
        if (!res.ok) throw new Error(`HTTP ${res.status}`);
        data = await res.json();

        console.log("Fetched data from Flask:", data); // debug to ensure backend is returning correctly

        loadStats();
        loadHighRisk();
        loadTable(data.slice(0, DEFAULT_VISIBLE_ROWS));
    } catch (err) {
        console.error("Failed to load transactions from server:", err);
        const tbody = document.querySelector("#resultsTable tbody");
        tbody.innerHTML = `<tr><td colspan="8" style="text-align:center; padding:20px; color:red;">⚠️ Failed to load transactions from server: ${err.message}</td></tr>`;
        document.getElementById("riskContainer").innerHTML = '<div class="risk-box" style="color:red;">⚠️ Failed to load data</div>';
    }
}

document.addEventListener("DOMContentLoaded", initDashboard);
window.searchData = searchData;
