package control;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.Ordine;
import model.OrdineDAO;
import model.Tratta;
import model.Utente;

@WebServlet("/CheckoutServlet")
public class CheckoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        // Controllo prima di tutto se l'utente si è autenticato
        Utente utenteLoggato = (Utente) session.getAttribute("utenteLoggato");
        
        if (utenteLoggato == null) {
            // Se non è loggato, lo rimando al login con un messaggio di avviso
            request.setAttribute("errore", "Devi effettuare il login per procedere all'acquisto!");
            RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
            dispatcher.forward(request, response);
            return; // Interrompo l'esecuzione qui
        }
        
        // Recupero il carrello dalla sessione
        List<Tratta> carrello = (List<Tratta>) session.getAttribute("carrello");
        
        // Se il carrello non esiste o è vuoto, lo rimando alla home
        if (carrello == null || carrello.isEmpty()) {
            response.sendRedirect("TratteServlet");
            return;
        }
        
        // Calcolo il totale della spesa scorrendo i viaggi nel carrello
        double totale = 0.0;
        for (Tratta t : carrello) {
            totale += t.getPrezzoAttuale();
        }
        
        // Creo l'oggetto Ordine da salvare, usando i metodi del mio JavaBean
        Ordine nuovoOrdine = new Ordine();
        nuovoOrdine.setTotaleOrdine(totale);
        nuovoOrdine.setEmailUtente(utenteLoggato.getEmail());
        
        // Chiamo il DAO per scrivere l'ordine sul database MySQL
        OrdineDAO oDao = new OrdineDAO();
        boolean trackingOk = oDao.doSave(nuovoOrdine);
        
        if (trackingOk) {
            // Se il database ha salvato tutto, posso svuotare il carrello della sessione
            session.removeAttribute("carrello");
            
            // Imposto un messaggio di successo da mostrare nella pagina del carrello vuoto
            request.setAttribute("messaggioSuccesso", "Acquisto completato con successo! Buon viaggio!");
            RequestDispatcher dispatcher = request.getRequestDispatcher("carrello.jsp");
            dispatcher.forward(request, response);
        } else {
            // Se c'è stato un problema col database, avviso l'utente senza svuotare il carrello
            request.setAttribute("errore", "Si è verificato un errore tecnico durante l'acquisto. Riprova.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("carrello.jsp");
            dispatcher.forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}