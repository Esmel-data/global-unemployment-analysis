# global-unemployment-analysis
Decisional analysis of global unemployment inequalities by gender and age group (2014–2024) — Python · SQL · Power BI

# 🌍 Global Unemployment Analysis Gender & Age Inequalities (2014–2024)

> Decisional dashboard analyzing unemployment disparities across 189 countries,
> segmented by gender, age group, and time period — built for non-technical decision-makers.

## 1. Project Overview

The global labor market reveals deep structural inequalities that vary significantly
by country, gender, and age group. This project analyzes ILO (International Labour
Organization) data covering 189 countries over 11 years (2014–2024) to answer
one central business question:

> To what extent have unemployment inequalities between genders and age groups
> evolved across countries between 2014 and 2024 — and which national profiles
> concentrate the most critical vulnerabilities?

The analytical output is a decisional Power BI dashboard designed for managers,
directors, and policymakers who need actionable insights without technical expertise.


## 2. Dataset

| Attribute        | Detail                                      |
|------------------|---------------------------------------------|
| Source           | International Labour Organization (ILO)    |
| File             | `global_unemployment.csv`              |
| Rows             | 1,134 observations                          |
| Columns          | 16 raw → 22 after feature engineering       |
| Period           | 2014 – 2024 (11 years)                      |
| Countries        | 189                                         |
| Key variables    | country, gender, age group, annual rates    |

Variable categories:
- Segmentation: country, gender, age_bracket, population_segment
- Time series: rate_2014 → rate_2024 (11 numeric columns)
- Engineered: rate_avg, rate_latest, covid_impact, decadal_trend,
  trend_direction, risk_level, gender_gap


## 3. Tools & Technologies

| Tool                  | Role in the pipeline                                         |
|-----------------------|--------------------------------------------------------------|
| Python            | Data loading, quality audit, cleaning, feature engineering, export |
| SQL (MySQL)       | 10 analytical queries answering key business questions       |
| Power BI          | Decisional dashboard — 3 pages, 20+ visuals, DAX measures   |
| Gamma             | Executive presentation for portfolio and stakeholder delivery|


## 4. Project Steps

### 1. Data Loading & Exploration (Python)
Loaded the ILO CSV dataset into a Jupyter Notebook.
Audited data types, missing values (none found), and outliers using the IQR method.
Extreme unemployment rates were retained as verified economic realities.

### 2. Cleaning & Feature Engineering (Python)
Renamed all columns for business readability compatible with Power BI slicers
and SQL table names. Dropped the constant column `indicator_name` (zero analytical
value). Created 7 business variables:

- `rate_avg_2014_2024` — structural unemployment level over the decade
- `rate_latest` — current situation indicator (2024)
- `covid_impact` — pandemic shock measurement (2020 vs 2019)
- `decadal_trend` — 10-year structural direction (2024 vs 2014)
- `trend_direction` — Improving / Stable / Worsening label for slicers
- `risk_level` — ILO-based segmentation: Low / Medium / High / Critical
- `gender_gap` — Female minus Male unemployment rate in 2024

### 3. SQL Analysis (MySQL Workbench)
Wrote and executed 10 autonomous analytical queries covering:
structural levels, gender inequalities, youth vulnerability,
COVID impact by segment, and decadal trajectories by country.

### 4. Decisional Dashboard (Power BI)
Built a 3-page Power BI dashboard connected to the MySQL table:

- Page 1 — Global View: worldwide trends, top fragile economies, risk map
- Page 2 — Inequalities: gender gap, youth vs adults, structural disparities
- Page 3 — Trajectories: COVID shock, worsening countries, maximum alert list

17 DAX measures created covering totals, averages, ratios,
segmented calculations, and trend indicators.

### 5. Report & Presentation (Gamma)
Produced a professional analytical report structured for decision-makers
and a Gamma presentation for portfolio delivery and recruiter readability.


## 5. Dashboard Preview

Page 1 — Global View
KPI cards (global rate, % Critical countries), worldwide trend line chart
with COVID reference marker, top 15 fragile countries bar chart, filled map.

Page 2 — Inequalities
Gender gap ranking by country, clustered bar chart Female vs Male by segment,
youth unemployment alert bar chart (>40%), scatter plot crossing 3 dimensions.

Page 3 — Trajectories
COVID impact by population segment, decadal worsening top 10,
Improving vs Worsening donut chart, maximum alert country table
(Critical + Worsening filter).


## 6. Key Results & Insights

| # | Insight |
|---|---------|
| 1 | South Africa leads structural unemployment with an average rate of 42% over 2014–2024 — driven by youth joblessness exceeding 64% in 2024 |
| 2 | COVID hit youth 82% harder than adults globally — average shock of +3.84 pts vs +2.11 pts for adults in 2020 |
| 3 | Algeria tops gender inequality with women facing a 28-point higher unemployment rate than men in 2024 — the widest gap in the dataset |
| 4 | 7 countries are at maximum alert — combining Critical youth unemployment and a Worsening 10-year trend: Afghanistan, Gaza Strip, Venezuela, Lebanon, Sudan, Haiti, Mozambique |
| 5 | Global unemployment in 2024 remains above pre-COVID levels** (14.22% vs 14.28% in 2019) — recovery is real but incomplete across most vulnerable economies |


## 7. How to Run

### Prerequisites
```
Python 3.9+
MySQL Workbench 8.0+
Power BI Desktop (free)
```

### Python dependencies
```bash
pip install pandas sqlalchemy pymysql mysql-connector-python jupyter
```

### Steps

**1. Clone the repository**
```bash
git clone https://github.com/your-username/global-unemployment-analysis.git
cd global-unemployment-analysis
```

**2. Run the Jupyter Notebook**
```bash
jupyter notebook
```
Open `unemployment_analysis.ipynb` and run all cells sequentially:
- Quality audit
- Cleaning & renaming
- Feature engineering
- Convert to XLSX → `global_unemployment.xlsx`

**3. Load data into MySQL**
Update credentials in the notebook connection cell:
```python
engine = create_engine(
    "mysql+pymysql://your_user:your_password@localhost/unemployment_db"
)
```
Run the `df.to_sql()` cell to create the `global_unemployment` table.

**4. Run SQL queries**
Open MySQL Workbench, connect to `unemployment_db`,
and run queries from `queries.sql` sequentially.

**5. Open the Power BI dashboard**
Open `Global_unemployment_dashboard.pbix` in Power BI Desktop.
Load ' global_unemployment.xlxs' into the MySQL data source:


### Dataset
The raw dataset `global_unemployment.csv` is included in this repository.
Original source: [ILO Statistics](https://ilostat.ilo.org/data/)


## Author

ESMEL — Data Analyst
[LinkedIn](www.linkedin.com/in/esmel-amari) ·

Python · SQL · Power BI · Analytical storytelling
