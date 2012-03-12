package data;

public class CResponsable {

	private int idresponsable;
	private String nombre;
	private String apellido;
	private CUsuario usuariosidusuario;
	private CArea areaidarea;
	
	/**
	 * @param idresponsable
	 * @param nombre
	 * @param apellido
	 * @param usuariosidusuario
	 * @param areaidarea
	 */
	public CResponsable(int idresponsable, String nombre, String apellido,
			CUsuario usuariosidusuario, CArea areaidarea) {
		this.idresponsable = idresponsable;
		this.nombre = nombre;
		this.apellido = apellido;
		this.usuariosidusuario = usuariosidusuario;
		this.areaidarea = areaidarea;
	}
	/**
	 * @return the areaidarea
	 */
	public CArea getAreaidarea() {
		return areaidarea;
	}
	/**
	 * @param areaidarea the areaidarea to set
	 */
	public void setAreaidarea(CArea areaidarea) {
		this.areaidarea = areaidarea;
	}
	/**
	 * @return the idresponsable
	 */
	public int getIdresponsable() {
		return idresponsable;
	}
	/**
	 * @param idresponsable the idresponsable to set
	 */
	public void setIdresponsable(int idresponsable) {
		this.idresponsable = idresponsable;
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
	 * @return the apellido
	 */
	public String getApellido() {
		return apellido;
	}
	/**
	 * @param apellido the apellido to set
	 */
	public void setApellido(String apellido) {
		this.apellido = apellido;
	}
	/**
	 * @return the usuariosidusuario
	 */
	public CUsuario getUsuariosidusuario() {
		return usuariosidusuario;
	}
	/**
	 * @param usuariosidusuario the usuariosidusuario to set
	 */
	public void setUsuariosidusuario(CUsuario usuariosidusuario) {
		this.usuariosidusuario = usuariosidusuario;
	}
	
}
