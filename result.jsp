<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Final Result</title>
    <style>
        body {
            background-image: url("assets/images/book.jpg");
            background-repeat: no-repeat;
            background-size: cover;
            background-attachment: fixed;
            /* You can also set background-position if you want to position the image */
        }

        h1 {
            text-align: center;
        }

        table {
            margin: 0 auto;
            border-collapse: collapse;
            width: 80%;
        }

        th, td {
            padding: 10px;
            text-align: center;
        }

        th {
            background-color: #D0E4F5;
        }

        td {
            background-color: white;
            box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.2);
        }

        a {
            color: #000;
            text-decoration: none;
        }

        a:hover {
            opacity: 0.8;
            box-shadow: 4px 4px 10px rgba(0, 0, 0, 0.4);
        }

        p {
            text-align: center;
        }
    </style>
</head>
<body>
    <h1>FINAL RESULT</h1>

    <form method="post">
        <table border='1'>
            <tr>
                <th>SlNo</th>
                <th>CANDIDATE NAME</th>
                <th>PARTY NAME</th>
                <th>No OF VOTES</th>
                
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

                String sql = "SELECT * FROM canreg";
                stmt = conn.createStatement();
                rs = stmt.executeQuery(sql);

                while (rs.next()) {
                    
                    String slno = rs.getString("slno");
                    String candidatename = rs.getString("candidatename");
                    String partyname = rs.getString("partyname");
                    int no_of_votes= rs.getInt("no_of_votes");
                   

                    out.println("<tr>");
                    // Display Party Symbol image
                   
                    out.println("<td>" + slno + "</td>");
                    out.println("<td>" + candidatename + "</td>");
                    out.println("<td>" + partyname+ "</td>");
                    out.println("<td>" + no_of_votes+ "</td>");
                    // Add a Vote button for each candidate
                   
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
        
    </form>
    <br><br>
    <div class="message-box">
        <a class="go-back-button" href="index.html">Go Back</a>
    </div>
</body>
</html>
