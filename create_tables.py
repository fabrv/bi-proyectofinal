
##solo crear el script para crear la tabla
import csv
##import psycopg2

# Connect to the PostgreSQL database
#conn = psycopg2.connect(
#    host="localhost",
#    database="bi",
#    user="postgres",
#    password="10119127"
#)

# Open the CSV file and read its contents
with open('benefits.csv', 'r') as f:
    reader = csv.reader(f)
    headers = next(reader)  # Get the column names from the first row
    ##print(headers)
    # Create a new table in the database using the column names as the fields
    ##cur = conn.cursor()
    query="CREATE TABLE benefits (%s);" % ','.join([f"{h} text" for h in headers])
    print(query)
    ##cur.execute(query)

    # Insert the data from the CSV file into the new table
    for row in reader:
        query="INSERT INTO benefits (%s) VALUES (%s);" % (','.join(headers), ','.join(["%s"] * len(headers)))
        ##print(query)
        ##cur.execute(query, row)