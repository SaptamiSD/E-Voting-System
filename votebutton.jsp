<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Voter Login Result</title>
</head>
<body>
    <h1>Voter Login Result</h1>

    <%
    String url = "jdbc:mysql://localhost:3306/e-voter";
    String user = "root";
    String dbPassword = ""; // Rename this variable

    String enteredVoterID = request.getParameter("voterid");
    String enteredPassword = request.getParameter("password");

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, dbPassword);

        String sql = "SELECT * FROM voterreg WHERE voterid = ? AND password = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, enteredVoterID);
        pstmt.setString(2, enteredPassword);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            // Voter authentication successful
            // Redirect to candisplay.jsp
            response.sendRedirect("votecount.jsp");
        } else {
            // Voter authentication failed
            out.println("Login failed. Please check your Voter ID and password.");
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
