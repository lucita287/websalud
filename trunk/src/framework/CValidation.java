package framework;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Locale;

import com.sun.org.apache.xerces.internal.impl.xpath.regex.ParseException;


public class CValidation {
	public CValidation(){
		
	}
	public String ValidarCampoVacio(String campo,String nombre_campo){
		String result="";
		campo=campo.trim();
		if(campo.length()<=0){
			result="{\"resultado\":\"ERROR\",\"mensaje\":\"El campo "+nombre_campo+" no puede estar vacío \"}";
		}
		return result;
	}
	public String ValidarRequest(String valor){
		if(valor==null){
			return "";
		}else{
			return valor;
		}
	}
	public String isFechaValida(String fechax,String nombre_fecha) {
		  try {
		      SimpleDateFormat formatoFecha = new SimpleDateFormat("dd/MM/yyyy", Locale.getDefault());
		      formatoFecha.setLenient(false);
		      formatoFecha.parse(fechax);
		      
		  } catch (ParseException e) {
		      return "{\"resultado\":\"ERROR\",\"mensaje\":\"La fecha no es valida, "+nombre_fecha+"\"}";
		  } catch (java.text.ParseException e) {
			  return "{\"resultado\":\"ERROR\",\"mensaje\":\"La fecha no es valida, "+nombre_fecha+"\"}";
		  }
		  return "";
	}
	public String validarFechaMayoraOtra(String fecha_inicio,String fecha_fin, String nfecha_inicio, String nfecha_fin){
		DateFormat f =DateFormat.getDateInstance(DateFormat.SHORT);
		Date dfecha_inicio=null;
		Date dfecha_fin=null;
		try {
			dfecha_inicio = f.parse(fecha_inicio);
			dfecha_fin = f.parse(fecha_fin);
			
		} catch (java.text.ParseException e) {}
		
		if(dfecha_inicio!=null && dfecha_fin!=null){
			Calendar cal1 = new GregorianCalendar();
			Calendar cal2 = new GregorianCalendar();
			cal1.setTime(dfecha_inicio);
			cal2.setTime(dfecha_fin);
			
			if(cal1.before(cal2)){
				return "";
			}else{
				return "{\"resultado\":\"ERROR\",\"mensaje\":\"La fecha "+nfecha_fin+" debe ser mayor que "+nfecha_inicio+"\"}";
				
			}
		}else{	
				return "{\"resultado\":\"ERROR\",\"mensaje\":\"No tienen el formato de fecha adecuado\"}";
		}
	}
	public Date CambiarFormato(String fecha){
		Date date1=new Date();
		try {
			date1 = new SimpleDateFormat("yy-MM-dd").parse(fecha);
		} catch (java.text.ParseException e) {}
		
		return date1;
	}
	public Date CambiarFormatoddmmyy(String fecha){
		Date date1=new Date();
		try {
			date1 = new SimpleDateFormat("dd/MM/yy").parse(fecha);
		} catch (java.text.ParseException e) {}
		
		return date1;
	}
	public String Limpiarvalor(String campo){
		campo=campo.replaceAll("\"", "'");
		campo=campo.trim();
		return campo;
	}
	public int ConvertEntero(String num){
		int result=0;
		try{
			result=Integer.parseInt(num);
		}catch(Exception e){
			
		}
		return result;
	}
	public String ValidarSiesMayor(int valor, int compara,String message){
		if(valor>=compara){
			return "";
		}else{
			
			return message;
		}
	}
	public String ValidarSiesMenor(int valor, int compara,String message){
		if(valor<compara){
			return "";
			
		}else{
			return message;
		}
	}
	public String ValidarRango(int valor,int menor,int mayor,String message){
		if(valor>=menor && valor<=mayor){
			return "";
		}else{
			return message;
		}
	}
	public String ValidarLongintud(String campo,int longitud,String nombre_campo){
		String result="";
		campo=campo.trim();
		if(campo.length()>longitud){
			result="{\"resultado\":\"ERROR\",\"mensaje\":\"El campo "+nombre_campo+" tiene una longitud mayor \"}";
		}
		return result;
	}
}
