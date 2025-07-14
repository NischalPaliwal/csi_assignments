# 🚀 Azure Data Factory Assignment Solution

---

## 📋 Table of Contents

1. [🔧 Self-hosted Integration Runtime Setup](#-self-hosted-integration-runtime-setup)
2. [🌐 FTP/SFTP Server Configuration](#-ftpsftp-server-configuration)
3. [📈 Incremental Load Pipeline with Daily Automation](#-incremental-load-pipeline-with-daily-automation)
4. [📈 Creating triggers for last saturday of every month](#-quick-reference-guide)

---

## 🔧 Self-hosted Integration Runtime Setup
### *Connecting On-premises to Azure SQL Database*

### 📝 Step 1: Create Self-hosted Integration Runtime in Azure Portal

#### 🎪 Navigate to Azure Data Factory
- 🔍 Go to Azure Portal → Search **"Data Factory"**
- 🎯 Select your ADF instance
- 🎨 Click **"Open Azure Data Factory Studio"**

#### ⚙️ Create Integration Runtime
- 🛠️ Click on **"Manage"** tab (toolbox icon) in the left panel
- 🔗 Select **"Integration runtimes"** → Click **"+ New"**
- 🏠 Choose **"Self-Hosted"** → Click **"Continue"**
- 📝 Enter name (e.g., `OnPremisesIR`) → Click **"Create"**
- 🔑 **Copy the authentication key** (you'll need this for installation)

---

### 💻 Step 2: Install SHIR on Local Server

#### 📥 Download Integration Runtime
- ⬇️ In the IR setup page, click **"Download and install integration runtime"**
- 🖥️ Run the downloaded MSI file on your on-premises server

#### 🔐 Register the Runtime
- 📋 Paste the authentication key from Step 1
- ✅ Click **"Register"** → Wait for successful registration

---

### 🔗 Step 3: Create Linked Services

#### 🏢 On-premises SQL Server Linked Service:
- 🛠️ Go to **"Manage"** tab → **"Linked services"** → **"+ New"**
- 🗄️ Select **"SQL Server"** → Click **"Continue"**
- 📊 Fill in the details:
  - **Name:** `OnPremSqlServer`
  - **Integration runtime:** Select your SHIR (`OnPremisesIR`)
  - **Server name:** Your on-premises server name
  - **Database name:** Your database name
  - **Authentication type:** Choose appropriate (Windows/SQL)
  - **Username/Password:** Enter credentials
- ✅ Click **"Test connection"** → **"Create"**

#### ☁️ Azure SQL Database Linked Service:
- 🛠️ **"Manage"** tab → **"Linked services"** → **"+ New"**
- 🗃️ Select **"Azure SQL Database"** → Click **"Continue"**
- 📝 Fill in details:
  - **Name:** `AzureSqlDatabase`
  - **Azure subscription:** Select your subscription
  - **Server name:** Your Azure SQL server
  - **Database name:** Your Azure SQL database
  - **Authentication type:** SQL authentication
  - **Username/Password:** Enter credentials
- ✅ Click **"Test connection"** → **"Create"**

---

### 📊 Step 4: Create Datasets

#### 🏢 On-premises Dataset:
- ✍️ Go to **"Author"** tab → **"+"** → **"Dataset"**
- 🗄️ Select **"SQL Server"** → Click **"Continue"**
- 📄 Select format (e.g., **"DelimitedText"** or **"Parquet"**) → **"Continue"**
- ⚙️ Configure:
  - **Name:** `OnPremSqlDataset`
  - **Linked service:** `OnPremSqlServer`
  - **Table name:** Select your table
- ✅ Click **"OK"**

#### ☁️ Azure SQL Dataset:
- ✍️ **"Author"** tab → **"+"** → **"Dataset"**
- 🗃️ Select **"Azure SQL Database"** → Continue
- ⚙️ Configure:
  - **Name:** `AzureSqlDataset`
  - **Linked service:** `AzureSqlDatabase`
  - **Table name:** Select destination table
- ✅ Click **"OK"**

---

### 🚀 Step 5: Create Copy Pipeline

#### 📋 Create Pipeline
- ✍️ **"Author"** tab → **"+"** → **"Pipeline"**
- 📝 **Name:** `OnPremToAzureSQLPipeline`

#### 📁 Add Copy Activity
- 🎯 From **"Activities"** panel, drag **"Copy data"** to pipeline canvas
- 🔍 Select the copy activity → Go to **"Source"** tab
- 📊 **Source dataset:** Select `OnPremSqlDataset`
- 🔍 **Use query:** Choose **"Table"** or **"Query"** as needed

#### 🎯 Configure Sink
- 🎯 Go to **"Sink"** tab
- 📊 **Sink dataset:** Select `AzureSqlDataset`
- 🔄 **Copy behavior:** Choose **"Insert"** or **"Upsert"**

#### 🚀 Publish and Test
- 📤 Click **"Publish all"** → **"Debug"** to test the pipeline

---

## 🌐 FTP/SFTP Server Configuration
### *Creating ADF Pipeline for File Transfer*

### 🔗 Step 1: Create FTP/SFTP Linked Service

#### 📁 For FTP:
- 🛠️ **"Manage"** tab → **"Linked services"** → **"+ New"**
- 📂 Select **"FTP"** → Continue
- ⚙️ Configure:
  - **Name:** `FtpServer`
  - **Server:** Your FTP server address
  - **Port:** 21 (default)
  - **Authentication type:** Basic
  - **Username/Password:** Enter credentials
- ✅ Test connection → Create

#### 🔐 For SFTP:
- 🛠️ **"Manage"** tab → **"Linked services"** → **"+ New"**
- 🔒 Select **"SFTP"** → Continue
- ⚙️ Configure:
  - **Name:** `SftpServer`
  - **Server:** Your SFTP server address
  - **Port:** 22 (default)
  - **Authentication type:** Basic or SSH Public Key
  - **Username/Password or SSH key details**
- ✅ Test connection → Create

---

### 📊 Step 2: Create FTP/SFTP Dataset

- ✍️ **"Author"** tab → **"+"** → **"Dataset"**
- 📂 Select **"FTP"** or **"SFTP"** → Continue
- 📄 Choose format (DelimitedText, Binary, etc.) → Continue
- ⚙️ Configure:
  - **Name:** `FtpFileDataset`
  - **Linked service:** Select your FTP/SFTP linked service
  - **File path:** Enter folder path (e.g., `/data/`)
  - **File name:** Use wildcards like `*.csv` for multiple files
- 📝 Set delimiter, headers as needed → OK

---

### ☁️ Step 3: Create Destination Dataset (Azure Blob/Data Lake)

- ✍️ **"Author"** tab → **"+"** → **"Dataset"**
- 🗄️ Select **"Azure Blob Storage"** or **"Azure Data Lake Storage Gen2"**
- ⚙️ Configure destination settings
- ✅ Click **"OK"**

---

### 🚀 Step 4: Create FTP/SFTP Pipeline

- ✍️ **"Author"** tab → **"+"** → **"Pipeline"**
- 📝 **Name:** `FtpToAzurePipeline`
- 🎯 Drag **"Copy data"** activity to canvas
- 📊 **Configure Source:** Select FTP/SFTP dataset
- 🎯 **Configure Sink:** Select Azure storage dataset
- 🚀 Publish and test

---

## 📈 Incremental Load Pipeline with Daily Automation

### 🗄️ Sample Source Table Setup

#### 📋 Create Orders Table in Source Database

```sql
-- Create sample Orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT,
    ProductName VARCHAR(100),
    OrderDate DATETIME DEFAULT GETDATE(),
    Quantity INT,
    Price DECIMAL(10,2),
    Status VARCHAR(20),
    CreatedDate DATETIME DEFAULT GETDATE(),
    ModifiedDate DATETIME DEFAULT GETDATE()
);
```

#### 📊 Insert Sample Data

```sql
-- Insert sample data
INSERT INTO Orders (CustomerID, ProductName, OrderDate, Quantity, Price, Status)
VALUES 
    (1001, 'Laptop', '2024-01-15 10:30:00', 1, 999.99, 'Completed'),
    (1002, 'Mouse', '2024-01-15 14:20:00', 2, 25.50, 'Pending'),
    (1003, 'Keyboard', '2024-01-16 09:15:00', 1, 75.00, 'Completed'),
    (1004, 'Monitor', '2024-01-16 16:45:00', 1, 299.99, 'Shipped'),
    (1005, 'Headphones', '2024-01-17 11:30:00', 3, 89.99, 'Pending');
```

#### 🆕 Add Recent Data for Testing

```sql
-- Add some recent data (this will be picked up by incremental load)
INSERT INTO Orders (CustomerID, ProductName, OrderDate, Quantity, Price, Status)
VALUES 
    (1006, 'Tablet', GETDATE(), 1, 399.99, 'New'),
    (1007, 'Phone', GETDATE(), 2, 699.99, 'New');
```

---

### 🚀 Step 1: Simple Incremental Load Setup

#### 📋 Create Your Pipeline
- ✍️ **"Author"** tab → **"+"** → **"Pipeline"**
- 📝 **Name:** `DailyIncrementalLoad`

#### 📁 Add Copy Activity
- 🎯 Drag **"Copy data"** to canvas
- 📊 **Source:** Orders table
- 🔍 **Source Query:** Use this incremental query:

```sql
SELECT * FROM Orders 
WHERE ModifiedDate >= DATEADD(day, -1, GETDATE())
```

- 🎯 **Sink:** Your destination table (Azure SQL Database)

#### ⏰ Set Up Daily Schedule
- 🛠️ **"Manage"** tab → **"Triggers"** → **"+ New"**
- 📅 Choose **"Schedule"**
- 📝 **Name:** `DailyTrigger`
- **Configuration:**
  - 🔄 **Recurrence:** Daily
  - 🕐 **Time:** 2:00 AM (or your preferred time)
  - 🔗 **Associate with pipeline:** Select `DailyIncrementalLoad`
- ✅ Click **"OK"** → **"Publish all"** → **"Start"** trigger

---

### 📊 Pipeline Architecture Overview

```
🗄️ Source Database (Orders)
          ↓
📅 Daily Trigger (2:00 AM)
          ↓
🔍 Incremental Query (Last 24 hours)
          ↓
📁 Copy Activity
          ↓
☁️ Azure SQL Database (Destination)
```

---

## 📈 Setting Up Triggers for Last Saturday of Every Month
---

## 🏆 Assignment Completion Checklist

- [ ] ✅ Created Self-hosted Integration Runtime
- [ ] 🔗 Configured On-premises SQL Server Linked Service
- [ ] ☁️ Set up Azure SQL Database Linked Service
- [ ] 📊 Created source and destination datasets
- [ ] 🚀 Built and tested copy pipeline
- [ ] 📁 Configured FTP/SFTP connections
- [ ] 🌐 Created file transfer pipeline
- [ ] 🗄️ Set up Orders table with sample data
- [ ] 📈 Created incremental load pipeline
- [ ] ⏰ Configured daily automation trigger
- [ ] 🎯 Successfully executed data movement

---

**🎓 Submitted by:** [Nischal Paliwal]  
**📅 Date:** [14/07/2025]  
**🏫 Domain:** Data Engineering

---