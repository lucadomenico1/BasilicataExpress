<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Tratta" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Il tuo Carrello - Basilicata Express</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f4f4f9; text-align: center; padding: 20px; margin: 0;}
        h1 { color: #004aad; }
        
        table { width: 80%; max-width: 800px; margin: 20px auto; border-collapse: collapse; background-color: white; box-shadow: 0 4px 10px rgba(0,0,0,0.1); border-radius: 8px; overflow: hidden; }
        th { background-color: #ff6600; color: white; padding: 15px; }
        td { padding: 15px; border-bottom: 1px solid #eee; color: #333; }
        
        .totale-box { margin-top: 30px; font-size: 1.5em; color: #004aad; }
        .prezzo-totale { font-weight: bold; color: #ff6600; }
        
        .btn { background-color: #004aad; color: white; padding: 12px 25px; text-decoration: none; border-radius: 5px; font-weight: bold; display: inline-block; margin: 15px 10px; transition: background-color 0.3s; }
        .btn:hover { background-color: #003380; }
        .btn-acquista { background-color: #28a745; } /* Un bel verde per l'acquisto */
        .btn-acquista:hover { background-color: #218838; }
        
        .empty-cart { font-size: 1.2em; color: #666; margin: 40px; }
    </style>
</head>
<body>

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
            <p>Il tuo carrello è tristemente vuoto!</p>
            <p>Torna alla home per scoprire i nostri viaggi.</p>
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
        <a href="#" class="btn btn-acquista">Procedi all'Acquisto</a>
    <%
        }
    %>

</body>
</html>