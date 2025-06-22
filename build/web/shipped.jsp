<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String purchaseidParam = request.getParameter("purchaseid");

    if (purchaseidParam != null && !purchaseidParam.isEmpty()) {
        int purchaseid = Integer.parseInt(purchaseidParam);
        String url = "jdbc:mysql://localhost:3306/ecommerce";
        String dbUser = "root";
        String dbPass = "admin";

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection(url, dbUser, dbPass);

            // Check if purchase exists and get current status
            String checkQuery = "SELECT purchasestatus FROM purchase WHERE purchaseid = ?";
            PreparedStatement checkStmt = con.prepareStatement(checkQuery);
            checkStmt.setInt(1, purchaseid);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                String currentStatus = rs.getString("purchasestatus");

                if ("Shipped".equalsIgnoreCase(currentStatus)) {
%>
<script>
    alert("Item has already been shipped.");
    window.location.href = "purchaseList.jsp";
</script>
<%
} else {
    // Update the status to 'Shipped'
    String updateQuery = "UPDATE purchase SET purchasestatus = 'Shipped' WHERE purchaseid = ?";
    PreparedStatement updateStmt = con.prepareStatement(updateQuery);
    updateStmt.setInt(1, purchaseid);
    int result = updateStmt.executeUpdate();

    if (result > 0) {
%>
<script>
    alert("Purchase status updated to 'Shipped' successfully.");
    window.location.href = "purchaseList.jsp";
</script>
<%
} else {
%>
<script>
    alert("Failed to update purchase status.");
    window.location.href = "purchaseList.jsp";
</script>
<%
        }
        updateStmt.close();
    }
} else {
%>
<script>
    alert("Purchase ID not found.");
    window.location.href = "purchaseList.jsp";
</script>
<%
    }

    rs.close();
    checkStmt.close();
    con.close();

} catch (Exception e) {
    e.printStackTrace();
%>
<script>
    alert("An error occurred. Please try again.");
    window.location.href = "purchaseList.jsp";
</script>
<%
    }

} else {
%>
<script>
    alert("Invalid purchase ID.");
    window.location.href = "purchaseList.jsp";
</script>
<%
    }
%>
