<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.university.renthouse.model.Review" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<% 
   // Tạo danh sách đánh giá trực tiếp trong JSP
   List<Review> reviews = new ArrayList<>();
   reviews.add(new Review("John Deo", 4.5, "RentHouse made finding my new home so easy! The process was smooth and the listings were exactly as shown.", "images/pic-1.png"));
   reviews.add(new Review("Jane Smith", 4.5, "I found the perfect apartment within days. The support team was friendly and responsive throughout the journey.", "images/pic-2.png"));
   reviews.add(new Review("Mike Johnson", 4.5, "Excellent platform with great property options. The agents were knowledgeable and helped me a lot.", "images/pic-3.png"));
   reviews.add(new Review("Sarah Brown", 4.5, "Highly recommend RentHouse! Everything was fast, professional, and secure. I love my new place!", "images/pic-4.png"));
   reviews.add(new Review("Tom Wilson", 4.5, "As a first-time renter, I felt confident with RentHouse guiding me. They really care about their users.", "images/pic-5.png"));
   reviews.add(new Review("Emily Davis", 4.5, "RentHouse connected me to the right home and made the entire process stress-free. Thank you!", "images/pic-6.png"));
   request.setAttribute("reviews", reviews); // Đặt danh sách vào request để sử dụng
%>
<!DOCTYPE html>
<html lang="en">
<head>
   <meta charset="UTF-8">
   <meta http-equiv="X-UA-Compatible" content="IE=edge">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>About Us</title>

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

<!-- about section starts -->
<section class="about">
   <div class="row">
      <div class="image">
         <img src="images/about-img.svg" alt="">
      </div>
      <div class="content">
         <h3>why choose us?</h3>
         <p>Wide range of properties</p>
         <p>Verified Listings Only</p>
         <p>Safe & Secure Platform</p>
         <p>Responsive Customer Support</p>
         <a href="contact.jsp" class="inline-btn">contact us</a>
      </div>
   </div>
</section>
<!-- about section ends -->

<!-- steps section starts -->
<section class="steps">
   <h1 class="heading">3 simple steps</h1>
   <div class="box-container">
      <div class="box">
         <img src="images/step-1.png" alt="">
         <h3>search property</h3>
         <p>Easily browse hundreds of verified listings. Use filters to find homes by location, budget, type, and features – all in just a few clicks.</p>
      </div>
      <div class="box">
         <img src="images/step-2.png" alt="">
         <h3>contact agents</h3>
         <p>Get in touch with trusted property owners or agents instantly. Schedule visits, ask questions, and get the support you need without hassle.</p>
      </div>
      <div class="box">
         <img src="images/step-3.png" alt="">
         <h3>enjoy property</h3>
         <p>Move into your new home with confidence. Enjoy a smooth rental experience and start making memories in your perfect space.</p>
      </div>
   </div>
</section>
<!-- steps section ends -->

<!-- review section starts -->
<section class="reviews">
   <h1 class="heading">client's reviews</h1>
   <div class="box-container">
      <%
         List<Review> reviewList = (List<Review>) request.getAttribute("reviews");
         if (reviewList != null && !reviewList.isEmpty()) {
            for (Review review : reviewList) {
      %>
      <div class="box">
         <div class="user">
            <img src="<%= review.getImageUrl() != null && !review.getImageUrl().isEmpty() ? review.getImageUrl() : "images/default-user.png" %>" alt="">
            <div>
               <h3><%= review.getClientName() != null && !review.getClientName().isEmpty() ? review.getClientName() : "Anonymous" %></h3>
               <div class="stars">
                  <%
                     int fullStars = (int) review.getRating();
                     boolean hasHalfStar = review.getRating() % 1 != 0;
                     for (int i = 0; i < fullStars; i++) {
                        out.println("<i class='fas fa-star'></i>");
                     }
                     if (hasHalfStar) {
                        out.println("<i class='fas fa-star-half-alt'></i>");
                     }
                     // Thêm sao trống để đủ 5 sao
                     for (int i = fullStars + (hasHalfStar ? 1 : 0); i < 5; i++) {
                        out.println("<i class='far fa-star'></i>");
                     }
                  %>
               </div>
            </div>
         </div>
         <p><%= review.getComment() != null && !review.getComment().isEmpty() ? review.getComment() : "No comment provided." %></p>
      </div>
      <%
            }
         } else {
            out.println("<p>No reviews available at the moment.</p>");
         }
      %>
   </div>
</section>
<!-- review section ends -->

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