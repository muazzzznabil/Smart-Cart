<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    if (session == null || session.getAttribute("userid") == null) {
        response.sendRedirect("login.jsp"); // Redirect if not logged in
        return;
    }

    int userid = (Integer) session.getAttribute("userid");
    String fullName = "";

    Connection con = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ecommerce", "root", "admin");

        // Get user's full name
        PreparedStatement ps = con.prepareStatement("SELECT fullname FROM users WHERE userid = ?");
        ps.setInt(1, userid);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            fullName = rs.getString("fullname");
        }

        rs.close();
        ps.close();
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (con != null) {
            con.close();
        }
    }
%>


<%
    String productIdParam = request.getParameter("productid");
    String productName = "";
    double price = 0;

    List<String> sizes = new ArrayList<>();

    if (productIdParam != null && !productIdParam.isEmpty()) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ecommerce", "root", "admin");

            // Fetch product details
            PreparedStatement ps = con.prepareStatement("SELECT productName, price FROM product WHERE productid = ?");
            ps.setInt(1, Integer.parseInt(productIdParam));
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                productName = rs.getString("productName");
                price = rs.getDouble("price");
            } else {
                productName = "Product Not Found";
            }

            rs.close();
            ps.close();

            // Fetch available sizes
            ps = con.prepareStatement("SELECT DISTINCT size FROM inventory WHERE productid = ?");
            ps.setInt(1, Integer.parseInt(productIdParam));
            rs = ps.executeQuery();

            while (rs.next()) {
                sizes.add(rs.getString("size"));
            }

            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (con != null) {
                con.close();
            }
        }
    } else {
        productName = "No product selected";
    }
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Bludd Culture - Checkout</title>
        <link rel="stylesheet" href="assets/css/styles.css">
    </head>
    <body>
        <div class="logo">
            <a href="index.jsp"><img src="assets/img/logo.png" alt="Bludd Culture Logo" class="logo-img" /></a>
        </div>

        <div class="navbar">
            <a href="index.jsp">Home</a>
            <a href="latest-news.jsp">Latest News</a>
            <a href="events.jsp">Events</a>
            <a href="shop.jsp">Shop</a>
            <a href="about.jsp">About</a>
            <a href="contact.jsp">Contact</a>
        </div>
        <br><br>

        <div class="checkout-section">
            <h1>Checkout</h1>
            <form action="SubmitCheckout.jsp" method="POST">
                <!-- Product Info -->
                <div class="form-group">
                    <label>Product</label>
                    <input type="text" name="product-name" value="<%= productName%>" readonly>
                </div>

                <!-- Quantity -->
                <div class="form-group">
                    <label for="quantity">Quantity</label>
                    <input type = "number" id = "purchasequantity" name="purchasequantity" required>
                </div>

                <!-- Price -->
                <div class="form-group">
                    <label for="total-amount">Total Amount</label>
                    <input type="text" id="total-amount" name="total-amount" value="RM<%= String.format("%.2f", price)%>" readonly />
                </div>

                <!-- Size -->
                <div class="form-group">
                    <label for="size">Size</label>
                    <select id="size" name="size" required onchange="fetchStock(<%= productIdParam%>, this.value)">
                        <option value="">Select Size</option>
                        <% for (String size : sizes) {%>
                        <option value="<%= size%>"><%= size%></option>
                        <% }%>
                    </select>
                </div>

                <!-- Full Name (auto-filled from session) -->
                <div class="form-group">
                    <label>Full Name</label>
                    <input type="text" name="full-name" value="<%= fullName%>" readonly>
                </div>

                <div class="form-group">
                    <label>Address</label>
                    <textarea name="address" required></textarea>
                </div>
                
                <!-- Submit -->
                <div class="form-group">
                    <button type="submit">Place Order</button>
                </div>
            </form>
        </div>

        <script>
            const basePrice = <%= price%>;

            function fetchStock(productId, size) {
                fetch(`get-stock?productId=${productId}&size=${size}`)
                        .then(res =>res.json())
                        .then(data => {
                            const maxQty = data.quantity;
                            const qtySelect = document.getElementById("quantity");
                            qtySelect.innerHTML = "";

                            if (maxQty === 0) {
                                const opt = document.createElement("option");
                                opt.text = "Out of stock";
                                opt.disabled = true;
                                qtySelect.appendChild(opt);
                                updateAmount(0);
                            } else {
                                for (let i = 1; i <= maxQty; i++) {
                                    const opt = document.createElement("option");
                                    opt.value = i;
                                    opt.text = i;
                                    qtySelect.appendChild(opt);
                                }
                                updateAmount(1); // default to 1
                            }
                        });
            }

            document.getElementById("purchasequantity").addEventListener("change", () => {
                const purchasequantity = document.getElementById("purchasequantity").value;
                updateAmount(purchasequantity);
            });

            function updateAmount(purchasequantity) {
                const total = basePrice * purchasequantity;
                document.getElementById("total-amount").value = "RM" + total.toFixed(2);
            }
        </script>
    </body>
</html>
