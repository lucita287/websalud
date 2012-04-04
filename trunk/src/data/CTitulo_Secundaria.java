package data;

public class CTitulo_Secundaria {
	private int idtitulo_secundaria;
	private String nombre;
	/**
	 * @param idtitulo_secundaria
	 * @param nombre
	 */
	public CTitulo_Secundaria(int idtitulo_secundaria, String nombre) {
		this.idtitulo_secundaria = idtitulo_secundaria;
		this.nombre = nombre;
	}
	/**
	 * @return the idtitulo_secundaria
	 */
	public int getIdtitulo_secundaria() {
		return idtitulo_secundaria;
	}
	/**
	 * @param idtitulo_secundaria the idtitulo_secundaria to set
	 */
	public void setIdtitulo_secundaria(int idtitulo_secundaria) {
		this.idtitulo_secundaria = idtitulo_secundaria;
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
