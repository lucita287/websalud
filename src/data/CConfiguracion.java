package data;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class CConfiguracion {
	private int idconfiguracion;
	private String telefono;
	private String correo_electronico;
	private String fax;
	private String direccion_imagen;
	private String direccion_pdf;
	private int tamanio_sub;
	private String dir_rel_imagen;
	private String dir_rel_pdf;
	private String direccion;
	private int ciclo;
	private int multifa_reporte;
	private int impresion_salud;
	private int random_carne;
	private String jefe_actual;
	private Date fecha_examen;
	private String dependencia;
	private String no_personal;
	private String password;
	
	public CConfiguracion(int idconfiguracion,String telefono, String correo_electronico, String fax, String direccion_imagen,
			String direccion_pdf, int tamanio_sub,String dir_rel_imagen, String dir_rel_pdf,String direccion, int ciclo, int multifa_reporte,int impresion_salud,int random_carne,String jefe_actual, Date fecha_examen,
			String dependencia,String no_personal,String password){
		this.dependencia=dependencia;
		this.no_personal=no_personal;
		this.password=password;
		this.idconfiguracion=idconfiguracion;
		this.telefono=telefono;
		this.correo_electronico=correo_electronico;
		this.fax=fax;
		this.direccion_imagen=direccion_imagen;
		this.direccion_pdf=direccion_pdf;
		this.tamanio_sub=tamanio_sub;
		this.dir_rel_imagen=dir_rel_imagen;
		this.dir_rel_pdf=dir_rel_pdf;
		this.direccion=direccion;
		this.ciclo=ciclo;
		this.multifa_reporte=multifa_reporte;
		this.impresion_salud=impresion_salud;
		this.random_carne=random_carne;
		this.jefe_actual=jefe_actual;
		this.fecha_examen=fecha_examen;
	}
	
	
	
	/**
	 * @return the dependencia
	 */
	public String getDependencia() {
		return dependencia;
	}



	/**
	 * @param dependencia the dependencia to set
	 */
	public void setDependencia(String dependencia) {
		this.dependencia = dependencia;
	}



	/**
	 * @return the no_personal
	 */
	public String getNo_personal() {
		return no_personal;
	}



	/**
	 * @param no_personal the no_personal to set
	 */
	public void setNo_personal(String no_personal) {
		this.no_personal = no_personal;
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
	 * @return the fecha_examen
	 */
	public Date getFecha_examen() {
		return fecha_examen;
	}



	/**
	 * @param fecha_examen the fecha_examen to set
	 */
	public void setFecha_examen(Date fecha_examen) {
		this.fecha_examen = fecha_examen;
	}



	/**
	 * @return the impresion_salud
	 */
	public int getImpresion_salud() {
		return impresion_salud;
	}



	/**
	 * @param impresion_salud the impresion_salud to set
	 */
	public void setImpresion_salud(int impresion_salud) {
		this.impresion_salud = impresion_salud;
	}



	/**
	 * @return the random_carne
	 */
	public int getRandom_carne() {
		return random_carne;
	}

public String getFormatoFechaddmmyy(Date date){
		
		if (date!=null){
				DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		
		return formatter.format(date);
		}else return "";
	}

	/**
	 * @param random_carne the random_carne to set
	 */
	public void setRandom_carne(int random_carne) {
		this.random_carne = random_carne;
	}



	/**
	 * @return the jefe_actual
	 */
	public String getJefe_actual() {
		return jefe_actual;
	}



	/**
	 * @param jefe_actual the jefe_actual to set
	 */
	public void setJefe_actual(String jefe_actual) {
		this.jefe_actual = jefe_actual;
	}



	/**
	 * @return the ciclo
	 */
	public int getCiclo() {
		return ciclo;
	}



	/**
	 * @param ciclo the ciclo to set
	 */
	public void setCiclo(int ciclo) {
		this.ciclo = ciclo;
	}



	/**
	 * @return the multifa_reporte
	 */
	public int getMultifa_reporte() {
		return multifa_reporte;
	}



	/**
	 * @param multifa_reporte the multifa_reporte to set
	 */
	public void setMultifa_reporte(int multifa_reporte) {
		this.multifa_reporte = multifa_reporte;
	}



	/**
	 * @param idconfiguracion the idconfiguracion to set
	 */
	public void setIdconfiguracion(int idconfiguracion) {
		this.idconfiguracion = idconfiguracion;
	}

	/**
	 * @param telefono the telefono to set
	 */
	public void setTelefono(String telefono) {
		this.telefono = telefono;
	}

	/**
	 * @param correo_electronico the correo_electronico to set
	 */
	public void setCorreo_electronico(String correo_electronico) {
		this.correo_electronico = correo_electronico;
	}

	/**
	 * @param fax the fax to set
	 */
	public void setFax(String fax) {
		this.fax = fax;
	}

	/**
	 * @param direccion_imagen the direccion_imagen to set
	 */
	public void setDireccion_imagen(String direccion_imagen) {
		this.direccion_imagen = direccion_imagen;
	}

	/**
	 * @param direccion_pdf the direccion_pdf to set
	 */
	public void setDireccion_pdf(String direccion_pdf) {
		this.direccion_pdf = direccion_pdf;
	}

	/**
	 * @param tamanio_sub the tamanio_sub to set
	 */
	public void setTamanio_sub(int tamanio_sub) {
		this.tamanio_sub = tamanio_sub;
	}

	/**
	 * @param dir_rel_imagen the dir_rel_imagen to set
	 */
	public void setDir_rel_imagen(String dir_rel_imagen) {
		this.dir_rel_imagen = dir_rel_imagen;
	}

	/**
	 * @param dir_rel_pdf the dir_rel_pdf to set
	 */
	public void setDir_rel_pdf(String dir_rel_pdf) {
		this.dir_rel_pdf = dir_rel_pdf;
	}

	/**
	 * @param direccion the direccion to set
	 */
	public void setDireccion(String direccion) {
		this.direccion = direccion;
	}

	public int getidconfiguracion(){
		return this.idconfiguracion;
	}
	public String gettelefono(){
		return this.telefono;
	}
	public String getcorreo_electronico(){
		return this.correo_electronico;
	}
	public String getfax(){
		return this.fax;
	}
	public String getdireccion_imagen(){
		return this.direccion_imagen;
	}
	public String getdireccion_pdf(){
		return this.direccion_pdf;
	}
	public int gettamanio_sub(){
		return this.tamanio_sub;
	}
	public String getdir_rel_imagen(){
		return this.dir_rel_imagen;
	}
	public String getdir_rel_pdf(){
		return this.dir_rel_pdf;
	}
	public String getdireccion(){
		return this.direccion;
	}
}