package data;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Locale;

public class CDetalleActividad {
	private int iddetalleactividad;
	private java.util.Date fecha;
	private java.util.Date horainicio;
	private java.util.Date horafin;
	private CActividad actividadidactividad;
	
	
	/**
	 * @param iddetalleactividad
	 * @param fecha
	 * @param horainicio
	 * @param horafin
	 * @param actividadidactividad
	 */
	public CDetalleActividad(int iddetalleactividad, Date fecha,
			Date horainicio, Date horafin, CActividad actividadidactividad) {
		this.iddetalleactividad = iddetalleactividad;
		this.fecha = fecha;
		this.horainicio = horainicio;
		this.horafin = horafin;
		this.actividadidactividad = actividadidactividad;
	}
	/**
	 * @return the iddetalleactividad
	 */
	public int getIddetalleactividad() {
		return iddetalleactividad;
	}
	/**
	 * @param iddetalleactividad the iddetalleactividad to set
	 */
	public void setIddetalleactividad(int iddetalleactividad) {
		this.iddetalleactividad = iddetalleactividad;
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
	 * @return the horainicio
	 */
	public java.util.Date getHorainicio() {
		return horainicio;
	}
	/**
	 * @param horainicio the horainicio to set
	 */
	public void setHorainicio(java.util.Date horainicio) {
		this.horainicio = horainicio;
	}
	/**
	 * @return the horafin
	 */
	public java.util.Date getHorafin() {
		return horafin;
	}
	/**
	 * @param horafin the horafin to set
	 */
	public void setHorafin(java.util.Date horafin) {
		this.horafin = horafin;
	}
	/**
	 * @return the actividadidactividad
	 */
	public CActividad getActividadidactividad() {
		return actividadidactividad;
	}
	/**
	 * @param actividadidactividad the actividadidactividad to set
	 */
	public void setActividadidactividad(CActividad actividadidactividad) {
		this.actividadidactividad = actividadidactividad;
	}
	public String getFormatoFechaddmmyy(Date date){
		DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		
		return formatter.format(date);
	}
	public String getFormatoFechahhmm(Date date){
		DateFormat formatter = new SimpleDateFormat("HH:mm a");
		
		return formatter.format(date);
	}
	public String getFormatoFechaDes(Date date){
		SimpleDateFormat formatter = new SimpleDateFormat("E ',' dd 'de' MMMM 'de' yyyy", new Locale("es"));
		return formatter.format(date);
	}
	public String getFormatoFechaCalendar(Date date,Date hour){
		//2012-03-17T13:15:00.000
		GregorianCalendar cal= new GregorianCalendar();
		 cal.setTime(date);
		 
		 GregorianCalendar cal1= new GregorianCalendar();
		 cal1.setTime(hour);
		 //cal.set(Calendar.HOUR_OF_DAY, cal1.get(Calendar.HOUR_OF_DAY));
		 //cal.set(Calendar.MINUTE, cal1.get(Calendar.MINUTE));
		 //cal.set(Calendar.SECOND, cal1.get(Calendar.SECOND));
		  //  Date date2 = cal.getTime();
		//SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'-06:00'");
		  //SimpleDateFormat formatter = new SimpleDateFormat("ddd, dd MMM yyyy HH':'mm':'ss 'GMT'zzzz");
		//2012-03-17T13:15:00.000
		 //return formatter.format(date2);
		//return "new Date("+cal.get(Calendar.YEAR)+","+cal.get(Calendar.MONTH)+","+cal.get(Calendar.DAY_OF_MONTH)+","+cal1.get(Calendar.HOUR_OF_DAY)+","+cal1.get(Calendar.MINUTE)+")";
		return "{\"year\":"+cal.get(Calendar.YEAR)+",\"month\":"+cal.get(Calendar.MONTH)+",\"day\":"+cal.get(Calendar.DAY_OF_MONTH)+",\"hour\":"+cal1.get(Calendar.HOUR_OF_DAY)+",\"minute\":"+cal1.get(Calendar.MINUTE)+"}";
	}
}
