package data;

public class CEncabezado_Condicion {
	private int idencabezado_condicion; 
	private String descripcion; 
	private int idtipo_interpretacion;
	private String tipo;
	/**
	 * @param idencabezado_condicion
	 * @param descripcion
	 * @param idtipo_interpretacion
	 */
	public CEncabezado_Condicion(int idencabezado_condicion, String descripcion,
			int idtipo_interpretacion) {
		this.idencabezado_condicion = idencabezado_condicion;
		this.descripcion = descripcion;
		this.idtipo_interpretacion = idtipo_interpretacion;
		this.tipo="";
	}
	
	/**
	 * @return the tipo
	 */
	public String getTipo() {
		return tipo;
	}

	/**
	 * @param tipo the tipo to set
	 */
	public void setTipo(String tipo) {
		this.tipo = tipo;
	}

	/**
	 * @return the idencabezado_condicion
	 */
	public int getIdencabezado_condicion() {
		return idencabezado_condicion;
	}
	/**
	 * @param idencabezado_condicion the idencabezado_condicion to set
	 */
	public void setIdencabezado_condicion(int idencabezado_condicion) {
		this.idencabezado_condicion = idencabezado_condicion;
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
	
}
