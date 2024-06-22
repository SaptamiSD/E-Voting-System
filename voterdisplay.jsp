<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>VOTERS LIST</title>
    <style>
        body {
            background-color: #f2f2f2;
            font-family: Arial, sans-serif;
            text-align: center;
        }

        h1 {
            color: #007bff;
        }

        table {
            margin: 20px auto;
            border-collapse: collapse;
            width: 80%;
            background-color: white;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
        }

        th, td {
            padding: 10px;
            text-align: center;
        }

        th {
            background-color: #007bff;
            color: white;
        }

        td {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <h1>VOTERS LIST</h1>

    <table border='1'>
        <tr>
            <th>Name</th>
            <th>Father's Name</th>
            <th>Gender</th>
            <th>Address</th>
            <th>Mobile Number</th>
            <th>Email</th>
            
        </tr>

        <%
        String url = "jdbc:mysql://localhost:3306/e-voter";
        String user = "root";
        String dbPassword = ""; // Rename this variable
        
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, dbPassword);

            String sql = "SELECT name, fathername, gender, address, mobilenumber, email, COUNT(*) as votes FROM voterreg GROUP BY name, fathername, gender, address, mobilenumber, email";
            stmt = conn.createStatement();
            rs = stmt.executeQuery(sql);

            while (rs.next()) {
                String name = rs.getString("name");
                String fathername = rs.getString("fathername");
                String gender = rs.getString("gender");
                String address = rs.getString("address");
                String mobilenumber = rs.getString("mobilenumber");
                String email = rs.getString("email");
                

                out.println("<tr>");
                out.println("<td>" + name + "</td>");
                out.println("<td>" + fathername + "</td>");
                out.println("<td>" + gender + "</td>");
                out.println("<td>" + address + "</td>");
                out.println("<td>" + mobilenumber + "</td>");
                out.println("<td>" + email + "</td>");
              
                out.println("</tr>");
            }

        } catch (Exception e) {
            out.println("An error occurred: " + e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                out.println("Error closing database connections: " + e.getMessage());
            }
        }
        %>
    </table>
</body>
</html>
