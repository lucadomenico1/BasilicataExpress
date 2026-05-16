package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class OrdineDAO {

    /**
     * Metodo per salvare un nuovo ordine nel database
     */
    public boolean doSave(Ordine ordine) {
        
        // Ho inserito i nomi ESATTI delle colonne del tuo database
        String query = "INSERT INTO ordine (totale_ordine, email_utente, data_acquisto) VALUES (?, ?, NOW())";

        try (Connection con = ConnessioneDB.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            // Ho inserito i metodi ESATTI del tuo file Ordine.java
            ps.setDouble(1, ordine.getTotaleOrdine());
            ps.setString(2, ordine.getEmailUtente());

            int righeInserite = ps.executeUpdate();
            
            return righeInserite > 0;

        } catch (SQLException e) {
            System.err.println("Errore durante il salvataggio dell'ordine: " + e.getMessage());
            return false;
        }
    }
}