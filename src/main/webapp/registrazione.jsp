<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registrazione - Basilicata Express</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f4f9; text-align: center; padding: 20px;}
        .box { background: white; width: 350px; margin: 0 auto; padding: 20px; border-radius: 8px; box-shadow: 0px 0px 10px rgba(0,0,0,0.1); }
        input[type="text"], input[type="email"], input[type="password"] { width: 90%; padding: 10px; margin: 10px 0; border: 1px solid #ccc; border-radius: 4px; }
        input[type="submit"] { background-color: #ff6600; color: white; padding: 10px 20px; border: none; border-radius: 4px; cursor: pointer; font-weight: bold;}
        input[type="submit"]:hover { background-color: #e65c00; }
        .errore { color: red; font-weight: bold; }
    </style>
</head>
<body>

    <div class="box">
        <h2 style="color: #004aad;">Crea un Account 🚂</h2>
        
        <% 
            String errore = (String) request.getAttribute("errore");
            if(errore != null) { 
        %>
            <p class="errore"><%= errore %></p>
        <% 
            } 
        %>

        <form action="RegistrazioneServlet" method="post">
            <input type="text" name="nome" placeholder="Il tuo Nome" required>
            <br>
            <input type="text" name="cognome" placeholder="Il tuo Cognome" required>
            <br>
            <input type="email" name="email" placeholder="La tua Email" required>
            <br>
            <input type="password" name="password" placeholder="Scegli una Password" required>
            <br>
            <input type="submit" value="Registrati">
        </form>
        
        <p style="margin-top: 15px; font-size: 14px;">
            Hai già un account? <a href="login.jsp" style="color: #004aad;">Accedi qui</a>
        </p>
    </div>

</body>
</html>