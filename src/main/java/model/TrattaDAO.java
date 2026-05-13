package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TrattaDAO {

    /**
     * Metodo per recuperare tutti i viaggi attivi dal database
     */
    public List<Tratta> doRetrieveAll() {
        // Creiamo una lista vuota che conterrà i nostri oggetti Tratta
        List<Tratta> viaggi = new ArrayList<>();
        
        // La query SQL (prendiamo solo i viaggi non cancellati)
        String query = "SELECT * FROM Tratta WHERE stato = 'Attivo'";

        // Usiamo il try-with-resources (chiude automaticamente la connessione!)
        try (Connection con = ConnessioneDB.getConnection();
             PreparedStatement ps = con.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            // Scorriamo le righe restituite dal database
            while (rs.next()) {
                Tratta t = new Tratta(); // Creiamo un nuovo "vagone" vuoto
                
                // Riempiamo il vagone prendendo i dati dalle colonne di MySQL
                t.setIdTratta(rs.getInt("id_tratta"));
                t.setPartenza(rs.getString("partenza"));
                t.setArrivo(rs.getString("arrivo"));
                t.setDataViaggio(rs.getDate("data_viaggio"));
                t.setOra(rs.getTime("ora"));
                t.setPrezzoAttuale(rs.getDouble("prezzo_attuale"));
                t.setStato(rs.getString("stato"));

                // Aggiungiamo il vagone pieno alla nostra lista
                viaggi.add(t);
            }

        } catch (SQLException e) {
            System.err.println("Errore nel recupero delle tratte: " + e.getMessage());
        }

        return viaggi;
    }
}