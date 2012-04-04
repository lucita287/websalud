package data;

import java.util.Date;

public class CPaciente {
	private int idpaciente;
	private String nombre;
	private java.util.Date fecha_nacimiento;
	private int carne;
	private String direccion;
	private String telefono;
	private String movil;
	private CCarrera idcarrera;
	private CCentro_Regional idcentro;
	private CUnidad_Academica idunidad;
	private CDependencia iddependencia;
	private int sexo;
	private String password;
	private String nombre_carrera;
	private String nombre_centro;
	private String nombre_unidad;
	private String nombre_dependencia;
	/**
	 * @param idpaciente
	 * @param nombre
	 * @param fecha_nacimiento
	 * @param carne
	 * @param direccion
	 * @param telefono
	 * @param movil
	 * @param idcarrera
	 * @param idcentro
	 * @param idunidad
	 * @param iddependencia
	 * @param sexo
	 * @param password
	 * @param nombre_carrera
	 * @param nombre_centro
	 * @param nombre_unidad
	 * @param nombre_dependencia
	 */
	public CPaciente(int idpaciente, String nombre, Date fecha_nacimiento,
			int carne, String direccion, String telefono, String movil,
			CCarrera idcarrera, CCentro_Regional idcentro,
			CUnidad_Academica idunidad, CDependencia iddependencia, int sexo,
			String password, String nombre_carrera, String nombre_centro,
			String nombre_unidad, String nombre_dependencia) {
		this.idpaciente = idpaciente;
		this.nombre = nombre;
		this.fecha_nacimiento = fecha_nacimiento;
		this.carne = carne;
		this.direccion = direccion;
		this.telefono = telefono;
		this.movil = movil;
		this.idcarrera = idcarrera;
		this.idcentro = idcentro;
		this.idunidad = idunidad;
		this.iddependencia = iddependencia;
		this.sexo = sexo;
		this.password = password;
		this.nombre_carrera = nombre_carrera;
		this.nombre_centro = nombre_centro;
		this.nombre_unidad = nombre_unidad;
		this.nombre_dependencia = nombre_dependencia;
	}
	/**
	 * @return the idpaciente
	 */
	public int getIdpaciente() {
		return idpaciente;
	}
	/**
	 * @param idpaciente the idpaciente to set
	 */
	public void setIdpaciente(int idpaciente) {
		this.idpaciente = idpaciente;
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
	/**
	 * @return the fecha_nacimiento
	 */
	public java.util.Date getFecha_nacimiento() {
		return fecha_nacimiento;
	}
	/**
	 * @param fecha_nacimiento the fecha_nacimiento to set
	 */
	public void setFecha_nacimiento(java.util.Date fecha_nacimiento) {
		this.fecha_nacimiento = fecha_nacimiento;
	}
	/**
	 * @return the carne
	 */
	public int getCarne() {
		return carne;
	}
	/**
	 * @param carne the carne to set
	 */
	public void setCarne(int carne) {
		this.carne = carne;
	}
	/**
	 * @return the direccion
	 */
	public String getDireccion() {
		return direccion;
	}
	/**
	 * @param direccion the direccion to set
	 */
	public void setDireccion(String direccion) {
		this.direccion = direccion;
	}
	/**
	 * @return the telefono
	 */
	public String getTelefono() {
		return telefono;
	}
	/**
	 * @param telefono the telefono to set
	 */
	public void setTelefono(String telefono) {
		this.telefono = telefono;
	}
	/**
	 * @return the movil
	 */
	public String getMovil() {
		return movil;
	}
	/**
	 * @param movil the movil to set
	 */
	public void setMovil(String movil) {
		this.movil = movil;
	}
	/**
	 * @return the idcarrera
	 */
	public CCarrera getIdcarrera() {
		return idcarrera;
	}
	/**
	 * @param idcarrera the idcarrera to set
	 */
	public void setIdcarrera(CCarrera idcarrera) {
		this.idcarrera = idcarrera;
	}
	/**
	 * @return the idcentro
	 */
	public CCentro_Regional getIdcentro() {
		return idcentro;
	}
	/**
	 * @param idcentro the idcentro to set
	 */
	public void setIdcentro(CCentro_Regional idcentro) {
		this.idcentro = idcentro;
	}
	/**
	 * @return the idunidad
	 */
	public CUnidad_Academica getIdunidad() {
		return idunidad;
	}
	/**
	 * @param idunidad the idunidad to set
	 */
	public void setIdunidad(CUnidad_Academica idunidad) {
		this.idunidad = idunidad;
	}
	/**
	 * @return the iddependencia
	 */
	public CDependencia getIddependencia() {
		return iddependencia;
	}
	/**
	 * @param iddependencia the iddependencia to set
	 */
	public void setIddependencia(CDependencia iddependencia) {
		this.iddependencia = iddependencia;
	}
	/**
	 * @return the sexo
	 */
	public int getSexo() {
		return sexo;
	}
	/**
	 * @param sexo the sexo to set
	 */
	public void setSexo(int sexo) {
		this.sexo = sexo;
	}
	/**
	 * @return the password
	 */
	public String getPassword() {
		return password;
	}
	/**
	 * @param password the password to set
	 */
	public void setPassword(String password) {
		this.password = password;
	}
	/**
	 * @return the nombre_carrera
	 */
	public String getNombre_carrera() {
		return nombre_carrera;
	}
	/**
	 * @param nombre_carrera the nombre_carrera to set
	 */
	public void setNombre_carrera(String nombre_carrera) {
		this.nombre_carrera = nombre_carrera;
	}
	/**
	 * @return the nombre_centro
	 */
	public String getNombre_centro() {
		return nombre_centro;
	}
	/**
	 * @param nombre_centro the nombre_centro to set
	 */
	public void setNombre_centro(String nombre_centro) {
		this.nombre_centro = nombre_centro;
	}
	/**
	 * @return the nombre_unidad
	 */
	public String getNombre_unidad() {
		return nombre_unidad;
	}
	/**
	 * @param nombre_unidad the nombre_unidad to set
	 */
	public void setNombre_unidad(String nombre_unidad) {
		this.nombre_unidad = nombre_unidad;
	}
	/**
	 * @return the nombre_dependencia
	 */
	public String getNombre_dependencia() {
		return nombre_dependencia;
	}
	/**
	 * @param nombre_dependencia the nombre_dependencia to set
	 */
	public void setNombre_dependencia(String nombre_dependencia) {
		this.nombre_dependencia = nombre_dependencia;
	}
	
}
