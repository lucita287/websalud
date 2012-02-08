package data;

import java.util.ArrayList;

public class CMenu {

	private int idmenu;
	private String descripcion;
	private String contenido;
	private CArea areaidarea;
	private CMenu idmenu_rec;
	private int size;
	private ArrayList<CMenu> list_menu=new ArrayList<CMenu>();
	
	public CMenu(int idmenu, String descripcion, CArea areaidarea,String contenido, int size,ArrayList<CMenu> list_menu){
		this.idmenu=idmenu;
		this.size=size;
		this.descripcion=descripcion;
		this.areaidarea=areaidarea;
		this.list_menu=list_menu;
		this.contenido=contenido;
	}
	
	public CMenu(int idmenu, String descripcion, CArea areaidarea,String contenido,int size, CMenu idmenu_rec){
		this.idmenu=idmenu;
		this.size=size;
		this.descripcion=descripcion;
		this.areaidarea=areaidarea;
		this.idmenu_rec=idmenu_rec;
		this.contenido=contenido;
	}
	public void setdescripcion(String descripcion){
		this.descripcion=descripcion;
	}
	public void setcontenido(String contenido){
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
	public CArea getareaidarea(){
		return this.areaidarea;
	}
	public CMenu getidmenu_rec(){
		return this.idmenu_rec;
	}
	public int getsize(){
		return this.size;
	}
	public int setsize(int size){
		return this.size=size;
	}
}
