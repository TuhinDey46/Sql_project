
## Introduction 

📊 Dive into the data job market! Focusing on data analyst roles in India, this project explores 💰 top-paying jobs, 🔥 in-demand skills, and 📈 where high demand meets high salary in data analytics.

🔍 SQL queries? Check them out here: [project_sql folder](/project_sql/)

## Background

Driven by a quest to navigate the data analyst job market in more effectively, this project was born from a desire to pinpoint top-paid and in-demand skills, streamlining others work to find optimal jobs.

### The questions I wanted to answer through my SQL queries were:
    
    1.What are the top-paying data analyst jobs?
    2.What skills are required for these top-paying jobs?
    3.What skills are most in demand for data analysts?
    4.Which skills are associated with higher salaries?
    5.What are the most optimal skills to learn?

## Tools I Used

For my deep dive into the data analyst job market, I the following tools:

- **SQL:** The backbone of my analysis, allowing me to query the database and find insights.
- **PostgreSQL:** The database management system i choose, ideal for handling the job posting data.
- **Visual Studio Code:** My go-to code editor and used to execute the SQL queries.
- **Git & GitHub:** Essential for version control and sharing,  ensuring collaboration and project tracking.

## The Analysis

Each query for this project aimed at investigating specific aspects of the data analyst job market in **India**. Here’s how I approached each question:

### 1. Top paying Data analyst roles in India. 

To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location set to India. This query highlights the high paying opportunities in the field.

```sql
SELECT
    job_id,
    job_title,
    job_location,
    Job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim
    ON job_postings_fact.company_id = company_dim.company_id
WHERE 
    job_title_short = 'Data Analyst' AND 
    job_location = 'India' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;
```
![Top Paying Roles](assets\top_paying_roles.png)

Hers's the breakdown of the Top Data Analyst Jobs in 2023:

- **Wide Salary Range:** Top 10 highest paying data analyst roles span from $111000 to $177000, indicating significant salary potential in the field.
- **Diverse Employers:** Companies like Bosch Group, ServiceNow, Deutsche Bank and Srijan Technologies are among those offering high salaries, showing a broad interest across different industries.
- **Job Title Variety:** There's a high diversity in job titles, from Data Analyst to Research Engineers, reflecting varied roles and specializations within data analytics.

### 2. Skills for Top Paying Jobs   

To understand what skills are required for the top-paying jobs, I joined the job postings data with the skills data, providing insights into what employers value for high-compensation roles.

```sql
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
```
![Top paying skills](assets\top_paying_roles_skills.png)

Here's the breakdown of the most demanded skills for the top 10 highest paying data analyst jobs in 2023:

- **sql** is leading with a count of 8
- **python** is following closely with a count of 6
- Other skills **azure**, **aws**, **oracle** shows the importance of cloud computing in the field of data.


### 3. In Demand Skills for Data Analysts

This query helped identify the skills most frequently requested in job postings, directing focus to areas with high demand.

```sql
SELECT 
    skills,
    COUNT (skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE   
    job_title_short = 'Data Analyst' AND
    job_location LIKE '%India'
GROUP BY
    skills
ORDER BY 
    demand_count DESC
LIMIT 25;
```

| skills    | demand_count  |
|-----------|-------------- |
| sql       | 2,561         |
| python    | 1,802         |
| excel     | 1,718         |
| tableau   | 1,346         |
| power bi  | 1,043         |
| r         | 806           |
| sas       | 708           |
| azure     | 436           |
| aws       | 370           |
| powerpoint| 330           |

*Table for Skills with the highest demand for Data Analyst Roles*

Here's the breakdown of the most demanded skills for data analysts in 2023:

- **SQL** remain fundamental, emphasizing the need for strong foundational skills in data processing.
- **Python** Comes second, pointing towards the increasing importance of technical skills in data storytelling and manipulation.
- **Visualization Tools** like **Tableau** and **Power BI** are also in top 5 showing the importance of data storytelling and sharing insights.

