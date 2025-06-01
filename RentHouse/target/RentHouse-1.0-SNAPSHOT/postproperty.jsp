<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
   <meta charset="UTF-8">
   <meta http-equiv="X-UA-Compatible" content="IE=edge">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>Post Property - MyHome</title>

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

<!-- post property section starts -->
<section class="post-property">
   <h1 class="heading">post your property</h1>
   <% 
      String errorMessage = (String) request.getAttribute("errorMessage");
      if (errorMessage != null) {
         out.println("<p class='error-message'>" + errorMessage + "</p>");
      }
   %>
   <form action="PostPropertyServlet" method="POST">
      <div class="box">
         <p>property name <span>*</span></p>
         <input type="text" name="name" required maxlength="50" placeholder="enter property name" class="input">
      </div>
      <div class="box">
         <p>location <span>*</span></p>
         <input type="text" name="location" required maxlength="50" placeholder="enter city name" class="input">
      </div>
      <div class="box">
         <p>price <span>*</span></p>
         <input type="text" name="price" required placeholder="enter price (e.g., 1,000,000)" class="input">
      </div>
      <div class="box">
         <p>image URL</p>
         <input type="text" name="image" placeholder="enter image URL" class="input">
      </div>
      <div class="flex">
         <div class="box">
            <p>property type <span>*</span></p>
            <select name="type" class="input" required>
               <option value="flat">flat</option>
               <option value="house">house</option>
               <option value="shop">shop</option>
            </select>
         </div>
         <div class="box">
            <p>status <span>*</span></p>
            <select name="status" class="input" required>
               <option value="sale">sale</option>
               <option value="resale">resale</option>
               <option value="rent">rent</option>
            </select>
         </div>
         <div class="box">
            <p>bedrooms <span>*</span></p>
            <select name="bedrooms" class="input" required>
               <option value="1">1 bedroom</option>
               <option value="2">2 bedrooms</option>
               <option value="3">3 bedrooms</option>
               <option value="4">4 bedrooms</option>
               <option value="5">5 bedrooms</option>
               <option value="6">6 bedrooms</option>
               <option value="7">7 bedrooms</option>
               <option value="8">8 bedrooms</option>
               <option value="9">9 bedrooms</option>
            </select>
         </div>
         <div class="box">
            <p>bathrooms <span>*</span></p>
            <select name="bathrooms" class="input" required>
               <option value="1">1 bathroom</option>
               <option value="2">2 bathrooms</option>
               <option value="3">3 bathrooms</option>
               <option value="4">4 bathrooms</option>
               <option value="5">5 bathrooms</option>
            </select>
         </div>
         <div class="box">
            <p>balcony <span>*</span></p>
            <select name="balcony" class="input" required>
               <option value="0">0 balcony</option>
               <option value="1">1 balcony</option>
               <option value="2">2 balconies</option>
               <option value="3">3 balconies</option>
            </select>
         </div>
         <div class="box">
            <p>area (sqft) <span>*</span></p>
            <input type="text" name="area" required placeholder="enter area in sqft" class="input">
         </div>
         <div class="box">
            <p>age of property <span>*</span></p>
            <input type="text" name="age" required placeholder="enter age in years" class="input">
         </div>
         <div class="box">
            <p>room floor <span>*</span></p>
            <input type="text" name="room_floor" required placeholder="enter room floor" class="input">
         </div>
         <div class="box">
            <p>total floors <span>*</span></p>
            <input type="text" name="total_floors" required placeholder="enter total floors" class="input">
         </div>
         <div class="box">
            <p>furnished status <span>*</span></p>
            <select name="furnished" class="input" required>
               <option value="unfurnished">unfurnished</option>
               <option value="furnished">furnished</option>
               <option value="semi-furnished">semi-furnished</option>
            </select>
         </div>
         <div class="box">
            <p>loan available <span>*</span></p>
            <select name="loan" class="input" required>
               <option value="yes">yes</option>
               <option value="no">no</option>
            </select>
         </div>
         <div class="box">
            <p>property status <span>*</span></p>
            <select name="property_status" class="input" required>
               <option value="ready">ready to move</option>
               <option value="under_construction">under construction</option>
            </select>
         </div>
      </div>
      <div class="box">
         <p>amenities</p>
         <input type="text" name="amenities" placeholder="enter amenities (comma-separated)" class="input">
      </div>
      <div class="box">
         <p>description</p>
         <textarea name="description" placeholder="enter description" class="input" rows="5"></textarea>
      </div>
      <div class="box">
         <p>deposit amount</p>
         <input type="text" name="deposit" placeholder="enter deposit amount" class="input">
      </div>
      <input type="submit" value="post property" name="submit" class="btn">
   </form>
</section>
<!-- post property section ends -->

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