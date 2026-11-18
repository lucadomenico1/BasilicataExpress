package model;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public class Tratta {
	private int id;
	private int partenza_id;
	private int arrivo_id;
	private String arrivo;
	private String partenza;
	private LocalDateTime data_ora_partenza;
	private String mezzo;
	private BigDecimal prezzo;  //Non uso double per i soldi perchè ha errori di arrotondamento
	private int posti_disponibili;
	
	
	
	//Costruttore
	public Tratta() {
		
	}
	
	//Metodi getter e setter
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getPartenza_id() {
		return partenza_id;
	}
	public void setPartenza_id(int partenza_id) {
		this.partenza_id = partenza_id;
	}
	public int getArrivo_id() {
		return arrivo_id;
	}
	public void setArrivo_id(int arrivo_id) {
		this.arrivo_id = arrivo_id;
	}
	public String getArrivo() {
		return arrivo;
	}
	public void setArrivo(String arrivo) {
		this.arrivo = arrivo;
	}
	public String getPartenza() {
		return partenza;
	}
	public void setPartenza(String partenza) {
		this.partenza = partenza;
	}
	public LocalDateTime getData_ora_partenza() {
		return data_ora_partenza;
	}
	public void setData_ora_partenza(LocalDateTime data_ora_partenza) {
		this.data_ora_partenza = data_ora_partenza;
	}
	public String getMezzo() {
		return mezzo;
	}
	public void setMezzo(String mezzo) {
		this.mezzo = mezzo;
	}
	public BigDecimal getPrezzo() {
		return prezzo;
	}
	public void setPrezzo(BigDecimal prezzo) {
		this.prezzo = prezzo;
	}
	public int getPosti_disponibili() {
		return posti_disponibili;
	}
	public void setPosti_disponibili(int posti_disponibili) {
		this.posti_disponibili = posti_disponibili;
	}
	

	
}