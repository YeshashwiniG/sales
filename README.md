# 📊 Task 6: Sales Trend Analysis Using Aggregations

## 🧑‍💼 Internship: Data Analyst

### 🔍 Objective:
Analyze monthly sales trends using SQL aggregate functions and time-based grouping. Extract insights like monthly revenue, order volume, average order value, and top-performing products.

---

## 📁 Dataset:
Table Name: `sales`  
Columns:
- `order_date` (DATE) – Date of the order
- `amount` (DECIMAL) – Revenue of the order
- `product_id` (INT) – ID of the product sold

---

## ⚙️ Tools Used:
- MySQL Workbench (or PostgreSQL / SQLite)
- SQL aggregate functions
- GitHub for code sharing

---

## 📦 Table Creation

```sql
CREATE TABLE sales (
    order_date DATE,
    amount DECIMAL(10,2),
    product_id INT
);
