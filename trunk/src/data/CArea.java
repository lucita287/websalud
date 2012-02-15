package data;

public class CArea {
	private int idarea;
	private String descripcion;
	private CArea areaidarea;
	public CArea(int idarea,String descripcion,CArea areaidarea){
		this.idarea=idarea;
		this.descripcion=descripcion;
		this.areaidarea=areaidarea;
	}
	public int getidarea(){
		return this.idarea;
	}
	public String getdescripcion(){
		return this.descripcion;
	}
	public CArea getareaidarea(){
		return this.areaidarea;
	}
	
}
