<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.university.renthouse.model.Property" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="en">
<head>
   <meta charset="UTF-8">
   <meta http-equiv="X-UA-Compatible" content="IE=edge">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>Home - MyHome</title>

   <!-- font awesome cdn link -->
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">

   <!-- custom css file link -->
   <link rel="stylesheet" href="css/style.css">
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
<!-- services section starts -->
<section class="services">
   <h1 class="heading">our services</h1>
   <div class="box-container">
      <div class="box">
         <img src="images/icon-1.png" alt="">
         <h3>buy house</h3>
         <p>Discover a wide range of affordable and premium homes available for purchase. Let us help you find your dream property effortlessly.</p>
      </div>
      <div class="box">
         <img src="images/icon-2.png" alt="">
         <h3>rent house</h3>
         <p>Find the perfect rental property that fits your budget and lifestyle. Safe, verified listings for hassle-free renting.</p>
      </div>
      <div class="box">
         <img src="images/icon-3.png" alt="">
         <h3>sell house</h3>
         <p>List your property with us and reach thousands of interested buyers. Fast, secure, and professional selling support.</p>
      </div>
      <div class="box">
         <img src="images/icon-4.png" alt="">
         <h3>flats and buildings</h3>
         <p>Explore apartments, flats, and full buildings for investment or personal use. Verified options in prime locations.</p>
      </div>
      <div class="box">
         <img src="images/icon-5.png" alt="">
         <h3>shops and malls</h3>
         <p>Looking for a commercial space? We connect you with the best retail shops and malls available for rent or sale.</p>
      </div>
      <div class="box">
         <img src="images/icon-6.png" alt="">
         <h3>24/7 service</h3>
         <p>Our dedicated team is available around the clock to answer your questions, provide assistance, and support your journey.</p>
      </div>
   </div>
</section>
<!-- services section ends -->


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

<!-- custom js file link -->
<script src="js/script.js"></script>
</body>
</html>