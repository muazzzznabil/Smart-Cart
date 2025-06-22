<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    HttpSession existingSession = request.getSession(false);
    if (existingSession != null) {
        Integer createdBy = (Integer) existingSession.getAttribute("createdBy");
        Integer lastModifiedBy = (Integer) existingSession.getAttribute("lastModifiedBy");
        Integer productid = Integer.parseInt(request.getParameter("productid"));
        String size = request.getParameter("size");
        Integer quantity = Integer.parseInt(request.getParameter("quantity"));

        if (createdBy != null && lastModifiedBy != null && productid != null){
                LocalDateTime currentDateTime = LocalDateTime.now();

                String url = "jdbc:mysql://localhost:3306/ecommerce";
                String user = "root";
                String password = "admin";

                try {
                    Connection conn = DriverManager.getConnection(url, user, password);

                    String insertQuery = "INSERT INTO inventory (productid, size, quantity, creationDate, lastModifiedDate, createdBy, lastModifiedBy) VALUES (?, ?, ?, ?, ?, ?, ?)";
                    PreparedStatement pstmt = conn.prepareStatement(insertQuery);
                    pstmt.setInt(1, productid);
                    pstmt.setString(2, size);
                    pstmt.setInt(3, quantity);
                    pstmt.setTimestamp(4, Timestamp.valueOf(currentDateTime));
                    pstmt.setTimestamp(5, Timestamp.valueOf(currentDateTime));
                    pstmt.setInt(6, createdBy);
                    pstmt.setInt(7, lastModifiedBy);

                    pstmt.executeUpdate();

                    conn.close();
                    response.sendRedirect("inventoryList.jsp");
                } catch (SQLIntegrityConstraintViolationException e) {
%>
<script type="text/javascript">
    alert("Sorry, the size is already entered fr the following product.");
    window.history.back();
</script>
<%
} catch (SQLException e) {
    e.printStackTrace();
%>
<script type="text/javascript">
    alert("An error occurred. Please try again.");
    window.location.href = "inventory.jsp"; // Redirect to the form
</script>
<%
            }
        } else {
            response.sendRedirect("error.jsp");
        }
    } else {
        response.sendRedirect("logindmin.jsp");
    }
%>