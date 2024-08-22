/*
Question: What are the most optimal skills to learn (aka It's in high demand and a high-paying skill)?
    - Identify skills in high demand and associated with high average salaries for DA Roles
    - Concentrates on jobs In India with specified salaries (Not nulls)
    - Why? Targets skills that offer job security (high demand) and financial benefits(high salaries),
        offering strategic insights for career development in Data analysis
*/

-- with CTEs 
WITH skills_demand AS
(
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT (skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE   
        job_title_short = 'Data Analyst' AND
        job_location LIKE '%India' AND
        salary_year_avg IS NOT NULL
    GROUP BY
        skills_dim.skill_id
), skills_salary AS
(
    SELECT 
        skills_job_dim.skill_id,
        ROUND(AVG(salary_year_avg), 2) avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE   
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL AND
        job_location LIKE '%India' 
    GROUP BY
        skills_job_dim.skill_id
)

SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM 
    skills_demand
INNER JOIN Skills_salary 
    ON skills_demand.skill_id = skills_salary.skill_id
ORDER BY
    demand_count DESC,
    avg_salary DESC
LIMIT 25

--Rewriten concisely

SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT (skills_job_dim.job_id) AS demand_count,
        ROUND(AVG(salary_year_avg), 2) avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL AND
        job_location LIKE '%India'
GROUP BY
    skills_dim.skill_id
ORDER BY    
    demand_count DESC
LIMIT 25;