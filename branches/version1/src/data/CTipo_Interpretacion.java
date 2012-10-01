package data;

public class CTipo_Interpretacion {
	private int idtipo_interpretacion;
	private String descripcion;
	private int orden;
	
	/**
	 * @param idtipo_interpretacion
	 * @param descripcion
	 */
	public CTipo_Interpretacion(int idtipo_interpretacion, String descripcion, int orden) {
		this.idtipo_interpretacion = idtipo_interpretacion;
		this.descripcion = descripcion;
		this.orden=orden;
	}
	
	/**
	 * @return the orden
	 */
	public int getOrden() {
		return orden;
	}
	/**
	 * @param orden the orden to set
	 */
	public void setOrden(int orden) {
		this.orden = orden;
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
