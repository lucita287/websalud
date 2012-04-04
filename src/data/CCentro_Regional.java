package data;

public class CCentro_Regional {
	private int idcentro_regional;
	private String nombre;
	private CDepartamento departamento;
	/**
	 * @param idcentro_regional
	 * @param nombre
	 * @param departamento
	 */
	public CCentro_Regional(int idcentro_regional, String nombre,
			CDepartamento departamento) {
		this.idcentro_regional = idcentro_regional;
		this.nombre = nombre;
		this.departamento = departamento;
	}
	/**
	 * @return the idcentro_regional
	 */
	public int getIdcentro_regional() {
		return idcentro_regional;
	}
	/**
	 * @param idcentro_regional the idcentro_regional to set
	 */
	public void setIdcentro_regional(int idcentro_regional) {
		this.idcentro_regional = idcentro_regional;
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
	 * @return the departamento
	 */
	public CDepartamento getDepartamento() {
		return departamento;
	}
	/**
	 * @param departamento the departamento to set
	 */
	public void setDepartamento(CDepartamento departamento) {
		this.departamento = departamento;
	}
	
	
}
