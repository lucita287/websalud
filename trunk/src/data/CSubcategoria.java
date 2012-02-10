package data;

public class CSubcategoria {
	private int idsubcategoria;
	private String descripcion;
	public CSubcategoria(int idsubcategoria,String descripcion ){
		this.idsubcategoria=idsubcategoria;
		this.descripcion=descripcion;
	}
	public int getidsubcategoria(){
		return this.idsubcategoria;
	}
	public String getdescripcion(){
		return this.descripcion;
	}
}
