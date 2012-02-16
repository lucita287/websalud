package data;

public class CMultimedia {
	private int idimagen;
	private String direccion;
	private String direccion_relativa;
	private int tamanio;
	private CUsuario usuarioidusuario;
	private int tipo;
	public CMultimedia(int idimagen,String direccion,String direccion_relativa, long tamanio, int tipo,CUsuario usuarioidusuario){
		this.idimagen=idimagen;
		this.direccion=direccion;
		this.direccion_relativa=direccion_relativa;
		this.tamanio=(int)tamanio;
		this.usuarioidusuario=usuarioidusuario;
		this.tipo=tipo;
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
	public int gettipo(){
		return this.tipo;
	}
}
