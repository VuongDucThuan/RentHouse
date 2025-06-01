<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, com.university.renthouse.util.DatabaseUtil, java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
   <meta charset="UTF-8">
   <meta http-equiv="X-UA-Compatible" content="IE=edge">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>Saved Properties</title>

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

<!-- saved properties section starts -->
<section class="listings">
   <h1 class="heading">saved properties</h1>
   <div class="box-container">
      <%
         HttpSession sessionObj = request.getSession(false);
         List<String> savedProperties = (List<String>) sessionObj.getAttribute("savedProperties");

         // Check if there are any saved properties
         if (sessionObj == null || savedProperties == null || savedProperties.isEmpty()) {
      %>
      <p class="error">You haven't saved any properties. Browse <a href="listings.jsp">all listings</a> to save some!</p>
      <%
         } else {
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;
            try {
               conn = DatabaseUtil.getConnection();
               if (conn == null) {
      %>
      <p class="error">Failed to connect to the database. Please try again later.</p>
      <%
                  return;
               }

               // Query details for each saved property
               String sql = "SELECT * FROM properties WHERE id = ?";
               stmt = conn.prepareStatement(sql);

               for (String propertyId : savedProperties) {
                  try {
                     stmt.setInt(1, Integer.parseInt(propertyId));
                     rs = stmt.executeQuery();
                     if (rs.next()) {
                        String name = rs.getString("name") != null ? rs.getString("name") : "Unnamed Property";
                        String location = rs.getString("location") != null ? rs.getString("location") : "Unknown";
                        String image = rs.getString("image") != null ? rs.getString("image") : "images/default.jpg";
                        String type = rs.getString("type") != null ? rs.getString("type") : "N/A";
                        String status = rs.getString("status") != null ? rs.getString("status") : "N/A";
                        String postedDate = rs.getString("posted_date") != null ? rs.getString("posted_date") : "N/A";
                        int bedrooms = rs.getInt("bedrooms");
                        int bathrooms = rs.getInt("bathrooms");
                        String area = rs.getString("area") != null ? rs.getString("area") : "N/A";
                        String images = rs.getString("images") != null ? rs.getString("images") : image;
                        String[] imageArray = images.split(",");
                        int totalImages = imageArray.length > 0 && !images.isEmpty() ? imageArray.length : 1;
      %>
      <div class="box">
         <div class="admin">
            <h3><%= name.charAt(0) %></h3>
            <div>
               <p><%= rs.getString("owner") != null ? rs.getString("owner") : "Unknown" %></p>
               <span><%= postedDate %></span>
            </div>
         </div>
         <div class="thumb">
            <p class="total-images"><i class="far fa-image"></i><span><%= totalImages %></span></p>
            <p class="type"><span><%= type %></span><span><%= status %></span></p>
            <form action="SavePropertyServlet" method="post" class="save">
               <input type="hidden" name="propertyId" value="<%= propertyId %>">
               <input type="hidden" name="action" value="remove">
               <button type="submit" name="save" class="fas fa-heart"></button>
            </form>
            <img src="<%= image %>" alt="<%= name %>">
         </div>
         <h3 class="name"><%= name %></h3>
         <p class="location"><i class="fas fa-map-marker-alt"></i><span><%= location %></span></p>
         <div class="flex">
            <p><i class="fas fa-bed"></i><span><%= bedrooms %></span></p>
            <p><i class="fas fa-bath"></i><span><%= bathrooms %></span></p>
            <p><i class="fas fa-maximize"></i><span><%= area %></span></p>
         </div>
         <a href="viewproperty.jsp?id=<%= propertyId %>" class="btn">view property</a>
      </div>
      <%
                     }
                  } catch (NumberFormatException | SQLException e) {
                     // Skip invalid propertyId
                     continue;
                  } finally {
                     if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
                  }
               }
            } catch (SQLException e) {
      %>
      <p class="error">Error loading saved properties: <%= e.getMessage() %></p>
      <p class="error">Please try again or contact support.</p>
      <%
            } finally {
               if (stmt != null) try { stmt.close(); } catch (SQLException ignored) {}
               DatabaseUtil.closeConnection(conn);
            }
         }
      %>
   </div>
</section>
<!-- saved properties section ends -->

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