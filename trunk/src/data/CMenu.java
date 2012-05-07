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
	private int estado;
	
	public CMenu(int idmenu, String descripcion, CArea areaidarea,String contenido, int size,ArrayList<CMenu> list_menu,int estado){
		this.idmenu=idmenu;
		this.size=size;
		this.descripcion=descripcion;
		this.areaidarea=areaidarea;
		this.list_menu=list_menu;
		this.contenido=contenido;
		this.estado=estado;
	}
	
	public CMenu(int idmenu, String descripcion, CArea areaidarea,String contenido,int size, CMenu idmenu_rec,int estado){
		this.idmenu=idmenu;
		this.size=size;
		this.descripcion=descripcion;
		this.areaidarea=areaidarea;
		this.idmenu_rec=idmenu_rec;
		this.contenido=contenido;
		this.estado=estado;
	}
	
	/**
	 * @return the estado
	 */
	public int getEstado() {
		return estado;
	}

	/**
	 * @param estado the estado to set
	 */
	public void setEstado(int estado) {
		this.estado = estado;
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
