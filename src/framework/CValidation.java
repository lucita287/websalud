package framework;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Locale;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.sun.org.apache.xerces.internal.impl.xpath.regex.ParseException;

import data.CUsuario;


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
	 //metodo para validar correo electronio
	public String ValidarEmail(String correo){
		Pattern pat = null;
        Matcher mat = null;        
        pat = Pattern.compile("^([0-9a-zA-Z]([_.w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-w]*[0-9a-zA-Z].)+([a-zA-Z]{2,9}.)+[a-zA-Z]{2,3})$");
        mat = pat.matcher(correo);
        if (mat.find()) {
            return "";
        }else{
            return "{\"resultado\":\"ERROR\",\"mensaje\":\"Debe ingresar un correo electornico valido\"}";
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
		campo=campo.replaceAll("\t", " ");
		campo=campo.replaceAll("\r", " ");
		campo=campo.replaceAll("\f", " ");
		campo=campo.replaceAll("\n", " ");
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
			result="{\"resultado\":\"ERROR\",\"mensaje\":\"El campo "+nombre_campo+" tiene una longitud mayor, la longitu maxima es "+longitud+" \"}";
		}
		return result;
	}
	public String ValidarNoLongintud(String campo,int longitud,String nombre_campo){
		String result="";
		campo=campo.trim();
		if(campo.length()<longitud){
			result="{\"resultado\":\"ERROR\",\"mensaje\":\"El campo "+nombre_campo+" debe tener una longitud mayor a "+longitud+" \"}";
		}
		return result;
	}
	public String ValidarPassword(String pass,String pass2){
		String result="";
		if(pass.compareTo(pass2)==0){
			if(pass.length()>=6){
				try{
					Integer.parseInt(pass);
					result="{\"resultado\":\"ERROR\",\"mensaje\":\"Debe contener almenos una letra\"}";	
				}catch(Exception e){
					result="";
				}
				
			}else{
				result="{\"resultado\":\"ERROR\",\"mensaje\":\"El password debe contener almenos 6 caracteres\"}";
			}
		}else{
			result="{\"resultado\":\"ERROR\",\"mensaje\":\" El password no coincide\"}";
		}
		return result;
	}
	public String ValidarNick(String nick,int idusuario){
		String result="";
		nick=nick.toLowerCase();
		CDataBase dbo=new CDataBase();
		dbo.Connect();
		CUsuario usuario=dbo.getUsuario(nick);
	if(usuario==null||(usuario!=null && idusuario==usuario.getidusuario())){
			result="";
		}else{
			result="{\"resultado\":\"ERROR\",\"mensaje\":\"Ya existe otro usuario con ese mismo nombre\"}";
		}
		dbo.Close();
		return result;
	}
	public String ValidarNick(String nick){
		String result="";
		nick=nick.toLowerCase();
		CDataBase dbo=new CDataBase();
		dbo.Connect();
		CUsuario usuario=dbo.getUsuario(nick);
	if(usuario==null){
			result="";
		}else{
			result="{\"resultado\":\"ERROR\",\"mensaje\":\"Ya existe otro usuario con ese mismo nombre\"}";
		}
		dbo.Close();
		return result;
	}
	public ArrayList<Integer> ValidarListaNumeros(String numeros){
		ArrayList<Integer> lista=new ArrayList<Integer>();
		String[]  splittArray = numeros.split(",");
		for(String value:splittArray){
			try{
				int num=Integer.parseInt(value);
				lista.add(num);	
			}catch(Exception e){
				
			}
		}
		return lista;
	}
	public String ValidarFormatoHora(String horario,String campo){
		String result="{\"resultado\":\"ERROR\",\"mensaje\":\"No tiene el formato de hora, "+campo+"\"}";
		horario+=":";
		String[]  splittArray = horario.split(":");
		if(splittArray.length==2){
			try{
				int hora=Integer.parseInt(splittArray[0]);
				int minuto=Integer.parseInt(splittArray[1]);
				if(hora>=0&&hora<=12){
					if(minuto>=0&&minuto<=60){
						result="";
					}
				}
					
			}catch(Exception e){
				
			}
		}
		return result;
	}
	
	public Integer[] getHorario(String horario){
		horario+=":";
		int hora=0;
		int minuto=0;
		String[]  splittArray = horario.split(":");
		if(splittArray.length==2){
			try{
				hora=Integer.parseInt(splittArray[0]);
			    minuto=Integer.parseInt(splittArray[1]);
					
			}catch(Exception e){
				
			}
		}
		Integer[] horas=new Integer[2];
		horas[0]=hora;
		horas[1]=minuto;
		return horas;
	}
	public String validarHoraMayoraOtra(String fecha, String formato,String fecha1, String formato1,String mensaje){
		String result="{\"resultado\":\"ERROR\",\"mensaje\":\"HORA MAYOR QUE OTRA, "+mensaje+"\"}";
		DateFormat formatter = new SimpleDateFormat("hh:mm:ss a");
		Date date=null;
		Date date2=null;
		try {
			date = (Date)formatter.parse(fecha+":00 "+formato);
			date2 = (Date)formatter.parse(fecha1+":00 "+formato1);
		} catch (java.text.ParseException e) {
			
		}
	     if(date!=null&& date2!=null && date2.compareTo(date)>0){
	    	 result="";
	     }
		return result;
	}
	public Date CambiarFormatohhmm(String hora, String formato){
		Date date1=new Date();
		DateFormat formatter = new SimpleDateFormat("HH:mm:ss");
		try {
			Integer[] horario=getHorario(hora);
			if(horario[0]!=12&&formato.equalsIgnoreCase("PM")){
				horario[0]+=12;
			}else if(horario[0]==12&&formato.equalsIgnoreCase("AM")){
				horario[0]=0;
			}else if(horario[0]==0&&formato.equalsIgnoreCase("PM")){
				horario[0]=12;
			}
			date1 = (Date)formatter.parse(horario[0]+":"+horario[1]+":00");
			
		} catch (java.text.ParseException e) {}
		
		return date1;
	}
	public Long ConvertLong(String num){
		Long result=0L;
		try{
			result=Long.parseLong(num);
		}catch(Exception e){
			
		}
		return result;
	}
}
