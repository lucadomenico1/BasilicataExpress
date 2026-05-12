package model;

import java.sql.Timestamp;

public class Ordine {

	// Variabili che rispecchiano la tabella Ordine in MySQL
	private int idOrdine;
	private Timestamp dataAcquisto;
	private double totaleOrdine;
	private String emailUtente; // La chiave esterna (Foreign Key) verso l'Utente
	
	// Costruttore vuoto
	public Ordine() {
	}
	
}