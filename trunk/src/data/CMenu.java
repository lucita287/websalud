package data;

public class CMenu {

	private int idmenu;
	private String descripcion;
	private int areaidarea;
	
	public CMenu(int idmenu, String descripcion, int areaidarea){
		this.idmenu=idmenu;
		this.descripcion=descripcion;
		this.areaidarea=areaidarea;
	}
	public int getidmenu(){
		return this.idmenu;
	}
	public String getdescripcion(){
		return this.descripcion;
	}
	public int getareaidarea(){
		return this.areaidarea;
	}
	
}
