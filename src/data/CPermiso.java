package data;

public class CPermiso {
	private int idpermiso;
	private String descripcion;
	private CCategoria_permiso idcategoria_permiso;
	
	/**
	 * @param idpermiso
	 * @param descripcion
	 * @param idcategoria_permiso
	 */
	public CPermiso(int idpermiso, String descripcion,
			CCategoria_permiso idcategoria_permiso) {
		this.idpermiso = idpermiso;
		this.descripcion = descripcion;
		this.idcategoria_permiso = idcategoria_permiso;
	}
	/**
	 * @return the idcategoria_permiso
	 */
	public CCategoria_permiso getIdcategoria_permiso() {
		return idcategoria_permiso;
	}
	/**
	 * @param idcategoria_permiso the idcategoria_permiso to set
	 */
	public void setIdcategoria_permiso(CCategoria_permiso idcategoria_permiso) {
		this.idcategoria_permiso = idcategoria_permiso;
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
