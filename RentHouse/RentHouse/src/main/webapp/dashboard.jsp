<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.university.renthouse.util.DatabaseUtil" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - MyHome</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">
    <link rel="stylesheet" href="css/style.css">
    <style>
        .dashboard {
            padding: 2rem;
            text-align: center;
        }
        .dashboard h3 {
            font-size: 2.5rem;
            margin-bottom: 1rem;
            color: #333;
        }
        .dashboard .buttons {
            margin: 1rem 0;
        }
        .dashboard .buttons a {
            display: inline-block;
            padding: 0.8rem 2rem;
            margin: 0.5rem;
            background-color: #007bff;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
            font-size: 1.2rem;
        }
        .dashboard .buttons a:hover {
            background-color: #0056b3;
        }
        .properties-list, .orders-list {
            margin-top: 2rem;
        }
        .properties-list h4, .orders-list h4 {
            font-size: 2rem;
            margin-bottom: 1rem;
            color: #444;
        }
        .properties-table, .orders-table {
            width: 100%;
            border-collapse: collapse;
            margin: 0 auto;
            max-width: 1200px;
        }
        .properties-table th, .properties-table td, .orders-table th, .orders-table td {
            padding: 1rem;
            border: 1px solid #ddd;
            text-align: left;
        }
        .properties-table th, .orders-table th {
            background-color: #f4f4f4;
            font-weight: bold;
        }
        .properties-table tr:nth-child(even), .orders-table tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        .properties-table tr:hover, .orders-table tr:hover {
            background-color: #f1f1f1;
        }
        .no-properties, .no-orders {
            font-style: italic;
            color: #777;
            margin-top: 1rem;
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
        .error-message {
            text-align: center;
            margin: 10px 0;
            padding: 10px;
            border-radius: 5px;
            color: #721c24;
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
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
<!-- dashboard section starts -->
    <section class="dashboard">
        <h3>Welcome, <%= username %>! (Role: <%= session.getAttribute("role") %>)</h3>
        <div class="buttons">
            <% if ("landlord".equals(session.getAttribute("role"))) { %>
                <a href="postproperty.jsp">Post a New Property</a>
            <% } else if ("student".equals(session.getAttribute("role"))) { %>
                <a href="listings.jsp">Find a House</a>
            <% } else if ("staff".equals(session.getAttribute("role"))) { %>
                <a href="managelandlords.jsp">Manage Landlords</a>
                <a href="managestudents.jsp">Manage Students</a>
                <a href="manageorders.jsp">Manage Orders</a>
            <% } %>
        </div>

        <% 
            String successMessage = request.getParameter("success");
            if (successMessage != null) {
                out.println("<div class='success-message'>" + successMessage + "</div>");
            }
            String errorMessage = request.getParameter("error");
            if (errorMessage != null) {
                out.println("<div class='error-message'>" + errorMessage + "</div>");
            }
        %>

        <% if ("student".equals(session.getAttribute("role"))) { %>
            <div class="properties-list">
                <h4>Your Ordered Properties</h4>
                <%
                    Connection conn = null;
                    PreparedStatement stmt = null;
                    ResultSet rs = null;
                    try {
                        conn = DatabaseUtil.getConnection();
                        String query = "SELECT o.id, o.property_id, o.order_date, o.status, p.name, p.type, p.price, p.location " +
                                      "FROM orders o JOIN properties p ON o.property_id = p.id " +
                                      "WHERE o.student_email = ?";
                        stmt = conn.prepareStatement(query);
                        stmt.setString(1, username);
                        rs = stmt.executeQuery();

                        if (!rs.isBeforeFirst()) {
                            out.println("<p class='no-properties'>You have not ordered any properties yet.</p>");
                        } else {
                %>
                            <table class="properties-table">
                                <thead>
                                    <tr>
                                        <th>Order ID</th>
                                        <th>Property Name</th>
                                        <th>Type</th>
                                        <th>Price</th>
                                        <th>Location</th>
                                        <th>Order Date</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        while (rs.next()) {
                                    %>
                                        <tr>
                                            <td><%= rs.getInt("id") %></td>
                                            <td><%= rs.getString("name") %></td>
                                            <td><%= rs.getString("type") %></td>
                                            <td><%= rs.getString("price") %></td>
                                            <td><%= rs.getString("location") %></td>
                                            <td><%= rs.getDate("order_date") %></td>
                                            <td><%= rs.getString("status") %></td>
                                        </tr>
                                    <%
                                        }
                                    %>
                                </tbody>
                            </table>
                <%
                        }
                    } catch (SQLException e) {
                        out.println("<p class='error-message'>Error retrieving ordered properties: " + e.getMessage() + "</p>");
                    } finally {
                        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                        if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                    }
                %>
            </div>
        <% } else if ("landlord".equals(session.getAttribute("role"))) { %>
            <div class="properties-list">
                <h4>Your Posted Properties</h4>
                <%
                    Connection conn = null;
                    PreparedStatement stmt = null;
                    ResultSet rs = null;
                    try {
                        conn = DatabaseUtil.getConnection();
                        String query = "SELECT * FROM properties WHERE owner = ?";
                        stmt = conn.prepareStatement(query);
                        stmt.setString(1, username);
                        rs = stmt.executeQuery();

                        if (!rs.isBeforeFirst()) {
                            out.println("<p class='no-properties'>You have not posted any properties yet.</p>");
                        } else {
                %>
                            <table class="properties-table">
                                <thead>
                                    <tr>
                                        <th>Name</th>
                                        <th>Type</th>
                                        <th>Status</th>
                                        <th>Price</th>
                                        <th>Location</th>
                                        <th>Posted Date</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        while (rs.next()) {
                                    %>
                                        <tr>
                                            <td><%= rs.getString("name") %></td>
                                            <td><%= rs.getString("type") %></td>
                                            <td><%= rs.getString("status") %></td>
                                            <td><%= rs.getString("price") %></td>
                                            <td><%= rs.getString("location") %></td>
                                            <td><%= rs.getDate("posted_date") %></td>
                                            <td>
                                                <form action="DeletePropertyServlet" method="post" style="display:inline;">
                                                    <input type="hidden" name="property_id" value="<%= rs.getInt("id") %>">
                                                    <button type="submit" class="action-btn delete-btn" style="cursor: pointer;">Delete</button>
                                                </form>
                                            </td>
                                        </tr>
                                    <%
                                        }
                                    %>
                                </tbody>
                            </table>
                <%
                        }
                    } catch (SQLException e) {
                        out.println("<p class='error-message'>Error retrieving properties: " + e.getMessage() + "</p>");
                    } finally {
                        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                        if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                    }
                %>
            </div>

            <div class="orders-list">
                <h4>Orders for Your Properties</h4>
                <%
                    try {
                        conn = DatabaseUtil.getConnection();
                        String query = "SELECT o.id, o.property_id, o.student_email, o.order_date, o.status, p.name " +
                                      "FROM orders o JOIN properties p ON o.property_id = p.id " +
                                      "WHERE o.landlord_email = ?";
                        stmt = conn.prepareStatement(query);
                        stmt.setString(1, username);
                        rs = stmt.executeQuery();

                        if (!rs.isBeforeFirst()) {
                            out.println("<p class='no-orders'>No orders for your properties yet.</p>");
                        } else {
                %>
                            <table class="orders-table">
                                <thead>
                                    <tr>
                                        <th>Order ID</th>
                                        <th>Property Name</th>
                                        <th>Student Email</th>
                                        <th>Order Date</th>
                                        <th>Status</th>
                                        <th>Actions</th>
             
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        while (rs.next()) {
                                    %>
                                        <tr>
                                            <td><%= rs.getInt("id") %></td>
                                            <td><%= rs.getString("name") %></td>
                                            <td><%= rs.getString("student_email") %></td>
                                            <td><%= rs.getDate("order_date") %></td>
                                            <td><%= rs.getString("status") %></td>
                                          
                                            <td>
                                                <form action="ManageOrderServlet" method="post" style="display:inline;">
                                                    <input type="hidden" name="order_id" value="<%= rs.getInt("id") %>">
                                                    <input type="hidden" name="action" value="confirm">
                                                    <button type="submit" class="action-btn confirm-btn" style="cursor: pointer;">Confirm</button>
                                                </form>
                                                <form action="ManageOrderServlet" method="post" style="display:inline;">
                                                    <input type="hidden" name="order_id" value="<%= rs.getInt("id") %>">
                                                    <input type="hidden" name="action" value="cancel">
                                                    <button type="submit" class="action-btn cancel-btn" style="cursor: pointer;">Cancel</button>
                                                </form>
                                            </td>
                                        </tr>
                                    <%
                                        }
                                    %>
                                </tbody>
                            </table>
                <%
                        }
                    } catch (SQLException e) {
                        out.println("<p class='error-message'>Error retrieving orders: " + e.getMessage() + "</p>");
                    } finally {
                        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                        if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                    }
                %>
            </div>
        <% } else if ("staff".equals(session.getAttribute("role"))) { %>
            <!-- Thêm nội dung cho staff nếu cần -->
        <% } %>
    </section>
<!-- dashboard section ends -->
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
</body>
</html>