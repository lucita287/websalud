package data;

public class CGrupo_Familiar {
	private int idpaciente  ; 
	private int idgrupo_familiar;
	private int idparentesco;
	private int genero;
	private String ocupacion;
	private Double aporte;
	private String lugar;
	private int salud;
	private int edad;
	private Double ingreso;
	
	
	/**
	 * @param idpaciente
	 * @param idgrupo_familiar
	 * @param idparentesco
	 * @param genero
	 * @param ocupacion
	 * @param ingreso
	 * @param lugar
	 * @param salud
	 * @param edad
	 */
	public CGrupo_Familiar(int idpaciente, int idgrupo_familiar,
			int idparentesco, int genero, String ocupacion, Double  aporte,
			String lugar, int salud, int edad,Double ingreso ) {
		this.idpaciente = idpaciente;
		this.idgrupo_familiar = idgrupo_familiar;
		this.idparentesco = idparentesco;
		this.genero = genero;
		this.ocupacion = ocupacion;
		this.ingreso = ingreso;
		this.aporte= aporte;
		this.lugar = lugar;
		this.salud = salud;
		this.edad = edad;
	}
	
	
	
	/**
	 * @return the aporte
	 */
	public Double getAporte() {
		return aporte;
	}



	/**
	 * @param aporte the aporte to set
	 */
	public void setAporte(Double aporte) {
		this.aporte = aporte;
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
	 * @return the idgrupo_familiar
	 */
	public int getIdgrupo_familiar() {
		return idgrupo_familiar;
	}
	/**
	 * @param idgrupo_familiar the idgrupo_familiar to set
	 */
	public void setIdgrupo_familiar(int idgrupo_familiar) {
		this.idgrupo_familiar = idgrupo_familiar;
	}
	/**
	 * @return the idparentesco
	 */
	public int getIdparentesco() {
		return idparentesco;
	}
	/**
	 * @param idparentesco the idparentesco to set
	 */
	public void setIdparentesco(int idparentesco) {
		this.idparentesco = idparentesco;
	}
	/**
	 * @return the genero
	 */
	public int getGenero() {
		return genero;
	}
	/**
	 * @param genero the genero to set
	 */
	public void setGenero(int genero) {
		this.genero = genero;
	}
	/**
	 * @return the ocupacion
	 */
	public String getOcupacion() {
		return ocupacion;
	}
	/**
	 * @param ocupacion the ocupacion to set
	 */
	public void setOcupacion(String ocupacion) {
		this.ocupacion = ocupacion;
	}
	/**
	 * @return the ingreso
	 */
	public Double getIngreso() {
		return ingreso;
	}
	/**
	 * @param ingreso the ingreso to set
	 */
	public void setIngreso(Double ingreso) {
		this.ingreso = ingreso;
	}
	/**
	 * @return the lugar
	 */
	public String getLugar() {
		return lugar;
	}
	/**
	 * @param lugar the lugar to set
	 */
	public void setLugar(String lugar) {
		this.lugar = lugar;
	}
	/**
	 * @return the salud
	 */
	public int getSalud() {
		return salud;
	}
	/**
	 * @param salud the salud to set
	 */
	public void setSalud(int salud) {
		this.salud = salud;
	}
	/**
	 * @return the edad
	 */
	public int getEdad() {
		return edad;
	}
	/**
	 * @param edad the edad to set
	 */
	public void setEdad(int edad) {
		this.edad = edad;
	}
	
	/**
	 * @param idpaciente
	 * @param idgrupo_familiar
	 * @param idparentesco
	 * @param genero
	 * @param ocupacion
	 * @param ingreso
	 * @param lugar
	 * @param salud
	 */
	
}
