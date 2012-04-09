package data;

public class CTitulo_Respuesta {
	private int idtitulo_respuesta; 
	private String descripcion;
	/**
	 * @param idtitulo_respuesta
	 * @param descripcion
	 */
	public CTitulo_Respuesta(int idtitulo_respuesta, String descripcion) {
		this.idtitulo_respuesta = idtitulo_respuesta;
		this.descripcion = descripcion;
	}
	/**
	 * @return the idtitulo_respuesta
	 */
	public int getIdtitulo_respuesta() {
		return idtitulo_respuesta;
	}
	/**
	 * @param idtitulo_respuesta the idtitulo_respuesta to set
	 */
	public void setIdtitulo_respuesta(int idtitulo_respuesta) {
		this.idtitulo_respuesta = idtitulo_respuesta;
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
