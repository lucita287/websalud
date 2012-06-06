package data;

public class CPacienteWebService {
	private Integer carne;
	private Integer codigo_unidad;
	private String unidad_academica;
	private Integer codigo_carrera;
	private String carrera;
	private int extension;
	
	
	/**
	 * @param carne
	 * @param codigo_unidad
	 * @param unidad_academica
	 * @param codigo_carrera
	 * @param carrera
	 */
	public CPacienteWebService(Integer carne, Integer codigo_unidad,
			String unidad_academica, Integer codigo_carrera, String carrera,int extension) {
		this.carne = carne;
		this.codigo_unidad = codigo_unidad;
		this.unidad_academica = unidad_academica;
		this.codigo_carrera = codigo_carrera;
		this.carrera = carrera;
		this.extension=extension;
	}
	/**
	 * @return the carne
	 */
	
	public Integer getCarne() {
		return carne;
	}
	/**
	 * @return the extension
	 */
	public int getExtension() {
		return extension;
	}
	/**
	 * @param extension the extension to set
	 */
	public void setExtension(int extension) {
		this.extension = extension;
	}
	/**
	 * @param carne the carne to set
	 */
	public void setCarne(Integer carne) {
		this.carne = carne;
	}
	/**
	 * @return the codigo_unidad
	 */
	public Integer getCodigo_unidad() {
		return codigo_unidad;
	}
	/**
	 * @param codigo_unidad the codigo_unidad to set
	 */
	public void setCodigo_unidad(Integer codigo_unidad) {
		this.codigo_unidad = codigo_unidad;
	}
	/**
	 * @return the unidad_academica
	 */
	public String getUnidad_academica() {
		return unidad_academica;
	}
	/**
	 * @param unidad_academica the unidad_academica to set
	 */
	public void setUnidad_academica(String unidad_academica) {
		this.unidad_academica = unidad_academica;
	}
	/**
	 * @return the codigo_carrera
	 */
	public Integer getCodigo_carrera() {
		return codigo_carrera;
	}
	/**
	 * @param codigo_carrera the codigo_carrera to set
	 */
	public void setCodigo_carrera(Integer codigo_carrera) {
		this.codigo_carrera = codigo_carrera;
	}
	/**
	 * @return the carrera
	 */
	public String getCarrera() {
		return carrera;
	}
	/**
	 * @param carrera the carrera to set
	 */
	public void setCarrera(String carrera) {
		this.carrera = carrera;
	}
	
}
