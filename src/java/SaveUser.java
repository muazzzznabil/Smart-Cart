
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;

public class SaveUser extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String userpassword = request.getParameter("userpassword");
        String ic_number = request.getParameter("ic_number");
        String fullname = request.getParameter("fullname");
        String phone_number = request.getParameter("phone_number");
        String roles = request.getParameter("roles");
        
        User e = new User();
        e.setUsername(username);
        e.setEmail(email);
        e.setUserpassword(userpassword);
        e.setIc_number(ic_number);
        e.setFullname(fullname);
        e.setPhone_number(phone_number);
        e.setRoles(roles);

        try {
            int status = UserDao.save(e);
            if (status > 0) {
                if (roles.equals ("admin")){
                response.sendRedirect("loginadmin.jsp");
                }
                
                else if(roles.equals ("customer")){
                response.sendRedirect("login.jsp");
                }
            } else {
                out.println("Sorry! Unable to save record");
            }
        } catch (SQLException ex) {
            String message = "Error: " + ex.getMessage();
            if (ex.getMessage().contains("Duplicate entry")) {
                if (ex.getMessage().contains("username")) {
                    message = "Error: Username already exists!";
                } else if (ex.getMessage().contains("email")) {
                    message = "Error: Email already exists!";
                } else if (ex.getMessage().contains("ic_number")) {
                    message = "Error: IC number already exists!";
                } else if (ex.getMessage().contains("phone_number")) {
                    message = "Error: Phone number already exists!";
                }
            }
            out.println("<script type=\"text/javascript\">");
            out.println("alert('" + message + "');");
            out.println("location='register.jsp';");
            out.println("</script>");
        } finally {
            out.close();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
