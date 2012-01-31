package data;

public class CNoticia {
	private String titulo;
	private String descripcion;
	private String imagen;
	private int idnoticia;
	
	public CNoticia(int idnoticia,String titulo, String descripcion,String imagen){
		this.idnoticia=idnoticia;
		this.titulo=titulo;
		this.descripcion=descripcion;
		this.imagen=imagen;
	}
	
	public String gettitulo(){
		return titulo;
	}
	public String getdescripcion(){
		return descripcion;
	}
	public String getimagen(){
		return imagen;
	}
	public int getidnoticia(){
		return idnoticia;
	}
}
