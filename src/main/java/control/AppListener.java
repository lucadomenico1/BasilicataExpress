package control;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

@WebListener  //Indica atomcat che questa è una classe listener e che deve avviarla lui
public class AppListener implements ServletContextListener{
	
	@Override
	public void contextInitialized(ServletContextEvent evento)  {
		try {
			Context iniziale = new InitialContext();
			DataSource ds = (DataSource) iniziale.lookup("java:comp/env/jdbc/basilicata");
			evento.getServletContext().setAttribute("DataSource", ds);
		}catch (NamingException e) {
			throw new IllegalStateException("DataSource non treovato", e);
		}
	}
}
