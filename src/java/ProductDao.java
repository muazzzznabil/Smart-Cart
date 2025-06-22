
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class ProductDao {

    private Connection con;

    public ProductDao(Connection con) {
        this.con = con;
    }

    public boolean addProduct(Product product) {
        boolean added = false;
        PreparedStatement pst = null;

        try {
            String query = "INSERT INTO product (productName, description, price, photo, categoryid, createdAt, createdBy, lastModifiedBy) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            pst = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            pst.setString(1, product.getProductName());
            pst.setString(2, product.getDescription());
            pst.setDouble(3, product.getPrice());
            pst.setBlob(4, product.getPhoto());
            pst.setInt(5, product.getCategoryid());
            pst.setTimestamp(6, product.getCreatedAt());
            pst.setInt(7, product.getCreatedBy());
            pst.setInt(8, product.getLastModifiedBy());

            int rowsAffected = pst.executeUpdate();

            if (rowsAffected > 0) {
                added = true;
                ResultSet rs = pst.getGeneratedKeys();
                if (rs.next()) {
                    product.setProductid(rs.getInt(1));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closePreparedStatement(pst);
        }
        return added;
    }

    // Helper method to close PreparedStatement
    private void closePreparedStatement(PreparedStatement pst) {
        if (pst != null) {
            try {
                pst.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

}
