package data;

public class CTipo_Sangre {
	private int idtipo_sangre;
	private String nombre;
	/**
	 * @param idtipo_sangre
	 * @param nombre
	 */
	public CTipo_Sangre(int idtipo_sangre, String nombre) {
		this.idtipo_sangre = idtipo_sangre;
		this.nombre = nombre;
	}
	/**
	 * @return the idtipo_sangre
	 */
	public int getIdtipo_sangre() {
		return idtipo_sangre;
	}
	/**
	 * @param idtipo_sangre the idtipo_sangre to set
	 */
	public void setIdtipo_sangre(int idtipo_sangre) {
		this.idtipo_sangre = idtipo_sangre;
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
