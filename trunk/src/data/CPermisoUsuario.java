package data;

import java.util.ArrayList;

public class CPermisoUsuario {
	private CUsuario idusuario;
	private ArrayList<CPermiso> idpermiso;
	public CPermisoUsuario(CUsuario idusuario, ArrayList<CPermiso> idpermiso) {
		this.idusuario = idusuario;
		this.idpermiso = idpermiso;
	}
	/**
	 * @return the idusuario
	 */
	public CUsuario getIdusuario() {
		return idusuario;
	}
	/**
	 * @param idusuario the idusuario to set
	 */
	public void setIdusuario(CUsuario idusuario) {
		this.idusuario = idusuario;
	}
	/**
	 * @return the idpermiso
	 */
	public ArrayList<CPermiso> getIdpermiso() {
		return idpermiso;
	}
	/**
	 * @param idpermiso the idpermiso to set
	 */
	public void setIdpermiso(ArrayList<CPermiso> idpermiso) {
		this.idpermiso = idpermiso;
	} 
	
}
