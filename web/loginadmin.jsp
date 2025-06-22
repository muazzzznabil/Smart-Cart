<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
        <title>LOGIN</title>
        <link rel="shortcut icon" type="image/x-icon" href="assets/img/favicon.png">
        <link rel="stylesheet" href="assets/css/bootstrap.min.css">
        <link rel="stylesheet" href="assets/plugins/fontawesome/css/fontawesome.min.css">
        <link rel="stylesheet" type="text/css" href="assets/plugins/fontawesome/css/all.min.css">
        <link rel="stylesheet" href="assets/css/feathericon.min.css">
        <link rel="stylesheet" href="assets/plugins/morris/morris.css">
        <link rel="stylesheet" href="assets/css/style.css">
    </head>

    <body>
        <div class="main-wrapper login-body">
            <div class="login-wrapper">
                <div class="container">
                    <div class="loginbox">
                        <div class="login-left"> <img class="img-fluid" src="assets/img/logo.png" alt="Logo"> </div>
                        <div class="login-right">
                            <div class="login-right-wrap">
                                <h1>Login</h1>
                                <p class="account-subtitle">Access to <b>Bludd Culture Corporation</b> dashboard</p>
                                <form action="LoginServlet" method="post">
                                    <div class="form-group">
                                        <input class="form-control" type="text" id="username" name="username" placeholder="Username" required>
                                    </div>
                                    <div class="form-group">
                                        <input class="form-control" type="password" id="userpassword" name="userpassword" placeholder="Password" required>
                                    </div>
                                    <div class="form-group">
                                        <button class="btn btn-primary btn-block" type="submit">Login</button>
                                    </div>
                                    <input type="hidden" name="roles" value="admin">

                                </form>
                                <div class="text-center forgotpass"><a href="forgot-password.html">Forgot Password?</a> </div>
                                <%-- Display error message if authentication fails --%>
                                <% if (request.getParameter("error") != null) { %>
                                <div class="alert alert-danger mt-3" role="alert">
                                    Invalid username or password. Please try again.
                                </div>
                                <% }%>
                                <div class="text-center dont-have">Don't have an account? <a href="registeradmin.jsp">Register</a></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="assets/js/jquery-3.5.1.min.js"></script>
        <script src="assets/js/popper.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="assets/plugins/slimscroll/jquery.slimscroll.min.js"></script>
        <script src="assets/js/script.js"></script>
    </body>

</html>