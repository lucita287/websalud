package data;

public class CPregunta {
	private int idpregunta;
	private String descripcion;
	private CCategoria idcategoria;
	private CSubcategoria idsubcategoria;
	public CPregunta(int idpregunta,String descripcion,CCategoria idcategoria,CSubcategoria idsubcategoria ){
		this.idpregunta=idpregunta;
		this.descripcion=descripcion;
		this.idcategoria=idcategoria;
		this.idsubcategoria=idsubcategoria;
	}
	public int getidpregunta(){
		return this.idpregunta;
	}
	public String getdescripcion(){
		return this.descripcion;
	}
	public CCategoria getidcategoria(){
		return this.idcategoria;
	}
	public CSubcategoria getsubcategoria(){
		return this.idsubcategoria;
	}
}
