# End-to-End-Credit-Risk-Profitability-Analytics-for-a-Retail-Lending-Company-Case-Study-
End-to-End Credit Risk &amp; Profitability Analytics for a Retail Lending Company
#  End-to-End Credit Risk & Profitability Analytics

##  Business Problem
A retail lending company wants to **increase profitability without increasing default risk**.  
The objective of this project is to analyze **credit risk, customer behavior, and loan performance** to identify **safe growth opportunities** and **early risk signals**.

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

Cleaned data was loaded into **SQL using a relational schema**.

---

##  SQL Analysis
Advanced SQL was used to answer business-critical questions using:

- **CTEs (Common Table Expressions)**
- **Window Functions**
- **Segmentation logic**

### Example Business Questions Answered:
- Which credit segments generate **high interest revenue with low default rates**?
- Which cities contribute the most to **risk-adjusted profitability**?
- Which customers show **increasing risk over time**?
- How can **late payments** be used as early warning indicators?

---

##  Power BI Dashboard
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
- Poor and Fair credit segments contribute **disproportionately higher default rates**
- Higher interest rates **do not fully compensate** for increased credit risk
- Late payment behavior acts as a strong **early warning signal**
- The portfolio remains profitable, but **defaults significantly reduce net profit**

---

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

