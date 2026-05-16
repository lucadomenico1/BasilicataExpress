<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Tratta" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Basilicata Express - Homepage</title>
    <link rel="stylesheet" href="styles/style.css">
</head>
<body>

    <%@ include file="header.jsp" %>

    <div class="container">
        <h1>Viaggia nel cuore della Basilicata</h1>
        <h2>Tutte le tratte disponibili in tempo reale</h2>

        <% 
            List<Tratta> viaggi = (List<Tratta>) request.getAttribute("viaggiDisponibili");
            if(viaggi != null && !viaggi.isEmpty()) {
        %>
            <table>
                <thead>
                    <tr>
                        <th>Partenza</th>
                        <th>Arrivo</th>
                        <th>Data</th>
                        <th>Ora</th>
                        <th>Prezzo</th>
                        <th>Azione</th>
                    </tr>
                </thead>
                <tbody>
                    <% for(Tratta t : viaggi) { %>
                        <tr>
                            <td><%= t.getPartenza() %></td>
                            <td><%= t.getArrivo() %></td>
                            <td><%= t.getDataViaggio() %></td>
                            <td><%= t.getOra() %></td>
                            <td class="price-tag">€ <%= String.format("%.2f", t.getPrezzoAttuale()) %></td>
                            <td>
                                <form action="CarrelloServlet" method="post" style="margin:0;">
                                    <input type="hidden" name="idTratta" value="<%= t.getIdTratta() %>">
                                    <input type="submit" class="btn" value="Aggiungi 🛒" style="padding: 8px 12px;">
                                </form>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        <% } else { %>
            <p class="empty-msg">Nessuna tratta disponibile al momento.</p>
        <% } %>
    </div>

</body>
</html>