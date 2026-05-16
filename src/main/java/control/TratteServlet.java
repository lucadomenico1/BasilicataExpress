package control;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.Tratta;
import model.TrattaDAO;


@WebServlet("/TratteServlet")
public class TratteServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        //Chiamiamo il (DAO)
        TrattaDAO trattaDAO = new TrattaDAO();
        List<Tratta> listaViaggi = trattaDAO.doRetrieveAll();
        
        
        request.setAttribute("viaggiDisponibili", listaViaggi);
        
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        //Se qualcuno chiama in POST, lo rimandiamo al GET
        doGet(request, response);
    }
}