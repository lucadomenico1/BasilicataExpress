<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Tratta" %>
<%@ page import="model.Utente" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Basilicata Express - Homepage</title>
    <style>
        /* Reset e Font */
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f4f4f9; margin: 0; padding: 0; }
        
        /* Barra di navigazione / Benvenuto */
        .header-bar { background-color: #004aad; color: white; padding: 10px 20px; display: flex; justify-content: space-between; align-items: center; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        .header-bar a { color: #ff6600; text-decoration: none; font-weight: bold; margin-left: 10px; }
        .header-bar a:hover { text-decoration: underline; }

        /* Contenuto Principale */
        .container { padding: 30px; text-align: center; }
        h1 { color: #004aad; margin-bottom: 5px; }
        h2 { color: #555; font-weight: 300; margin-bottom: 30px; }

        /* Tabella */
        table { width: 90%; max-width: 1000px; margin: 0 auto; border-collapse: collapse; background-color: white; box-shadow: 0 4px 15px rgba(0,0,0,0.1); border-radius: 8px; overflow: hidden; }
        th { background-color: #ff6600; color: white; padding: 15px; text-transform: uppercase; letter-spacing: 1px; }
        td { padding: 15px; border-bottom: 1px solid #eee; color: #333; }
        tr:hover { background-color: #f9f9f9; }
        .price-tag { color: #004aad; font-weight: bold; font-size: 1.1em; }
        
        .empty-msg { font-style: italic; color: #888; margin-top: 50px; }
    </style>
</head>
<body>

    <div class="header-bar">
        <div><strong>Basilicata Express</strong></div>
        <div>
            <% 
                // Controllo se c'è un utente loggato in sessione per salutarlo
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

    <div class="container">
        <h1>Viaggia nel cuore della Basilicata</h1>
        <h2>Tutte le tratte disponibili in tempo reale</h2>

        <% 
            // Prendo la lista dei viaggi che mi ha preparato la Servlet
            List<Tratta> viaggi = (List<Tratta>) request.getAttribute("viaggiDisponibili");
            
            // Verifico che la lista esista e non sia vuota prima di creare la tabella
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
                    <% 
                        // Scorro tutti i viaggi e stampo una riga per ognuno
                        for(Tratta t : viaggi) { 
                    %>
                        <tr>
                            <td><%= t.getPartenza() %></td>
                            <td><%= t.getArrivo() %></td>
                            <td><%= t.getDataViaggio() %></td>
                            <td><%= t.getOra() %></td>
                            <td class="price-tag">€ <%= String.format("%.2f", t.getPrezzoAttuale()) %></td>
                            
                            <td>
                                <form action="CarrelloServlet" method="post" style="margin:0;">
                                    <input type="hidden" name="idTratta" value="<%= t.getIdTratta() %>">
                                    <input type="submit" value="Aggiungi 🛒" style="background-color: #004aad; color: white; border: none; padding: 8px 12px; border-radius: 4px; cursor: pointer; font-weight: bold;">
                                </form>
                            </td>
                        </tr>
                    <% 
                        } 
                    %>
                </tbody>
            </table>
        <% 
            } else { 
        %>
            <p class="empty-msg">Nessuna tratta disponibile al momento o Servlet non avviata correttamente.</p>
        <% 
            } 
        %>
    </div>

</body>
</html>
