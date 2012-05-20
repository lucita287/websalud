package data;

public class CMenu_Categoria {
	private int idmenu_categoria;
	private String nombre;
	private String instruccion;
	private int area_examen;
	
	
	
	/**
	 * @param idmenu_categoria
	 * @param nombre
	 * @param instruccion
	 * @param area_examen
	 */
	public CMenu_Categoria(int idmenu_categoria, String nombre,
			String instruccion, int area_examen) {
		this.idmenu_categoria = idmenu_categoria;
		this.nombre = nombre;
		this.instruccion = instruccion;
		this.area_examen = area_examen;
	}
	/**
	 * @return the instruccion
	 */
	public String getInstruccion() {
		return instruccion;
	}
	/**
	 * @param instruccion the instruccion to set
	 */
	public void setInstruccion(String instruccion) {
		this.instruccion = instruccion;
	}
	/**
	 * @return the area_examen
	 */
	public int getArea_examen() {
		return area_examen;
	}
	/**
	 * @param area_examen the area_examen to set
	 */
	public void setArea_examen(int area_examen) {
		this.area_examen = area_examen;
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
