package data;

public class CArea {
	private int idarea;
	private String nombre;
	private CArea areaidarea;
	private String descripcion;
	private int size;
	private CMultimedia idmultimedia;
	
	public CArea(int idarea,String nombre,String descripcion, int size, CMultimedia idmultimedia,CArea areaidarea){
		this.idarea=idarea;
		this.nombre=nombre;
		this.areaidarea=areaidarea;
		this.descripcion=descripcion;
		this.idmultimedia=idmultimedia;
		this.size=size;
	}
	public void setidarea(int idarea){
		this.idarea=idarea;
	}
	public void setnombre(String nombre){
		this.nombre=nombre;
	}
	public void setdescripcion(String descripcion){
		this.descripcion=descripcion;
	}
	public void setidmultimedia(CMultimedia idmultimedia){
		this.idmultimedia=idmultimedia;
	}
	public void setareaidarea(CArea areaidarea){
		this.areaidarea=areaidarea;
	}
	public int getidarea(){
		return this.idarea;
	}
	public String getnombre(){
		return this.nombre;
	}
	public CArea getareaidarea(){
		return this.areaidarea;
	}
	public String getdescripcion(){
		return this.descripcion;
	}
	public int getsize(){
		return this.size;
	}
	public CMultimedia getidmultimedia(){
		return this.idmultimedia;
	}
	
}
