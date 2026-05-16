<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Tratta" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Il tuo Carrello - Basilicata Express</title>
    <link rel="stylesheet" href="styles/style.css">
</head>
<body>
	<@ include file="header.jsp" %>
    <h1>Il tuo Carrello 🛒</h1>

    <%
        // 1. Apriamo la Sessione e proviamo a prendere la lista "carrello"
        List<Tratta> carrello = (List<Tratta>) session.getAttribute("carrello");
        
        // Prepariamo una variabile per calcolare il prezzo totale
        double totale = 0.0;

        // 2. Controlliamo se il carrello è vuoto o non esiste ancora
        if (carrello == null || carrello.isEmpty()) {
    %>
       <div class="empty-cart">
    <% 
        String msgSuccesso = (String) request.getAttribute("messaggioSuccesso");
        if (msgSuccesso != null) {
    %>
        <p style="color: #28a745; font-weight: bold;"><%= msgSuccesso %></p>
    <% } else { %>
        <p>Il tuo carrello è vuoto!</p>
        <p>Torna alla home per scoprire i nostri viaggi.</p>
    <% } %>
</div>
        <a href="TratteServlet" class="btn">Torna alla Homepage</a>
    <%
        } else {
    %>
        <table>
            <thead>
                <tr>
                    <th>Partenza</th>
                    <th>Arrivo</th>
                    <th>Data</th>
                    <th>Prezzo</th>
                </tr>
            </thead>
            <tbody>
                <%
                    // 3. Scorriamo i viaggi che l'utente ha messo nel carrello
                    for(Tratta t : carrello) {
                        // Man mano che stampiamo i viaggi, sommiamo il prezzo al totale!
                        totale += t.getPrezzoAttuale(); 
                %>
                    <tr>
                        <td><%= t.getPartenza() %></td>
                        <td><%= t.getArrivo() %></td>
                        <td><%= t.getDataViaggio() %></td>
                        <td>€ <%= String.format("%.2f", t.getPrezzoAttuale()) %></td>
                    </tr>
                <%
                    }
                %>
            </tbody>
        </table>

        <div class="totale-box">
            Totale da pagare: <span class="prezzo-totale">€ <%= String.format("%.2f", totale) %></span>
        </div>

        <br>
        <a href="TratteServlet" class="btn">Continua lo shopping</a>
        <a href="CheckoutServlet" class="btn btn-acquista">Procedi all'Acquisto</a>
    <%
        }
    %>

</body>
</html>