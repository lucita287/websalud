package data;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Locale;

public class CCita {
	private int idcita;
	private java.util.Date fecha;
	private java.util.Date hora_inicio;
	private int estado;
	private int tipo_examen;
	private int cupo;
	private Date hora_fin;
	private int cupo_disp;
	/**
	 * @param idcita
	 * @param fecha
	 * @param hora
	 * @param estado
	 * @param tipo_examen
	 * @param cupo
	 */
	public CCita(int idcita, Date fecha, Date hora_inicio, Date hora_fin, int estado,
			int tipo_examen, int cupo,int cupo_disp) {
		this.idcita = idcita;
		this.fecha = fecha;
		this.hora_inicio = hora_inicio;
		this.estado = estado;
		this.tipo_examen = tipo_examen;
		this.cupo = cupo;
		this.hora_fin=hora_fin;
		this.cupo_disp=cupo_disp;
	}
	
	
	/**
	 * @return the cupo_disp
	 */
	public int getCupo_disp() {
		return cupo_disp;
	}


	/**
	 * @param cupo_disp the cupo_disp to set
	 */
	public void setCupo_disp(int cupo_disp) {
		this.cupo_disp = cupo_disp;
	}


	/**
	 * @return the hora_inicio
	 */
	public java.util.Date getHora_inicio() {
		return hora_inicio;
	}


	/**
	 * @param hora_inicio the hora_inicio to set
	 */
	public void setHora_inicio(java.util.Date hora_inicio) {
		this.hora_inicio = hora_inicio;
	}


	/**
	 * @return the idcita
	 */
	public int getIdcita() {
		return idcita;
	}
	/**
	 * @param idcita the idcita to set
	 */
	public void setIdcita(int idcita) {
		this.idcita = idcita;
	}
	/**
	 * @return the fecha
	 */
	public java.util.Date getFecha() {
		return fecha;
	}
	/**
	 * @param fecha the fecha to set
	 */
	public void setFecha(java.util.Date fecha) {
		this.fecha = fecha;
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
	 * @return the tipo_examen
	 */
	public int getTipo_examen() {
		return tipo_examen;
	}
	/**
	 * @param tipo_examen the tipo_examen to set
	 */
	public void setTipo_examen(int tipo_examen) {
		this.tipo_examen = tipo_examen;
	}
	/**
	 * @return the cupo
	 */
	public int getCupo() {
		return cupo;
	}
	/**
	 * @param cupo the cupo to set
	 */
	public void setCupo(int cupo) {
		this.cupo = cupo;
	}

	public String getFormatoFechaddmmyy(Date date){
		DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		
		return formatter.format(date);
	}
	public String getFormatoFechahhmm(Date date){
		DateFormat formatter = new SimpleDateFormat("HH:mm a");
		
		return formatter.format(date);
	}
	public String getFormatoFechahhmm2(Date date){
		DateFormat formatter = new SimpleDateFormat("HH:mm");
		
		return formatter.format(date);
	}
	public String getFormatoFechaDes(Date date){
		SimpleDateFormat formatter = new SimpleDateFormat("E ',' dd 'de' MMMM 'de' yyyy", new Locale("es"));
		return formatter.format(date);
	}
	public String getTipo_examenD(){
		return (this.tipo_examen==1)?"AUTOEVALUACION":"MULTIFASICO";
	}
	public String getFormatoFechaCalendar(Date date,Date hour){
		GregorianCalendar cal= new GregorianCalendar();
		 cal.setTime(date);
		 
		 GregorianCalendar cal1= new GregorianCalendar();
		 cal1.setTime(hour);
		 return "{\"year\":"+cal.get(Calendar.YEAR)+",\"month\":"+cal.get(Calendar.MONTH)+",\"day\":"+cal.get(Calendar.DAY_OF_MONTH)+",\"hour\":"+cal1.get(Calendar.HOUR_OF_DAY)+",\"minute\":"+cal1.get(Calendar.MINUTE)+"}";
	}
	/**
	 * @return the hora_fin
	 */
	public Date getHora_fin() {
		return hora_fin;
	}
	/**
	 * @param hora_fin the hora_fin to set
	 */
	public void setHora_fin(Date hora_fin) {
		this.hora_fin = hora_fin;
	}
	
}
