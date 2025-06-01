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
               <li><a href="dashboard.jsp">Dashboard</a></li>
               <li><a href="#">Rent<i class="fas fa-angle-down"></i></a>
                  <ul>
                     <li><a href="ListingsServlet?type=house&category=rent">house</a></li>
                     <li><a href="ListingsServlet?type=flat&category=rent">flat</a></li>
                  </ul>
               </li>
               <li><a href="#">Help<i class="fas fa-angle-down"></i></a>
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
                     String userRole = (String) session.getAttribute("role");
                     if (username != null) {
                        out.println("<li><a href='dashboard.jsp'>Welcome, " + username + "</a></li>");
                        if ("student".equals(userRole)) {
                           out.println("<li><a href='myorder.jsp'>my orders</a></li>");
                        }
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
<section class="post-property" style="padding: 3rem 5%;">
   <h1 class="heading" style="text-align: center; margin-bottom: 2rem; color: #333;">Post Your Property</h1>
   <% 
      String errorMessage = (String) request.getAttribute("errorMessage");
      if (errorMessage != null) {
         out.println("<p class='error-message' style='color: #DA2C32; text-align: center; margin-bottom: 1.5rem;'>" + errorMessage + "</p>");
      }
   %>
   <form action="PostPropertyServlet" method="POST" style="max-width: 1000px; margin: 0 auto; background: #fff; padding: 2rem; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1);">
      <div class="box" style="margin-bottom: 1.5rem;">
         <p style="font-size: 1.6rem; color: #333; margin-bottom: 0.5rem;">Property Name <span style="color: #DA2C32;">*</span></p>
         <input type="text" name="name" required maxlength="50" placeholder="Enter property name" class="input" style="width: 100%; padding: 1rem; font-size: 1.6rem; border: 1px solid #ccc; border-radius: 5px; outline: none; transition: border-color 0.3s;">
      </div>
      <div class="box" style="margin-bottom: 1.5rem;">
         <p style="font-size: 1.6rem; color: #333; margin-bottom: 0.5rem;">Location <span style="color: #DA2C32;">*</span></p>
         <input type="text" name="location" required maxlength="50" placeholder="Enter city name" class="input" style="width: 100%; padding: 1rem; font-size: 1.6rem; border: 1px solid #ccc; border-radius: 5px; outline: none; transition: border-color 0.3s;">
      </div>
      <div class="box" style="margin-bottom: 1.5rem;">
         <p style="font-size: 1.6rem; color: #333; margin-bottom: 0.5rem;">Price <span style="color: #DA2C32;">*</span></p>
         <input type="text" name="price" required placeholder="Enter price (e.g., 1,000,000)" class="input" style="width: 100%; padding: 1rem; font-size: 1.6rem; border: 1px solid #ccc; border-radius: 5px; outline: none; transition: border-color 0.3s;">
      </div>
      <div class="box" style="margin-bottom: 1.5rem;">
         <p style="font-size: 1.6rem; color: #333; margin-bottom: 0.5rem;">Image URL</p>
         <input type="text" name="image" placeholder="Enter image URL" class="input" style="width: 100%; padding: 1rem; font-size: 1.6rem; border: 1px solid #ccc; border-radius: 5px; outline: none; transition: border-color 0.3s;">
      </div>
      <div class="flex" style="display: grid; grid-template-columns: repeat(auto-fit, minmax(25rem, 1fr)); gap: 1.5rem; margin-bottom: 1.5rem;">
         <div class="box">
            <p style="font-size: 1.6rem; color: #333; margin-bottom: 0.5rem;">Property Type <span style="color: #DA2C32;">*</span></p>
            <select name="type" class="input" required style="width: 100%; padding: 1rem; font-size: 1.6rem; border: 1px solid #ccc; border-radius: 5px; outline: none; transition: border-color 0.3s;">
               <option value="flat">Flat</option>
               <option value="house">House</option>
               <option value="shop">Shop</option>
            </select>
         </div>
         <div class="box">
            <p style="font-size: 1.6rem; color: #333; margin-bottom: 0.5rem;">Status <span style="color: #DA2C32;">*</span></p>
            <select name="status" class="input" required style="width: 100%; padding: 1rem; font-size: 1.6rem; border: 1px solid #ccc; border-radius: 5px; outline: none; transition: border-color 0.3s;">
               <option value="sale">Sale</option>
               <option value="resale">Resale</option>
               <option value="rent">Rent</option>
            </select>
         </div>
         <div class="box">
            <p style="font-size: 1.6rem; color: #333; margin-bottom: 0.5rem;">Bedrooms <span style="color: #DA2C32;">*</span></p>
            <select name="bedrooms" class="input" required style="width: 100%; padding: 1rem; font-size: 1.6rem; border: 1px solid #ccc; border-radius: 5px; outline: none; transition: border-color 0.3s;">
               <option value="1">1 Bedroom</option>
               <option value="2">2 Bedrooms</option>
               <option value="3">3 Bedrooms</option>
               <option value="4">4 Bedrooms</option>
               <option value="5">5 Bedrooms</option>
               <option value="6">6 Bedrooms</option>
               <option value="7">7 Bedrooms</option>
               <option value="8">8 Bedrooms</option>
               <option value="9">9 Bedrooms</option>
            </select>
         </div>
         <div class="box">
            <p style="font-size: 1.6rem; color: #333; margin-bottom: 0.5rem;">Bathrooms <span style="color: #DA2C32;">*</span></p>
            <select name="bathrooms" class="input" required style="width: 100%; padding: 1rem; font-size: 1.6rem; border: 1px solid #ccc; border-radius: 5px; outline: none; transition: border-color 0.3s;">
               <option value="1">1 Bathroom</option>
               <option value="2">2 Bathrooms</option>
               <option value="3">3 Bathrooms</option>
               <option value="4">4 Bathrooms</option>
               <option value="5">5 Bathrooms</option>
            </select>
         </div>
         <div class="box">
            <p style="font-size: 1.6rem; color: #333; margin-bottom: 0.5rem;">Balcony <span style="color: #DA2C32;">*</span></p>
            <select name="balcony" class="input" required style="width: 100%; padding: 1rem; font-size: 1.6rem; border: 1px solid #ccc; border-radius: 5px; outline: none; transition: border-color 0.3s;">
               <option value="0">0 Balcony</option>
               <option value="1">1 Balcony</option>
               <option value="2">2 Balconies</option>
               <option value="3">3 Balconies</option>
            </select>
         </div>
         <div class="box">
            <p style="font-size: 1.6rem; color: #333; margin-bottom: 0.5rem;">Area (sqft) <span style="color: #DA2C32;">*</span></p>
            <input type="text" name="area" required placeholder="Enter area in sqft" class="input" style="width: 100%; padding: 1rem; font-size: 1.6rem; border: 1px solid #ccc; border-radius: 5px; outline: none; transition: border-color 0.3s;">
         </div>
         <div class="box">
            <p style="font-size: 1.6rem; color: #333; margin-bottom: 0.5rem;">Age of Property <span style="color: #DA2C32;">*</span></p>
            <input type="text" name="age" required placeholder="Enter age in years" class="input" style="width: 100%; padding: 1rem; font-size: 1.6rem; border: 1px solid #ccc; border-radius: 5px; outline: none; transition: border-color 0.3s;">
         </div>
         <div class="box">
            <p style="font-size: 1.6rem; color: #333; margin-bottom: 0.5rem;">Room Floor <span style="color: #DA2C32;">*</span></p>
            <input type="text" name="room_floor" required placeholder="Enter room floor" class="input" style="width: 100%; padding: 1rem; font-size: 1.6rem; border: 1px solid #ccc; border-radius: 5px; outline: none; transition: border-color 0.3s;">
         </div>
         <div class="box">
            <p style="font-size: 1.6rem; color: #333; margin-bottom: 0.5rem;">Total Floors <span style="color: #DA2C32;">*</span></p>
            <input type="text" name="total_floors" required placeholder="Enter total floors" class="input" style="width: 100%; padding: 1rem; font-size: 1.6rem; border: 1px solid #ccc; border-radius: 5px; outline: none; transition: border-color 0.3s;">
         </div>
         <div class="box">
            <p style="font-size: 1.6rem; color: #333; margin-bottom: 0.5rem;">Furnished Status <span style="color: #DA2C32;">*</span></p>
            <select name="furnished" class="input" required style="width: 100%; padding: 1rem; font-size: 1.6rem; border: 1px solid #ccc; border-radius: 5px; outline: none; transition: border-color 0.3s;">
               <option value="unfurnished">Unfurnished</option>
               <option value="furnished">Furnished</option>
               <option value="semi-furnished">Semi-furnished</option>
            </select>
         </div>
         <div class="box">
            <p style="font-size: 1.6rem; color: #333; margin-bottom: 0.5rem;">Loan Available <span style="color: #DA2C32;">*</span></p>
            <select name="loan" class="input" required style="width: 100%; padding: 1rem; font-size: 1.6rem; border: 1px solid #ccc; border-radius: 5px; outline: none; transition: border-color 0.3s;">
               <option value="yes">Yes</option>
               <option value="no">No</option>
            </select>
         </div>
         <div class="box">
            <p style="font-size: 1.6rem; color: #333; margin-bottom: 0.5rem;">Property Status <span style="color: #DA2C32;">*</span></p>
            <select name="property_status" class="input" required style="width: 100%; padding: 1rem; font-size: 1.6rem; border: 1px solid #ccc; border-radius: 5px; outline: none; transition: border-color 0.3s;">
               <option value="ready">Ready to Move</option>
               <option value="under_construction">Under Construction</option>
            </select>
         </div>
      </div>
      <div class="box" style="margin-bottom: 1.5rem;">
         <p style="font-size: 1.6rem; color: #333; margin-bottom: 0.5rem;">Amenities</p>
         <input type="text" name="amenities" placeholder="Enter amenities (comma-separated)" class="input" style="width: 100%; padding: 1rem; font-size: 1.6rem; border: 1px solid #ccc; border-radius: 5px; outline: none; transition: border-color 0.3s;">
      </div>
      <div class="box" style="margin-bottom: 1.5rem;">
         <p style="font-size: 1.6rem; color: #333; margin-bottom: 0.5rem;">Description</p>
         <textarea name="description" placeholder="Enter description" class="input" rows="5" style="width: 100%; padding: 1rem; font-size: 1.6rem; border: 1px solid #ccc; border-radius: 5px; outline: none; resize: vertical; transition: border-color 0.3s;"></textarea>
      </div>
      <div class="box" style="margin-bottom: 2rem;">
         <p style="font-size: 1.6rem; color: #333; margin-bottom: 0.5rem;">Deposit Amount</p>
         <input type="text" name="deposit" placeholder="Enter deposit amount" class="input" style="width: 100%; padding: 1rem; font-size: 1.6rem; border: 1px solid #ccc; border-radius: 5px; outline: none; transition: border-color 0.3s;">
      </div>
      <input type="submit" value="Post Property" name="submit" class="btn" style="width: 100%; padding: 1.2rem; font-size: 1.8rem; background-color: #007BFF; color: #fff; border: none; border-radius: 5px; cursor: pointer; transition: background-color 0.3s;">
   </form>
</section>
<!-- post property section ends -->

<!-- footer section starts -->
<footer class="footer">
   <section class="flex">
      <div class="box">
         <a href="tel:1234567890"><i class="fas fa-phone"></i><span>123456789</span></a>
         <a href="tel:1112223333"><i class="fas fa-phone"></i><span>1112223333</span></a>
         <a href="#"><i class="fab fa-linkedin"></i><span>linkedin</span></a>
      </div>
      <div class="box">
         <a href="LatestListingsServlet"><span>home</span></a>
         <a href="about.jsp"><span>about</span></a>
         <a href="contact.jsp"><span>contact</span></a>
         <a href="ListingsServlet"><span>all listings</span></a>
         <a href="saveproperties.jsp"><span>saved properties</span></a>
      </div>
      <div class="box">
         <a href="#"><span>facebook</span><i class="fab fa-facebook-f"></i></a>
         <a href="#"><span>twitter</span><i class="fab fa-twitter"></i></a>
         <a href="#"><span>instagram</span><i class="fab fa-instagram"></i></a>
      </div>
   </section>
   <div class="credit">© copyright @ 2025 by | all rights reserved! </div>
</footer>
<!-- footer section ends -->

<!-- custom js file link -->
<script src="js/script.js"></script>
</body>
</html>