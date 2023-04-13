import pandas as pd
from sqlalchemy import create_engine

# Replace these values with your own database credentials
db_user = 'your_username'
db_password = 'your_password'
db_host = 'your_host'
db_port = 'your_port'
db_name = 'your_database_name'

# Read the CSV file using Pandas
data = pd.read_csv('path/to/your/csv/file.csv')

# Create a connection to the PostgreSQL database using SQLAlchemy
engine = create_engine(f'postgresql://{db_user}:{db_password}@{db_host}:{db_port}/{db_name}')

# Write the data to the database
data.to_sql('your_table_name', engine, if_exists='replace', index=False)

# Confirm that the data was successfully written to the database
result = engine.execute('SELECT COUNT(*) FROM your_table_name').fetchone()
print(f'{result[0]} rows were added to the {db_name} database.')
