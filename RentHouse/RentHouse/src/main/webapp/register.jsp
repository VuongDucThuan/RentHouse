<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - MyHome</title>
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
<!-- register section starts -->
    <section class="form-container">
        <form id="registerForm" action="RegisterServlet" method="POST" onsubmit="return validateRegisterForm()">
            <h3>register now!</h3>
            <div>
                <input type="text" name="username" required maxlength="50" placeholder="enter your username" class="box">
                <div id="usernameError" class="error"></div>
            </div>
            <div>
                <input type="email" name="email" required maxlength="100" placeholder="enter your email" class="box">
                <div id="emailError" class="error"></div>
            </div>
            <div>
                <input type="text" name="phone" required maxlength="15" placeholder="enter your phone" class="box">
                <div id="phoneError" class="error"></div>
            </div>
            <div>
                <input type="password" name="pass" required maxlength="100" placeholder="enter your password" class="box">
                <div id="passError" class="error"></div>
            </div>
            <div>
                <input type="password" name="c_pass" required maxlength="100" placeholder="confirm your password" class="box">
                <div id="cPassError" class="error"></div>
            </div>
            <div>
                <select name="role" required class="box" style="margin: 10px 0;">
                    <option value="">Select Role</option>
                    <option value="landlord">Landlord (House Owner)</option>
                    <option value="student">Student</option>
                    <option value="staff">Staff</option>
                </select>
                <div id="roleError" class="error"></div>
            </div>
            <p>already have an account? <a href="login.jsp">login now</a></p>
            <input type="submit" value="register now" name="submit" class="btn">
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
<!-- register section ends -->
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
        function validateRegisterForm() {
            const username = document.forms["registerForm"]["username"].value;
            const email = document.forms["registerForm"]["email"].value;
            const phone = document.forms["registerForm"]["phone"].value;
            const password = document.forms["registerForm"]["pass"].value;
            const confirmPassword = document.forms["registerForm"]["c_pass"].value;
            const role = document.forms["registerForm"]["role"].value;
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

            // Ẩn lỗi cũ
            document.getElementById("usernameError").style.display = "none";
            document.getElementById("emailError").style.display = "none";
            document.getElementById("phoneError").style.display = "none";
            document.getElementById("passError").style.display = "none";
            document.getElementById("cPassError").style.display = "none";
            document.getElementById("roleError").style.display = "none";

            // Kiểm tra username
            if (username.length < 3) {
                document.getElementById("usernameError").textContent = "Username must be at least 3 characters long.";
                document.getElementById("usernameError").style.display = "block";
                return false;
            }

            // Kiểm tra email
            if (!emailRegex.test(email)) {
                document.getElementById("emailError").textContent = "Please enter a valid email address.";
                document.getElementById("emailError").style.display = "block";
                return false;
            }

            // Kiểm tra phone
            if (!phone.match(/^\d{10,15}$/)) {
                document.getElementById("phoneError").textContent = "Phone number must be 10-15 digits.";
                document.getElementById("phoneError").style.display = "block";
                return false;
            }

            // Kiểm tra password
            if (password.length < 6) {
                document.getElementById("passError").textContent = "Password must be at least 6 characters long.";
                document.getElementById("passError").style.display = "block";
                return false;
            }

            // Kiểm tra confirm password
            if (password !== confirmPassword) {
                document.getElementById("cPassError").textContent = "Passwords do not match.";
                document.getElementById("cPassError").style.display = "block";
                return false;
            }

            // Kiểm tra role
            if (role === "") {
                document.getElementById("roleError").textContent = "Please select a role.";
                document.getElementById("roleError").style.display = "block";
                return false;
            }

            return true;
        }
    </script>
</body>
</html>