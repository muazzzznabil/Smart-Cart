<%@ page import="java.sql.*, java.io.*, java.time.LocalDateTime" %>
<%@ page import="javax.servlet.http.HttpSession, javax.servlet.http.Part" %>
<%
    HttpSession existingSession = request.getSession(false);
    if (existingSession != null) {
        Integer createdBy = (Integer) existingSession.getAttribute("createdBy");
        Integer lastModifiedBy = (Integer) existingSession.getAttribute("lastModifiedBy");
        String productName = request.getParameter("productName");
        String description = request.getParameter("description");
        String priceStr = request.getParameter("price");
        Double price = Double.parseDouble(priceStr.trim());
        Integer categoryid = Integer.parseInt(request.getParameter("categoryid"));
        Part filePart = request.getPart("photo");
        System.out.println("Price param = " + price); // for debugging
        if (createdBy != null && lastModifiedBy != null && categoryid != null) {
            LocalDateTime currentDateTime = LocalDateTime.now();

            try {
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ecommerce", "root", "admin");

                InputStream photoStream = filePart.getInputStream();

                String insertQuery = "INSERT INTO product (productName, description, price, photo, categoryid, creationDate, lastModifiedDate, createdBy, lastModifiedBy) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
                PreparedStatement pstmt = conn.prepareStatement(insertQuery);
                pstmt.setString(1, productName);
                pstmt.setString(2, description);
                pstmt.setDouble(3, price);
                pstmt.setBlob(4, photoStream);
                pstmt.setInt(5, categoryid);
                pstmt.setTimestamp(6, Timestamp.valueOf(currentDateTime));
                pstmt.setTimestamp(7, Timestamp.valueOf(currentDateTime));
                pstmt.setInt(8, createdBy);
                pstmt.setInt(9, lastModifiedBy);

                pstmt.executeUpdate();
                conn.close();

                response.sendRedirect("productList.jsp");

            } catch (SQLIntegrityConstraintViolationException e) {
%>
<script>
    alert("Sorry, this product is already registered.");
    window.history.back();
</script>
<%
} catch (SQLException e) {
    e.printStackTrace();
%>
<script>
    alert("Database error occurred. Please try again.");
    window.location.href = "product.jsp";
</script>
<%
            }
        } else {
            response.sendRedirect("error.jsp");
        }
    } else {
        response.sendRedirect("loginadmin.jsp");
    }
%>
