# 📊 E-Commerce & Retail Business Analytics (MySQL)

## 📌 Project Overview
This repository contains a comprehensive SQL project designed for an online retail database (`OnlineRetailDB`). It demonstrates production-ready database design, entity relationships, and complex data analysis queries aimed at solving real-world business tracking problems.

## 🛠️ Tech Stack & SQL Concepts
- **Database Engine:** MySQL v8.0+
- **Core Concepts:** Multi-table Inner/Left Joins, Aggregate Functions, Common Table Expressions (CTEs), Subqueries, Data Normalization, and Referential Integrity.

## 🗄️ Database Schema Model
The database consists of 5 normalized tables:
1. `Customers` - Tracks customer demographics (Name, City).
2. `Categories` - Product classifications (Electronics, Clothing, etc.).
3. `Products` - Stores product pricing, category mappings, and current stock status.
4. `Orders` - Records high-level transactional details (Order Date, Customer ID).
5. `OrderItems` - Line-level details mapping quantities to specific orders.
