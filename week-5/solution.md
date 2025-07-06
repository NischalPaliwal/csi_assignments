# Azure Data Factory Assignment

## Task 1: Copy Data from Database to CSV, Parquet, and Avro File Formats

### Steps:

1. **Create Source**: First, create the source from which the pipeline will extract records and dump them into a sink after required transformations.

2. **Create Storage Account**: There are two ways to proceed:
   - Azure Data Lakes
   - Azure Blob Storage

3. **Storage Account Configuration**: Choose any of the above options but ensure the following points while creating storage:
   - Choose primary service as "Azure Blob Storage or Azure Data Lake Gen2"
   - If targeting Azure Data Lake, enable "Hierarchical Namespace" option

4. **Directory Setup**: 
   - Create two directories inside the storage account named "source" and "destination"
   - Upload the source file or dataset in the source directory for each file format

5. **Instantiate Azure Data Factory**

6. **Navigate to Azure Data Factory Studio**:
   - Click on the "Azure Data Factory Studio" option
   - Navigate to the "Manage" tab

7. **Create Linked Service**:
   - Create "Linked Service" for Azure Data Lake
   - Only one "Linked Service" is needed for Azure Data Lake as both source and sink locations exist in the same data lake

8. **Navigate to Author Tab**: Go to the "Author" tab to create tasks/jobs

9. **Add Copy Data Activities**:
   - In the activities section, search for "copy data"
   - Drag & drop the icon to the canvas

10. **Configure Multiple Activities**:
    - Drop three copy data activities for the three file formats
    - Ensure they are placed in parallel, not sequentially

11. **General Settings Configuration**:
    - Configure general settings such as "Retry" and "Retry interval" fields for each activity

12. **Configure Source and Sink Properties**:
    - Set up "source" and "sink" properties for each activity

13. **Test Pipeline**:
    - Click the "Debug" button above the canvas to test run the pipeline

14. **Create Triggers**:
    - Click "Add trigger" → "New/Edit" buttons

15. **Publish Changes**:
    - Publish all changes to the data factory

## Task 2: Copy Selective Tables with Selective Columns from One Database to Another

### Overview:
Same steps as Task 1 but with a few key differences:

### Key Differences:

1. **Linked Services**: 
   - Create linked services for the databases (source and sink)

2. **Database Configuration**:
   - Source: PostgreSQL
   - Sink: Azure SQL

3. **Copy Data Activity**: 
   - Use copy data activity (same as Task 1)

4. **Dataset Configuration**:
   - Set "source" and "sink" datasets

5. **Source Properties**:
   - Choose "Query" over "Table" in the "Use query" field
   - Write down the specific query for selective columns

## Task 3: Copy All Tables from One Database to Another

### Overview:
Same steps as Task 1 but with a few key differences:

### Key Differences:

1. **Linked Services**: 
   - Continue with the same linked services from Task 2

2. **Copy Data Activity**: 
   - Use copy data activity (same as previous tasks)

3. **Dataset Configuration**:
   - Keep "source" and "sink" datasets as they are

4. **Source Properties**:
   - Choose "Table" over "Query" in the "Use query" field
   - This will copy all tables without filtering.