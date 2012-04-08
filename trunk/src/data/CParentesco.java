package data;

public class CParentesco {
	private int idparentesco;
	private String nombre;
	private int grupo_familiar;
	private int antecendentes_familiares;
	private int emergencias;
	/**
	 * @param idparentesco
	 * @param nombre
	 * @param grupo_familiar
	 * @param antecendentes_familiares
	 * @param emergencias
	 */
	public CParentesco(int idparentesco, String nombre, int grupo_familiar,
			int antecendentes_familiares, int emergencias) {
		this.idparentesco = idparentesco;
		this.nombre = nombre;
		this.grupo_familiar = grupo_familiar;
		this.antecendentes_familiares = antecendentes_familiares;
		this.emergencias = emergencias;
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
	 * @return the nombre
	 */
	public String getNombre() {
		return nombre;
	}
	/**
	 * @param nombre the nombre to set
	 */
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	/**
	 * @return the grupo_familiar
	 */
	public int getGrupo_familiar() {
		return grupo_familiar;
	}
	/**
	 * @param grupo_familiar the grupo_familiar to set
	 */
	public void setGrupo_familiar(int grupo_familiar) {
		this.grupo_familiar = grupo_familiar;
	}
	/**
	 * @return the antecendentes_familiares
	 */
	public int getAntecendentes_familiares() {
		return antecendentes_familiares;
	}
	/**
	 * @param antecendentes_familiares the antecendentes_familiares to set
	 */
	public void setAntecendentes_familiares(int antecendentes_familiares) {
		this.antecendentes_familiares = antecendentes_familiares;
	}
	/**
	 * @return the emergencias
	 */
	public int getEmergencias() {
		return emergencias;
	}
	/**
	 * @param emergencias the emergencias to set
	 */
	public void setEmergencias(int emergencias) {
		this.emergencias = emergencias;
	}
	public boolean getBooleano(int i){
		if(i==1) return true;
		else return false;
	}
	public String getMensaje(int i){
		if(i==1) return "SI";
		else return "NO";
	}
}
