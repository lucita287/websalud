package data;

public class CTipo_Interpretacion {
	private int idtipo_interpretacion;
	private String descripcion;
	/**
	 * @param idtipo_interpretacion
	 * @param descripcion
	 */
	public CTipo_Interpretacion(int idtipo_interpretacion, String descripcion) {
		this.idtipo_interpretacion = idtipo_interpretacion;
		this.descripcion = descripcion;
	}
	/**
	 * @return the idtipo_interpretacion
	 */
	public int getIdtipo_interpretacion() {
		return idtipo_interpretacion;
	}
	/**
	 * @param idtipo_interpretacion the idtipo_interpretacion to set
	 */
	public void setIdtipo_interpretacion(int idtipo_interpretacion) {
		this.idtipo_interpretacion = idtipo_interpretacion;
	}
	/**
	 * @return the descripcion
	 */
	public String getDescripcion() {
		return descripcion;
	}
	/**
	 * @param descripcion the descripcion to set
	 */
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	
}
