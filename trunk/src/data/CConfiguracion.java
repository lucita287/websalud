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