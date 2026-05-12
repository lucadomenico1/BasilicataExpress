package model;

import java.sql.Timestamp;

public class Ordine {

	// Variabili che rispecchiano la tabella Ordine in MySQL
	private int idOrdine;
	private Timestamp dataAcquisto;
	private double totaleOrdine;
	private String emailUtente; // La chiave esterna verso l'Utente
	
	// Costruttore vuoto
	public Ordine() {
	}

	public int getIdOrdine() {
		return idOrdine;
	}

	public void setIdOrdine(int idOrdine) {
		this.idOrdine = idOrdine;
	}

	public Timestamp getDataAcquisto() {
		return dataAcquisto;
	}

	public void setDataAcquisto(Timestamp dataAcquisto) {
		this.dataAcquisto = dataAcquisto;
	}

	public double getTotaleOrdine() {
		return totaleOrdine;
	}

	public void setTotaleOrdine(double totaleOrdine) {
		this.totaleOrdine = totaleOrdine;
	}

	public String getEmailUtente() {
		return emailUtente;
	}

	public void setEmailUtente(String emailUtente) {
		this.emailUtente = emailUtente;
	}
	
	
}