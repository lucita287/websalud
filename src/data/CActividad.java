package data;

public class CActividad {
	private int idactividad;
	private String titulo;
	private CArea areaidarea;
	private String descripcion;
	private CEdificio edificioidedificio;
	private String salon;
	
	
	/**
	 * @param idactividad
	 * @param titulo
	 * @param areaidarea
	 * @param descripcion
	 * @param edificioidedificio
	 * @param salon
	 */
	public CActividad(int idactividad, String titulo, CArea areaidarea,
			String descripcion, CEdificio edificioidedificio, String salon) {
		this.idactividad = idactividad;
		this.titulo = titulo;
		this.areaidarea = areaidarea;
		this.descripcion = descripcion;
		this.edificioidedificio = edificioidedificio;
		this.salon = salon;
	}
	/**
	 * @return the salon
	 */
	public String getSalon() {
		return salon;
	}
	/**
	 * @param salon the salon to set
	 */
	public void setSalon(String salon) {
		this.salon = salon;
	}
	/**
	 * @return the idactividad
	 */
	public int getIdactividad() {
		return idactividad;
	}
	/**
	 * @param idactividad the idactividad to set
	 */
	public void setIdactividad(int idactividad) {
		this.idactividad = idactividad;
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
	 * @return the areaidarea
	 */
	public CArea getAreaidarea() {
		return areaidarea;
	}
	/**
	 * @param areaidarea the areaidarea to set
	 */
	public void setAreaidarea(CArea areaidarea) {
		this.areaidarea = areaidarea;
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
	 * @return the edificioidedificio
	 */
	public CEdificio getEdificioidedificio() {
		return edificioidedificio;
	}
	/**
	 * @param edificioidedificio the edificioidedificio to set
	 */
	public void setEdificioidedificio(CEdificio edificioidedificio) {
		this.edificioidedificio = edificioidedificio;
	}
	
}
