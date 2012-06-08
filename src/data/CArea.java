package data;

public class CArea {
	private int idarea;
	private String nombre;
	private CArea areaidarea;
	private String descripcion;
	private int size;
	private CMultimedia idmultimedia;
	private String html_adicional;
	private String descripcion_imagen;
	private String palabras_buscador;
	private String descripcion_buscador;
	
	public CArea(int idarea,String nombre,String descripcion, int size, CMultimedia idmultimedia,CArea areaidarea,String html_adicional){
		this.idarea=idarea;
		this.nombre=nombre;
		this.areaidarea=areaidarea;
		this.descripcion=descripcion;
		this.idmultimedia=idmultimedia;
		this.size=size;
		this.html_adicional=html_adicional;
		this.descripcion_buscador="";
		this.descripcion_imagen="";
		this.palabras_buscador="";
	}
	
	
	
	/**
	 * @return the descripcion_imagen
	 */
	public String getDescripcion_imagen() {
		return descripcion_imagen;
	}



	/**
	 * @param descripcion_imagen the descripcion_imagen to set
	 */
	public void setDescripcion_imagen(String descripcion_imagen) {
		this.descripcion_imagen = descripcion_imagen;
	}



	/**
	 * @return the palabras_buscador
	 */
	public String getPalabras_buscador() {
		return palabras_buscador;
	}



	/**
	 * @param palabras_buscador the palabras_buscador to set
	 */
	public void setPalabras_buscador(String palabras_buscador) {
		this.palabras_buscador = palabras_buscador;
	}



	/**
	 * @return the descripcion_buscador
	 */
	public String getDescripcion_buscador() {
		return descripcion_buscador;
	}



	/**
	 * @param descripcion_buscador the descripcion_buscador to set
	 */
	public void setDescripcion_buscador(String descripcion_buscador) {
		this.descripcion_buscador = descripcion_buscador;
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
