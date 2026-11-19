package control;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import javax.sql.DataSource;
import dao.ComuneDAO;
import model.Comune;

@WebServlet("/dbtest")
public class DbTestServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/plain;charset=UTF-8");

        DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
        ComuneDAO dao = new ComuneDAO(ds);

        try {
            for (Comune c : dao.findAll()) {
                response.getWriter().println(c.getId() + " - " + c.getNomeComune());
            }
        } catch (SQLException e) {
            response.getWriter().println("ERRORE: " + e);
        }
    }
}