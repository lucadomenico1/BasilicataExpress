package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UtenteDAO {

    /**
     * Metodo per controllare le credenziali di accesso
     */
    public Utente doRetrieveByEmailAndPassword(String email, String password) {
        
        Utente u = null; // Partiamo dal presupposto che l'utente non esista
        
        // La query SQL con i punti interrogativi per la sicurezza
        String query = "SELECT * FROM Utente WHERE email = ? AND password = ?";

        try (Connection con = ConnessioneDB.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            // Sostituiamo i punti interrogativi con i dati veri passati al metodo
            ps.setString(1, email);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                // Se il database ci restituisce una riga, le credenziali sono giuste!
                if (rs.next()) {
                    u = new Utente();
                    u.setEmail(rs.getString("email"));
                    u.setPassword(rs.getString("password"));
                    u.setNome(rs.getString("nome"));
                    u.setCognome(rs.getString("cognome"));
                    u.setRuolo(rs.getString("ruolo"));
                }
            }

        } catch (SQLException e) {
            System.err.println("Errore durante il login: " + e.getMessage());
        }

        // Se le credenziali sono sbagliate, 'u' rimarrà null
        return u;
    }
    /**
     * Metodo per salvare un nuovo utente nel database (Registrazione)
     */
    public boolean doSave(Utente utente) {
        // La query per inserire i dati. Usiamo i '?' per evitare la SQL Injection
        String query = "INSERT INTO Utente (email, password, nome, cognome, ruolo) VALUES (?, ?, ?, ?, ?)";

        try (Connection con = ConnessioneDB.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            // Riempiamo i punti interrogativi con i dati dell'oggetto Utente
            ps.setString(1, utente.getEmail());
            ps.setString(2, utente.getPassword());
            ps.setString(3, utente.getNome());
            ps.setString(4, utente.getCognome());
            ps.setString(5, "cliente"); // Chi si registra dal sito è sempre un "cliente" di default

            // executeUpdate() si usa per INSERT, UPDATE e DELETE. Restituisce il numero di righe modificate.
            int righeInserite = ps.executeUpdate();
            
            // Se ha inserito almeno 1 riga, la registrazione è andata a buon fine
            return righeInserite > 0;

        } catch (SQLException e) {
            System.err.println("Errore durante la registrazione: " + e.getMessage());
            return false; // Se c'è un errore (es. email già esistente), restituisce false
        }
    }
}