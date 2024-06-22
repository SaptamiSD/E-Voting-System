<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
    try {
        String name = request.getParameter("name");
        String phonenumber = request.getParameter("phonenumber");
        String email = request.getParameter("email");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");

        // Validate inputs
        if (name == null || name.isEmpty() ||
            phonenumber == null || phonenumber.isEmpty() ||
            email == null || email.isEmpty() ||
            subject == null || subject.isEmpty() ||
            message == null || message.isEmpty()) {

            out.println("<font size='+3' color='red'>Error: All fields are required!</font>");
        } else {
            String URL = "jdbc:mysql://localhost:3306/e-voter";

            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection(URL, "root", "");

            out.println("<font size='+3' color='green'>Successfully connected <br></font>");

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO messageus (name, phonenumber, email, subject, message) VALUES (?, ?, ?, ?, ?)");
            
            ps.setString(1, name);
            ps.setString(2, phonenumber);
            ps.setString(3, email);
            ps.setString(4, subject);
            ps.setString(5, message);

            ps.executeUpdate();

            out.println("<font size='+3' color='green'>Data inserted to table</font>");
            con.close();
        }
    } catch (Exception e) {
%>
        <font size="+3" color="red">
<%
        out.println("Unable to process: " + e.getMessage());
    }
%>
</font>
</body>
</html>
