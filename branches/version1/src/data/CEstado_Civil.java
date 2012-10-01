package data;

public class CEstado_Civil {
	private int idestado_civil;
	private String nombre;
	/**
	 * @param idestado_civil
	 * @param nombre
	 */
	public CEstado_Civil(int idestado_civil, String nombre) {
		this.idestado_civil = idestado_civil;
		this.nombre = nombre;
	}
	/**
	 * @return the idestado_civil
	 */
	public int getIdestado_civil() {
		return idestado_civil;
	}
	/**
	 * @param idestado_civil the idestado_civil to set
	 */
	public void setIdestado_civil(int idestado_civil) {
		this.idestado_civil = idestado_civil;
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
