
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String userpassword = request.getParameter("userpassword");
        String roles = request.getParameter("roles");
        int userid = getUserid(username);
        


//        debug
//        System.out.println("Login Attempt:");
//        System.out.println("Username: " + username);
//        System.out.println("Password: " + userpassword);
//        System.out.println("Role: " + roles);
        boolean isAuthenticated = authenticate(username, userpassword);

        if (isAuthenticated) {
            String fullname = getUserFullName(username);

            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            session.setAttribute("fullname", fullname);
            session.setAttribute("roles", roles);
           


            int lastModifiedBy = getUserid(username);
            int createdBy = getUserid(username);
            session.setAttribute("lastModifiedBy", lastModifiedBy);
            session.setAttribute("createdBy", createdBy);
            session.setAttribute("userid", userid);


            if ("customer".equals(roles)) {
                response.sendRedirect("index.jsp");
            } else if ("admin".equals(roles)) {
                response.sendRedirect("dashboard.jsp");
            }

        } else {
            if ("admin".equals(roles)) {
                response.sendRedirect("loginadmin.jsp?error=1");
            } else if ("customer".equals(roles)) {
                response.sendRedirect("login.jsp?error=1");
            }
        }
    }

    private boolean authenticate(String username, String userpassword) {
        boolean authenticated = false;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ecommerce", "root", "admin");
            String query = "SELECT * FROM users WHERE username = ? AND userpassword = ?";
            ps = con.prepareStatement(query);
            ps.setString(1, username);
            ps.setString(2, userpassword);
            rs = ps.executeQuery();
            authenticated = rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {

            try {
                if (rs != null) {
                    rs.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                if (ps != null) {
                    ps.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return authenticated;
    }

    // Method to retrieve user role from the database
    private String getUserRole(String username) {
        String roles = "";
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            // Your database connection code
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ecommerce", "root", "admin");
            String query = "SELECT roles FROM users WHERE username = ?";
            ps = con.prepareStatement(query);
            ps.setString(1, username);
            rs = ps.executeQuery();
            if (rs.next()) {
                roles = rs.getString("roles");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close resources
            try {
                if (rs != null) {
                    rs.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                if (ps != null) {
                    ps.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return roles;
    }

    // Method to retrieve user full name from the database
    private String getUserFullName(String username) {
        String fullname = "";
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ecommerce", "root", "admin");
            String query = "SELECT fullname FROM users WHERE username = ?";
            ps = con.prepareStatement(query);
            ps.setString(1, username);
            rs = ps.executeQuery();
            if (rs.next()) {
                fullname = rs.getString("fullname");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                if (ps != null) {
                    ps.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return fullname;
    }

    private int getUserid(String username) {
        int userid = 0;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ecommerce", "root", "admin");
            String query = "SELECT userid FROM users WHERE username = ?";
            ps = con.prepareStatement(query);
            ps.setString(1, username);
            rs = ps.executeQuery();
            if (rs.next()) {
                userid = rs.getInt("userid");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                if (ps != null) {
                    ps.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return userid;
    }
}
