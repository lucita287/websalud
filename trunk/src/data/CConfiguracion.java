package data;

public class CConfiguracion {
	private int idconfiguracion;
	private String telefono;
	private String correo_electronico;
	private String fax;
	private String direccion_imagen;
	private String direccion_pdf;
	private int tamanio_sub;
	private String dir_rel_imagen;
	private String dir_rel_pdf;
	private String direccion;
	
	public CConfiguracion(int idconfiguracion,String telefono, String correo_electronico, String fax, String direccion_imagen,
			String direccion_pdf, int tamanio_sub,String dir_rel_imagen, String dir_rel_pdf,String direccion){
		this.idconfiguracion=idconfiguracion;
		this.telefono=telefono;
		this.correo_electronico=correo_electronico;
		this.fax=fax;
		this.direccion_imagen=direccion_imagen;
		this.direccion_pdf=direccion_pdf;
		this.tamanio_sub=tamanio_sub;
		this.dir_rel_imagen=dir_rel_imagen;
		this.dir_rel_pdf=dir_rel_pdf;
		this.direccion=direccion;
	}
	
	/**
	 * @param idconfiguracion the idconfiguracion to set
	 */
	public void setIdconfiguracion(int idconfiguracion) {
		this.idconfiguracion = idconfiguracion;
	}

	/**
	 * @param telefono the telefono to set
	 */
	public void setTelefono(String telefono) {
		this.telefono = telefono;
	}

	/**
	 * @param correo_electronico the correo_electronico to set
	 */
	public void setCorreo_electronico(String correo_electronico) {
		this.correo_electronico = correo_electronico;
	}

	/**
	 * @param fax the fax to set
	 */
	public void setFax(String fax) {
		this.fax = fax;
	}

	/**
	 * @param direccion_imagen the direccion_imagen to set
	 */
	public void setDireccion_imagen(String direccion_imagen) {
		this.direccion_imagen = direccion_imagen;
	}

	/**
	 * @param direccion_pdf the direccion_pdf to set
	 */
	public void setDireccion_pdf(String direccion_pdf) {
		this.direccion_pdf = direccion_pdf;
	}

	/**
	 * @param tamanio_sub the tamanio_sub to set
	 */
	public void setTamanio_sub(int tamanio_sub) {
		this.tamanio_sub = tamanio_sub;
	}

	/**
	 * @param dir_rel_imagen the dir_rel_imagen to set
	 */
	public void setDir_rel_imagen(String dir_rel_imagen) {
		this.dir_rel_imagen = dir_rel_imagen;
	}

	/**
	 * @param dir_rel_pdf the dir_rel_pdf to set
	 */
	public void setDir_rel_pdf(String dir_rel_pdf) {
		this.dir_rel_pdf = dir_rel_pdf;
	}

	/**
	 * @param direccion the direccion to set
	 */
	public void setDireccion(String direccion) {
		this.direccion = direccion;
	}

	public int getidconfiguracion(){
		return this.idconfiguracion;
	}
	public String gettelefono(){
		return this.telefono;
	}
	public String getcorreo_electronico(){
		return this.correo_electronico;
	}
	public String getfax(){
		return this.fax;
	}
	public String getdireccion_imagen(){
		return this.direccion_imagen;
	}
	public String getdireccion_pdf(){
		return this.direccion_pdf;
	}
	public int gettamanio_sub(){
		return this.tamanio_sub;
	}
	public String getdir_rel_imagen(){
		return this.dir_rel_imagen;
	}
	public String getdir_rel_pdf(){
		return this.dir_rel_pdf;
	}
	public String getdireccion(){
		return this.direccion;
	}
}