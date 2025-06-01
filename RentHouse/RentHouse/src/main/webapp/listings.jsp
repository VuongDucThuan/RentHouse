
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.university.renthouse.model.Property" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="jakarta.servlet.http.HttpServletResponse" %>

<%
    // Redirect đến ListingsServlet nếu không có dữ liệu
    if (request.getAttribute("properties") == null) {
        response.sendRedirect("ListingsServlet");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Listings</title>

    <!-- font awesome cdn link -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">

    <!-- custom css file link -->
    <link rel="stylesheet" href="css/style.css">

    <style>
        .error-message {
            text-align: center;
            margin: 10px 0;
            padding: 10px;
            border-radius: 5px;
            color: #721c24;
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
        }
        .success-message {
            text-align: center;
            margin: 10px 0;
            padding: 10px;
            border-radius: 5px;
            color: #155724;
            background-color: #d4edda;
            border: 1px solid #c3e6cb;
        }
        .box .details {
            margin-top: 10px;
            font-size: 14px;
            color: #666;
        }
        .box .details span {
            margin-right: 10px;
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

<!-- listings section starts -->
<section class="listings">
    <h1 class="heading">all listings</h1>
    <% 
        String errorMessage = (String) request.getAttribute("errorMessage");
        if (errorMessage != null) {
            out.println("<p class='error-message'>" + errorMessage + "</p>");
        }
        String successMessage = request.getParameter("success");
        if (successMessage != null) {
            out.println("<p class='success-message'>" + successMessage + "</p>");
        }
        String error = request.getParameter("error");
        if (error != null) {
            out.println("<p class='error-message'>" + error + "</p>");
        }
    %>
    <div class="box-container">
        <%
            List<Property> properties = (List<Property>) request.getAttribute("properties");
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
            String role = (String) session.getAttribute("role");
            if (properties != null && !properties.isEmpty()) {
                for (Property property : properties) {
        %>
        <div class="box">
            <div class="admin">
                <h3><%= property.getOwner() != null && !property.getOwner().isEmpty() ? property.getOwner().charAt(0) : "U" %></h3>
                <div>
                    <p><%= property.getOwner() != null && !property.getOwner().isEmpty() ? property.getOwner() : "Unknown" %></p>
                    <span><%= property.getPostedDate() != null ? dateFormat.format(property.getPostedDate()) : "N/A" %></span>
                </div>
            </div>
            <div class="thumb">
                <p class="total-images"><i class="far fa-image"></i><span><%= property.getTotalImages() %></span></p>
                <p class="type"><span><%= property.getType() != null ? property.getType() : "N/A" %></span><span><%= property.getStatus() != null ? property.getStatus() : "N/A" %></span></p>
                <form action="SavePropertyServlet" method="POST" class="save">
                    <input type="hidden" name="propertyId" value="<%= property.getId() %>">
                    <button type="submit" name="save" class="far fa-heart"></button>
                </form>
                <img src="<%= property.getImage() != null && !property.getImage().isEmpty() ? property.getImage() : "images/default.jpg" %>" alt="">
            </div>
            <h3 class="name"><%= property.getName() != null ? property.getName() : "Unnamed Property" %></h3>
            <p class="location"><i class="fas fa-map-marker-alt"></i><span><%= property.getLocation() != null ? property.getLocation() : "Unknown Location" %></span></p>
            <div class="flex">
                <p><i class="fas fa-bed"></i><span><%= property.getBedrooms() %></span></p>
                <p><i class="fas fa-bath"></i><span><%= property.getBathrooms() %></span></p>
                <p><i class="fas fa-maximize"></i><span><%= property.getArea() != null ? property.getArea() : "N/A" %> sqft</span></p>
            </div>
            <div class="details">
                <span>Furnished: <%= property.getFurnished() != null ? property.getFurnished() : "N/A" %></span>
                <span>Status: <%= property.getPropertyStatus() != null ? property.getPropertyStatus() : "N/A" %></span>
            </div>
            <a href="viewproperty.jsp?id=<%= property.getId() %>" class="btn">view property</a>
            <% if ("student".equals(role)) { %>
                <form action="OrderHouseServlet" method="post" style="display:inline;">
                    <input type="hidden" name="property_id" value="<%= property.getId() %>">
                    <button type="submit" class="order-btn">Order</button>
                </form>
            <% } %>
        </div>
        <%
                }
            } else if (errorMessage == null) {
                out.println("<p class='error-message'>No listings available at the moment.</p>");
            }
        %>
    </div>
</section>
<!-- listings section ends -->

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