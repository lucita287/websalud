package data;

public class CPermiso {
	private int idpermiso;
	private String descripcion;
	/**
	 * @param idpermisos
	 * @param descripcion
	 */
	public CPermiso(int idpermiso, String descripcion) {
		this.idpermiso = idpermiso;
		this.descripcion = descripcion;
	}
	/**
	 * @return the idpermisos
	 */
	public int getIdpermiso() {
		return idpermiso;
	}
	/**
	 * @param idpermisos the idpermisos to set
	 */
	public void setIdpermiso(int idpermiso) {
		this.idpermiso = idpermiso;
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
	
}
