<%@ page import="model.Utente" %>
<div class="header-bar">
    <div><strong>Basilicata Express </strong></div>
    <div>
        <% 
            Utente utenteLoggato = (Utente) session.getAttribute("utenteLoggato");
            if (utenteLoggato != null) { 
        %>
            <span>Benvenuto, <strong><%= utenteLoggato.getNome() %></strong>!</span> 
            <a href="LogoutServlet">Esci</a>
        <% 
            } else { 
        %>
            <span>Sei un visitatore.</span>
            <a href="login.jsp">Accedi</a>
        <% 
        } 
        %>
    </div>
</div>