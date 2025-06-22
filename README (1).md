# 🛒 SmartCart: A Web-Based E-Commerce Application for Seamless Online Shopping

SmartCart is a web-based e-commerce system developed using Java EE technologies (JSP, Servlets, JDBC) and hosted on Apache Tomcat. It enables seamless interaction between customers and the system for browsing, purchasing, and managing products online. Admins can manage products, users, orders, and payments through the platform.

## 👥 Group Members and Module Responsibilities

| Module Name        | Responsible Member | CRUD Functionalities                                                                 |
|--------------------|--------------------|--------------------------------------------------------------------------------------|
| Product Management | Iman               | Add new products, edit existing listings, delete products, and view product details. |
| User Management    | Adam               | Handle user registration, profile updates, user deletion, and viewing user lists.    |
| Order Management   | Luqman             | Manage order placement, update order status, view order history, and cancel orders.  |
| Payment Management | Daniel             | Record payments, update payment status, manage refunds, and view payment transactions.|

---

## 🛠️ How to Run the Project Locally (Using Apache Tomcat)

To run the SmartCart project on your local machine:

1. **Prerequisites:**
   - NetBeans IDE (with Java EE support)
   - Apache Tomcat (configured in NetBeans)
   - MySQL Server
   - JDBC Driver (Connector/J)

2. **Setup Instructions:**
   - Clone the repository to your local machine:
     ```bash
     git clone https://github.com/case-1412/bludd.git
     ```
   - Open the project in NetBeans.
   - Create a MySQL database named `smartcart_db`.
   - Import the SQL dump file provided in the project to set up the tables and initial data.
   - Update your `DBConnection.java` file with your MySQL username and password.
   - Right-click the project in NetBeans > Run.
   - Make sure Tomcat server is running and correctly configured.

---

## 🛍️ How Customers Use SmartCart to Buy Products

SmartCart offers a smooth user experience for customers to shop online. Here's how it works:

1. **Browse Products**  
   Users can view a list of available products with details such as name, price, and description.

2. **Register or Log In**  
   Customers must register for an account or log in to place orders.

3. **Add to Cart**  
   Products can be added to the cart with a single click.

4. **View Cart & Checkout**  
   Users can view and modify their cart, then proceed to checkout.

5. **Place Order & Make Payment**  
   Orders are confirmed, and users proceed to the payment module. Payments are recorded and status updated.

6. **View Order History**  
   Customers can view previous orders and cancel any pending orders.

## 🛍️ How Admin Use SmartCart to Manage Products   

Admin Functionalities:
Product Management: Add, edit, or remove products from the store catalog.

User Management: View registered users and delete inappropriate or inactive accounts.

Order Management: Monitor all customer orders, update statuses (e.g., pending, shipped), or cancel orders.

Payment Monitoring: Track payment transactions, confirm payment statuses, and issue refunds if needed.
---

## 🔗 Live Demo

[Click here to view the live demo](https://case-1412.github.io/bludd/)

