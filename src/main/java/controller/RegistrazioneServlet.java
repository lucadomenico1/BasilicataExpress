package controller;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.Utente;
import model.UtenteDAO;

@WebServlet("/RegistrazioneServlet")
public class RegistrazioneServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Se un utente arriva qui senza form, lo mandiamo alla pagina JSP
        response.sendRedirect("registrazione.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Raccogliamo i dati inseriti dall'utente nel Form HTML
        String nome = request.getParameter("nome");
        String cognome = request.getParameter("cognome");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        // 2. Creiamo il "vagone" (l'oggetto) Utente e lo riempiamo
        Utente nuovoUtente = new Utente();
        nuovoUtente.setNome(nome);
        nuovoUtente.setCognome(cognome);
        nuovoUtente.setEmail(email);
        nuovoUtente.setPassword(password);
        // Il ruolo "cliente" lo imposta in automatico il DAO!
        
        // 3. Chiamiamo il DAO per tentare il salvataggio nel database
        UtenteDAO uDao = new UtenteDAO();
        boolean salvataggioOk = uDao.doSave(nuovoUtente);
        
        if (salvataggioOk) {
            // SUCCESSO: L'utente è stato salvato. Lo mandiamo a fare il login!
            request.setAttribute("errore", "Registrazione completata! Ora puoi fare il login.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
            dispatcher.forward(request, response);
        } else {
            // ERRORE: Probabilmente l'email è già presente nel database
            request.setAttribute("errore", "Errore: Email già in uso o dati non validi.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("registrazione.jsp");
            dispatcher.forward(request, response);
        }
    }
}