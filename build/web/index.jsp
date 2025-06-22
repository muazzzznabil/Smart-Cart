<%-- 
    Document   : index
    Created on : 9 Jun 2025, 16:38:58
    Author     : Nomi
--%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Base64" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Bludd Culture - Home</title>
        <link rel="stylesheet" href="assets/css/styles.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    </head>
    <body>

        <!-- Logo Section -->
        <div class="logo">
            <a href="index.jsp">
                <img src="assets/img/logo.png" alt="Bludd Culture Logo" class="logo-img">
            </a>
        </div>

        <!-- Navigation Bar -->
        <div class="navbar">
            <a href="https://www.instagram.com/bldculture/" target="_blank">
                <i class="fab fa-instagram"></i>
            </a>

            <!-- Shopping Cart Icon -->
            <a href="purchasecust.jsp">
                <i class="fas fa-shopping-cart"></i>
            </a>

            <a href="index.jsp">Home</a>
            <a href="latest-news.jsp">Latest News</a>
            <a href="events.jsp">Events</a>
            <a href="shop.jsp">Shop</a>
            <a href="about.jsp">About</a>
            <a href="contact.jsp">Contact</a>

            <%
                String username = (String) session.getAttribute("username");
                if (username != null) {
            %>
            <a href="logoutcust" style="font-weight: bold; color: white;">Logout</a>
            <%
            } else {
            %>
            <a href="login.jsp" style="font-weight: bold; color: white;">Login</a>
            <%
                }
            %>


        </div>


        <!-- Hero Section -->
        <div class="hero">
            <div>
                <h1>Welcome to Bludd Culture</h1>
                <p>Discover the style that defines our culture.</p>
                <!-- Link the button to the Shop page -->
                <a href="shop.jsp">
                    <button>Explore Now</button>
                </a>
            </div>
        </div>

        <!-- About Section -->
        <div class="section">
            <h2>About Us</h2>
            <p>Bludd Culture is where creativity meets fashion and community thrives.</p>
            <img src="assets/img/about-image.jpg" alt="About Bludd Culture">
        </div>

        <!-- Image Grid Section -->
        <div class="section">
            <h2>Our Latest Collections</h2>
            <div class="image-grid">
                <a href="shop.jsp">
                    <img src="assets/img/image1.jpg" alt="Collection 1">
                </a>
                <a href="shop.jsp">
                    <img src="assets/img/image2.jpg" alt="Collection 2">
                </a>
                <a href="shop.jsp">
                    <img src="assets/img/image3.jpg" alt="Collection 3">
                </a>
            </div>
        </div>

        <!-- Footer -->
        <div class="footer">
            <p>&copy; 2024 Bludd Culture. All Rights Reserved.</p>
        </div>

    </body>
</html>
