# End-to-End-Credit-Risk-Profitability-Analytics-for-a-Retail-Lending-Company-Case-Study-
End-to-End Credit Risk &amp; Profitability Analytics for a Retail Lending Company
#  End-to-End Credit Risk & Profitability Analytics

##  Project Overview
This project analyzes a retail lending portfolio to identify **profitable growth opportunities while controlling credit risk**.  
It demonstrates **end-to-end data analytics skills** — from messy raw data cleaning to SQL-based risk analysis and executive-level Power BI dashboards.


##  Business Problem
A retail lending company faces declining profitability due to rising loan defaults.  
The objective of this analysis is to **identify credit segments and customer behaviors that maximize interest income while minimizing default risk**, and to surface **early warning signals** for proactive risk management.

---

##  Data Overview
The analysis is based on four core datasets:

- **Customers** – demographic details, income, credit score  
- **Loans** – loan amount, interest rate, tenure, loan status  
- **Repayments** – due dates, payment delays, late payments  
- **Defaults** – default flags and default dates  

The data was **intentionally messy** to simulate real-world business scenarios.

---

##  Data Cleaning & ETL
Data cleaning and transformation were performed using **Python (Pandas)** and **Power Query**.

### Key Cleaning Steps:
- Handled missing income using **median imputation by employment type**
- Standardized inconsistent categorical fields (city, gender, interest rate formats)
- Converted textual numeric fields into proper numeric types
- Created business features:
  - Credit Segment
  - Income Band
  - Loan Risk Flag
  - Late Payment Flag
- Validated referential integrity across all tables

- Data cleaning decisions were documented and driven by business logic rather than convenience.  
For example, median income was used instead of mean due to income skewness, and categorical standardization was required to prevent incorrect aggregations in downstream analysis.


Cleaned data was loaded into **SQL using a relational schema**.

---

##  SQL Analysis
Advanced SQL was used to answer business-critical questions using:

- **CTEs (Common Table Expressions)**
- **Window Functions**
- **Segmentation logic**

SQL was used not only for aggregation but for **advanced analytical modeling**, including:
- Multi-step CTE pipelines
- Window functions for ranking, trends, and customer behavior analysis
- Risk segmentation and early warning logic


### Example Business Questions Answered:
- Which credit segments generate **high interest revenue with low default rates**?
- Which cities contribute the most to **risk-adjusted profitability**?
- Which customers show **increasing risk over time**?
- How can **late payments** be used as early warning indicators?

---

##  Power BI Dashboard
The dashboard was designed for **non-technical stakeholders**, with tooltips, conditional formatting, and key insights embedded directly into each page.

An **executive-ready Power BI dashboard** was built with four pages:

1. **Executive Overview** – overall portfolio health and KPIs  
2. **Credit Risk Analysis** – risk vs return assessment  
3. **Customer Insights** – borrower behavior and exposure  
4. **Operations & Trends** – defaults, delays, and early warning signals  

### Dashboard Features:
- Dynamic KPIs
- Conditional formatting
- Tooltip pages for metric explanations
- Key Insights on every page for non-technical stakeholders

---

##  Key Insights
- Credit scores below ~580 show sharply higher default rates, making them unsuitable for aggressive growth
- Higher interest rates alone do not compensate for poor credit quality, negatively impacting net profit
- Late payment behavior consistently appears before defaults, enabling early intervention strategies
---

##  Business Impact
If implemented, this analysis could help the business:
- Improve risk-adjusted profitability by prioritizing safer credit segments
- Reduce default losses through early identification of high-risk loans
- Support data-driven credit policy and pricing decisions


##  Tools & Technologies Used
- **Python** (Pandas, NumPy)
- **SQL** (CTEs, Window Functions)
- **Power BI** (DAX, Tooltips, Conditional Formatting)

---

##  Outcome
This project demonstrates **end-to-end ownership** of a real-world analytics problem — from messy raw data to **executive-level business insights**.

It reflects industry-aligned skills in:
- Data Cleaning & ETL
- SQL-based Business Analysis
- Data Modeling
- Dashboard Storytelling

---

