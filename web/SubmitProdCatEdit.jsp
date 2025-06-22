<%@ page import="java.sql.*, java.time.LocalDateTime, javax.servlet.http.HttpSession" %>
<%@ page import="java.io.*" %>

<%
    HttpSession existingSession = request.getSession(false);
    if (existingSession != null) {
        Integer lastModifiedBy = (Integer) existingSession.getAttribute("lastModifiedBy");
        String categoryid = request.getParameter("categoryid");
        String categoryName = request.getParameter("categoryName");

        if (lastModifiedBy != null && categoryid != null && categoryName != null && !categoryid.isEmpty() && !categoryName.isEmpty()) {
            Connection conn = null;
            PreparedStatement pstmt = null;

            try {
                String url = "jdbc:mysql://localhost:3306/ecommerce";
                String user = "root";
                String password = "admin";

                conn = DriverManager.getConnection(url, user, password);

                // Update query
                String updateQuery = "UPDATE productcategory SET categoryName=?, lastModifiedDate=?, lastModifiedBy=? WHERE categoryid=?";
                pstmt = conn.prepareStatement(updateQuery);
                pstmt.setString(1, categoryName);
                pstmt.setTimestamp(2, Timestamp.valueOf(LocalDateTime.now()));
                pstmt.setInt(3, lastModifiedBy);
                pstmt.setInt(4, Integer.parseInt(categoryid));

                int rowsUpdated = pstmt.executeUpdate();

                conn.close();

                if (rowsUpdated > 0) {
                    response.sendRedirect("productCategoryList.jsp"); // Redirect on successful update
                } else {
%>
<script type="text/javascript">
    alert("Sorry, the product category is already entered.");
    window.history.back();
</script>
<%
    }
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
    window.location.href = "category.jsp"; // Redirect to the form
</script>
<%
            }
        } else {
            response.sendRedirect("error.jsp"); // Redirect if parameters are missing or empty
        }
    } else {
        response.sendRedirect("login.jsp"); // Redirect if session is not valid
    }
%>