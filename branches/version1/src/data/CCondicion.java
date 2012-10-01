package data;

public class CCondicion {
	private Integer idpregunta1;
	private Integer signo;
	private Integer valor;
	private Integer tipo;
	private Integer idcondicion;
	private Integer idencabezado_condicion;
	private CCondicion condicion1;
	private CCondicion condicion2;
	private String  pregunta1;
	private int orden_pregunta;
	private Integer inicio;
	private String descripcion;
	/**
	 * @param idpregunta1
	 * @param signo
	 * @param valor
	 * @param tipo
	 * @param idcondicion
	 * @param idencabezado_condicion
	 * @param rec_condicion
	 * @param inicio
	 * @param descripcion
	 */
	public CCondicion(Integer idpregunta1, Integer signo, Integer valor,
			Integer tipo, Integer idcondicion, Integer idencabezado_condicion,
			CCondicion condicion1,CCondicion condicion2,Integer inicio,String descripcion) {
		this.idpregunta1 = idpregunta1;
		this.signo = signo;
		this.valor = valor;
		this.tipo = tipo;
		this.idcondicion = idcondicion;
		this.idencabezado_condicion = idencabezado_condicion;
		this.condicion1 = condicion1;
		this.condicion2= condicion2;
		this.inicio=inicio;
		this.descripcion=descripcion;
		pregunta1="";
		orden_pregunta=0;
	}
	
	
	
	/**
	 * @return the inicio
	 */
	public Integer getInicio() {
		return inicio;
	}



	/**
	 * @param inicio the inicio to set
	 */
	public void setInicio(Integer inicio) {
		this.inicio = inicio;
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
	 * @return the orden_pregunta
	 */
	public int getOrden_pregunta() {
		return orden_pregunta;
	}



	/**
	 * @param orden_pregunta the orden_pregunta to set
	 */
	public void setOrden_pregunta(int orden_pregunta) {
		this.orden_pregunta = orden_pregunta;
	}



	/**
	 * @return the pregunta1
	 */
	public String getPregunta1() {
		return pregunta1;
	}

	/**
	 * @param pregunta1 the pregunta1 to set
	 */
	public void setPregunta1(String pregunta1) {
		this.pregunta1 = pregunta1;
	}

	/**
	 * @return the idpregunta1
	 */
	public Integer getIdpregunta1() {
		return idpregunta1;
	}
	/**
	 * @param idpregunta1 the idpregunta1 to set
	 */
	public void setIdpregunta1(Integer idpregunta1) {
		this.idpregunta1 = idpregunta1;
	}
	/**
	 * @return the signo
	 */
	public Integer getSigno() {
		return signo;
	}
	/**
	 * @return the signo respuesta
	 */
	public String getSignoR() {
		if(signo==1) return "MAYOR";
		else if(signo==2) return "MENOR";
		else if(signo==3) return "MAYOR IGUAL";
		else if(signo==4) return "MENOR IGUAL";
		else if(signo==5) return "IGUAL";
		else return "NO IGUAL";
			
	}
	/**
	 * @return the signo respuesta
	 */
	public String getSignoR2() {
		if(signo==1) return ">";
		else if(signo==2) return "<";
		else if(signo==3) return ">=";
		else if(signo==4) return "<=";
		else if(signo==5) return "=";
		else return "<>";
			
	}
	/**
	 * @param signo the signo to set
	 */
	public void setSigno(Integer signo) {
		this.signo = signo;
	}
	/**
	 * @return the valor
	 */
	public Integer getValor() {
		return valor;
	}
	/**
	 * @param valor the valor to set
	 */
	public void setValor(Integer valor) {
		this.valor = valor;
	}
	/**
	 * @return the tipo
	 */
	public Integer getTipo() {
		return tipo;
	}
	
	/**
	 * @return the tipo respuesta
	 */
	public String getTipoR() {
		if(tipo==0) return "CONDICION";
		else if(tipo==1) return "AND";
		else if(tipo==2) return "OR";
		else if(tipo==3) return "PARENTESIS";
		else  return "NOT";
			
	}
	/**
	 * @param tipo the tipo to set
	 */
	public void setTipo(Integer tipo) {
		this.tipo = tipo;
	}
	/**
	 * @return the idcondicion
	 */
	public Integer getIdcondicion() {
		return idcondicion;
	}
	/**
	 * @param idcondicion the idcondicion to set
	 */
	public void setIdcondicion(Integer idcondicion) {
		this.idcondicion = idcondicion;
	}
	/**
	 * @return the idencabezado_condicion
	 */
	public Integer getIdencabezado_condicion() {
		return idencabezado_condicion;
	}
	/**
	 * @param idencabezado_condicion the idencabezado_condicion to set
	 */
	public void setIdencabezado_condicion(Integer idencabezado_condicion) {
		this.idencabezado_condicion = idencabezado_condicion;
	}
	/**
	 * @return the condicion1
	 */
	public CCondicion getCondicion1() {
		return condicion1;
	}
	/**
	 * @param condicion1 the condicion1 to set
	 */
	public void setCondicion1(CCondicion condicion1) {
		this.condicion1 = condicion1;
	}
	/**
	 * @return the condicion2
	 */
	public CCondicion getCondicion2() {
		return condicion2;
	}
	/**
	 * @param condicion2 the condicion2 to set
	 */
	public void setCondicion2(CCondicion condicion2) {
		this.condicion2 = condicion2;
	}
	
	
}
