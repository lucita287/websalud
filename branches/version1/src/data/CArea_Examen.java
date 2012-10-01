package data;

public class CArea_Examen {
	private int idarea_examen;
	private String nombre;
	
	/**
	 * @param idarea_examen
	 * @param nombre
	 */
	public CArea_Examen(int idarea_examen, String nombre) {
		this.idarea_examen = idarea_examen;
		this.nombre = nombre;
	}
	/**
	 * @return the idarea_examen
	 */
	public int getIdarea_examen() {
		return idarea_examen;
	}
	/**
	 * @param idarea_examen the idarea_examen to set
	 */
	public void setIdarea_examen(int idarea_examen) {
		this.idarea_examen = idarea_examen;
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
