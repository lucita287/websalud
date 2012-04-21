package data;

public class CMenu_Categoria {
	int idmenu_categoria;
	String nombre;
	
	
	
	/**
	 * @param idmenu_categoria
	 * @param nombre
	 */
	public CMenu_Categoria(int idmenu_categoria, String nombre) {
		this.idmenu_categoria = idmenu_categoria;
		this.nombre = nombre;
	}
	/**
	 * @return the idmenu_categoria
	 */
	public int getIdmenu_categoria() {
		return idmenu_categoria;
	}
	/**
	 * @param idmenu_categoria the idmenu_categoria to set
	 */
	public void setIdmenu_categoria(int idmenu_categoria) {
		this.idmenu_categoria = idmenu_categoria;
	}
	/**
	 * @return the nombre
	 */
	public String getNombre() {
		return nombre;
	}
	/**
	 * @param nombre the nombre to set
	 */
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	
}
