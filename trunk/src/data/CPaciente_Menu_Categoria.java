package data;

public class CPaciente_Menu_Categoria {
	private int idpaciente ;
	private int idmenu_categoria;
	private int auto_evaluacion;
	private int multifasico;
	/**
	 * @param idpaciente
	 * @param idmenu_categoria
	 * @param auto_evaluacion
	 * @param multifasico
	 */
	public CPaciente_Menu_Categoria(int idpaciente, int idmenu_categoria,
			int auto_evaluacion, int multifasico) {
		this.idpaciente = idpaciente;
		this.idmenu_categoria = idmenu_categoria;
		this.auto_evaluacion = auto_evaluacion;
		this.multifasico = multifasico;
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
	 * @return the idmenu_categoria
	 */
	public int getIdmenu_categoria() {
		return idmenu_categoria;
	}
	/**
	 * @param idmenu_categoria the idmenu_categoria to set
	 */
	public void setIdmenu_categoria(int idmenu_categoria) {
		this.idmenu_categoria = idmenu_categoria;
	}
	/**
	 * @return the auto_evaluacion
	 */
	public int getAuto_evaluacion() {
		return auto_evaluacion;
	}
	/**
	 * @param auto_evaluacion the auto_evaluacion to set
	 */
	public void setAuto_evaluacion(int auto_evaluacion) {
		this.auto_evaluacion = auto_evaluacion;
	}
	/**
	 * @return the multifasico
	 */
	public int getMultifasico() {
		return multifasico;
	}
	/**
	 * @param multifasico the multifasico to set
	 */
	public void setMultifasico(int multifasico) {
		this.multifasico = multifasico;
	}
	
}
