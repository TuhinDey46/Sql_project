/* Find a job posting from the first quarter that have a salary greater than $70 K
    - combine job posting tables from the first quarter of 2023 (jan-mar)
    - Gets job posting with an average yearly salary >$70K
*/
SELECT 
    job_id,
    job_title_short,
    job_location,
    job_via,
    salary_year_avg
FROM (
    SELECT *
    FROM january_jobs
    UNION ALL
    SELECT *
    FROM february_jobs
    UNION ALL
    SELECT *
    FROM march_jobs
)
WHERE salary_year_avg > 70000 AND job_title_short = 'Data Analyst'
ORDER BY
    salary_year_avg DESC

