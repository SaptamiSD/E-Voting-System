<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert Voter Registration Data</title>
</head>
<body>
    <h1> </h1>

    <% 
        String url = "jdbc:mysql://localhost:3306/e-voter";
        String user = "root";
        String dbPassword = ""; // Rename this variable
        
        String voterid = request.getParameter("voterid");
        String dob = request.getParameter("dob");
        String userPassword = request.getParameter("password"); // Rename this variable
        String name = request.getParameter("name");
        String fathername = request.getParameter("fathername");
        String gender = request.getParameter("gender");
        String address = request.getParameter("address");
        String mobilenumber = request.getParameter("mobilenumber");
        String email = request.getParameter("email");

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            // Calculate the age based on date of birth
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date dobDate = sdf.parse(dob);
            Calendar dobCal = Calendar.getInstance();
            dobCal.setTime(dobDate);
            int yearOfBirth = dobCal.get(Calendar.YEAR);

            Calendar todayCal = Calendar.getInstance();
            int currentYear = todayCal.get(Calendar.YEAR);
            int age = currentYear - yearOfBirth;

            if (todayCal.get(Calendar.DAY_OF_YEAR) < dobCal.get(Calendar.DAY_OF_YEAR)) {
                age--; // If the birthday hasn't occurred yet this year
            }

            if (age >= 18) {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection(url, user, dbPassword);

                // Check if the voter already exists
                String checkSql = "SELECT COUNT(*) FROM voterreg WHERE voterid = ? OR email = ? OR name = ?";
                pstmt = conn.prepareStatement(checkSql);
                pstmt.setString(1, voterid);
                pstmt.setString(2, email);
                pstmt.setString(3, name);
                rs = pstmt.executeQuery();

                rs.next();
                int count = rs.getInt(1);

                if (count > 0) {
                    out.println("Registration failed: Voter with the same ID, email, or name already exists.");
                } else {
                    // Insert the new voter
                    String insertSql = "INSERT INTO voterreg (voterid, dob, age, password, name, fathername, gender, address, mobilenumber, email) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                    pstmt = conn.prepareStatement(insertSql);
                    pstmt.setString(1, voterid);
                    pstmt.setString(2, dob);
                    pstmt.setInt(3, age);
                    pstmt.setString(4, userPassword);
                    pstmt.setString(5, name);
                    pstmt.setString(6, fathername);
                    pstmt.setString(7, gender);
                    pstmt.setString(8, address);
                    pstmt.setString(9, mobilenumber);
                    pstmt.setString(10, email);

                    int rowsAffected = pstmt.executeUpdate();

                    if (rowsAffected > 0) {
                        out.println("Voter Registered successfully!");
                    } else {
                        out.println("Failed to Register.");
                    }
                }
            } else {
                out.println("Registration failed: Voter must be above 18 years of age.");
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
    <div class="message-box">
        <a class="go-back-button" href="index.html">Go Back</a>
    </div>
</body>
</html>
