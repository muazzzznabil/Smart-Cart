<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*, javax.naming.InitialContext, javax.sql.DataSource" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Delete Category</title>
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/css/style.css">
    <script src="assets/js/jquery-3.5.1.min.js"></script>
    <script src="assets/js/popper.min.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>
</head>
<body>

<%
    // Get categoryid from request parameter
    String categoryidString = request.getParameter("categoryid");
    if (categoryidString != null && !categoryidString.isEmpty()) {
        int categoryid = Integer.parseInt(categoryidString);
        
        // Database connection parameters
        String url = "jdbc:mysql://localhost:3306/ecommerce";
        String username = "root";
        String password = "admin";
        
        Connection con = null;
        PreparedStatement ps = null;
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(url, username, password);
            
            String sql = "DELETE FROM productcategory WHERE categoryid = ?";
            ps = con.prepareStatement(sql);
            ps.setInt(1, categoryid);
            
            int rowsDeleted = ps.executeUpdate();
            if (rowsDeleted > 0) {
                
%>
                <div class="modal fade show" id="successModal" tabindex="-1" role="dialog" aria-labelledby="successModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="successModalLabel">Category Deleted Successfully</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <p>Category with ID <%= categoryid %> deleted successfully.</p>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-primary" onclick="window.location.href='productCategoryList.jsp';">Back to Categories</button>
                            </div>
                        </div>
                    </div>
                </div>
                <script>
                    // Show the success modal
                    $(document).ready(function() {
                        $('#successModal').modal('show');
                    });
                </script>
<%
            } else {
                out.println("<div class='container mt-5'>");
                out.println("<h3>Failed to delete category with ID " + categoryid + "</h3>");
                out.println("<a href='productCategoryList.jsp' class='btn btn-primary'>Back to Categories</a>");
                out.println("</div>");
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            out.println("Error: " + e.getMessage());
        } finally {
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    } else {
        out.println("<div class='container mt-5'>");
        out.println("<h3>Missing categoryid parameter</h3>");
        out.println("<a href='productCategoryList.jsp' class='btn btn-primary'>Back to Categories</a>");
        out.println("</div>");
    }
%>

</body>
</html>