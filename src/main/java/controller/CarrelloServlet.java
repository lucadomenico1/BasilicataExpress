package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.Tratta;
import model.TrattaDAO;

@WebServlet("/CarrelloServlet")
public class CarrelloServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Se uno prova ad accedere direttamente alla Servlet, lo rimando alla home
        response.sendRedirect("TratteServlet");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Recupero l'ID del viaggio che l'utente ha cliccato dal form HTML
        String idStringa = request.getParameter("idTratta");
        
        if (idStringa != null) {
            // Trasformo l'ID da stringa a numero intero
            int idTratta = Integer.parseInt(idStringa);
            
            // Chiedo al DAO di darmi l'oggetto Tratta completo corrispondente a quell'ID
            TrattaDAO tDao = new TrattaDAO();
            Tratta viaggioScelto = tDao.doRetrieveById(idTratta);
            
            if (viaggioScelto != null) {
                // Prendo la sessione dell'utente
                HttpSession session = request.getSession();
                
                // Provo a recuperare il carrello dalla sessione
                // Il carrello non è altro che una Lista di Tratte!
                List<Tratta> carrello = (List<Tratta>) session.getAttribute("carrello");
                
                // Se è la prima volta che l'utente clicca "Aggiungi", il carrello non esiste (è null).
                // Quindi lo devo creare!
                if (carrello == null) {
                    carrello = new ArrayList<>();
                }
                
                // Aggiungo il viaggio alla lista
                carrello.add(viaggioScelto);
                
                // Salvo la lista aggiornata di nuovo nella sessione
                session.setAttribute("carrello", carrello);
            }
        }
        
        // Dopo aver aggiunto il viaggio, rimando l'utente a una pagina che gli fa vedere il suo carrello
        // (Creeremo questa pagina nel prossimo step)
        response.sendRedirect("carrello.jsp");
    }
}