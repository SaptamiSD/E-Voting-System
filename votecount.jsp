<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Vote for Candidates</title>
    <style>
        <!-- Your CSS styles here -->
        <style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f0f0f0;
    }

    h1 {
        text-align: center;
        color: #333;
    }

    table {
        width: 80%;
        margin: 20px auto;
        border-collapse: collapse;
        background-color: #fff;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    th, td {
        padding: 10px;
        text-align: left;
    }

    th {
        background-color: #333;
        color: #fff;
    }

    tr:nth-child(even) {
        background-color: #f2f2f2;
    }

    input[type="radio"] {
        transform: scale(1.5); /* Increase radio button size */
    }

    input[type="submit"] {
        display: block;
        margin: 20px auto;
        padding: 10px 20px;
        background-color: #333;
        color: #fff;
        border: none;
        cursor: pointer;
        transition: background-color 0.3s ease-in-out;
    }

    input[type="submit"]:hover {
        background-color: #555;
    }

    p {
        text-align: center;
        margin-top: 10px;
        color: #333;
    }
</style>
        
    </style>
</head>
<body>
    <h1>VOTE HERE</h1>

    <form action="" method="post">
        <table border='1'>
            <tr>
                <th>Sl. No</th>
                <th>Candidate Name</th>
                <th>Party Name</th>
                <th>Vote</th>
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

                String sql = "SELECT slno, candidatename, partyname FROM canreg";
                stmt = conn.createStatement();
                rs = stmt.executeQuery(sql);

                while (rs.next()) {
                    String slno = rs.getString("slno");
                    String candidatename = rs.getString("candidatename");
                    String partyname = rs.getString("partyname");

                    out.println("<tr>");
                    out.println("<td>" + slno + "</td>");
                    out.println("<td>" + candidatename + "</td>");
                    out.println("<td>" + partyname + "</td>");
                    // Add a hidden input field to store the candidate's name
                    out.println("<td><input type='radio' name='candidate' value='" + candidatename + "'></td>");
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
        <!-- Add a submit button to count the vote -->
        <input type="submit" name="countVote" value="Count Vote">
    </form>

    <%
 // Check if the user has already voted
    String hasVoted = (String) session.getAttribute("hasVoted");
    if (hasVoted != null && hasVoted.equals("true")) {
        out.println("<h2>You have already voted!</h2>");
    } else {

    // Check if the form has been submitted to count the vote
    if (request.getParameter("countVote") != null) {
        String selectedCandidateName = request.getParameter("candidate");
        
        if (selectedCandidateName != null && !selectedCandidateName.isEmpty()) {
            try {
                conn = DriverManager.getConnection(url, user, dbPassword);

                // Update the vote count for the selected candidate
                String updateVoteCountSQL = "UPDATE canreg SET no_of_votes = no_of_votes + 1 WHERE candidatename = ?";
                PreparedStatement updateVoteCountStmt = conn.prepareStatement(updateVoteCountSQL);
                updateVoteCountStmt.setString(1, selectedCandidateName);

                int rowsAffected = updateVoteCountStmt.executeUpdate();
                
                if (rowsAffected > 0) {
                    out.println("<p>Your vote for " + selectedCandidateName + " has been counted.</p>");
                } else {
                    out.println("<p>Failed to count your vote.</p>");
                }
            } catch (Exception e) {
                out.println("An error occurred: " + e.getMessage());
            } finally {
                try {
                    if (conn != null) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    out.println("Error closing database connections: " + e.getMessage());
                }
            }
         // Here, we'll just set a session attribute to mark that the user has voted
            session.setAttribute("hasVoted", "true");
            out.println("<h2>Thank you for voting!</h2>");
        }
        } else {
            out.println("<p>Please select a candidate to vote.</p>");
        }
    }
   


 

    %>
     <div class="message-box">
       
        <a class="go-back-button" href="index.html">Go Back</a>
    </div>
</body>
</html>