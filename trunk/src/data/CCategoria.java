package data;

public class CCategoria {
	private int idcategoria;
	private String descripcion;
	private int orden;
	private int autoevaluacion;
	private int multifasico;
	private int estado;
	private CMenu_Categoria idmenu_categoria;
	/**
	 * @param idcategoria
	 * @param descripcion
	 * @param orden
	 * @param autoevaluacion
	 * @param multifasico
	 * @param estado
	 * @param idmenu_categoria
	 */
	public CCategoria(int idcategoria, String descripcion, int orden,
			int autoevaluacion, int multifasico, int estado,CMenu_Categoria idmenu_categoria) {
		this.idcategoria = idcategoria;
		this.descripcion = descripcion;
		this.orden = orden;
		this.autoevaluacion = autoevaluacion;
		this.multifasico = multifasico;
		this.estado = estado;
		this.idmenu_categoria=idmenu_categoria;
	}
	
	/**
	 * @return the idmenu_categoria
	 */
	public CMenu_Categoria getIdmenu_categoria() {
		return idmenu_categoria;
	}

	/**
	 * @param idmenu_categoria the idmenu_categoria to set
	 */
	public void setIdmenu_categoria(CMenu_Categoria idmenu_categoria) {
		this.idmenu_categoria = idmenu_categoria;
	}

	/**
	 * @return the idcategoria
	 */
	public int getIdcategoria() {
		return idcategoria;
	}
	/**
	 * @param idcategoria the idcategoria to set
	 */
	public void setIdcategoria(int idcategoria) {
		this.idcategoria = idcategoria;
	}
	/**
	 * @return the descripcion
	 */
	public String getDescripcion() {
		return descripcion;
	}
	/**
	 * @param descripcion the descripcion to set
	 */
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	/**
	 * @return the orden
	 */
	public int getOrden() {
		return orden;
	}
	/**
	 * @param orden the orden to set
	 */
	public void setOrden(int orden) {
		this.orden = orden;
	}
	/**
	 * @return the autoevaluacion
	 */
	public int getAutoevaluacion() {
		return autoevaluacion;
	}
	/**
	 * @param autoevaluacion the autoevaluacion to set
	 */
	public void setAutoevaluacion(int autoevaluacion) {
		this.autoevaluacion = autoevaluacion;
	}
	/**
	 * @return the multifasico
	 */
	public int getMultifasico() {
		return multifasico;
	}
	/**
	 * @param multifasico the multifasico to set
	 */
	public void setMultifasico(int multifasico) {
		this.multifasico = multifasico;
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
	 public boolean getBooleano(int i){
         if(i==1) return true;
         else return false;
	 }
	 public String getMensaje(int i){
	         if(i==1) return "SI";
	         else return "NO";
	 }
	 public String getEstadoMensaje(){
         if(this.estado==1) return "HABILITADO";
         else return "DESHABILITADO";
 }
}
