package data;

import java.util.ArrayList;

public class CTipo_Pregunta {
	private int idtipo_pregunta;
	private String descripcion;
	private ArrayList<CTitulo_Respuesta> idgrupo_titulo_respuesta;
	/**
	 * @param idtipo_pregunta
	 * @param descripcion
	 * @param idgrupo_titulo_respuesta
	 */
	public CTipo_Pregunta(int idtipo_pregunta, String descripcion,
			ArrayList<CTitulo_Respuesta> idgrupo_titulo_respuesta) {
		this.idtipo_pregunta = idtipo_pregunta;
		this.descripcion = descripcion;
		this.idgrupo_titulo_respuesta = idgrupo_titulo_respuesta;
	}
	/**
	 * @return the idtipo_pregunta
	 */
	public int getIdtipo_pregunta() {
		return idtipo_pregunta;
	}
	/**
	 * @param idtipo_pregunta the idtipo_pregunta to set
	 */
	public void setIdtipo_pregunta(int idtipo_pregunta) {
		this.idtipo_pregunta = idtipo_pregunta;
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
	 * @return the idgrupo_titulo_respuesta
	 */
	public ArrayList<CTitulo_Respuesta> getIdgrupo_titulo_respuesta() {
		return idgrupo_titulo_respuesta;
	}
	/**
	 * @param idgrupo_titulo_respuesta the idgrupo_titulo_respuesta to set
	 */
	public void setIdgrupo_titulo_respuesta(
			ArrayList<CTitulo_Respuesta> idgrupo_titulo_respuesta) {
		this.idgrupo_titulo_respuesta = idgrupo_titulo_respuesta;
	}
	
}
