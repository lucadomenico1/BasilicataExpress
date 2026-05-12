package model;

import java.sql.Date;
import java.sql.Time;

public class Tratta {
	
	// Variabili che rispecchiano la tabella Tratta in MySQL
	private int idTratta;
	private String partenza;
	private String arrivo;
	private Date dataViaggio;
	private Time ora;
	private double prezzoAttuale;
	private String stato;
	
	// Costruttore vuoto
	public Tratta() {
	}

	public int getIdTratta() {
		return idTratta;
	}

	public void setIdTratta(int idTratta) {
		this.idTratta = idTratta;
	}

	public String getPartenza() {
		return partenza;
	}

	public void setPartenza(String partenza) {
		this.partenza = partenza;
	}

	public String getArrivo() {
		return arrivo;
	}

	public void setArrivo(String arrivo) {
		this.arrivo = arrivo;
	}

	public Date getDataViaggio() {
		return dataViaggio;
	}

	public void setDataViaggio(Date dataViaggio) {
		this.dataViaggio = dataViaggio;
	}

	public Time getOra() {
		return ora;
	}

	public void setOra(Time ora) {
		this.ora = ora;
	}

	public double getPrezzoAttuale() {
		return prezzoAttuale;
	}

	public void setPrezzoAttuale(double prezzoAttuale) {
		this.prezzoAttuale = prezzoAttuale;
	}

	public String getStato() {
		return stato;
	}

	public void setStato(String stato) {
		this.stato = stato;
	}

	
}
