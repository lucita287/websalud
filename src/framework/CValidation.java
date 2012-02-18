package framework;


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
