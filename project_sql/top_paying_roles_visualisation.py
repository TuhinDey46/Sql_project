# Code for the top paying roles Graph

import pandas as pd
import matplotlib.pyplot as plt

# Create the dataframe
data = {
    'Job Title': [
        'Staff Applied Research Engineer',
        'Data Architect 2023',
        'Data Architect - Data Migration',
        'Technical Data Architect - Healthcare',
        'Data Architect',
        'Senior Business & Data Analyst',
        'Sr. Enterprise Data Analyst',
        'Senior Analyst, Product Revenue',
        'Data Analyst/Senior Data Analyst'
    ],
    'Salary Year Avg': [
        177283.0, 165000.0, 165000.0, 165000.0, 163782.0,
        119250.0, 118140.0, 111175.0, 111175.0
    ]
}

df = pd.DataFrame(data)

# Create the plot
plt.figure(figsize=(12, 6))
bars = plt.bar(df['Job Title'], df['Salary Year Avg'])

# Customize the plot
plt.title('Average Yearly Salary by Job Title', fontsize=16)
plt.xlabel('Job Title', fontsize=12)
plt.ylabel('Salary Year Average ($)', fontsize=12)
plt.xticks(rotation=45, ha='right')
plt.tight_layout()

# Add value labels on top of each bar
for bar in bars:
    height = bar.get_height()
    plt.text(bar.get_x() + bar.get_width()/2., height,
             f'${height:,.0f}',
             ha='center', va='bottom', rotation=0)

# Show the plot
#plt.show()
# Save the plot
plt.savefig('top_paying_roles.png', dpi=300, bbox_inches='tight')