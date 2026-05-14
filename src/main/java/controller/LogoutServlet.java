package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        //Recuperiamo la sessione attuale (il 'false' significa: prendila solo se esiste già, non crearne una nuova)
        HttpSession session = request.getSession(false);
        
        // Se l'utente aveva una sessione attiva, la distruggiamo
        if (session != null) {
            session.invalidate();
        }
        
        //Rimandiamo alla vetrina principale per fargli vedere che ora è un visitatore
        response.sendRedirect("TratteServlet");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
    
    
}