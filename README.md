<img src="/Walmart.png" alt="Walmart"/>

# Walmart Sales Data - SQL Project

## Overview
This project focuses on analyzing Walmart sales data using SQL. The objective is to clean the data, engineer new features, and derive business insights.

## Table Details
**Table Name:** `SALES`

### **Columns:**
- `customer_id` (Primary Key, Unique ID for each sale)
- `product_id` (ID of the sold product)
- `store_id` (Store where the sale happened)
- `sale_date` (Date of the transaction)
- `time` (Time of the transaction)
- `quantity` (Number of items sold)
- `price` (Price per item)
- `total_sales` (Computed: `quantity * price`)
- `time_of_day` (Morning, Afternoon, Evening - based on transaction time)
- `sales_category` (Good/Bad - based on total sales vs. average sales)

## **SQL Queries**

### **1. Create the Sales Table**
```sql
CREATE TABLE SALES (
    sale_id SERIAL PRIMARY KEY,
    product_id INT,
    store_id INT,
    sale_date DATE,
    time TIME,
    quantity INT,
    price DECIMAL(10,2),
    total_sales DECIMAL(12,2),
    time_of_day VARCHAR(50),
    sales_category VARCHAR(20)
);
```

### **2. Insert Sample Data**
```sql
INSERT INTO SALES (product_id, store_id, sale_date, time, quantity, price, total_sales)
VALUES 
(101, 1, '2024-03-01', '08:30:00', 2, 15.99, 31.98),
(102, 2, '2024-03-01', '14:15:00', 1, 25.50, 25.50),
(103, 1, '2024-03-01', '18:45:00', 3, 10.00, 30.00);
```

### **3. Add Time of Day Column**
```sql
ALTER TABLE SALES ADD COLUMN time_of_day VARCHAR(50);
```

### **4. Update Time of Day Values**
```sql
UPDATE SALES
SET time_of_day = (
    CASE 
        WHEN time BETWEEN '00:00:00' AND '12:00:00' THEN 'MORNING'
        WHEN time BETWEEN '12:01:00' AND '16:00:00' THEN 'AFTERNOON'
        ELSE 'EVENING'
    END
);
```

### **5. Add Sales Category (Good/Bad)**
```sql
ALTER TABLE SALES ADD COLUMN sales_category VARCHAR(20);

UPDATE SALES
SET sales_category = (
    CASE 
        WHEN total_sales >= (SELECT AVG(total_sales) FROM SALES) THEN 'Good'
        ELSE 'Bad'
    END
);
```

## **Business Insights**

### **1. Total Sales Per Product**
```sql
SELECT product_id, SUM(total_sales) AS total_revenue
FROM SALES
GROUP BY product_id
ORDER BY total_revenue DESC;
```

### **2. Peak Sales Hours**
```sql
SELECT time_of_day, COUNT(*) AS sales_count
FROM SALES
GROUP BY time_of_day
ORDER BY sales_count DESC;
```

### **3. Best-Selling Stores**
```sql
SELECT store_id, SUM(total_sales) AS store_revenue
FROM SALES
GROUP BY store_id
ORDER BY store_revenue DESC;
```

## **Usage**
1. Run the SQL scripts sequentially to create the database and tables.
2. Insert sales data manually or via ETL processes.
3. Execute the queries to generate insights on Walmart's sales trends.
