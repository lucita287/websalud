package data;

public class CArea {
	private int idarea;
	private String descripcion;
	
	public CArea(int idarea,String descripcion){
		this.idarea=idarea;
		this.descripcion=descripcion;
	}
	public int getidarea(){
		return this.idarea;
	}
	public String getdescripcion(){
		return this.descripcion;
	}
}
