package data;

public class CArea {
	private int idarea;
	private String nombre;
	private CArea areaidarea;
	private String descripcion;
	private int size;
	private CMultimedia idmultimedia;
	private String html_adicional;
	
	public CArea(int idarea,String nombre,String descripcion, int size, CMultimedia idmultimedia,CArea areaidarea,String html_adicional){
		this.idarea=idarea;
		this.nombre=nombre;
		this.areaidarea=areaidarea;
		this.descripcion=descripcion;
		this.idmultimedia=idmultimedia;
		this.size=size;
		this.html_adicional=html_adicional;
	}
	
	
	/**
	 * @return the html_adicional
	 */
	public String getHtml_adicional() {
		return html_adicional;
	}


	/**
	 * @param html_adicional the html_adicional to set
	 */
	public void setHtml_adicional(String html_adicional) {
		this.html_adicional = html_adicional;
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
	public void setsize(int size){
		this.size=size;
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
