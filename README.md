<div align="center">

<!-- Header Banner -->
<img src="https://capsule-render.vercel.app/api?type=waving&color=0:1a1a2e,50:16213e,100:0f3460&height=200&section=header&text=Credit%20Card%20Analysis&fontSize=48&fontColor=e94560&fontAlignY=38&desc=Data-Driven%20Financial%20Intelligence%20Platform&descAlignY=58&descSize=16&descColor=a8b2d8&animation=fadeIn" width="100%"/>

<!-- Badges -->
<p>
  <img src="https://img.shields.io/badge/Python-3.8+-3776AB?style=for-the-badge&logo=python&logoColor=white"/>
  <img src="https://img.shields.io/badge/SQL-MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white"/>
  <img src="https://img.shields.io/badge/Power%20BI-Dashboard-F2C811?style=for-the-badge&logo=powerbi&logoColor=black"/>
  <img src="https://img.shields.io/badge/Jupyter-Notebook-F37626?style=for-the-badge&logo=jupyter&logoColor=white"/>
  <img src="https://img.shields.io/badge/KPIs-50%20Queries-e94560?style=for-the-badge"/>
</p>

<p>
  <a href="#-overview">Overview</a> •
  <a href="#-tech-stack">Tech Stack</a> •
  <a href="#-kpi-categories">KPIs</a> •
  <a href="#-project-structure">Structure</a> •
  <a href="#-getting-started">Getting Started</a> •
  <a href="#-dashboard">Dashboard</a>
</p>

</div>

---

## 🎯 Overview

> **Transform raw billing data into actionable financial intelligence.**

This project delivers a comprehensive, end-to-end analysis of credit card transactions — uncovering spending patterns, customer risk profiles, and churn signals using **Python**, **SQL**, and **Power BI**.

```
Raw Billing Data  →  Python (EDA + Cleaning)  →  MySQL (50 KPI Queries)  →  Power BI Dashboard
```

### What this project answers:
- 💰 Which customer segments drive the most revenue?
- ⚠️ Who is at highest risk of default or churn?
- 📈 How is spending behavior shifting over time?
- 🏦 Where are credit limits being dangerously stretched?

---

## 🛠️ Tech Stack

| Layer | Technology | Purpose |
|-------|-----------|---------|
| 🐍 Python | `pandas`, `numpy`, `mysql-connector-python` | Data cleaning, EDA, DB ingestion |
| 🗃️ SQL | MySQL | 50 analytical KPI queries |
| 📊 Power BI | `.pbix` Dashboard | Interactive visualization |
| 📓 Jupyter | `main.ipynb` | Exploratory analysis notebook |

---

## 📊 KPI Categories

> **50 production-grade SQL queries across 5 analytical domains.**

<details>
<summary><b>💰 Q1–10 · Revenue & Profitability</b></summary>

| # | KPI |
|---|-----|
| Q1 | Total interest revenue by quarter |
| Q2 | QoQ revenue growth rate |
| Q3 | Top 10% customer revenue contribution (Pareto) |
| Q4 | Profitability breakdown by job category |
| Q5 | Profitability breakdown by state |
| Q6 | Average annual fee revenue per card type |
| Q7 | Revenue per active customer |
| Q8 | Revolving balance vs. transactor segmentation |
| Q9 | Credit limit utilization vs. revenue correlation |
| Q10 | Top revenue-generating card categories |

</details>

<details>
<summary><b>⚡ Q11–20 · Activity & Engagement</b></summary>

| # | KPI |
|---|-----|
| Q11 | Monthly transaction volume trends |
| Q12 | Total transaction value by month |
| Q13 | Active vs. dormant customer ratio |
| Q14 | High-frequency, low-value spender profiles |
| Q15 | Average transactions per customer per month |
| Q16 | Customer engagement score by card type |
| Q17 | Seasonal spending peaks identification |
| Q18 | Merchant category spending distribution |
| Q19 | Weekend vs. weekday spending patterns |
| Q20 | Digital (chip/online) vs. swipe transaction ratio |

</details>

<details>
<summary><b>🚨 Q21–30 · Risk & Credit</b></summary>

| # | KPI |
|---|-----|
| Q21 | Overall delinquency rate |
| Q22 | Utilization-to-default correlation |
| Q23 | Near-limit accounts (>90% utilization) |
| Q24 | State-wise credit risk heatmap |
| Q25 | Delinquency rate by income bracket |
| Q26 | Credit limit increase request patterns |
| Q27 | 60/90-day overdue account tracking |
| Q28 | High-risk customer scoring model |
| Q29 | Churn probability by behavior segment |
| Q30 | Fraud signal detection via anomalous patterns |

</details>

<details>
<summary><b>👥 Q31–40 · Customer Segmentation</b></summary>

