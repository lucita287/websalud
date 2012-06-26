package data;

import java.util.Date;

public class CTarjeta_Impresa_S {
	private java.util.Date fecha;
	private int carne;
	private String nombre;
	
	
	/**
	 * @param fecha
	 * @param carne
	 * @param nombre
	 */
	public CTarjeta_Impresa_S(Date fecha, int carne, String nombre) {
		this.fecha = fecha;
		this.carne = carne;
		this.nombre = nombre;
	}
	/**
	 * @return the fecha
	 */
	public java.util.Date getFecha() {
		return fecha;
	}
	/**
	 * @param fecha the fecha to set
	 */
	public void setFecha(java.util.Date fecha) {
		this.fecha = fecha;
	}
	/**
	 * @return the carne
	 */
	public int getCarne() {
		return carne;
	}
	/**
	 * @param carne the carne to set
	 */
	public void setCarne(int carne) {
		this.carne = carne;
	}
	/**
	 * @return the nombre
	 */
	public String getNombre() {
		return nombre;
	}
	/**
	 * @param nombre the nombre to set
	 */
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	
	
	
}
