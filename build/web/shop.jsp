<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Shop - Bludd Culture</title>
    <link rel="stylesheet" href="assets/css/styles.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />
    <style>
        .product-grid {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
        }
        .product-card {
            border: 1px solid #ccc;
            border-radius: 5px;
            padding: 15px;
            width: 220px;
            text-align: center;
            background: #fff;
            transition: box-shadow 0.3s ease;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }
        .product-card:hover {
            box-shadow: 0 0 10px rgba(0,0,0,0.2);
        }
        .product-card img {
            width: 100%;
            height: auto;
            border-radius: 4px;
        }
        .product-card h3 {
            margin: 10px 0 5px 0;
            font-size: 18px;
        }
        .product-card p {
            color: #555;
            font-size: 15px;
        }
        .product-card .description {
            font-size: 14px;
            color: #777;
            margin: 8px 0;
            height: 40px;
            overflow: hidden;
        }
        .buy-btn {
            margin-top: 10px;
            padding: 8px 16px;
            background-color: #e23a48;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 14px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
        }
        .buy-btn:hover {
            background-color: #c12f3c;
        }
    </style>
</head>
<body>

    <!-- Header and Nav -->
    <div class="logo">
        <a href="index.jsp">
            <img src="assets/img/logo.png" alt="Bludd Culture Logo" class="logo-img" />
        </a>
    </div>

    <div class="navbar">
        <a href="https://www.instagram.com/bldculture/" target="_blank">
            <i class="fab fa-instagram"></i>
        </a>
        <a href="checkout.jsp"><i class="fas fa-shopping-cart"></i></a>
        <a href="index.jsp">Home</a>
        <a href="latest-news.jsp">Latest News</a>
        <a href="events.jsp">Events</a>
        <a href="shop.jsp">Shop</a>
        <a href="about.jsp">About</a>
        <a href="contact.jsp">Contact</a>
        <a href="login.jsp" style="font-weight: bold; color: white;">Login</a>
    </div>

    <!-- Shop Section -->
    <div class="section">
        <h2>Shop Now</h2>
        <div class="product-grid">

            <%
                Connection con = null;
                PreparedStatement ps = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ecommerce", "root", "admin");

                    String query = "SELECT productid, productName, price, photo, description FROM product ORDER BY createdAt DESC";
                    ps = con.prepareStatement(query);
                    rs = ps.executeQuery();

                    while (rs.next()) {
                        int productid = rs.getInt("productid");
                        String name = rs.getString("productName");
                        double price = rs.getDouble("price");
                        String photo = rs.getString("photo");
                        String description = rs.getString("description");

                        String imagePath = (photo != null && !photo.trim().isEmpty()) 
                            ? "uploads/" + photo 
                            : "assets/img/default.jpg";
            %>
                <div class="product-card">
                    <a href="checkout.jsp?productid=<%= productid %>">
                        <img src="<%= imagePath %>" alt="<%= name %>" />
                        <h3><%= name %></h3>
                    </a>
                    <p class="description"><%= (description != null && !description.isEmpty()) ? description : "No description available." %></p>
                    <p>RM <%= String.format("%.2f", price) %></p>
                    <a class="buy-btn" href="checkout.jsp?productid=<%= productid %>">Buy Now</a>
                </div>
            <%
                    }
                } catch (Exception e) {
                    out.println("<p>Error loading products: " + e.getMessage() + "</p>");
                    e.printStackTrace();
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (ps != null) ps.close();
                        if (con != null) con.close();
                    } catch (SQLException ex) {
                        ex.printStackTrace();
                    }
                }
            %>

        </div>
    </div>

    <!-- Footer -->
    <div class="footer">
        <p>&copy; 2024 Bludd Culture. All Rights Reserved.</p>
    </div>

</body>
</html>
