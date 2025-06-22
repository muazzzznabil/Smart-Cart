<%@ page import="javax.servlet.http.HttpSession" %>
<%
    Integer userid = (Integer) session.getAttribute("userid");
    if (userid == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<h2>Enter Your Address</h2>
<form action="SaveAddress" method="post">
    <label>Label (e.g. Home, Office):</label>
    <input type="text" name="label" required><br>

    <label>Address:</label>
    <textarea name="address" required></textarea><br>

    <label>City:</label>
    <input type="text" name="city" required><br>

    <label>Postcode:</label>
    <input type="text" name="postcode" required><br>

    <label>State:</label>
    <input type="text" name="state" required><br>

    <label>Country:</label>
    <input type="text" name="country" value="Malaysia"><br>

    <label>Default Address?</label>
    <input type="checkbox" name="is_default" value="true"><br>

    <input type="submit" value="Save Address">
</form>
