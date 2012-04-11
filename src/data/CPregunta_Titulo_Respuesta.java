package data;

public class CPregunta_Titulo_Respuesta {
	private CPregunta idpregunta;
	private CTitulo_Respuesta idtitulo_respuesta;
	private int ponderacion;
	
	/**
	 * @param idpregunta
	 * @param idtitulo_respuesta
	 * @param ponderacion
	 */
	public CPregunta_Titulo_Respuesta(CPregunta idpregunta,
			CTitulo_Respuesta idtitulo_respuesta, int ponderacion) {
		this.idpregunta = idpregunta;
		this.idtitulo_respuesta = idtitulo_respuesta;
		this.ponderacion = ponderacion;
	}
	/**
	 * @return the idpregunta
	 */
	public CPregunta getIdpregunta() {
		return idpregunta;
	}
	/**
	 * @param idpregunta the idpregunta to set
	 */
	public void setIdpregunta(CPregunta idpregunta) {
		this.idpregunta = idpregunta;
	}
	/**
	 * @return the idtitulo_respuesta
	 */
	public CTitulo_Respuesta getIdtitulo_respuesta() {
		return idtitulo_respuesta;
	}
	/**
	 * @param idtitulo_respuesta the idtitulo_respuesta to set
	 */
	public void setIdtitulo_respuesta(CTitulo_Respuesta idtitulo_respuesta) {
		this.idtitulo_respuesta = idtitulo_respuesta;
	}
	/**
	 * @return the ponderacion
	 */
	public int getPonderacion() {
		return ponderacion;
	}
	/**
	 * @param ponderacion the ponderacion to set
	 */
	public void setPonderacion(int ponderacion) {
		this.ponderacion = ponderacion;
	}
	
}