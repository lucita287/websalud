package data;

public class CCategoria {
	private int idcategoria;
	private String descripcion;
	private int orden;
	private int autoevaluacion;
	private int multifasico;
	/**
	 * @param idcategoria
	 * @param descripcion
	 * @param orden
	 * @param autoevaluacion
	 * @param multifasico
	 */
	public CCategoria(int idcategoria, String descripcion, int orden,
			int autoevaluacion, int multifasico) {
		this.idcategoria = idcategoria;
		this.descripcion = descripcion;
		this.orden = orden;
		this.autoevaluacion = autoevaluacion;
		this.multifasico = multifasico;
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
	public boolean getBooleano(int i){
		if(i==1) return true;
		else return false;
	}
	public String getMensaje(int i){
		if(i==1) return "SI";
		else return "NO";
	}
}
