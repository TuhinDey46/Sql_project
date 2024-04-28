/* FIND The count of the number of remote job posting per skill
    - Display the top 5 skills by demand in remote jobs.
    - Include SKill_ID, Name, Count_of_job_postings.
*/

WITH remote_job_skills AS (
SELECT
    Skill_id,
    COUNT(*) AS Skill_count
FROM
    skills_job_dim
INNER JOIN job_postings_fact AS job_postings
ON job_postings.job_id = skills_job_dim.job_id
WHERE   
        job_postings.job_work_from_home = TRUE AND job_title_short = 'Data Analyst'
GROUP BY
    skill_id
)



SELECT 
    skills.skill_id,
    skills as skill_name,
    skill_count
FROM remote_job_skills
INNER JOIN skills_dim AS skills ON skills.skill_id = remote_job_skills.skill_id
ORDER BY skill_count DESC
LIMIT 5;