<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Checkout Failed</title>
        <link rel="stylesheet" href="assets/css/styles.css">
    </head>
    <body>
        <style>
            .message-container {
                max-width: 600px;
                margin: 100px auto;
                text-align: center;
                padding: 30px;
                border: 1px solid #ddd;
                border-radius: 10px;
                background-color: #f9f9f9;
            }

            .message-container h1 {
                color: #333;
                font-size: 32px;
                margin-bottom: 10px;
            }

            .message-container p {
                color: #666;
                font-size: 18px;
                margin-bottom: 20px;
            }

            .btn {
                display: inline-block;
                margin: 10px;
                padding: 12px 20px;
                background-color: #e23a48;
                color: white;
                text-decoration: none;
                border-radius: 5px;
                font-weight: bold;
            }

            .btn:hover {
                background-color: #c52836;
            }
        </style>
        <div class="message-container">
            <h1>Oops!</h1>
            <p>There was a problem processing your order.</p>
            <p>Please try again or contact our support team.</p>
            <a href="checkout.jsp" class="btn">Try Again</a>
            <a href="contact.jsp" class="btn">Contact Support</a>
        </div>
    </body>
</html>
