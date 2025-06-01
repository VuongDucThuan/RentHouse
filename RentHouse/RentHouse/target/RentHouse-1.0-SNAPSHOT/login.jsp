<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - MyHome</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">
    <link rel="stylesheet" href="css/style.css">
    <style>
        .error-message, .success-message {
            text-align: center;
            margin: 10px 0;
            padding: 10px;
            border-radius: 5px;
            display: none; /* Ẩn ban đầu */
        }
        .error-message {
            color: #721c24;
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
        }
        .success-message {
            color: #155724;
            background-color: #d4edda;
            border: 1px solid #c3e6cb;
        }
        .error {
            border: 1px solid #721c24;
            background-color: #f8d7da;
            color: #721c24;
            padding: 5px;
            border-radius: 3px;
            margin-top: 5px;
            display: none;
        }
    </style>
</head>
<body>
    <!-- header section starts -->
<header class="header">
   <nav class="navbar nav-1">
      <section class="flex">
         <a href="home.jsp" class="logo"><i class="fas fa-house"></i>MyHome</a>
         <ul>
            <li><a href="postproperty.jsp">post property<i class="fas fa-paper-plane"></i></a></li>
         </ul>
      </section>
   </nav>

   <nav class="navbar nav-2">
      <section class="flex">
         <div id="menu-btn" class="fas fa-bars"></div>

         <div class="menu">
            <ul>
               <li><a href="dashboard.jsp">dashboard</a></li>
               <li><a href="listings.jsp">All listings</a></li>
               <li><a href="#">help<i class="fas fa-angle-down"></i></a>
                  <ul>
                     <li><a href="about.jsp">about us</a></li>
                     <li><a href="contact.jsp">contact us</a></li>
                     <li><a href="contact.jsp#faq">FAQ</a></li>
                  </ul>
               </li>
            </ul>
         </div>

         <ul>
            <li><a href="saveproperties.jsp">saved <i class="far fa-heart"></i></a></li>
            <li><a href="#">account <i class="fas fa-angle-down"></i></a>
               <ul>
                  <% 
                     String username = (String) session.getAttribute("username");
                     if (username != null) {
                        out.println("<li><a href='dashboard.jsp'>Welcome, " + username + "</a></li>");
                        out.println("<li><a href='LogoutServlet'>logout</a></li>");
                     } else {
                        out.println("<li><a href='login.jsp'>login</a></li>");
                        out.println("<li><a href='register.jsp'>register</a></li>");
                     }
                  %>
               </ul>
            </li>
         </ul>
      </section>
   </nav>
</header>
<!-- header section ends -->
<!-- login section starts -->
    <section class="form-container">
        <form id="loginForm" action="LoginServlet" method="POST" onsubmit="return validateLoginForm()">
            <h3>welcome back!</h3>
            <div>
                <input type="email" name="email" required maxlength="100" placeholder="enter your email" class="box">
                <div id="emailError" class="error"></div>
            </div>
            <div>
                <input type="password" name="pass" required maxlength="100" placeholder="enter your password" class="box">
                <div id="passError" class="error"></div>
            </div>
            <p>don't have an account? <a href="register.jsp">register now</a></p>
            <input type="submit" value="login now" name="submit" class="btn">
            <% 
                String errorMessage = (String) request.getAttribute("errorMessage");
                if (errorMessage != null) {
                    out.println("<div class='error-message' style='display: block;'>" + errorMessage + "</div>");
                }
                String successMessage = (String) request.getAttribute("successMessage");
                if (successMessage != null) {
                    out.println("<div class='success-message' style='display: block;'>" + successMessage + "</div>");
                }
            %>
        </form>
    </section>
<!-- login section ends -->
<!-- footer section starts -->
    <footer class="footer">
   <section class="flex">
      <div class="box">
         <a href="tel:0337030071"><i class="fas fa-phone"></i><span>0337030071</span></a>
         <a href="mailto:thuanducvuong@gmail.com"><i class="fas fa-envelope"></i><span>thuanducvuong@gmail.com</span></a>
      </div>
      <div class="box">
         <a href="home.jsp"><span>home</span></a>
         <a href="about.jsp"><span>about</span></a>
         <a href="contact.jsp"><span>contact</span></a>
         <a href="listings.jsp"><span>all listings</span></a>
         <a href="saveproperties.jsp"><span>saved properties</span></a>
      </div>
      <div class="box">
         <a href="#"><span>facebook</span><i class="fab fa-facebook-f"></i></a>
         <a href="#"><span>twitter</span><i class="fab fa-twitter"></i></a>
         <a href="#"><span>linkedin</span><i class="fab fa-linkedin"></i></a>
         <a href="#"><span>instagram</span><i class="fab fa-instagram"></i></a>
      </div>
   </section>
</footer>
<!-- footer section ends -->

    <script src="js/script.js"></script>
    <script>
        function validateLoginForm() {
            const email = document.forms["loginForm"]["email"].value;
            const password = document.forms["loginForm"]["pass"].value;
            const emailError = document.getElementById("emailError");
            const passError = document.getElementById("passError");
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

            // Ẩn lỗi cũ
            emailError.style.display = "none";
            passError.style.display = "none";

            // Kiểm tra email
            if (!emailRegex.test(email)) {
                emailError.textContent = "Please enter a valid email address.";
                emailError.style.display = "block";
                return false;
            }

            // Kiểm tra password
            if (password.length < 6) {
                passError.textContent = "Password must be at least 6 characters long.";
                passError.style.display = "block";
                return false;
            }

            return true;
        }
    </script>
</body>
</html>