package data;

public class CResultado_Examen {
	 private int idresultado_examen; 
	 private String titulo; 
	 private String interpretacion; 
	 private int  idtipo_interpretacion;
	 private int size;
	/**
	 * @param idresultado_examen
	 * @param titulo
	 * @param interpretacion
	 * @param idtipo_interpretacion
	 */
	public CResultado_Examen(int idresultado_examen, String titulo,
			String interpretacion, int idtipo_interpretacion, int size) {
		this.idresultado_examen = idresultado_examen;
		this.titulo = titulo;
		this.interpretacion = interpretacion;
		this.idtipo_interpretacion = idtipo_interpretacion;
		this.size=size;
	}
	
	
	/**
	 * @return the size
	 */
	public int getSize() {
		return size;
	}


	/**
	 * @param size the size to set
	 */
	public void setSize(int size) {
		this.size = size;
	}


	/**
	 * @return the idresultado_examen
	 */
	public int getIdresultado_examen() {
		return idresultado_examen;
	}
	/**
	 * @param idresultado_examen the idresultado_examen to set
	 */
	public void setIdresultado_examen(int idresultado_examen) {
		this.idresultado_examen = idresultado_examen;
	}
	/**
	 * @return the titulo
	 */
	public String getTitulo() {
		return titulo;
	}
	/**
	 * @param titulo the titulo to set
	 */
	public void setTitulo(String titulo) {
		this.titulo = titulo;
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
	 * @return the idtipo_interpretacion
	 */
	public int getIdtipo_interpretacion() {
		return idtipo_interpretacion;
	}
	/**
	 * @param idtipo_interpretacion the idtipo_interpretacion to set
	 */
	public void setIdtipo_interpretacion(int idtipo_interpretacion) {
		this.idtipo_interpretacion = idtipo_interpretacion;
	}
	 
}
