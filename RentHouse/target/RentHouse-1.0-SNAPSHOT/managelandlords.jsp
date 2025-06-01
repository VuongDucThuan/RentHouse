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
    <title>Manage Landlords - MyHome</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">
    <link rel="stylesheet" href="css/style.css">
    <style>
        .manage-landlords {
            padding: 2rem;
            text-align: center;
        }
        .manage-landlords h3 {
            font-size: 2.5rem;
            margin-bottom: 1rem;
            color: #333;
        }
        .landlords-table {
            width: 100%;
            border-collapse: collapse;
            margin: 0 auto;
            max-width: 1200px;
        }
        .landlords-table th, .landlords-table td {
            padding: 1rem;
            border: 1px solid #ddd;
            text-align: left;
        }
        .landlords-table th {
            background-color: #f4f4f4;
            font-weight: bold;
        }
        .landlords-table tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        .landlords-table tr:hover {
            background-color: #f1f1f1;
        }
        .no-landlords {
            font-style: italic;
            color: #777;
            margin-top: 1rem;
        }
        .action-btn {
            padding: 0.5rem 1rem;
            margin: 0.2rem;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .delete-btn {
            background-color: #dc3545;
            color: #fff;
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
            <li><a href="dashboard.jsp">Back to Dashboard</a></li>
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

    <section class="manage-landlords">
        <h3>Manage Landlords</h3>
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

        <%
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;
            try {
                conn = DatabaseUtil.getConnection();
                String query = "SELECT email,phone FROM users WHERE role = 'landlord'";
                stmt = conn.prepareStatement(query);
                rs = stmt.executeQuery();

                if (!rs.isBeforeFirst()) {
                    out.println("<p class='no-landlords'>No landlords found.</p>");
                } else {
        %>
                    <table class="landlords-table">
                        <thead>
                            <tr>
                                <th>Email</th>
                                <th>Phone</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                while (rs.next()) {
                            %>
                                <tr>
                                    <td><%= rs.getString("email") %></td>
                                    <td><%= rs.getString("phone") %></td>
                                    <td>
                                        <form action="DeleteLandlordServlet" method="post" style="display:inline;">
                                            <input type="hidden" name="email" value="<%= rs.getString("email") %>">
                                            <button type="submit" class="action-btn delete-btn">Delete</button>
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
                out.println("<p class='error-message'>Error retrieving landlords: " + e.getMessage() + "</p>");
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        %>
    </section>

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

    <script src="js/script.js"></script>
</body>
</html>