| # | KPI |
|---|-----|
| Q31 | Age group spending distribution |
| Q32 | Income bracket analysis |
| Q33 | Education level vs. credit behavior |
| Q34 | Marital status vs. spending patterns |
| Q35 | Homeowner vs. non-homeowner spend comparison |
| Q36 | Gender-based transaction analysis |
| Q37 | Customer lifetime value (CLV) by segment |
| Q38 | Premium vs. standard card holder behavior |
| Q39 | Geographic spending clusters |
| Q40 | Multi-card holder vs. single-card segmentation |

</details>

<details>
<summary><b>🛒 Q41–50 · Spending Behavior</b></summary>

| # | KPI |
|---|-----|
| Q41 | Expense type breakdown (grocery, travel, dining…) |
| Q42 | Chip adoption rate by customer segment |
| Q43 | 4-week rolling average transaction analysis |
| Q44 | Behavioral shift detection over time |
| Q45 | Subscription vs. one-time purchase ratio |
| Q46 | International transaction patterns |
| Q47 | Cashback vs. rewards utilization rate |
| Q48 | Impulse vs. planned spending classification |
| Q49 | Peak spending hour analysis |
| Q50 | Year-over-year category shift report |

</details>

---

## 📁 Project Structure

```
credit-card-analysis/
│
├── 📂 Datasets/                    # Raw input data (CSV)
├── 📂 Final Dataset/               # Cleaned & merged dataset
├── 📂 Dashboard/                   # Dashboard screenshots/exports
│
├── 📓 main.ipynb                   # EDA + data cleaning + DB ingestion
├── 🗃️  Credit Card Analysis.sql    # All 50 SQL KPI queries
├── 📊 Credit Card Performance Analysis.pbix  # Power BI dashboard
├── 📄 Sales KPIs.docx              # KPI documentation
├── 📋 requirements.txt             # Python dependencies
└── 📖 README.md                    # You are here
```

---

## 🚀 Getting Started

### Prerequisites
```bash
Python 3.8+   |   MySQL 8.0+   |   Power BI Desktop
```

### 1. Clone the repository
```bash
git clone https://github.com/chayanshh/credit-card-analysis.git
cd credit-card-analysis
```

### 2. Install Python dependencies
```bash
pip install -r requirements.txt
```

### 3. Configure MySQL connection
Open `main.ipynb` and update the connection block:
```python
import mysql.connector

conn = mysql.connector.connect(
    host="localhost",
    user="your_username",
    password="your_password",
    database="credit_card_db"
)
```

### 4. Run the notebook
```bash
jupyter notebook main.ipynb
```
> This performs data cleaning, EDA, and loads the final dataset into MySQL.

### 5. Execute SQL queries
Open `Credit Card Analysis.sql` in MySQL Workbench and run any/all of the 50 KPI queries.

### 6. Open the Power BI Dashboard
Open `Credit Card Performance Analysis.pbix` in Power BI Desktop and connect to your MySQL instance.

---

## 📈 Dashboard

The Power BI dashboard covers:

- **Revenue Overview** — QoQ trends, top earners, interest income
- **Customer Risk Map** — Delinquency rates, utilization heatmaps by state
- **Segment Deep-Dives** — Age, income, education, homeownership
- **Spending Behavior** — Category breakdown, chip adoption, 4-week moving avg

> 📂 See `/Dashboard` folder for screenshots.

---

## 🧩 Data Pipeline

```mermaid
flowchart LR
    A[📁 Raw CSVs] --> B[🐍 Python EDA]
    B --> C[🧹 Cleaned Dataset]
    C --> D[🗃️ MySQL Database]
    D --> E[🔍 50 SQL KPIs]
    E --> F[📊 Power BI Dashboard]
    F --> G[💡 Actionable Insights]
```

---

## 🔑 Key Insights Delivered

| Insight Area | Outcome |
|---|---|
| 📊 Revenue Attribution | Identify which 10% of customers generate the majority of revenue |
| ⚠️ Default Prediction | Correlate utilization rates with delinquency probability |
| 🔄 Churn Detection | Flag disengaging customers before they leave |
| 📍 Geographic Risk | Pinpoint high-risk states for targeted intervention |
| 🛒 Spend Patterns | Understand 4-week behavioral cycles for personalized offers |

---

## 📦 Dependencies

```txt
pandas
numpy
mysql-connector-python
```

---

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/new-kpi`
3. Commit your changes: `git commit -m 'Add Q51: Customer cohort analysis'`
4. Push and open a Pull Request

---

## 👤 Author

**Chayansh**
- GitHub: [@chayanshh](https://github.com/chayanshh)

---

<div align="center">

<img src="https://capsule-render.vercel.app/api?type=waving&color=0:0f3460,50:16213e,100:1a1a2e&height=120&section=footer" width="100%"/>

*Built with 🔥 Python · SQL · Power BI*

</div>
