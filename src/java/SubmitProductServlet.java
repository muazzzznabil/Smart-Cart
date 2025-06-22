
import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@WebServlet("/SubmitProductServlet")
@MultipartConfig
public class SubmitProductServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private static final String UPLOAD_DIRECTORY = "uploads";
    private static final String DB_URL = "jdbc:mysql://localhost:3306/ecommerce";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "admin";
    private static final String[] ALLOWED_IMAGE_TYPES = {"image/jpeg", "image/png"};

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get parameters
        String productName = request.getParameter("productName");
        String description = request.getParameter("description");
        String priceStr = request.getParameter("price");
        String categoryidStr = request.getParameter("categoryid");
        Part filePart = request.getPart("photo");

        // Basic validation
        if (productName == null || productName.isEmpty()
                || priceStr == null || priceStr.isEmpty()
                || categoryidStr == null || categoryidStr.isEmpty()
                || filePart == null) {
            sendAlert(response, "All fields are required.");
            return;
        }

        double price;
        int categoryid;
        try {
            price = Double.parseDouble(priceStr);
            categoryid = Integer.parseInt(categoryidStr);
        } catch (NumberFormatException e) {
            sendAlert(response, "Price and category ID must be valid numbers.");
            return;
        }

        // Validate image file type
        if (!isImageFile(filePart)) {
            sendAlert(response, "Unsupported file type. Please upload only JPEG or PNG images.");
            return;
        }

        // Save file to disk
        String fileName = getFileName(filePart);
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }
        String filePath = uploadPath + File.separator + fileName;
        filePart.write(filePath);

        // Get session or hardcoded createdBy (replace with real user/session management)
        HttpSession existingSession = request.getSession(false);
        if (existingSession != null) {
            Integer createdBy = (Integer) existingSession.getAttribute("createdBy");
            Integer lastModifiedBy = (Integer) existingSession.getAttribute("lastModifiedBy");
            java.sql.Timestamp now = new java.sql.Timestamp(System.currentTimeMillis());

            // Save product info to DB
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

                String query = "INSERT INTO product (productName, description, price, photo, categoryid, createdAt, createdBy, lastModifiedBy) "
                        + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

                PreparedStatement pst = con.prepareStatement(query);
                pst.setString(1, productName);
                pst.setString(2, description);
                pst.setDouble(3, price);
                pst.setString(4, fileName);  // Storing filename, not blob
                pst.setInt(5, categoryid);
                pst.setTimestamp(6, now);
                pst.setInt(7, createdBy);
                pst.setInt(8, lastModifiedBy);

                int rows = pst.executeUpdate();
                pst.close();
                con.close();

                if (rows > 0) {
                    response.sendRedirect("productList.jsp");
                } else {
                    sendAlert(response, "Failed to save product to database.");
                }
            } catch (Exception e) {
                e.printStackTrace();
                sendAlert(response, "Server error: " + e.getMessage());
            }
        }
    }
    

    private boolean isImageFile(Part part) {
        String contentType = part.getContentType();
        for (String allowedType : ALLOWED_IMAGE_TYPES) {
            if (contentType.equalsIgnoreCase(allowedType)) {
                return true;
            }
        }
        return false;
    }

    private String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        for (String cd : contentDisposition.split(";")) {
            if (cd.trim().startsWith("filename")) {
                String filename = cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
                return filename.substring(filename.lastIndexOf(File.separator) + 1);
            }
        }
        return null;
    }

    private void sendAlert(HttpServletResponse response, String message) throws IOException {
        String alertScript = "<script>alert('" + message + "'); window.location.href='product.jsp';</script>";
        response.setContentType("text/html");
        response.getWriter().println(alertScript);
    }
}
