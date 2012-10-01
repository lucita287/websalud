package data;

public class CContenido {
	
	private int idcontenido;
	private String descripcion;
	private String titulo;
	private CMultimedia idmultimedia;
	private CMenu idmenu;
	public CContenido(int idcontenido,String descripcion, String titulo,CMultimedia idmultimedia, CMenu idmenu){
		this.idcontenido=idcontenido;
		this.descripcion=descripcion;
		this.idmenu=idmenu;
		this.idmultimedia=idmultimedia;
		this.titulo=titulo;
	}
	public int getidcontenido(){
		return idcontenido;
	}
	public void setidcontenido(int idcontenido){
		this.idcontenido=idcontenido;
	}
	public String getdescripcion(){
		return descripcion;
	}
	public void setdescripcion(String descripcion){
		this.descripcion=descripcion;
	}
	public String gettitulo(){
		return titulo;
	}
	public void settitulo(String titulo){
		this.titulo=titulo;
	}
	public CMultimedia getmultimedia(){
		return idmultimedia;
	}
	public void setmultimedia(CMultimedia idmultimedia){
		this.idmultimedia=idmultimedia;
	}
	public CMenu getidmenu(){
		return idmenu;
	}
	
}
