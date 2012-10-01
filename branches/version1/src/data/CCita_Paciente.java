package data;

public class CCita_Paciente {
	
	private CPaciente idpaciente;
	private CCita idcita;
	private String recibo_pago;
	private int estado;
	/**
	 * @param idpaciente
	 * @param idcita
	 * @param recibo_pago
	 * @param estado
	 */
	public CCita_Paciente(CPaciente idpaciente, CCita idcita,
			String recibo_pago, int estado) {
		this.idpaciente = idpaciente;
		this.idcita = idcita;
		this.recibo_pago = recibo_pago;
		this.estado = estado;
	}
	/**
	 * @return the idpaciente
	 */
	public CPaciente getIdpaciente() {
		return idpaciente;
	}
	/**
	 * @param idpaciente the idpaciente to set
	 */
	public void setIdpaciente(CPaciente idpaciente) {
		this.idpaciente = idpaciente;
	}
	/**
	 * @return the idcita
	 */
	public CCita getIdcita() {
		return idcita;
	}
	/**
	 * @param idcita the idcita to set
	 */
	public void setIdcita(CCita idcita) {
		this.idcita = idcita;
	}
	/**
	 * @return the recibo_pago
	 */
	public String getRecibo_pago() {
		return recibo_pago;
	}
	/**
	 * @param recibo_pago the recibo_pago to set
	 */
	public void setRecibo_pago(String recibo_pago) {
		this.recibo_pago = recibo_pago;
	}
	/**
	 * @return the estado
	 */
	public int getEstado() {
		return estado;
	}
	/**
	 * @param estado the estado to set
	 */
	public void setEstado(int estado) {
		this.estado = estado;
	}
	
}
