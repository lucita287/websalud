package data;

public class CAnuncio {
	 private int idanuncio ; 
	 private String nombre   ;
	 private String descripcion ; 
	 private String contenido  ;
	/**
	 * @param idanuncio
	 * @param nombre
	 * @param descripcion
	 * @param contenido
	 */
	public CAnuncio(int idanuncio, String nombre, String descripcion,
			String contenido) {
		this.idanuncio = idanuncio;
		this.nombre = nombre;
		this.descripcion = descripcion;
		this.contenido = contenido;
	}
	/**
	 * @return the idanuncio
	 */
	public int getIdanuncio() {
		return idanuncio;
	}
	/**
	 * @param idanuncio the idanuncio to set
	 */
	public void setIdanuncio(int idanuncio) {
		this.idanuncio = idanuncio;
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
	 * @return the descripcion
	 */
	public String getDescripcion() {
		return descripcion;
	}
	/**
	 * @param descripcion the descripcion to set
	 */
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	/**
	 * @return the contenido
	 */
	public String getContenido() {
		return contenido;
	}
	/**
	 * @param contenido the contenido to set
	 */
	public void setContenido(String contenido) {
		this.contenido = contenido;
	}
	 
}
