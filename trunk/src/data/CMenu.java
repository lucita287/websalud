package data;

import java.util.ArrayList;

public class CMenu {

	private int idmenu;
	private String descripcion;
	private int areaidarea;
	private String contenido;
	private ArrayList<CMenu> list_menu=new ArrayList<CMenu>();
	
	public CMenu(int idmenu, String descripcion, int areaidarea,String contenido, ArrayList<CMenu> list_menu){
		this.idmenu=idmenu;
		this.descripcion=descripcion;
		this.areaidarea=areaidarea;
		this.list_menu=list_menu;
		this.contenido=contenido;
	}
	public int getidmenu(){
		return this.idmenu;
	}
	public String getcontenido(){
		return this.contenido;
	}
	public ArrayList<CMenu> getlist_menu(){
		return this.list_menu;
	}
	public String getdescripcion(){
		return this.descripcion;
	}
	public int getareaidarea(){
		return this.areaidarea;
	}
	
}
