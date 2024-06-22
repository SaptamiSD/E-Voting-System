<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Login Result</title>
</head>
<body>
    <h1>Admin Login Result</h1>

    <%
    String url = "jdbc:mysql://localhost:3306/e-voter";
    String user = "root";
    String dbPassword = " "; // Rename this variable

    String enteredAdminID = request.getParameter("adminid");
    String enteredPassword = request.getParameter("password");

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, dbPassword);

        String sql = "SELECT * FROM admin WHERE adminid = ? AND password = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, enteredAdminID);
        pstmt.setString(2, enteredPassword);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            // Admin authentication successful
            // Redirect to adminbutton.jsp
            response.sendRedirect("adminbutton.jsp");
        } else {
            // Admin authentication failed
            out.println("Login failed. Please check your Admin ID and password.");
        }
    } catch (Exception e) {
        out.println("An error occurred: " + e.getMessage());
    } finally {
        try {
            if (rs != null) {
                rs.close();
            }
            if (pstmt != null) {
                pstmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException e) {
            out.println("Error closing database connections: " + e.getMessage());
        }
    }
    %>
</body>
</html>