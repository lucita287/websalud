package data;

import java.util.ArrayList;

public class CPregunta_Paciente {
	int idpregunta;
	int idpaciente;
	Integer cantidad;
	String respuesta;
	ArrayList<Integer> lista;
	/**
	 * @param idpregunta
	 * @param idpaciente
	 * @param cantidad
	 * @param respuesta
	 * @param lista
	 */
	public CPregunta_Paciente(int idpregunta, int idpaciente, Integer cantidad,
			String respuesta,ArrayList<Integer> lista) {
		this.idpregunta = idpregunta;
		this.idpaciente = idpaciente;
		this.cantidad = cantidad;
		this.respuesta = respuesta;
		this.lista = lista;
	}
	
	/**
	 * @return the lista
	 */
	public ArrayList<Integer> getLista() {
		return lista;
	}

	/**
	 * @param lista the lista to set
	 */
	public void setLista(ArrayList<Integer> lista) {
		this.lista = lista;
	}

	/**
	 * @return the idpregunta
	 */
	public int getIdpregunta() {
		return idpregunta;
	}
	/**
	 * @param idpregunta the idpregunta to set
	 */
	public void setIdpregunta(int idpregunta) {
		this.idpregunta = idpregunta;
	}
	/**
	 * @return the idpaciente
	 */
	public int getIdpaciente() {
		return idpaciente;
	}
	/**
	 * @param idpaciente the idpaciente to set
	 */
	public void setIdpaciente(int idpaciente) {
		this.idpaciente = idpaciente;
	}
	/**
	 * @return the cantidad
	 */
	public Integer getCantidad() {
		return cantidad;
	}
	/**
	 * @param cantidad the cantidad to set
	 */
	public void setCantidad(Integer cantidad) {
		this.cantidad = cantidad;
	}
	/**
	 * @return the respuesta
	 */
	public String getRespuesta() {
		return respuesta;
	}
	/**
	 * @param respuesta the respuesta to set
	 */
	public void setRespuesta(String respuesta) {
		this.respuesta = respuesta;
	}
	
	
}
