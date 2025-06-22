<%@ page import="java.util.*, java.sql.*" %>
<%
    String role = (String) session.getAttribute("roles");
    Integer userid = (Integer) session.getAttribute("userid");

    if (role == null || !"customer".equals(role)) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Map<String, String>> purchases = new ArrayList<>();

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ecommerce", "root", "admin");

        PreparedStatement ps = con.prepareStatement("SELECT p.purchaseid, pr.productname, p.productquantity, p.address, p.creationDate, p.purchasestatus FROM purchase p JOIN product pr ON p.productid = pr.productid WHERE p.userid = ?");
        ps.setInt(1, userid);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Map<String, String> row = new HashMap<>();
            row.put("purchaseid", rs.getString("purchaseid"));
            row.put("productname", rs.getString("productname"));
            row.put("quantity", rs.getString("productquantity"));
            row.put("address", rs.getString("address"));
            row.put("date", rs.getString("creationDate"));
            row.put("status", rs.getString("purchasestatus"));
            purchases.add(row);
        }

        rs.close();
        ps.close();
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>My Purchases - Bludd Culture</title>
        <link rel="stylesheet" href="assets/css/styles.css">
        <style>
            .purchase-section {
                padding: 30px;
                max-width: 90%;
                margin: auto;
            }

            .purchase-section h1 {
                text-align: center;
                color: #E23A48;
                margin-bottom: 30px;
            }

            .purchase-table {
                width: 100%;
                border-collapse: collapse;
                background-color: #fff;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }

            .purchase-table th, .purchase-table td {
                padding: 14px 16px;
                border-bottom: 1px solid #ddd;
            }

            .purchase-table th {
                background-color: #E23A48;
                color: white;
                text-align: left;
            }

            .purchase-table tr:hover {
                background-color: #f9f9f9;
            }

            .no-purchases {
                text-align: center;
                color: #666;
                font-size: 18px;
                margin-top: 20px;
            }
            .navbar a.active {
                background-color: #E23A48;
                color: white;
            }
            .deliver-btn {
                background-color: #4CAF50;
                color: white;
                border: none;
                padding: 6px 12px;
                margin-left: 10px;
                border-radius: 4px;
                cursor: pointer;
                font-size: 14px;
            }

            .deliver-btn:hover {
                background-color: #45a049;
            }
        </style>
    </head>
    <body>

        <div class="navbar">
            <a href="index.jsp">Home</a>
            <a href="latest-news.jsp">Latest News</a>
            <a href="events.jsp">Events</a>
            <a href="shop.jsp">Shop</a>
            <a href="about.jsp">About</a>
            <a href="contact.jsp">Contact</a>
        </div>

        <div class="purchase-section">
            <h1>My Purchase History</h1>

            <%
                if (purchases.isEmpty()) {
            %>
            <div class="no-purchases">You haven't made any purchases yet.</div>
            <%
            } else {
            %>
            <table class="purchase-table">
                <tr>
                    <th>Product</th>
                    <th>Quantity</th>
                    <th>Address</th>
                    <th>Date</th>
                    <th>Status</th>
                    <th>Action<th>
                </tr>
                <%
                    for (Map<String, String> purchase : purchases) {
                %>
                <tr>
                    <td><%= purchase.get("productname")%></td>
                    <td><%= purchase.get("quantity")%></td>
                    <td><%= purchase.get("address")%></td>
                    <td><%= purchase.get("date")%></td>
                    <td><%= purchase.get("status")%></td>
                    <td>
                        <% if ("shipped".equalsIgnoreCase(purchase.get("status"))) {%>
                        <form method="post" action="delivered.jsp" style="display:inline;">
                            <input type="hidden" name="purchaseid" value="<%= purchase.get("purchaseid")%>">
                            <button type="submit" class="deliver-btn">Mark as Delivered</button>
                        </form>
                        <% } else { %>
                        <em>N/A</em>
                        <% } %>
                    </td>
                </tr>
                <%
                    }
                %>
            </table>
            <%
                }
            %>
        </div>

        <!-- Footer -->
        <div class="footer">
            <p>&copy; 2024 Bludd Culture. All Rights Reserved.</p>
        </div>

    </body>
</html>
