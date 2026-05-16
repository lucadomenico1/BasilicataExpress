package control;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.Utente;
import model.UtenteDAO;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Se qualcuno prova ad accedere alla servlet senza form, lo mandiamo alla pagina di login
        response.sendRedirect("login.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Prendiamo i dati scritti dall'utente nel form HTML
        String email = request.getParameter("emailUtente");
        String password = request.getParameter("passwordUtente");
        
        // 2. Chiamiamo il nostro DAO per fare il controllo nel Database
        UtenteDAO uDao = new UtenteDAO();
        Utente utenteTrovato = uDao.doRetrieveByEmailAndPassword(email, password);
        
        if (utenteTrovato != null) {
            // 3. SUCCESSO! L'utente esiste. Creiamo la Sessione.
            HttpSession session = request.getSession();
            session.setAttribute("utenteLoggato", utenteTrovato);
            
            // Lo rimandiamo alla pagina principale per fargli vedere i viaggi
            response.sendRedirect("TratteServlet");
        } else {
            // 4. ERRORE! Credenziali sbagliate. Rimettiamo un messaggio nella valigia e torniamo al login.
            request.setAttribute("errore", "Email o password errati. Riprova!");
            RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
            dispatcher.forward(request, response);
        }
    }
}