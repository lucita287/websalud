package data;

public class CCategoria_permiso {
	int idcategoria_permiso;
	String nombre;
	/**
	 * @param idcategoria_permiso
	 * @param nombre
	 */
	public CCategoria_permiso(int idcategoria_permiso, String nombre) {
		this.idcategoria_permiso = idcategoria_permiso;
		this.nombre = nombre;
	}
	/**
	 * @return the idcategoria_permiso
	 */
	public int getIdcategoria_permiso() {
		return idcategoria_permiso;
	}
	/**
	 * @param idcategoria_permiso the idcategoria_permiso to set
	 */
	public void setIdcategoria_permiso(int idcategoria_permiso) {
		this.idcategoria_permiso = idcategoria_permiso;
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
