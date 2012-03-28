package data;

import java.util.ArrayList;

public class CUsuarioPermiso {
	private CUsuario idusuario;
	private ArrayList<Integer> idpermiso;
	private ArrayList<Integer> idarea;
	/**
	 * @param idusuario
	 * @param lista_permisos
	 * @param idarea
	 */
	public CUsuarioPermiso(CUsuario idusuario, ArrayList<Integer> lista_permisos,ArrayList<Integer> idarea) {
		this.idusuario = idusuario;
		this.idpermiso = lista_permisos;
		this.idarea= idarea;
	}
	
	/**
	 * @return the idarea
	 */
	public ArrayList<Integer> getIdarea() {
		return idarea;
	}

	/**
	 * @param idarea the idarea to set
	 */
	public void setIdarea(ArrayList<Integer> idarea) {
		this.idarea = idarea;
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