### 4. Skills based on Salary

Exploring the average salaries associated with different skills revealed which skills are the highest paying.

```sql
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
```

| skills     | avg_salary  |
|------------|-------------|
| postgresql | 165,000.00  |
| gitlab     | 165,000.00  |
| pyspark    | 165,000.00  |
| mysql      | 165,000.00  |
| linux      | 165,000.00  |
| neo4j      | 163,782.00  |
| gdpr       | 163,782.00  |
| airflow    | 138,087.50  |
| mongodb    | 135,994.00  |
| databricks | 135,994.00  |

*Table for skills with highest salary*

Here's a breakdown of the results for top paying skills for Data Analysts:

- **High Demand for Big Data & ML Skills:** Top salaries are commanded by analysts skilled in big data technologies (PySpark, Couchbase), machine learning tools (DataRobot, Jupyter), and Python libraries (Pandas, NumPy), reflecting the industry's high valuation of data processing and predictive modeling capabilities.

- **Software Development & Deployment Proficiency:** Knowledge in development and deployment tools (GitLab, Kubernetes, Airflow) indicates a lucrative crossover between data analysis and engineering, with a premium on skills that facilitate automation and efficient data pipeline management.

- **Cloud Computing Expertise:** Familiarity with cloud and data engineering tools (Elasticsearch, Databricks, GCP) underscores the growing importance of cloud-based analytics environments, suggesting that cloud proficiency significantly boosts earning potential in data analytics.

### 5 Most Optimal Skills to Learn

Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering a strategic focus for skill development.

```sql
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
```


| skills   | demand_count | avg_salary  |
|----------|--------------|-------------|
| sql      | 46           | 92,983.62   |
| excel    | 39           | 88,518.96   |
| python   | 36           | 95,933.33   |
| tableau  | 20           | 95,102.80   |
| r        | 18           | 86,609.11   |
| power bi | 17           | 109,832.18  |
| azure    | 15           | 98,569.80   |
| aws      | 12           | 95,333.00   |
| oracle   | 11           | 104,260.32  |
| spark    | 11           | 118,332.45  |

*Table for the most optimal skills for Data analyst sorted by Demand*

Here's a breakdown of the most optimal skills for Data Analysts in 2023:

- **sql** and **Excel** - Shows the importance foundational knowledge of Data processing and spreadsheet manipulation but these skills are not highest paid means the proficiency in these skills are widely available.
- **Python** and **R** - Highest paying in-demand programming language and Python is edges out R in terms of demand and salary because of its wide usability outside of the field of data. 
- **snoflake**, **azure** and **aws** are Skills in specialized technologies shows significant demand with relatively high average salaries, pointing towards the growing importance of cloud platforms and big data technologies in data analysis.


## Conclusions

### Insights

From the analysis, several general insights emerged:

1. **Top-Paying Data Analyst Jobs**: The highest-paying jobs for data analysts in India offer a wide range of salaries, the highest is arround $177000!
2. **Skills for Top-Paying Jobs**: High-paying data analyst jobs require advanced proficiency in SQL, suggesting it’s a critical skill for earning a top salary.
3. **Most In-Demand Skills**: SQL is also the most demanded skill in the data analyst job market, thus making it essential for job seekers.
4. **Skills with Higher Salaries**: Specialized skills, such as Pyspark, databricks, postgresql and the cloud computing technologies such as aws, azure, etc are associated with the highest average salaries, indicating a premium on niche expertise.
5. **Optimal Skills for Job Market Value**: SQL leads in demand and offers for a high average salary, positioning it as one of the most optimal skills for data analysts to learn to maximize their market value.

### Closing Thoughts

This project enhanced my SQL skills and provided valuable insights into the data
analyst job market. The findings from the
analysis serve as a guide to prioritizing skill development and job search efforts.
Aspiring data analysts can better
position themselves in a competitive job market by focusing on the optimal skills.