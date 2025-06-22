
import java.sql.*;
import java.util.*;
import java.sql.SQLException;

public class UserDao {

    public static Connection getConnection() {
        Connection con = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ecommerce", "root", "admin");
        } catch (Exception ex) {
            System.out.println(ex);
        }
        return con;
    }

    public static int save(User e) throws SQLException {
        int status = 0;
        try {
            Connection con = UserDao.getConnection();
            PreparedStatement ps = con.prepareStatement("insert into users (username, email, userpassword, ic_number, fullname, phone_number, roles) values(?,?,?,?,?,?,?)");
            ps.setString(1, e.getUsername());
            ps.setString(2, e.getEmail());
            ps.setString(3, e.getUserpassword());
            ps.setString(4, e.getIc_number());
            ps.setString(5, e.getFullname());
            ps.setString(6, e.getPhone_number());
            ps.setString(7, e.getRoles());

            status = ps.executeUpdate();
            con.close();
        } catch (SQLException ex) {
            throw ex;
        }
        return status;
    }

    public static int update(User e) {
        int status = 0;
        try {
            Connection con = UserDao.getConnection();

            PreparedStatement ps = con.prepareStatement("update users set username=?, email=?,userpassword=?,ic_number=?,fullname=?,phone_number=?,roles=? where userid=?");
            ps.setString(1, e.getUsername());
            ps.setString(2, e.getEmail());
            ps.setString(3, e.getUserpassword());
            ps.setString(4, e.getIc_number());
            ps.setString(5, e.getFullname());
            ps.setString(6, e.getPhone_number());
            ps.setString(7, e.getRoles());
            ps.setInt(8, e.getUserid());

            status = ps.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return status;
    }

    public static User getUserByUserid(int userid) {
        User user = new User();

        try {
            Connection con = UserDao.getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM users WHERE userid=?");
            ps.setInt(1, userid);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Map<String, String> userData = new HashMap<>();
                userData.put("userid", String.valueOf(rs.getInt("userid")));
                userData.put("username", rs.getString("username"));
                userData.put("email", rs.getString("email"));
                userData.put("userpassword", rs.getString("userpassword"));
                userData.put("ic_number", rs.getString("ic_number"));
                userData.put("fullname", rs.getString("fullname"));
                userData.put("phone_number", rs.getString("phone_number"));
                userData.put("roles", rs.getString("roles"));

                user.setUserid(Integer.parseInt(userData.get("userid")));
                user.setUsername(userData.get("username"));
                user.setEmail(userData.get("email"));
                user.setUserpassword(userData.get("userpassword"));
                user.setIc_number(userData.get("ic_number"));
                user.setFullname(userData.get("fullname"));
                user.setPhone_number(userData.get("phone_number"));
                user.setRoles(userData.get("roles"));
            }
            con.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return user;
    }

    public static List<User> getAllUsers() {
        List<User> list = new ArrayList<User>();

        try {
            Connection con = UserDao.getConnection();
            PreparedStatement ps = con.prepareStatement("select * from users");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                User e = new User();
                e.setUserid(rs.getInt(1));
                e.setUsername(rs.getString(2));
                e.setEmail(rs.getString(3));
                e.setUserpassword(rs.getString(4));
                e.setIc_number(rs.getString(5));
                e.setFullname(rs.getString(6));
                e.setPhone_number(rs.getString(7));
                e.setRoles(rs.getString(8));

                list.add(e);
            }
            con.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }
}
