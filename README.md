# 🏥 Medical Diagnosis Expert System (Prolog)

A **rule-based Medical Diagnosis Expert System** developed using **Prolog** that simulates a doctor’s diagnostic reasoning.  
The system interacts with users, asks about symptoms, and infers the most probable disease along with confidence level, severity, treatment, and prevention advice.

> ⚠️ This system is for **educational purposes only** and is not a replacement for professional medical advice.

---

## 📌 Features

- Interactive symptom-based diagnosis
- Rule-based reasoning using **forward chaining**
- Confidence percentage calculation
- Disease severity assessment
- Treatment and prevention recommendations
- Clear and explainable inference process

---

## 🧠 Diseases Covered

- Flu (Influenza)
- Malaria
- Typhoid
- COVID-19
- Heart Attack

---

## ⚙️ Technology Used

- **Language:** Prolog  
- **Paradigm:** Rule-based Expert System  
- **Inference Mechanism:** Forward Chaining (Data-Driven Reasoning)

---

## 🏗️ System Architecture

- **Knowledge Base**
  - Diseases
  - Symptoms
  - Severity levels
  - Treatments
  - Prevention methods

- **Inference Engine**
  - Symptom matching
  - Confidence calculation
  - Best disease selection

- **User Interface**
  - Interactive yes/no symptom questions
  - Diagnosis output

---

## 🧪 How It Works

1. User starts the system
2. System asks symptom-related questions
3. User responses are collected
4. Symptoms are matched with known diseases
5. Confidence level is calculated
6. Disease with highest confidence is inferred
7. Severity, treatment, and prevention are displayed

---

## ▶️ How to Run

1. Install a Prolog environment (e.g., **SWI-Prolog**)
2. Load the program file:
   ```prolog
   consult('medical_diagnosis.pl').
