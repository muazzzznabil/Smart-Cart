<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    HttpSession existingSession = request.getSession(false);
    if (existingSession != null) {
        Integer createdBy = (Integer) existingSession.getAttribute("createdBy");
        Integer lastModifiedBy = (Integer) existingSession.getAttribute("lastModifiedBy");
        String categoryName = request.getParameter("categoryName");

        if (createdBy != null && lastModifiedBy != null && categoryName != null && !categoryName.isEmpty()) {
            LocalDateTime currentDateTime = LocalDateTime.now();

            String url = "jdbc:mysql://localhost:3306/ecommerce";
            String user = "root";
            String password = "admin";

            try {
                Connection conn = DriverManager.getConnection(url, user, password);

                String insertQuery = "INSERT INTO productcategory (categoryName, creationDate, lastModifiedDate, createdBy, lastModifiedBy) VALUES (?, ?, ?, ?, ?)";
                PreparedStatement pstmt = conn.prepareStatement(insertQuery);
                pstmt.setString(1, categoryName);
                pstmt.setTimestamp(2, Timestamp.valueOf(currentDateTime));
                pstmt.setTimestamp(3, Timestamp.valueOf(currentDateTime));
                pstmt.setInt(4, createdBy);
                pstmt.setInt(5, lastModifiedBy);

                pstmt.executeUpdate();

                conn.close();
                response.sendRedirect("productCategoryList.jsp");
            } catch (SQLIntegrityConstraintViolationException e) {
%>
<script type="text/javascript">
    alert("Sorry, the product category is already entered.");
    window.history.back();
</script>
<%
} catch (SQLException e) {
    e.printStackTrace();
%>
<script type="text/javascript">
    alert("An error occurred. Please try again.");
    window.location.href = "productCategory.jsp"; // Redirect to the form
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