/*
Question : what skills are required for the top-paying data analyst jobs in India?
    - Use the top 10 Highest-paying jobs from the First query
    - Add the specific skills required for these roles
    - Why? It provides a detailed look at which high-paying jobs demand certain skills,
        Helping job seekers understand which skills to develop that align with top salaries. 
*/

WITH top_paying_jobs AS 
(
    SELECT
            job_id,
            job_title,
            job_location,
            salary_year_avg,
            name AS company_name
    FROM
            job_postings_fact
    LEFT JOIN company_dim
            ON job_postings_fact.company_id = company_dim.company_id
    WHERE 
            job_title_short = 'Data Analyst' AND 
            job_location LIKE '%India' AND
            salary_year_avg IS NOT NULL
    ORDER BY
            salary_year_avg DESC
    LIMIT 10
    )

SELECT  top_paying_jobs.*,
            skills_dim.skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id