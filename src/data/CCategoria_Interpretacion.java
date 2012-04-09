package data;

public class CCategoria_Interpretacion {
	private int idcategoria_interpretacion;
	private int ponderacion_max;
	private int ponderacion_min;
	private String interpretacion;
	private CCategoria idcategoria;
	/**
	 * @param idcategoria_interpretacion
	 * @param ponderacion_max
	 * @param ponderacion_min
	 * @param interpretacion
	 * @param idcategoria
	 */
	public CCategoria_Interpretacion(int idcategoria_interpretacion,
			int ponderacion_max, int ponderacion_min, String interpretacion,
			CCategoria idcategoria) {
		this.idcategoria_interpretacion = idcategoria_interpretacion;
		this.ponderacion_max = ponderacion_max;
		this.ponderacion_min = ponderacion_min;
		this.interpretacion = interpretacion;
		this.idcategoria = idcategoria;
	}
	/**
	 * @return the idcategoria_interpretacion
	 */
	public int getIdcategoria_interpretacion() {
		return idcategoria_interpretacion;
	}
	/**
	 * @param idcategoria_interpretacion the idcategoria_interpretacion to set
	 */
	public void setIdcategoria_interpretacion(int idcategoria_interpretacion) {
		this.idcategoria_interpretacion = idcategoria_interpretacion;
	}
	/**
	 * @return the ponderacion_max
	 */
	public int getPonderacion_max() {
		return ponderacion_max;
	}
	/**
	 * @param ponderacion_max the ponderacion_max to set
	 */
	public void setPonderacion_max(int ponderacion_max) {
		this.ponderacion_max = ponderacion_max;
	}
	/**
	 * @return the ponderacion_min
	 */
	public int getPonderacion_min() {
		return ponderacion_min;
	}
	/**
	 * @param ponderacion_min the ponderacion_min to set
	 */
	public void setPonderacion_min(int ponderacion_min) {
		this.ponderacion_min = ponderacion_min;
	}
	/**
	 * @return the interpretacion
	 */
	public String getInterpretacion() {
		return interpretacion;
	}
	/**
	 * @param interpretacion the interpretacion to set
	 */
	public void setInterpretacion(String interpretacion) {
		this.interpretacion = interpretacion;
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
	
}
