package data;

public class CCategoria {
	private int idcategoria;
	private String descripcion;
	public CCategoria(int idcategoria, String descripcion){
		this.idcategoria=idcategoria;
		this.descripcion=descripcion;
	}
	public String getdescripcion(){
		return this.descripcion;
	}
	public int getidcategoria(){
		return this.idcategoria;
	}
}
