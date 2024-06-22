<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Voter Login</title>
    <!-- Add your CSS styles here for Voter form styling -->
    <!-- ... (CSS styles remain the same) ... -->
</head>
<body class="voter">
    <div class="container voter">
        <h2 class="voter">Voter Login</h2>
        <form action="votebutton.jsp" method="POST"> <!-- Changed action to "votebutton.jsp" -->
            <label for="voterid" class="voter">Voter ID:</label>
            <input type="text" id="voterid" name="voterid" class="voter" required>

            <label for="password" class="voter">Password:</label>
            <input type="password" id="password" name="password" class="voter" required>

            <button type="submit" class="voter">Login</button>
        </form>
    </div>
</body>
</html>
