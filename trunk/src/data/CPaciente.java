package data;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

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
	private String email;
	private String usuario;
	private CParentesco parentesco_ced;
	private String cedula;
	private int no_personal;
	
	private CEstado_Civil estado_civilidestado_civil;
	private String emer_nombre;
	private CParentesco idemer_parentesco;
	private String emer_telefono;
	private String emer_movil;
	private CTipo_Sangre idtipo_sangre;
	private CEstado_Civil idestado_civil;
	private String titulo_secundaria;
	private String crecio_en;

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
	 * @param email
	 * @param usuario
	 * @param parentesco_ced
	 * @param cedula
	 */
	public CPaciente(int idpaciente, String nombre, Date fecha_nacimiento,
			int carne, String direccion, String telefono, String movil,
			CCarrera idcarrera, CCentro_Regional idcentro,
			CUnidad_Academica idunidad, CDependencia iddependencia, int sexo,
			String password, String email,
			String usuario, CParentesco parentesco_ced, String cedula, int no_personal) {
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
		this.email = email;
		this.usuario = usuario;
		this.parentesco_ced = parentesco_ced;
		this.cedula = cedula;
		this.no_personal= no_personal;
	}

	
	
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
	 * @param email
	 * @param usuario
	 * @param parentesco_ced
	 * @param cedula
	 * @param estado_civilidestado_civil
	 * @param emer_nombre
	 * @param idemer_parentesco
	 * @param emer_telefono
	 * @param emer_movil
	 * @param idtipo_sangre
	 * @param idestado_civil
	 * @param titulo_secundaria
	 * @param crecio_en
	 */
	public CPaciente(int idpaciente, String nombre, Date fecha_nacimiento,
			int carne, String direccion, String telefono, String movil,
			CCarrera idcarrera, CCentro_Regional idcentro,
			CUnidad_Academica idunidad, CDependencia iddependencia, int sexo,
			String password, String email, String usuario,
			CParentesco parentesco_ced, String cedula,int no_personal,
			CEstado_Civil estado_civilidestado_civil, String emer_nombre,
			CParentesco idemer_parentesco, String emer_telefono,
			String emer_movil, CTipo_Sangre idtipo_sangre,
			CEstado_Civil idestado_civil, String titulo_secundaria,
			String crecio_en) {
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
		this.email = email;
		this.usuario = usuario;
		this.parentesco_ced = parentesco_ced;
		this.cedula = cedula;
		this.estado_civilidestado_civil = estado_civilidestado_civil;
		this.emer_nombre = emer_nombre;
		this.idemer_parentesco = idemer_parentesco;
		this.emer_telefono = emer_telefono;
		this.emer_movil = emer_movil;
		this.idtipo_sangre = idtipo_sangre;
		this.idestado_civil = idestado_civil;
		this.titulo_secundaria = titulo_secundaria;
		this.crecio_en = crecio_en;
		this.no_personal= no_personal;
	}

	

	/**
	 * @return the no_personal
	 */
	public int getNo_personal() {
		return no_personal;
	}



	/**
	 * @param no_personal the no_personal to set
	 */
	public void setNo_personal(int no_personal) {
		this.no_personal = no_personal;
	}



	/**
	 * @return the estado_civilidestado_civil
	 */
	public CEstado_Civil getEstado_civilidestado_civil() {
		return estado_civilidestado_civil;
	}



	/**
	 * @param estado_civilidestado_civil the estado_civilidestado_civil to set
	 */
	public void setEstado_civilidestado_civil(
			CEstado_Civil estado_civilidestado_civil) {
		this.estado_civilidestado_civil = estado_civilidestado_civil;
	}



	/**
	 * @return the emer_nombre
	 */
	public String getEmer_nombre() {
		return emer_nombre;
	}



	/**
	 * @param emer_nombre the emer_nombre to set
	 */
	public void setEmer_nombre(String emer_nombre) {
		this.emer_nombre = emer_nombre;
	}



	/**
	 * @return the idemer_parentesco
	 */
	public CParentesco getIdemer_parentesco() {
		return idemer_parentesco;
	}



	/**
	 * @param idemer_parentesco the idemer_parentesco to set
	 */
	public void setIdemer_parentesco(CParentesco idemer_parentesco) {
		this.idemer_parentesco = idemer_parentesco;
	}



	/**
	 * @return the emer_telefono
	 */
	public String getEmer_telefono() {
		return emer_telefono;
	}



	/**
	 * @param emer_telefono the emer_telefono to set
	 */
	public void setEmer_telefono(String emer_telefono) {
		this.emer_telefono = emer_telefono;
	}



	/**
	 * @return the emer_movil
	 */
	public String getEmer_movil() {
		return emer_movil;
	}



	/**
	 * @param emer_movil the emer_movil to set
	 */
	public void setEmer_movil(String emer_movil) {
		this.emer_movil = emer_movil;
	}



	/**
	 * @return the idtipo_sangre
	 */
	public CTipo_Sangre getIdtipo_sangre() {
		return idtipo_sangre;
	}



	/**
	 * @param idtipo_sangre the idtipo_sangre to set
	 */
	public void setIdtipo_sangre(CTipo_Sangre idtipo_sangre) {
		this.idtipo_sangre = idtipo_sangre;
	}



	/**
	 * @return the idestado_civil
	 */
	public CEstado_Civil getIdestado_civil() {
		return idestado_civil;
	}



	/**
	 * @param idestado_civil the idestado_civil to set
	 */
	public void setIdestado_civil(CEstado_Civil idestado_civil) {
		this.idestado_civil = idestado_civil;
	}



	/**
	 * @return the titulo_secundaria
	 */
	public String getTitulo_secundaria() {
		return titulo_secundaria;
	}



	/**
	 * @param titulo_secundaria the titulo_secundaria to set
	 */
	public void setTitulo_secundaria(String titulo_secundaria) {
		this.titulo_secundaria = titulo_secundaria;
	}



	/**
	 * @return the crecio_en
	 */
	public String getCrecio_en() {
		return crecio_en;
	}



	/**
	 * @param crecio_en the crecio_en to set
	 */
	public void setCrecio_en(String crecio_en) {
		this.crecio_en = crecio_en;
	}



	/**
	 * @return the parentesco_ced
	 */
	public CParentesco getParentesco_ced() {
		return parentesco_ced;
	}


	/**
	 * @param parentesco_ced the parentesco_ced to set
	 */
	public void setParentesco_ced(CParentesco parentesco_ced) {
		this.parentesco_ced = parentesco_ced;
	}


	/**
	 * @return the cedula
	 */
	public String getCedula() {
		return cedula;
	}


	/**
	 * @param cedula the cedula to set
	 */
	public void setCedula(String cedula) {
		this.cedula = cedula;
	}


	/**
	 * @return the usuario
	 */
	public String getUsuario() {
		return usuario;
	}

	/**
	 * @param usuario the usuario to set
	 */
	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}

	/**
	 * @return the email
	 */
	public String getEmail() {
		return email;
	}

	/**
	 * @param email the email to set
	 */
	public void setEmail(String email) {
		this.email = email;
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
	public String getFormatoFechaDes(Date date){
		SimpleDateFormat formatter = new SimpleDateFormat("E ',' dd 'de' MMMM 'de' yyyy", new Locale("es"));
		return formatter.format(date);
	}
	
}