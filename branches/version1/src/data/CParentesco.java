package data;

public class CParentesco {
	private int idparentesco;
	private String nombre;
	/**
	 * @param idparentesco
	 * @param nombre
	 * @param grupo_familiar
	 * @param antecendentes_familiares
	 * @param emergencias
	 */
	public CParentesco(int idparentesco, String nombre) {
		this.idparentesco = idparentesco;
		this.nombre = nombre;
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

	public boolean getBooleano(int i){
		if(i==1) return true;
		else return false;
	}
	public String getMensaje(int i){
		if(i==1) return "SI";
		else return "NO";
	}
}
