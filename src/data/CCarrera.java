package data;

public class CCarrera {
	private int idcarrera;
	private String nombre;
	/**
	 * @param idcarrera
	 * @param nombre
	 */
	public CCarrera(int idcarrera, String nombre) {
		this.idcarrera = idcarrera;
		this.nombre = nombre;
	}
	/**
	 * @return the idcarrera
	 */
	public int getIdcarrera() {
		return idcarrera;
	}
	/**
	 * @param idcarrera the idcarrera to set
	 */
	public void setIdcarrera(int idcarrera) {
		this.idcarrera = idcarrera;
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
