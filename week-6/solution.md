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
  <img width="1920" height="1020" alt="Screenshot 2025-07-14 083554" src="https://github.com/user-attachments/assets/bd14dafa-0c59-460b-89f9-f01143b2c4bf" />
  <img width="1920" height="1020" alt="Screenshot 2025-07-14 083608" src="https://github.com/user-attachments/assets/bd8b8bd1-d6e1-478b-8a85-08a00cbc1181" />

#### ⚙️ Create Integration Runtime
- 🛠️ Click on **"Manage"** tab (toolbox icon) in the left panel
- 🔗 Select **"Integration runtimes"** → Click **"+ New"**
- 🏠 Choose **"Self-Hosted"** → Click **"Continue"**
- 📝 Enter name (e.g., `OnPremisesIR`) → Click **"Create"**
- 🔑 **Copy the authentication key** (you'll need this for installation)
  <img width="1920" height="1020" alt="Screenshot 2025-07-14 083653" src="https://github.com/user-attachments/assets/47ead3e3-087c-449c-8eb4-e7fa7e8bb80d" />
  <img width="1920" height="1020" alt="Screenshot 2025-07-14 083731" src="https://github.com/user-attachments/assets/7ca0e21d-6f37-4860-8204-bb1c8464735b" />
  <img width="1920" height="1020" alt="Screenshot 2025-07-14 084032" src="https://github.com/user-attachments/assets/89e9367a-ae06-4e26-82e0-0057d556b065" />

---

### 💻 Step 2: Install SHIR on Local Server

#### 📥 Download Integration Runtime
- ⬇️ In the IR setup page, click **"Download and install integration runtime"**
- 🖥️ Run the downloaded MSI file on your on-premises server
  <img width="1920" height="1020" alt="Screenshot 2025-07-14 084056" src="https://github.com/user-attachments/assets/2327c8d2-4c81-465c-9e9d-b500133603a1" />

#### 🔐 Register the Runtime
- 📋 Paste the authentication key from Step 1
- ✅ Click **"Register"** → Wait for successful registration
  <img width="984" height="680" alt="Screenshot 2025-07-14 085005" src="https://github.com/user-attachments/assets/4e5c79b8-2228-42da-a9cc-43ba82c1082c" />
  <img width="984" height="680" alt="Screenshot 2025-07-14 085025" src="https://github.com/user-attachments/assets/df12e7d2-734a-4ba5-918a-f22b2027f481" />
  <img width="984" height="680" alt="Screenshot 2025-07-14 085131" src="https://github.com/user-attachments/assets/a34adcf9-ab1c-4913-9d25-d8fb03ffef3b" />
  
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
  <img width="1920" height="1020" alt="Screenshot 2025-07-14 090411" src="https://github.com/user-attachments/assets/9d63178c-4888-4bc7-8134-0d85b846c258" />
  <img width="1920" height="1020" alt="Screenshot 2025-07-14 090909" src="https://github.com/user-attachments/assets/80876b1a-0a52-49de-bf85-04da7eb84c61" />

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
  <img width="1920" height="1020" alt="Screenshot 2025-07-14 091549" src="https://github.com/user-attachments/assets/e68cd8c5-e091-4b93-b4a3-bdb914991fc2" />
  <img width="1920" height="1020" alt="Screenshot 2025-07-14 091811" src="https://github.com/user-attachments/assets/242f8489-b061-40f1-8730-b1455a2923d7" />
  <img width="1920" height="1020" alt="Screenshot 2025-07-14 092217" src="https://github.com/user-attachments/assets/ddb42d58-d0c7-4168-87db-0d06f1dee559" />

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
  <img width="1920" height="1020" alt="Screenshot 2025-07-14 092733" src="https://github.com/user-attachments/assets/90e0907f-97d8-42a6-806b-436ed216f63d" />
  <img width="1920" height="1020" alt="Screenshot 2025-07-14 093251" src="https://github.com/user-attachments/assets/4e842203-e547-48d2-8cc9-682e2a9f13c3" />

---

### 🚀 Step 5: Create Copy Pipeline

#### 📋 Create Pipeline
- ✍️ **"Author"** tab → **"+"** → **"Pipeline"**
- 📝 **Name:** `OnPremToAzureSQLPipeline`
  <img width="1920" height="1020" alt="Screenshot 2025-07-14 095720" src="https://github.com/user-attachments/assets/7abe6dd1-7548-4ebc-b6c4-e846ff475d00" />

#### 📁 Add Copy Activity
- 🎯 From **"Activities"** panel, drag **"Copy data"** to pipeline canvas
- 🔍 Select the copy activity → Go to **"Source"** tab
- 📊 **Source dataset:** Select `OnPremSqlDataset`
- 🔍 **Use query:** Choose **"Table"** or **"Query"** as needed
  <img width="1920" height="1020" alt="Screenshot 2025-07-14 095759" src="https://github.com/user-attachments/assets/71798016-17ff-4630-bfa4-32f394a8cc96" />

#### 🎯 Configure Sink
- 🎯 Go to **"Sink"** tab
- 📊 **Sink dataset:** Select `AzureSqlDataset`
- 🔄 **Copy behavior:** Choose **"Insert"** or **"Upsert"**
  <img width="1920" height="1020" alt="Screenshot 2025-07-14 101831" src="https://github.com/user-attachments/assets/58d575c0-5fcc-4009-a45d-10a6458a95eb" />

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
  <img width="1920" height="1020" alt="Screenshot 2025-07-14 101912" src="https://github.com/user-attachments/assets/7d3b04a7-bd0a-427d-b6b2-60a577ffe8b5" />
  <img width="1920" height="1020" alt="Screenshot 2025-07-14 130947" src="https://github.com/user-attachments/assets/eae48a3f-4158-4e0a-b125-c4f0c19ca97d" />

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
  <img width="1920" height="1020" alt="Screenshot 2025-07-14 130959" src="https://github.com/user-attachments/assets/6ba3eba4-5c34-41e3-bdef-40d7cb2210f5" />

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
  <img width="1920" height="1020" alt="Screenshot 2025-07-14 131218" src="https://github.com/user-attachments/assets/39e59272-a14d-4054-83fa-3f305a6297a6" />

---

### 🚀 Step 4: Create FTP/SFTP Pipeline

- ✍️ **"Author"** tab → **"+"** → **"Pipeline"**
- 📝 **Name:** `FtpToAzurePipeline`
- 🎯 Drag **"Copy data"** activity to canvas
- 📊 **Configure Source:** Select FTP/SFTP dataset
- 🎯 **Configure Sink:** Select Azure storage dataset
- 🚀 Publish and test
  <img width="1920" height="1020" alt="Screenshot 2025-07-14 131609" src="https://github.com/user-attachments/assets/345cccd9-88e6-4af5-bb0e-20e69b9d295e" />
  <img width="1920" height="1020" alt="Screenshot 2025-07-14 131646" src="https://github.com/user-attachments/assets/06407a85-0008-4441-a521-55d5e2332a94" />
  <img width="1920" height="1020" alt="Screenshot 2025-07-14 132130" src="https://github.com/user-attachments/assets/866bbc48-25ee-4a17-b6ae-8cb7629ffd95" />

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
  <img width="1920" height="1020" alt="Screenshot 2025-07-14 134203" src="https://github.com/user-attachments/assets/48295b74-669b-4e7d-98c4-9072aff25338" />
  <img width="1920" height="1020" alt="Screenshot 2025-07-14 134212" src="https://github.com/user-attachments/assets/53f4f524-0379-4c2d-bbe6-c376ca092c32" />
  <img width="1920" height="1020" alt="Screenshot 2025-07-14 134413" src="https://github.com/user-attachments/assets/4ff99926-1000-4299-b992-94206b49156e" />

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
  <img width="785" height="864" alt="Screenshot 2025-07-14 134837" src="https://github.com/user-attachments/assets/b925406b-d6d1-414a-907d-589789f6c4a0" />
  <img width="789" height="863" alt="Screenshot 2025-07-14 134857" src="https://github.com/user-attachments/assets/49df8fb7-2b9e-4ef1-9f05-376c3b87dfab" />

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

**🎓 Submitted by:** Nischal Paliwal  
**📅 Date:** 14/07/2025 
**🏫 Domain:** Data Engineering

---
