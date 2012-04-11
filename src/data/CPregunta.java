package data;

public class CPregunta {
	private int idpregunta;
	private int orden;
	private int requerida;
	private String pregunta;
	private CCategoria idcategoria;
	private String descripcion;
	private CTipo_Pregunta idtipo_pregunta;
	private int auto_evaluacion;
	private int multifasico;
	private int largo;
	private int multiple;
	private int estado;
	/**
	 * @param idpregunta
	 * @param orden
	 * @param requerida
	 * @param pregunta
	 * @param idcategoria
	 * @param descripcion
	 * @param idtipo_pregunta
	 * @param auto_evaluacion
	 * @param multifasico
	 * @param largo
	 * @param multiple
	 * @param idgrupo
	 * @param estado
	 */
	public CPregunta(int idpregunta, int orden, int requerida, String pregunta,
			CCategoria idcategoria, String descripcion,
			CTipo_Pregunta idtipo_pregunta, int auto_evaluacion,
			int multifasico, int largo, int multiple,int estado) {
		this.idpregunta = idpregunta;
		this.orden = orden;
		this.requerida = requerida;
		this.pregunta = pregunta;
		this.idcategoria = idcategoria;
		this.descripcion = descripcion;
		this.idtipo_pregunta = idtipo_pregunta;
		this.auto_evaluacion = auto_evaluacion;
		this.multifasico = multifasico;
		this.largo = largo;
		this.multiple = multiple;
		this.estado = estado;
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


	
	/**
	 * @return the idpregunta
	 */
	public int getIdpregunta() {
		return idpregunta;
	}
	/**
	 * @param idpregunta the idpregunta to set
	 */
	public void setIdpregunta(int idpregunta) {
		this.idpregunta = idpregunta;
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
	 * @return the requerida
	 */
	public int getRequerida() {
		return requerida;
	}
	/**
	 * @param requerida the requerida to set
	 */
	public void setRequerida(int requerida) {
		this.requerida = requerida;
	}
	/**
	 * @return the pregunta
	 */
	public String getPregunta() {
		return pregunta;
	}
	/**
	 * @param pregunta the pregunta to set
	 */
	public void setPregunta(String pregunta) {
		this.pregunta = pregunta;
	}
	/**
	 * @return the idcategoria
	 */
	public CCategoria getIdcategoria() {
		return idcategoria;
	}
	/**
	 * @param idcategoria the idcategoria to set
	 */
	public void setIdcategoria(CCategoria idcategoria) {
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
	 * @return the idtipo_pregunta
	 */
	public CTipo_Pregunta getIdtipo_pregunta() {
		return idtipo_pregunta;
	}
	/**
	 * @param idtipo_pregunta the idtipo_pregunta to set
	 */
	public void setIdtipo_pregunta(CTipo_Pregunta idtipo_pregunta) {
		this.idtipo_pregunta = idtipo_pregunta;
	}
	/**
	 * @return the auto_evaluacion
	 */
	public int getAuto_evaluacion() {
		return auto_evaluacion;
	}
	/**
	 * @param auto_evaluacion the auto_evaluacion to set
	 */
	public void setAuto_evaluacion(int auto_evaluacion) {
		this.auto_evaluacion = auto_evaluacion;
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
	 * @return the largo
	 */
	public int getLargo() {
		return largo;
	}
	/**
	 * @param largo the largo to set
	 */
	public void setLargo(int largo) {
		this.largo = largo;
	}
	/**
	 * @return the multiple
	 */
	public int getMultiple() {
		return multiple;
	}
	/**
	 * @param multiple the multiple to set
	 */
	public void setMultiple(int multiple) {
		this.multiple = multiple;
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
