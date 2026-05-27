# 🚚 Logistics Company Data Analysis with SQL
 
> Uncovering business insights from logistics operations using MySQL
 
---
 
## 📌 Project Overview
 
This project analyzes a logistics company's operational data using SQL to evaluate:
- Workforce distribution across branches
- Customer segmentation and behavior
- Shipment characteristics and delivery performance
- Payment patterns and revenue analysis
The analysis supports data-driven decisions for operational efficiency and strategic planning.
 
---
 
## 🗂️ Dataset Structure
 
| Table | Key Columns |
|-------|------------|
| `employee_details` | E_ID, E_Name, E_Branch, E_Designation |
| `customer` | C_ID, C_Name, C_Type |
| `shipment_details` | SH_ID, SH_Weight, SH_Domain, SH_Charges, SER_TYPE, SH_Content |
| `payment_details` | C_ID, Payment_Mode, Payment_Status, Amount, Payment_Date |
| `membership` | M_ID, Start_Date, End_Date |
| `status` | SH_ID, Current_Status, Delivery_Date |
 
---
 
## 🛠️ Tools Used
 
- **MySQL Workbench** — Query execution and database management
- **SQL** — JOINs, GROUP BY, subqueries, window functions, CTEs
---
 
## 📊 Scope of Analysis
 
### 🔵 Basic
| # | Query | Purpose |
|---|-------|---------|
| 1 | Branch-wise employee count | Optimize staff deployment |
| 3 | NY branch employee details | Branch-level lookup |
| 4 | Customer count by type | Segmentation |
| 6 | Designation-wise employee count | Workforce planning |
 
### 🟡 Intermediate
| # | Query | Purpose |
|---|-------|---------|
| 2 | Average payment by mode | Payment behavior analysis |
| 5 | Delivery boy shipment status | Delivery performance tracking |
| 7 | Avg weight by payment status | Weight-payment correlation |
| 8 | Avg weight by shipment domain | Domestic vs international comparison |
| 11 | Membership dates (paid customers) | Member retention insights |
| 12 | Card payment + regular service clients | Preference analysis |
 
### 🔴 Advanced
| # | Query | Purpose |
|---|-------|---------|
| 9 | Top 3 highest charge shipments | High-value shipment identification |
| 10 | Customer count by type (sorted) | Dominant segment analysis |
| 13 | Customer count by payment status | Payment compliance measurement |
| 14 | Customer count by service type | Service demand analysis |
| 15 | Customer count by shipment domain | Domestic vs international demand |
 
### ⭐ Bonus — Advanced SQL
| Query | Concept Used | Purpose |
|-------|-------------|---------|
| Branch revenue ranking | `RANK()` Window Function | Top revenue branches |
| Above-average charge customers | CTE (`WITH` clause) | High-value customer segmentation |
| Shipment weight classification | `CASE WHEN` | Operational weight tiering |
 
---
 
## 💡 Key Business Insights
 
- **TX branch** has the highest employee count (14), making it the most staffed for delivery operations
- **Retail customers** form the largest segment (78), followed by Internal Goods (68) and Wholesale (54)
- **COD payments** average higher (₹49,578) than Card Payments (₹45,039), suggesting COD dominance in high-value orders
- **Domestic shipments** (109 customers) outpace International (91), indicating stronger local demand
- **50% customers are NOT PAID** — a significant collections improvement opportunity
---
 
## 📁 Repository Structure
 
```
logistics-sql-analysis/
│
├── logistics_analysis.sql     ← All 15 queries + 3 bonus advanced queries
├── SQL_PROJECT_DA.pdf         ← Project presentation with query outputs
└── README.md                  ← Project documentation (this file)
```
 
---
 
## 🚀 How to Run
 
1. Open **MySQL Workbench**
2. Create a new database: `CREATE DATABASE logistics_db;`
3. Import your dataset tables into `logistics_db`
4. Open `logistics_analysis.sql`
5. Run queries section by section (Basic → Intermediate → Advanced)
---
 
## 👤 Author
 
**Paras Soni** — Data Analyst  
📧 iparassoni2005@gmail.com  
🔗 [LinkedIn](https://www.linkedin.com/in/paras-soni-05866633a)  
🐙 [GitHub](https://github.com/iparassoni2005-gif)
 
---
 
*Built with MySQL Workbench | Data Analysis & Business Intelligence*
