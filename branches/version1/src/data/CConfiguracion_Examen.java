package data;

public class CConfiguracion_Examen {
	private int idconfiguracion_examen;
	private int terminacion;
	private int tipo_examen;
	
	
	/**
	 * @param idconfiguracion_examen
	 * @param terminacion
	 * @param tipo_examen
	 */
	public CConfiguracion_Examen(int idconfiguracion_examen, int terminacion,
			int tipo_examen) {
		this.idconfiguracion_examen = idconfiguracion_examen;
		this.terminacion = terminacion;
		this.tipo_examen = tipo_examen;
	}
	/**
	 * @return the idconfiguracion_examen
	 */
	public int getIdconfiguracion_examen() {
		return idconfiguracion_examen;
	}
	/**
	 * @param idconfiguracion_examen the idconfiguracion_examen to set
	 */
	public void setIdconfiguracion_examen(int idconfiguracion_examen) {
		this.idconfiguracion_examen = idconfiguracion_examen;
	}
	/**
	 * @return the terminacion
	 */
	public int getTerminacion() {
		return terminacion;
	}
	/**
	 * @param terminacion the terminacion to set
	 */
	public void setTerminacion(int terminacion) {
		this.terminacion = terminacion;
	}
	/**
	 * @return the tipo_examen
	 */
	public int getTipo_examen() {
		return tipo_examen;
	}
	/**
	 * @param tipo_examen the tipo_examen to set
	 */
	public void setTipo_examen(int tipo_examen) {
		this.tipo_examen = tipo_examen;
	}
	
}
