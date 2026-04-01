--- [Q1] Top 10 pays avec le taux de chômage moyen le plus élevé (2014–2024)
--- Logique : Identifie les économies structurellement les plus fragiles sur la décennie — base pour prioriser les pays à surveiller.
SELECT
    country,
    ROUND(AVG(rate_avg_2014_2024), 2) AS avg_unemployment_rate
FROM global_unemployment
GROUP BY country
ORDER BY avg_unemployment_rate DESC
LIMIT 10;

--- [Q2] Taux de chômage moyen mondial par année (2014–2024)
--- Logique : Révèle la tendance globale annuelle et identifie les ruptures (ex : pic COVID 2020) — éclaire les décisions de politique macro.

SELECT
    ROUND(AVG(rate_2014), 2) AS y2014,
    ROUND(AVG(rate_2015), 2) AS y2015,
    ROUND(AVG(rate_2016), 2) AS y2016,
    ROUND(AVG(rate_2017), 2) AS y2017,
    ROUND(AVG(rate_2018), 2) AS y2018,
    ROUND(AVG(rate_2019), 2) AS y2019,
    ROUND(AVG(rate_2020), 2) AS y2020,
    ROUND(AVG(rate_2021), 2) AS y2021,
    ROUND(AVG(rate_2022), 2) AS y2022,
    ROUND(AVG(rate_2023), 2) AS y2023,
    ROUND(AVG(rate_2024), 2) AS y2024
FROM global_unemployment;

--- [Q3] Écart de genre moyen par pays en 2024 — Top 15 inégalités
--- Logique : Mesure où les femmes sont structurellement désavantagées sur le marché du travail — décision RH et politique d'inclusion.
select
    country,
    ROUND(AVG(gender_gap), 2) AS avg_gender_gap_2024
FROM global_unemployment
WHERE gender_gap IS NOT NULL
GROUP BY country
ORDER BY avg_gender_gap_2024 DESC
LIMIT 15;


--- [Q4] Répartition des pays par niveau de risque en 2024

--- Logique : Donne une vue macro de la distribution mondiale du risque chômage — utile pour un KPI card et un donut chart décisionnel.

SELECT
    risk_level,
    COUNT(DISTINCT country) AS number_of_countries,
    ROUND(AVG(rate_latest), 2) AS avg_rate_in_group
FROM global_unemployment
GROUP BY risk_level
ORDER BY avg_rate_in_group DESC;


--- [Q5] Pays où le chômage Youth dépasse 40 % en 2024 vs Adults

--- Logique : Identifie les économies où la jeunesse est en situation critique — priorité pour les politiques d'emploi et formation.

SELECT
    y.country,
    ROUND(AVG(y.rate_2024), 2) AS youth_rate_2024,
    ROUND(AVG(a.rate_2024), 2) AS adult_rate_2024,
    ROUND(AVG(y.rate_2024) - AVG(a.rate_2024), 2) AS youth_vs_adult_gap
FROM global_unemployment y
JOIN global_unemployment a
    ON y.country = a.country
    AND y.gender = a.gender
WHERE y.population_segment = 'Youth'
  AND a.population_segment = 'Adults'
GROUP BY y.country
HAVING youth_rate_2024 > 40
ORDER BY youth_rate_2024 DESC;


--- [Q6] Impact COVID moyen par segment de population

--- Logique : Révèle quel groupe a été le plus touché par la pandémie — éclaire les priorités de relance économique ciblée.

SELECT
    population_segment,
    ROUND(AVG(covid_impact), 2) AS avg_covid_impact,
    ROUND(MAX(covid_impact), 2) AS max_covid_impact,
    ROUND(MIN(covid_impact), 2) AS min_covid_impact
FROM global_unemployment
GROUP BY population_segment
ORDER BY avg_covid_impact DESC;


--- [Q7] Top 10 pays avec la plus forte dégradation sur 2014–2024

--- Logique : Identifie les économies en détérioration structurelle — signal d'alerte pour investisseurs et décideurs politiques.

SELECT
    country,
    ROUND(AVG(decadal_trend), 2) AS avg_decadal_trend
FROM global_unemployment
WHERE trend_direction = 'Worsening'
GROUP BY country
ORDER BY avg_decadal_trend DESC
LIMIT 10;


--- [Q8] Pays ayant amélioré le chômage féminin sur 2014–2024

--- Logique : Met en lumière les politiques d'inclusion réussies — benchmark pour les pays encore en difficulté.

SELECT
    country,
    ROUND(AVG(rate_2014), 2) AS female_rate_2014,
    ROUND(AVG(rate_2024), 2) AS female_rate_2024,
    ROUND(AVG(decadal_trend), 2) AS improvement
FROM global_unemployment
WHERE gender = 'Female'
  AND trend_direction = 'Improving'
GROUP BY country
ORDER BY improvement ASC
LIMIT 15;


--- [Q9] Chômage féminin vs masculin par segment en 2024 — vue mondiale

--- Logique : Compare systématiquement les deux genres par tranche d'âge — base du visuel d'inégalité structurelle du dashboard.

SELECT
    population_segment,
    gender,
    ROUND(AVG(rate_2024), 2) AS avg_rate_2024
FROM global_unemployment
GROUP BY population_segment, gender
ORDER BY population_segment, gender;


--- [Q10] Pays avec chômage Youth Critical ET tendance Worsening

--- Logique : Croise deux signaux d'alerte maximaux — liste rouge des économies nécessitant une intervention urgente.

SELECT
    country,
    ROUND(AVG(rate_latest), 2) AS youth_rate_2024,
    ROUND(AVG(decadal_trend), 2) AS trend_10y,
    risk_level,
    trend_direction
FROM global_unemployment
WHERE population_segment = 'Youth'
  AND risk_level = 'Critical'
  AND trend_direction = 'Worsening'
GROUP BY country, risk_level, trend_direction
ORDER BY youth_rate_2024 DESC;