package data;

public class CImagen {
	private int idimagen;
	private String direccion;
	private String direccion_relativa;
	private int tamanio;
	private CUsuario usuarioidusuario;
	
	public CImagen(int idimagen,String direccion,String direccion_relativa, long tamanio, CUsuario usuarioidusuario){
		this.idimagen=idimagen;
		this.direccion=direccion;
		this.direccion_relativa=direccion_relativa;
		this.tamanio=(int)tamanio;
		this.usuarioidusuario=usuarioidusuario;
	}
	public int getidimagen(){
		return this.idimagen;
	}
	public String getdireccion(){
		return this.direccion;
	}
	public String getdireccion_relativa(){
		return this.direccion_relativa;
	}
	public int gettamanio(){
		return this.tamanio;
	}
	public CUsuario getusuarioidusuario(){
		return this.usuarioidusuario;
	}
	
}
