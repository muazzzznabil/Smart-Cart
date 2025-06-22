<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bludd Culture - Contact</title>
    <link rel="stylesheet" href="assets/css/styles.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <div class="navbar">
        <a href="index.jsp">Home</a>
        <a href="latest-news.jsp">Latest News</a>
        <a href="events.jsp">Events</a>
        <a href="shop.jsp">Shop</a>
        <a href="about.jsp">About</a>
        <a href="contact.jsp" class="active">Contact</a>
    </div>

    <section class="contact-section">
        <div class="contact-header">
            <h1>Contact Us</h1>
            <p>We?d love to hear from you. Reach out anytime.</p>
        </div>

        <div class="contact-form-container">
            <form action="" method="POST" id="contact-form">
                <div class="form-group">
                    <label for="name">Full Name</label>
                    <input type="text" id="name" name="name" placeholder="Your Name" required>
                </div>
                <div class="form-group">
                    <label for="email">Email Address</label>
                    <input type="email" id="email" name="email" placeholder="Your Email" required>
                </div>
                <div class="form-group">
                    <label for="message">Message</label>
                    <textarea id="message" name="message" placeholder="Your Message" required></textarea>
                </div>
                <button type="submit" class="submit-btn">Send Message</button>
            </form>
        </div>

        <div class="contact-info">
            <div class="info-item">
                <i class="fas fa-phone-alt"></i>
                <p>+123 456 7890</p>
            </div>
            <div class="info-item">
                <i class="fas fa-envelope"></i>
                <p>contact@bluddculture.com</p>
            </div>
            <div class="info-item">
                <i class="fas fa-map-marker-alt"></i>
                <p>123 Street, City, Country</p>
            </div>
        </div>
    </section>
</body>
</html>

    <!-- Footer -->
    <div class="footer">
        <p>&copy; 2024 Bludd Culture. All Rights Reserved.</p>
    </div>
</body>
</html>
