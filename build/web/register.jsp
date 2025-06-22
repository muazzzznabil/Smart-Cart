<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>REGISTRATION FORM</title>
        <link rel="shortcut icon" type="image/x-icon" href="assets/img/favicon.png">
        <link rel="stylesheet" href="assets/css/bootstrap.min.css">
        <link rel="stylesheet" href="assets/plugins/fontawesome/css/all.min.css">
        <link rel="stylesheet" href="assets/plugins/fontawesome/css/fontawesome.min.css">
        <link rel="stylesheet" href="assets/css/feathericon.min.css">
        <link rel="stylesheet" href="assets/plugins/morris/morris.css">
        <link rel="stylesheet" href="assets/css/style.css"> </head>
    <body>
        <div class="main-wrapper login-body">
            <div class="login-wrapper">
                <div class="container">
                    <div class="loginbox">
                        <div class="login-left"> <img class="img-fluid" src="assets/img/logo.png" alt="Logo"> </div>
                        <div class="login-right">
                            <div class="login-right-wrap">
                                <h1 class="mb-3">Register</h1>
                                <form action="SaveUser" method="post">
                                    <div class="form-group">
                                        <input class="form-control" type="text" name="username" required placeholder="Username">
                                    </div>

                                    <div class="form-group">
                                        <input class="form-control" type="email" name="email" required placeholder="Email">
                                    </div>

                                    <div class="form-group">
                                        <input class="form-control" type="password" name="userpassword" required pattern=".{6,}" title="Password must be at least 6 characters long" placeholder="Password">
                                    </div>

                                    <div class="form-group">
                                        <input class="form-control" type="text" name="fullname" required pattern="[a-zA-Z\s]+" placeholder="Fullname">
                                    </div>

                                    <div class="form-group">
                                        <input class="form-control" type="text" name="ic_number" required pattern="[0-9]{12}" placeholder="IC Number without (-)">
                                    </div>

                                    <div class="form-group">
                                        <input class="form-control" type="text" name="phone_number" required pattern="[0-9]{10,}" placeholder="Phone number">
                                    </div>

                                    <input type="hidden" name="roles" value="customer">

                                    <div class="form-group mb-0">
                                        <button class="btn btn-primary btn-block" type="submit">Register</button>
                                    </div>

                                </form>
                                <div class="text-center dont-have">Already have an account? <a href="loginadmin.jsp">Login</a> </div>
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