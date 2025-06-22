<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.sql.*"%>
<%@ page import="com.model.Prods" %>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>INVENTORY LIST</title>
        <link rel="shortcut icon" type="image/x-icon" href="assets/img/favicon.png">
        <link rel="stylesheet" href="assets/css/bootstrap.min.css">
        <link rel="stylesheet" href="assets/plugins/fontawesome/css/fontawesome.min.css">
        <link rel="stylesheet" href="assets/plugins/fontawesome/css/all.min.css">
        <link rel="stylesheet" href="assets/css/feathericon.min.css">
        <link rel="stylehseet" href="https://cdn.oesmith.co.uk/morris-0.5.1.css">
        <link rel="stylesheet" href="assets/plugins/morris/morris.css">
        <link rel="stylesheet" href="assets/css/style.css">
    </head>
    <body>
        <div class="main-wrapper">
            <div class="header">
                <div class="header-left">
                    <a href="dashboard.jsp" class="logo"> <span class="logoclass">BLUDD CULTURE CORPORATION</span> </a>
                    <!--                    <a href="dashboard.jsp" class="logo logo-small"> <img src="assets/img/hotel_logo.png" alt="Logo" width="30" height="30"> </a>-->
                </div>
                <a href="javascript:void(0);" id="toggle_btn"> <i class="fe fe-text-align-left"></i> </a>
                <a class="mobile_btn" id="mobile_btn"> <i class="fas fa-bars"></i> </a>
                <ul class="nav user-menu">
                    <li class="nav-item dropdown noti-dropdown">
                        <a href="#" class="dropdown-toggle nav-link" data-toggle="dropdown"> <i class="fe fe-bell"></i> <span class="badge badge-pill">3</span> </a>
                        <div class="dropdown-menu notifications">
                            <div class="topnav-dropdown-header"> <span class="notification-title">Notifications</span> <a href="javascript:void(0)" class="clear-noti"> Clear All </a> </div>
                            <div class="noti-content">
                                <ul class="notification-list">
                                    <li class="notification-message">
                                        <a href="#">
                                            <div class="media"> <span class="avatar avatar-sm">
                                                    <img class="avatar-img rounded-circle" alt="User Image" src="assets/img/profiles/avatar-02.jpg">
                                                </span>
                                                <div class="media-body">
                                                    <p class="noti-details"><span class="noti-title">Carlson Tech</span> has approved <span class="noti-title">your estimate</span></p>
                                                    <p class="noti-time"><span class="notification-time">4 mins ago</span> </p>
                                                </div>
                                            </div>
                                        </a>
                                    </li>
                                    <li class="notification-message">
                                        <a href="#">
                                            <div class="media"> <span class="avatar avatar-sm">
                                                    <img class="avatar-img rounded-circle" alt="User Image" src="assets/img/profiles/avatar-11.jpg">
                                                </span>
                                                <div class="media-body">
                                                    <p class="noti-details"><span class="noti-title">International Software
                                                            Inc</span> has sent you a invoice in the amount of <span class="noti-title">$218</span></p>
                                                    <p class="noti-time"><span class="notification-time">6 mins ago</span> </p>
                                                </div>
                                            </div>
                                        </a>
                                    </li>
                                    <li class="notification-message">
                                        <a href="#">
                                            <div class="media"> <span class="avatar avatar-sm">
                                                    <img class="avatar-img rounded-circle" alt="User Image" src="assets/img/profiles/avatar-17.jpg">
                                                </span>
                                                <div class="media-body">
                                                    <p class="noti-details"><span class="noti-title">John Hendry</span> sent a cancellation request <span class="noti-title">Apple iPhone
                                                            XR</span></p>
                                                    <p class="noti-time"><span class="notification-time">8 mins ago</span> </p>
                                                </div>
                                            </div>
                                        </a>
                                    </li>
                                    <li class="notification-message">
                                        <a href="#">
                                            <div class="media"> <span class="avatar avatar-sm">
                                                    <img class="avatar-img rounded-circle" alt="User Image" src="assets/img/profiles/avatar-13.jpg">
                                                </span>
                                                <div class="media-body">
                                                    <p class="noti-details"><span class="noti-title">Mercury Software
                                                            Inc</span> added a new product <span class="noti-title">Apple
                                                            MacBook Pro</span></p>
                                                    <p class="noti-time"><span class="notification-time">12 mins ago</span> </p>
                                                </div>
                                            </div>
                                        </a>
                                    </li>
                                </ul>
                            </div>
                            <div class="topnav-dropdown-footer"> <a href="#">View all Notifications</a> </div>
                        </div>
                    </li>
                    <li class="nav-item dropdown has-arrow">
                        <a href="#" class="dropdown-toggle nav-link" data-toggle="dropdown"> <span class="user-img"><img class="rounded-circle" src="assets/img/profiles/avatar-01.jpg" width="31" alt="Soeng Souy"></span> </a>
                        <div class="dropdown-menu">
                            <div class="user-header">
                                <div class="avatar avatar-sm"> <img src="assets/img/profiles/avatar-01.jpg" alt="User Image" class="avatar-img rounded-circle"> </div>
                                <div class="user-text">
                                    <h6><%= session.getAttribute("fullname")%></h6> 
                                    <p class="text-muted mb-0"><%= session.getAttribute("roles")%></p>
                                </div>
                            </div> <a class="dropdown-item" href="profile.jsp">My Profile</a> <a class="dropdown-item" href="settings.html">Account Settings</a> <a class="dropdown-item" href="logout">Logout</a> </div>
                    </li>
                </ul>
            </div>
            <div class="sidebar" id="sidebar">
                <div class="sidebar-inner slimscroll">
                    <div id="sidebar-menu" class="sidebar-menu">
                        <ul>
                            <li class="active"> <a href="#"><i class="fas fa-tachometer-alt"></i> <span>Dashboard</span></a> </li>
                            <li class="list-divider"></li>

                            <li class="submenu"> <a href="#"><i class="fas fa-user"></i> <span> User </span> <span class="menu-arrow"></span></a>
                                <ul class="submenu_class" style="display: none;">
                                    <li><a href="userList.jsp">User List </a></li>
                                </ul>
                            </li>
                            <li class="submenu"> <a href="#"><i class="fas fa-key"></i> <span> Product Category </span> <span class="menu-arrow"></span></a>
                                <ul class="submenu_class" style="display: none;">
                                    <li><a href="productCategoryList.jsp">Product Category List</a></li>
                                    <li><a href="category.jsp"> Manage Product Category </a></li>
                                </ul>
                            </li>
                            <li class="submenu"> <a href="#"><i class="fas fa-key"></i> <span> Product </span> <span class="menu-arrow"></span></a>
                                <ul class="submenu_class" style="display: none;">
                                    <li><a href="productList.jsp">Product List</a></li>
                                    <li><a href="product.jsp"> Manage Product </a></li>
                                </ul>
                            </li>
                            <li class="submenu"> <a href="#"><i class="fas fa-key"></i> <span> Inventory </span> <span class="menu-arrow"></span></a>
                                <ul class="submenu_class" style="display: none;">
                                    <li><a href="inventoryList.jsp">Inventory List</a></li>
                                    <li><a href="inventory.jsp"> Manage Inventory</a></li>
                                </ul>
                            </li>
                            <li class="submenu"> <a href="#"><i class="fas fa-key"></i> <span> Purchases </span> <span class="menu-arrow"></span></a>
                                <ul class="submenu_class" style="display: none;">
                                    <li><a href="purchaseList.jsp">Purchase List</a></li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="page-wrapper">
                <div class="content container-fluid">
                    <div class="page-header">
                        <div class="row align-items-center">
                            <div class="col">
                                <div class="mt-5">
                                    <h4 class="card-title float-left mt-2">All Product Category</h4> 
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="card card-table">
                                <div class="card-body booking_card">
                                    <div class="table-responsive">
                                        <table class="datatable table table-stripped table table-hover table-center mb-0">
                                            <thead>
                                                <tr>
                                                    <th>No</th>
                                                    <th>Product Id</th>
                                                    <th>Product Name</th>
                                                    <th>Size</th>
                                                    <th>Quantity</th>
                                                    <th>Created By</th>
                                                    <th>Creation Date</th>
                                                    <th>Last Modified By</th>
                                                    <th>Last Modified Date</th>
                                                    <th class="text-right">Actions</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    Connection con = null;
                                                    PreparedStatement ps = null;
                                                    ResultSet rs = null;
                                                    int no = 1; // Initialize the counter

                                                    try {
                                                        Class.forName("com.mysql.jdbc.Driver");
                                                        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ecommerce", "root", "admin");
                                                        String query = "SELECT " + "i.inventoryid, " + "p.productid, " + "p.productName, " + "p.createdAt, "
                                                                + "uc.fullname AS createdByFullName, " + "ul.fullname AS lastModifiedByFullName, "
                                                                + "i.size, " + "i.quantity, " + "i.creationDate, " + "i.lastModifiedDate " + "FROM product p "
                                                                + "INNER JOIN inventory i ON p.productid = i.productid "
                                                                + "LEFT JOIN users uc ON p.createdBy = uc.userid " + "LEFT JOIN users ul ON p.lastModifiedBy = ul.userid "
                                                                + "ORDER BY p.productid, i.size";

                                                        ps = con.prepareStatement(query);
                                                        rs = ps.executeQuery();

                                                        while (rs.next()) {
                                                            int productid = rs.getInt("productid");
                                                            int inventoryid = rs.getInt("inventoryid");
                                                            String productName = rs.getString("productName");
                                                            String size = rs.getString("size");
                                                            int quantity = rs.getInt("quantity");
                                                            Timestamp creationDate = rs.getTimestamp("creationDate");
                                                            Timestamp lastModifiedDate = rs.getTimestamp("lastModifiedDate");
                                                            String createdByFullName = rs.getString("createdByFullName");
                                                            String lastModifiedByFullName = rs.getString("lastModifiedByFullName");
                                                %>
                                                <tr>
                                                    <td><%= no++%></td>
                                                    <td><%= productid%></td>
                                                    <td><%= productName%></td>
                                                    <td><%= size%></td>
                                                    <td><%= quantity%></td>
                                                    <td><%= createdByFullName%></td>
                                                    <td><%= creationDate%></td>
                                                    <td><%= lastModifiedByFullName%></td>
                                                    <td><%= lastModifiedDate%></td>

                                                    <td class="text-right">
                                                        <div class="dropdown dropdown-action"> 
                                                            <a href="#" class="action-icon dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                                                <i class="fas fa-ellipsis-v ellipse_color"></i>
                                                            </a>
                                                            <div class="dropdown-menu dropdown-menu-right"> 
                                                                <a class="dropdown-item" href="inventoryEdit.jsp?invetoryid=<%= inventoryid%>">
                                                                    <i class="fas fa-pencil-alt m-r-5"></i> Edit
                                                                </a> 
                                                                <a class="dropdown-item" href="#" data-toggle="modal" data-target="#delete_asset" data-id="<%= inventoryid%>">
                                                                    <i class="fas fa-trash-alt m-r-5"></i> Delete
                                                                </a>
                                                            </div>
                                                        </div>
                                                    </td> 
                                                </tr>
                                                <%
                                                        }
                                                    } catch (Exception e) {
                                                        e.printStackTrace();
                                                    } finally {
                                                        try {
                                                            if (rs != null) {
                                                                rs.close();
                                                            }
                                                            if (ps != null) {
                                                                ps.close();
                                                            }
                                                            if (con != null) {
                                                                con.close();
                                                            }
                                                        } catch (SQLException e) {
                                                            e.printStackTrace();
                                                        }
                                                    }
                                                %>

                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="delete_asset" tabindex="-1" role="dialog" aria-labelledby="deleteModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="deleteModalLabel">Delete Confirmation</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        Are you sure you want to delete this category?
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                        <a id="confirmDeleteBtn" href="#" class="btn btn-danger">Delete</a>
                    </div>
                </div>
            </div>
        </div>

        <script src="assets/js/jquery-3.5.1.min.js"></script>
        <script src="assets/js/popper.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="assets/plugins/slimscroll/jquery.slimscroll.min.js"></script>
        <script src="assets/plugins/raphael/raphael.min.js"></script>
        <script src="assets/plugins/datatables/jquery.dataTables.min.js"></script>
        <script src="assets/plugins/datatables/datatables.min.js"></script>
        <script src="assets/js/script.js"></script>
        <script>
            $('#delete_asset').on('show.bs.modal', function (event) {
                var button = $(event.relatedTarget); // Button that triggered the modal
                var id = button.data('id'); // Extract info from data-* attributes
                var confirmDeleteBtn = $('#confirmDeleteBtn');
                confirmDeleteBtn.attr('href', 'productCategoryDelete.jsp?categoryid=' + id);
            });
        </script>

    </body>
</html>