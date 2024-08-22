/*
Question: What are the top skills based on salary in India?
    - Look at the average salary associated with each skill for DA position
    - Focuses on roles with specified salaries, regardless of location
    - why? It reveals how different skills impact salary levels for DAs and 
        helps identify the most financially rewarding skills to aquire or improve.
*/

SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 2) avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE   
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL AND
    job_location LIKE '%India' 
GROUP BY
    skills
ORDER BY 
    avg_salary DESC
LIMIT 25;