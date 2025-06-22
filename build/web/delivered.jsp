<%@ page import="java.sql.*" %>
<%
    String role = (String) session.getAttribute("roles");

    if (role == null || !"customer".equals(role)) {
        response.sendRedirect("login.jsp");
        return;
    }

    String purchaseidStr = request.getParameter("purchaseid");

    if (purchaseidStr != null && !purchaseidStr.isEmpty()) {
        int purchaseid = Integer.parseInt(purchaseidStr);

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ecommerce", "root", "admin");

            // Only update if the current status is 'Shipped'
            PreparedStatement checkStatus = con.prepareStatement("SELECT purchasestatus FROM purchase WHERE purchaseid = ?");
            checkStatus.setInt(1, purchaseid);
            ResultSet rs = checkStatus.executeQuery();

            if (rs.next()) {
                String currentStatus = rs.getString("purchasestatus");
                if ("Shipped".equalsIgnoreCase(currentStatus)) {
                    PreparedStatement ps = con.prepareStatement("UPDATE purchase SET purchasestatus = 'Delivered' WHERE purchaseid = ?");
                    ps.setInt(1, purchaseid);
                    ps.executeUpdate();
                    ps.close();
                }
            }

            rs.close();
            checkStatus.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    response.sendRedirect("purchasecust.jsp");
%>
