const submitBtn = document.getElementById("submitBtn");
const sampleBtn = document.getElementById("sampleBtn");
const txnInput = document.getElementById("transactionId");

const placeholderMsg = document.getElementById("placeholderMsg");
const dynamicResult = document.getElementById("dynamicResult");
const txnIdDisplay = document.getElementById("txnIdDisplay");
const predictionLabel = document.getElementById("predictionLabel");
const fraudScoreValue = document.getElementById("fraudScoreValue");
const riskLevel = document.getElementById("riskLevel");
const responseTime = document.getElementById("responseTime");
const timestamp = document.getElementById("timestamp");

// Sample transactions for testing
const sampleTransactions = [
  { id: "TX-LEGIT-001", label: "LEGITIMATE", fraud_score: 0.21, risk_level: "Low" },
  { id: "TX-FRAUD-789", label: "FRAUDULENT", fraud_score: 0.92, risk_level: "High" },
  { id: "TX-BORDER-555", label: "LEGITIMATE", fraud_score: 0.65, risk_level: "Medium" }
];

// Replace with real AML endpoint + key when ready
const USE_SAMPLE = true;
const AML_ENDPOINT = "https://<your-aml-endpoint>.azurewebsites.net/score";
const AML_KEY = "<your-endpoint-key>";

async function fetchPrediction(txnId) {
  let data;

  if (USE_SAMPLE) {
    // Pick matching sample or random
    data = sampleTransactions.find(tx => tx.id === txnId) || sampleTransactions[0];
    await new Promise(r => setTimeout(r, 300)); // simulate network delay
  } else {
    try {
      const startTime = performance.now();
      const res = await fetch(AML_ENDPOINT, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "Authorization": `Bearer ${AML_KEY}`
        },
        body: JSON.stringify({ transaction_id: txnId })
      });
      data = await res.json();
      const endTime = performance.now();
      data.responseTime = Math.round(endTime - startTime);
    } catch (err) {
      console.error("Error calling AML endpoint:", err);
      alert("Failed to fetch prediction from AML endpoint.");
      return;
    }
  }

  // Update UI
  placeholderMsg.style.display = "none";
  dynamicResult.style.display = "block";

  txnIdDisplay.textContent = `ID: ${data.id || txnId}`;
  predictionLabel.textContent = data.label;
  predictionLabel.className = "prediction-tag " + (data.label === "FRAUDULENT" ? "fraudulent" : "legitimate");
  fraudScoreValue.textContent = data.fraud_score.toFixed(2);
  riskLevel.textContent = data.risk_level;
  responseTime.textContent = data.responseTime ? `${data.responseTime}ms` : "—";
  timestamp.textContent = new Date().toLocaleString();
}

// Event listeners
submitBtn.addEventListener("click", () => {
  const txnId = txnInput.value.trim();
  if (txnId) fetchPrediction(txnId);
});

sampleBtn.addEventListener("click", () => {
  const randomSample = sampleTransactions[Math.floor(Math.random() * sampleTransactions.length)];
  txnInput.value = randomSample.id;
  fetchPrediction(randomSample.id);
});
