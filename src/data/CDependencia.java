package data;

public class CDependencia {
	private int iddependencia;
	private String nombre;
	/**
	 * @param iddependencia
	 * @param nombre
	 */
	public CDependencia(int iddependencia, String nombre) {
		this.iddependencia = iddependencia;
		this.nombre = nombre;
	}
	/**
	 * @return the iddependencia
	 */
	public int getIddependencia() {
		return iddependencia;
	}
	/**
	 * @param iddependencia the iddependencia to set
	 */
	public void setIddependencia(int iddependencia) {
		this.iddependencia = iddependencia;
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
