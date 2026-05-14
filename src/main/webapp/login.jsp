<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login - Basilicata Express</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f4f9; color: #333; padding: 20px; text-align: center;}
        .login-box { background: white; width: 300px; margin: 0 auto; padding: 20px; border-radius: 8px; box-shadow: 0px 0px 10px rgba(0,0,0,0.1); }
        input[type="text"], input[type="password"] { width: 90%; padding: 10px; margin: 10px 0; border: 1px solid #ccc; border-radius: 4px; }
        input[type="submit"] { background-color: #004aad; color: white; padding: 10px 20px; border: none; border-radius: 4px; cursor: pointer; }
        input[type="submit"]:hover { background-color: #ff6600; }
        .errore { color: red; font-weight: bold; }
    </style>
</head>
<body>

    <div class="login-box">
        <h2 style="color: #004aad;">Accedi 🚂</h2>
        
        <% 
            String errore = (String) request.getAttribute("errore");
            if(errore != null) { 
        %>
            <p class="errore"><%= errore %></p>
        <% 
            } 
        %>

        <form action="LoginServlet" method="post">
            <input type="text" name="emailUtente" placeholder="La tua Email" required>
            <br>
            <input type="password" name="passwordUtente" placeholder="La tua Password" required>
            <br>
            <input type="submit" value="Entra">
        </form>
    </div>

</body>
</html>