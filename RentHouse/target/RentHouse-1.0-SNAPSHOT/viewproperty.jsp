```jsp
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, com.university.renthouse.util.DatabaseUtil" %>
<!DOCTYPE html>
<html lang="en">
<head>
   <meta charset="UTF-8">
   <meta http-equiv="X-UA-Compatible" content="IE=edge">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>View Property</title>

   <!-- font awesome cdn link -->
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">

   <!-- custom css file link -->
   <link rel="stylesheet" href="css/style.css">

   <style>
      .error {
         text-align: center;
         margin: 10px 0;
         padding: 10px;
         border-radius: 5px;
         color: #721c24;
         background-color: #f8d7da;
         border: 1px solid #f5c6cb;
      }
      .order-btn {
         display: inline-block;
         padding: 1rem 2rem; /* Tăng kích thước nút */
         margin-top: 1rem; /* Khoảng cách phía trên */
         background-color: #28a745; /* Màu xanh lá */
         color: var(--white); /* Màu chữ trắng */
         text-decoration: none;
         border-radius: 5px; /* Bo góc nhẹ */
         font-size: 1.8rem; /* Tăng kích thước chữ */
         font-weight: 500; /* Chữ đậm vừa */
         border: none;
         cursor: pointer;
         transition: all 0.3s ease; /* Hiệu ứng chuyển mượt */
         box-shadow: var(--box-shodow); /* Sử dụng bóng từ CSS gốc */
         margin-left: 1rem; /* Khoảng cách với nút Save Property */
      }
      .order-btn:hover {
         background-color: #218838; /* Màu xanh lá đậm hơn khi hover */
         transform: translateY(-2px); /* Hiệu ứng nâng nhẹ khi hover */
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

<!-- view property section starts -->
<section class="view-property">
   <div class="details">
      <%
         Connection conn = null;
         PreparedStatement stmt = null;
         ResultSet rs = null;
         String propertyIdStr = request.getParameter("id");

         // Kiểm tra tham số id
         if (propertyIdStr == null || propertyIdStr.trim().isEmpty()) {
      %>
      <p class="error">No property ID provided. Please go back to <a href="listings.jsp">All Listings</a>.</p>
      <% return; }

         int propertyId;
         try {
             propertyId = Integer.parseInt(propertyIdStr);
         } catch (NumberFormatException e) {
      %>
      <p class="error">Invalid property ID format. Please go back to <a href="listings.jsp">All Listings</a>.</p>
      <% return; }

         try {
            conn = DatabaseUtil.getConnection();
            if (conn == null) {
      %>
      <p class="error">Failed to connect to the database. Please check the server configuration.</p>
      <% return; }

            String sql = "SELECT * FROM properties WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, propertyId);
            rs = stmt.executeQuery();

            if (rs.next()) {
               String name = rs.getString("name") != null ? rs.getString("name") : "Unnamed Property";
               String location = rs.getString("location") != null ? rs.getString("location") : "Unknown";
               String price = rs.getString("price") != null ? rs.getString("price") : "N/A";
               String image = rs.getString("image") != null ? rs.getString("image") : "images/default.jpg";
               String images = rs.getString("images") != null ? rs.getString("images") : image;
               String[] imageArray = images.split(",");
               String owner = rs.getString("owner") != null ? rs.getString("owner") : "Unknown";
               String phone = rs.getString("phone") != null ? rs.getString("phone") : "N/A";
               String type = rs.getString("type") != null ? rs.getString("type") : "N/A";
               String status = rs.getString("status") != null ? rs.getString("status") : "N/A";
               String postedDate = rs.getString("posted_date") != null ? rs.getString("posted_date") : "N/A";
               String rooms = rs.getString("rooms") != null ? rs.getString("rooms") : "N/A";
               String deposit = rs.getString("deposit") != null ? rs.getString("deposit") : "N/A";
               String propertyStatus = rs.getString("property_status") != null ? rs.getString("property_status") : "N/A";
               int bedrooms = rs.getInt("bedrooms");
               int bathrooms = rs.getInt("bathrooms");
               int balcony = rs.getInt("balcony");
               String area = rs.getString("area") != null ? rs.getString("area") : "N/A";
               String age = rs.getString("age") != null ? rs.getString("age") : "N/A";
               String roomFloor = rs.getString("room_floor") != null ? rs.getString("room_floor") : "N/A";
               String totalFloors = rs.getString("total_floors") != null ? rs.getString("total_floors") : "N/A";
               String furnished = rs.getString("furnished") != null ? rs.getString("furnished") : "N/A";
               String loan = rs.getString("loan") != null ? rs.getString("loan") : "N/A";
               String amenities = rs.getString("amenities") != null ? rs.getString("amenities").trim() : "";
               String description = rs.getString("description") != null ? rs.getString("description") : "No description available.";
      %>
      <div class="thumb">
         <div class="big-image">
            <img src="<%= image %>" alt="<%= name %>">
         </div>
         <div class="small-images">
            <% 
               if (imageArray.length > 0 && !images.isEmpty()) {
                   for (String img : imageArray) {
                       if (img != null && !img.trim().isEmpty()) {
            %>
            <img src="<%= img.trim() %>" alt="<%= name %>">
            <% 
                       }
                   }
               } else {
            %>
            <img src="<%= image %>" alt="<%= name %>">
            <% } %>
         </div>
      </div>
      <h3 class="name"><%= name %></h3>
      <p class="location"><i class="fas fa-map-marker-alt"></i><span><%= location %></span></p>
      <div class="info">
         <p><i class="fas fa-tag"></i><span><%= price %></span></p>
         <p><i class="fas fa-user"></i><span><%= owner %> (owner)</span></p>
         <p><i class="fas fa-phone"></i><a href="tel:<%= phone %>"><%= phone %></a></p>
         <p><i class="fas fa-building"></i><span><%= type %></span></p>
         <p><i class="fas fa-house"></i><span><%= status %></span></p>
         <p><i class="fas fa-calendar"></i><span><%= postedDate %></span></p>
      </div>
      <h3 class="title">details</h3>
      <div class="flex">
         <div class="box">
            <p><i>rooms :</i><span><%= rooms %></span></p>
            <p><i>deposit amount :</i><span><%= deposit %></span></p>
            <p><i>status :</i><span><%= propertyStatus %></span></p>
            <p><i>bedroom :</i><span><%= bedrooms %></span></p>
            <p><i>bathroom :</i><span><%= bathrooms %></span></p>
            <p><i>balcony :</i><span><%= balcony %></span></p>
         </div>
         <div class="box">
            <p><i>carpet area :</i><span><%= area %></span></p>
            <p><i>age :</i><span><%= age %></span></p>
            <p><i>room floor :</i><span><%= roomFloor %></span></p>
            <p><i>total floors :</i><span><%= totalFloors %></span></p>
            <p><i>furnished :</i><span><%= furnished %></span></p>
            <p><i>loan :</i><span><%= loan %></span></p>
         </div>
      </div>
      <h3 class="title">amenities</h3>
      <div class="flex">
         <div class="box">
            <p><i class="<%= amenities.contains("lifts") ? "fas fa-check" : "fas fa-times" %>"></i><span>lifts</span></p>
            <p><i class="<%= amenities.contains("security guards") ? "fas fa-check" : "fas fa-times" %>"></i><span>security guards</span></p>
            <p><i class="fas fa-times"></i><span>play ground</span></p>
            <p><i class="<%= amenities.contains("gardens") ? "fas fa-check" : "fas fa-times" %>"></i><span>gardens</span></p>
            <p><i class="<%= amenities.contains("water supply") ? "fas fa-check" : "fas fa-times" %>"></i><span>water supply</span></p>
            <p><i class="<%= amenities.contains("power backup") ? "fas fa-check" : "fas fa-times" %>"></i><span>power backup</span></p>
         </div>
         <div class="box">
            <p><i class="<%= amenities.contains("parking area") ? "fas fa-check" : "fas fa-times" %>"></i><span>parking area</span></p>
            <p><i class="fas fa-times"></i><span>gym</span></p>
            <p><i class="<%= amenities.contains("shopping mall") ? "fas fa-check" : "fas fa-times" %>"></i><span>shopping mall</span></p>
            <p><i class="<%= amenities.contains("hospital") ? "fas fa-check" : "fas fa-times" %>"></i><span>hospital</span></p>
            <p><i class="<%= amenities.contains("schools") ? "fas fa-check" : "fas fa-times" %>"></i><span>schools</span></p>
            <p><i class="<%= amenities.contains("market area") ? "fas fa-check" : "fas fa-times" %>"></i><span>market area</span></p>
         </div>
      </div>
      <h3 class="title">description</h3>
      <p class="description"><%= description %></p>
      <div style="display: flex; align-items: center;">
         <form action="SavePropertyServlet" method="post" class="save"> 
            <input type="hidden" name="propertyId" value="<%= propertyId %>">
            <input type="submit" value="save property" name="save" class="inline-btn">
         </form>
         <% if ("student".equals(session.getAttribute("role"))) { %>
            <form action="OrderHouseServlet" method="post" style="display:inline;">
               <input type="hidden" name="property_id" value="<%= propertyId %>">
               <button type="submit" class="order-btn">Order</button>
            </form>
         <% } %>
      </div>
      <% } else { %>
      <p class="error">Property not found. Please go back to <a href="listings.jsp">All Listings</a>.</p>
      <% } %>
      <% } catch (SQLException e) { %>
      <p class="error">Error loading property: <%= e.getMessage() %></p>
      <p class="error">Please ensure the database is set up correctly and the server is running.</p>
      <% } catch (Exception e) { %>
      <p class="error">Unexpected error: <%= e.getMessage() %></p>
      <p class="error">Please go back to <a href="listings.jsp">All Listings</a> and try again.</p>
      <% } finally {
         if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
         if (stmt != null) try { stmt.close(); } catch (SQLException ignored) {}
         DatabaseUtil.closeConnection(conn);
      } %>
   </div>
</section>
<!-- view property section ends -->

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
```