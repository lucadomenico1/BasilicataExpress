package model;

import java.sql.Connection;
import java.sql.SQLException;
import javax.naming.InitialContext;
import javax.naming.Context;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class ConnessioneDB {

    private static DataSource ds;

    static {
        try {
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:/comp/env");
            ds = (DataSource) envContext.lookup("jdbc/BasilicataExpressDB");
        } catch (NamingException e) {
            System.err.println("Errore nella configurazione del DataSource JNDI!");
            e.printStackTrace();
        }
    }

    public static Connection getConnection() throws SQLException {
        if (ds == null) {
            throw new SQLException("DataSource non configurato correttamente!");
        }
        return ds.getConnection();
    }
}