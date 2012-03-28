package data;

public class CDepartamento {
	private int iddepartamento;
	private String nombre;
	
	/**
	 * @param iddepartamento
	 * @param nombre
	 */
	public CDepartamento(int iddepartamento, String nombre) {
		this.iddepartamento = iddepartamento;
		this.nombre = nombre;
	}

	/**
	 * @return the iddepartamento
	 */
	public int getIddepartamento() {
		return iddepartamento;
	}

	/**
	 * @param iddepartamento the iddepartamento to set
	 */
	public void setIddepartamento(int iddepartamento) {
		this.iddepartamento = iddepartamento;
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
	
}
