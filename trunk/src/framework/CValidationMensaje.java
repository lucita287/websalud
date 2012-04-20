package framework;

import java.text.SimpleDateFormat;
import java.util.Locale;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import com.sun.org.apache.xerces.internal.impl.xpath.regex.ParseException;

import net.tanesha.recaptcha.ReCaptchaImpl;
import net.tanesha.recaptcha.ReCaptchaResponse;

public class CValidationMensaje extends CValidation {
	
	public String ValidarMCaptcha(HttpServletRequest request){
		String recaptcha_response_field=request.getParameter("recaptcha_response_field");
		String challenge = request.getParameter("recaptcha_challenge_field");
		String remoteAddr = request.getRemoteAddr();
        ReCaptchaImpl reCaptcha = new ReCaptchaImpl();
        reCaptcha.setPrivateKey("6Lf9as8SAAAAAI5FO_4qetoWZv4D_8nRFDSsbp5P");
        ReCaptchaResponse reCaptchaResponse = reCaptcha.checkAnswer(remoteAddr, challenge, recaptcha_response_field);
        if (reCaptchaResponse.isValid()) {
        	return "";
        } else {
        	return "<div class='registro_validator'>NO COINCIDE EL TEXTO CON LA IMAGEN</div>";
        }
	}
	public String ValidarMUsuario(String name,CDataExam dbo){
		String validacion="";
		if(name.length()<4){
			validacion="<div class='registro_validator'>EL NOMBRE DE USUARIO DEBE CONTENER MAS DE 4 CARACTERES</div>";
			
		}else if(name.contains(" ")){
			validacion="<div class='registro_validator'>EL NOMBRE DE USUARIO NO PUEDE CONTENER ESPACIOS EN BLANCO</div>";
			
		}else if(name.length()>11){
			validacion="<div class='registro_validator'>EL NOMBRE DE USUARIO NO PUEDE CONTENER MAS DE 11 CARACTERES</div>";
			
		}
		
		if(validacion.isEmpty()){
			int cant=dbo.getPacienteDisponiblidad(name);
			if(cant>0) validacion="<div class='registro_validator'>NOMBRE DE USUARIO REGISTRADO</div>";
		}
		
		return validacion;
	}
	public String ValidarMEmail(String correo){
		Pattern pat = null;
        Matcher mat = null;        
        pat = Pattern.compile("^([0-9a-zA-Z]([_.w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-w]*[0-9a-zA-Z].)+([a-zA-Z]{2,9}.)+[a-zA-Z]{2,3})$");
        mat = pat.matcher(correo);
        if (mat.find()||correo.length()==0) {
        	if(correo.length()<80)
        		return "";
        	else return "<div class='registro_validator'>DEBE INGRESAR UN CORREO ELECTRONICO NO MAYOR A 80 CARACTERES </div>";
        }else{
            return "<div class='registro_validator'>DEBE INGRESAR UN CORREO ELECTRONICO VALIDO</div>";
        }
	}
	public String ValidarMCarne(int carne,CDataExam dbo){
		if(carne<1000000)
			return "<div class='registro_validator'>DEBE INGRESAR UN CARNE VALIDO</div>";
		else {
			if(dbo.getPacienteCarneDisponiblidad(carne)>0){
				return "<div class='registro_validator'>EXISTE UN USUARIO REGISTRADO CON EL MISMO CARNE, RECUPERE EL PASSWORD </div>";
			}else return "";
		}
		
	}
	public String ValidarMCombo(int num,String tipo){
			if(num>0)
				return "";
			 else return "<div class='registro_validator'>Debe seleccionar un "+tipo+"</div>";
	}
	public String ValidarMNoPersonal(int num){
			if(num<=0){
				return "<div class='registro_validator'>DEBE INGRESAR UN NUMERO DE PERSONAL VALIDO</div>";
			}else return "";
			
	}
	public String ValidarMFecha(String fecha) {
		  try {
		      SimpleDateFormat formatoFecha = new SimpleDateFormat("dd/MM/yyyy", Locale.getDefault());
		      formatoFecha.setLenient(false);
		      formatoFecha.parse(fecha);
		      
		  } catch (ParseException e) {
		      return "<div class='registro_validator'>LA FECHA DE NACIMIENTO NO ES VALIDA</div>";
		  } catch (java.text.ParseException e) {
			  return "<div class='registro_validator'>LA FECHA DE NACIMIENTO NO ES VALIDA</div>";
		  }
		  return "";
	}
	public String ValidarMPassword(String pass,String pass2){
		String result="";
		if(pass.compareTo(pass2)==0){
			if(pass.length()>=6 && pass.length()<20){
				try{
					Integer.parseInt(pass);
					result="<div class='registro_validator'>DEBE CONTENER ALMENOS UNA LETRA</div>";	
				}catch(Exception e){
					result="";
				}
				
			}else{
				result="<div class='registro_validator'>EL PASSWORD DEBE CONTENER ALMENOS 6 CARACTERES Y MENOR DE 20 CARACTERES</div>";
			}
		}else{
			result="<div class='registro_validator'>EL PASSWORD NO COINCIDE CON LA CONFIRMACI&Oacute;N DE PASSWORD El password no coincide con la confirmación de password</div>";
		}
		return result;
	}
	public String ValidarMNombre(String name,String tipo){
		String result="";
		if(name.length()>300){
			result="<div class='registro_validator'>DEBE INGRESAR EL CAMPO DE "+tipo+" NO MAYOR A 300 CARACTERES </div>";
		}else if(name.isEmpty()){
			result="<div class='registro_validator'>DEBE INGRESAR EL CAMPO DE "+tipo+"</div>";
		}else if(name.length()<5){
			result="<div class='registro_validator'>EL CAMPO "+tipo+" DEBE CONTENER ALMENOS 4 CARACTERES</div>";
		}
		return result;
	}
	
}
