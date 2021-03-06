package data;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;

import framework.CValidation;

public class CNoticia {
	private String titulo;
	private String descripcion;
	private CMultimedia multimediaidmultimedia;
	private Date fecha_inicio;
	private Date fecha_fin;
	private int prioridad;
	private int idnoticia;
	private CArea areaidarea;
	private String descripcion_corta;
	private int estado;
	private CMultimedia multimediaidmultimedia_pdf;
	
	public CNoticia(String titulo, String descripcion,String descripcion_corta,
			CMultimedia multimediaidmultimedia, Date fecha_inicio,
			Date fecha_fin, int prioridad, int idnoticia, int estado,CArea areaidarea,CMultimedia multimediaidmultimedia_pdf) {
		this.titulo = titulo;
		this.descripcion = descripcion;
		this.multimediaidmultimedia = multimediaidmultimedia;
		this.fecha_inicio = fecha_inicio;
		this.fecha_fin = fecha_fin;
		this.prioridad = prioridad;
		this.idnoticia = idnoticia;
		this.areaidarea = areaidarea;
		this.descripcion_corta=descripcion_corta;
		this.estado=estado;
		this.multimediaidmultimedia_pdf=multimediaidmultimedia_pdf;
	}
	
	/**
	 * @return the multimediaidmultimedia_pdf
	 */
	public CMultimedia getMultimediaidmultimedia_pdf() {
		return multimediaidmultimedia_pdf;
	}

	/**
	 * @param multimediaidmultimedia_pdf the multimediaidmultimedia_pdf to set
	 */
	public void setMultimediaidmultimedia_pdf(CMultimedia multimediaidmultimedia_pdf) {
		this.multimediaidmultimedia_pdf = multimediaidmultimedia_pdf;
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
	 * @return the descripcion_corta
	 */
	public String getDescripcion_corta() {
		return descripcion_corta;
	}

	/**
	 * @param descripcion_corta the descripcion_corta to set
	 */
	public void setDescripcion_corta(String descripcion_corta) {
		this.descripcion_corta = descripcion_corta;
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
	 * @return the multimediaidmultimedia
	 */
	public CMultimedia getMultimediaidmultimedia() {
		return multimediaidmultimedia;
	}
	/**
	 * @param multimediaidmultimedia the multimediaidmultimedia to set
	 */
	public void setMultimediaidmultimedia(CMultimedia multimediaidmultimedia) {
		this.multimediaidmultimedia = multimediaidmultimedia;
	}
	/**
	 * @return the fecha_inicio
	 */
	public Date getFecha_inicio() {
		return fecha_inicio;
	}
	/**
	 * @param fecha_inicio the fecha_inicio to set
	 */
	public void setFecha_inicio(String fecha_inicio) {
		CValidation valid=new CValidation();
		this.fecha_inicio = valid.CambiarFormato(fecha_inicio);
	}
	/**
	 * @param fecha_inicio the fecha_inicio to set
	 */
	public void setFecha_inicio(Date fecha_inicio) {
		this.fecha_inicio=fecha_inicio;
		//this.fecha_inicio = fecha_inicio;
	}
	/**
	 * @return the fecha_fin
	 */
	public Date getFecha_fin() {
		return fecha_fin;
	}
	/**
	 * @param fecha_fin the fecha_fin to set
	 */
	public void setFecha_fin(Date fecha_fin) {
		this.fecha_fin = fecha_fin;
	}
	public void setFecha_fin(String fecha_fin) {
		CValidation valid=new CValidation();
		this.fecha_inicio = valid.CambiarFormato(fecha_fin);
	}
	/**
	 * @return the prioridad
	 */
	public int getPrioridad() {
		return prioridad;
	}
	/**
	 * @param prioridad the prioridad to set
	 */
	public void setPrioridad(int prioridad) {
		this.prioridad = prioridad;
	}
	/**
	 * @return the idnoticia
	 */
	public int getIdnoticia() {
		return idnoticia;
	}
	/**
	 * @param idnoticia the idnoticia to set
	 */
	public void setIdnoticia(int idnoticia) {
		this.idnoticia = idnoticia;
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
	public String getFormatoFecha(Date date){
		Calendar c = Calendar.getInstance();
		c.setTime( date );
		return c.get(java.util.Calendar.YEAR)+"-"+c.get(java.util.Calendar.MONTH)+"-"+c.get(java.util.Calendar.DAY_OF_MONTH);
	}
	public String getFormatoFechaddmmyy(Date date){
		DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		
		return formatter.format(date);
	}
	public String getFormatoFechaDes(Date date){
		SimpleDateFormat formatter = new SimpleDateFormat("E ',' dd 'de' MMMM 'de' yyyy", new Locale("es"));
		return formatter.format(date);
	}
}
