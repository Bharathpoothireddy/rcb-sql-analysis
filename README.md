# 🏏 RCB IPL Analysis — SQL Project

**A 2-week SQL learning project analyzing Royal Challengers Bengaluru's performance across 17 IPL seasons (2008–2024).**

![SQLite](https://img.shields.io/badge/SQLite-Database-blue)
![Python](https://img.shields.io/badge/Python-Integration-green)
![Status](https://img.shields.io/badge/Status-Complete-brightgreen)

---

## 📋 Project Overview

This project replicates an EDA workflow entirely in SQL — from basic SELECT queries to window functions and views. Built as part of a structured 14-day learning plan.

**Database:** SQLite  
**Tables:** matches (1,095 rows), deliveries (260,920 rows)  
**Total Queries Written:** 60+ across 13 notebooks  

---

## 🔍 Daily Breakdown

| Day | Topic | Key Skill |
|-----|-------|-----------|
| 1 | Setup & First Queries | SELECT, FROM, LIMIT |
| 2 | Filtering | WHERE, AND, OR, COUNT |
| 3 | Aggregation | GROUP BY, CASE WHEN, ROUND |
| 4 | Conditional Logic | CASE statements, outcome tagging |
| 5 | Subqueries | Nested queries, HAVING, filtering |
| 6 | JOINs | INNER JOIN, LEFT JOIN, cross-table |
| 7 | Review & Polish | Clean .sql file with top 10 queries |
| 8 | Python + SQL | pd.read_sql_query(), charts |
| 9 | Parameterized Queries | ? placeholders, reusable functions |
| 10 | Window Functions | RANK, PARTITION BY, running totals |
| 11 | CTEs | WITH clauses, modular queries |
| 12 | Views | CREATE VIEW, reusable virtual tables |
| 13 | Mini Project | Full RCB analysis in pure SQL |
| 14 | Wrap-Up | README, portfolio polish |

---

## 📊 Key Findings (from SQL)

- RCB's all-time win rate: **48.2%** (123 wins, 132 losses)
- Toss impact is marginal — ~5% difference in win probability
- Virat Kohli: 8,014 runs (most in RCB history)
- YS Chahal: 143 wickets (leading RCB bowler)
- Chris Gayle scored 72.5% of his RCB runs in wins
- S Aravind took 72.9% of his wickets in wins

---

## 📁 Repository Structure

rcb-sql-analysis/
├── README.md
├── rcb_analysis_queries.sql
│
├── 01_sql_setup.ipynb
├── 02_where_filtering.ipynb
├── 03_aggregation.ipynb
├── 04_case_statements.ipynb
├── 05_subqueries.ipynb
├── 06_joins.ipynb
├── 08_python_sql_integration.ipynb
├── 09_parameterized_queries.ipynb
├── 10_window_functions.ipynb
├── 11_ctes.ipynb
├── 12_views.ipynb
└── 13_mini_project.ipynb
│
└── plots/
├── rcb_season_winpct_sql.png
├── toss_analysis_sql.png
└── top_batsmen_sql.png


⚠️ Note: Raw CSV files (matches.csv, deliveries.csv) and the database file (ipl_data.db) are not included due to size limits. Download them from Kaggle and run `01_sql_setup.ipynb` to recreate the database.

---

## 🛠 Tech Stack

- **Language:** SQL (SQLite), Python 3
- **Libraries:** sqlite3, Pandas, Matplotlib
- **Environment:** Jupyter Notebook
- **Version Control:** GitHub (drag-and-drop uploads)

---

## 🚀 How to Run

1. Download the IPL dataset from Kaggle (matches.csv + deliveries.csv)
2. Place both CSV files in the project folder
3. Open `01_sql_setup.ipynb` in Jupyter Notebook
4. Run all cells to create the SQLite database
5. Open any notebook from Days 2-13 and run the queries

---

## 💼 Skills Demonstrated

| SQL Skill | Business Application |
|-----------|---------------------|
| JOINs & subqueries | Combining data from multiple sources |
| Window functions | Rankings, running totals, cohort analysis |
| CTEs & Views | Modular, reusable reporting queries |
| Parameterized queries | Dynamic dashboards and APIs |
| Python + SQL integration | Production data pipelines |

---

## 👤 Author

**Bharath Poothireddy**  
[LinkedIn] (https://linkedin.com/in/bharath-poothireddy-78a602353)
