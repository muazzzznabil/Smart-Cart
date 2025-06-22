<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    if (session == null || session.getAttribute("userid") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int userid = (Integer) session.getAttribute("userid");
    String productName = request.getParameter("product-name");
    String quantityStr = request.getParameter("purchasequantity");
    String address = request.getParameter("address");
    String size = request.getParameter("size");

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    int productId = 0;
    int quantity = 0;

    try {
        quantity = Integer.parseInt(quantityStr);
    } catch (NumberFormatException e) {
        quantity = 1; // default fallback
    }

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ecommerce", "root", "admin");

        // Step 1: Get product ID by name (if needed)
        ps = con.prepareStatement("SELECT productid FROM product WHERE productName = ?");
        ps.setString(1, productName);
        rs = ps.executeQuery();

        if (rs.next()) {
            productId = rs.getInt("productid");
        } else {
            throw new Exception("Product not found");
        }

        rs.close();
        ps.close();

        // Step 2: Insert into purchase table
        ps = con.prepareStatement("INSERT INTO purchase (productid, productquantity, address, userid) VALUES (?, ?, ?, ?)");
        ps.setInt(1, productId);
        ps.setInt(2, quantity);
        ps.setString(3, address);
        ps.setInt(4, userid);

        int result = ps.executeUpdate();

        if (result > 0) {
            response.sendRedirect("checkout-success.jsp");
        } else {
            response.sendRedirect("checkout-failed.jsp");
        }

        ps.close();
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("checkout-failed.jsp");
    } finally {
        if (con != null) try { con.close(); } catch (Exception ignore) {}
    }
%>
s