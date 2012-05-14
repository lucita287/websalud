package data;

public class CUnidad_Academica {
	private int idunidad_academica;
	private String nombre;
	private int codigo;
	/**
	 * @param idunidad_academica
	 * @param nombre
	 */
	public CUnidad_Academica(int idunidad_academica, String nombre,int codigo) {
		this.idunidad_academica = idunidad_academica;
		this.nombre = nombre;
		this.codigo = codigo;
	}
	/**
	 * @return the idunidad_academica
	 */
	public int getIdunidad_academica() {
		return idunidad_academica;
	}
	/**
	 * @param idunidad_academica the idunidad_academica to set
	 */
	public void setIdunidad_academica(int idunidad_academica) {
		this.idunidad_academica = idunidad_academica;
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
