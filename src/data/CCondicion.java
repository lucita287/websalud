package data;

public class CCondicion {
	private Integer idpregunta1;
	private Integer signo;
	private Integer valor;
	private Integer tipo;
	private Integer idcondicion;
	private Integer idencabezado_condicion;
	private Integer condicion1;
	private Integer condicion2;
	private String  pregunta1;
	/**
	 * @param idpregunta1
	 * @param signo
	 * @param valor
	 * @param tipo
	 * @param idcondicion
	 * @param idencabezado_condicion
	 * @param rec_condicion
	 */
	public CCondicion(Integer idpregunta1, Integer signo, Integer valor,
			Integer tipo, Integer idcondicion, Integer idencabezado_condicion,
			Integer condicion1,Integer condicion2) {
		this.idpregunta1 = idpregunta1;
		this.signo = signo;
		this.valor = valor;
		this.tipo = tipo;
		this.idcondicion = idcondicion;
		this.idencabezado_condicion = idencabezado_condicion;
		this.condicion1 = condicion1;
		this.condicion2= condicion2;
		pregunta1="";
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
	public Integer getCondicion1() {
		return condicion1;
	}
	/**
	 * @param condicion1 the condicion1 to set
	 */
	public void setCondicion1(Integer condicion1) {
		this.condicion1 = condicion1;
	}
	/**
	 * @return the condicion2
	 */
	public Integer getCondicion2() {
		return condicion2;
	}
	/**
	 * @param condicion2 the condicion2 to set
	 */
	public void setCondicion2(Integer condicion2) {
		this.condicion2 = condicion2;
	}
	
	
}
