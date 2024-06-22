<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert Voter Registration Data</title>
</head>
<body>
    <h1>Insert Voter Registration Data</h1>

    <% 
        String url = "jdbc:mysql://localhost:3306/e-voter";
        String user = "root";
        String dbPassword = ""; // Rename this variable

        String slno = request.getParameter("slno");
        String candidatename = request.getParameter("candidatename");
        String partyname = request.getParameter("partyname");

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, dbPassword);

            String sql = "INSERT INTO canreg (slno, candidatename, partyname) VALUES (?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, slno);
            pstmt.setString(2, candidatename);
            pstmt.setString(3, partyname);

            int rowsAffected = pstmt.executeUpdate();
            
            if (rowsAffected > 0) {
                out.println("Candidate Registered successfully!");
            } else {
                out.println("Failed to Register Candidate.");
            }
        } catch (Exception e) {
            out.println("An error occurred: " + e.getMessage());
        } finally {
            try {
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
