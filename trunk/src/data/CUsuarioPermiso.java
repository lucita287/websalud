package data;

import java.util.ArrayList;

public class CUsuarioPermiso {
	private CUsuario idusuario;
	private ArrayList<Integer> idpermiso;
	/**
	 * @param idusuario
	 * @param lista_permisos
	 */
	public CUsuarioPermiso(CUsuario idusuario, ArrayList<Integer> lista_permisos) {
		this.idusuario = idusuario;
		this.idpermiso = lista_permisos;
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
	public ArrayList<Integer> getIdpermiso() {
		return idpermiso;
	}
	/**
	 * @param idpermiso the idpermiso to set
	 */
	public void setIdpermiso(ArrayList<Integer> idpermiso) {
		this.idpermiso = idpermiso;
	}
}
