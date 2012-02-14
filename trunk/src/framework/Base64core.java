package framework;

import java.io.IOException;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

public class Base64core {
	public Base64core(){
		
	}
	public String codificar(String code){
		BASE64Encoder encoder = new BASE64Encoder();
		 String contenido=encoder.encode(code.getBytes());
		 return contenido;
	}
	public String decodificar(String code){
		BASE64Decoder decoder = new BASE64Decoder();
		code=code.replaceAll(" ","+");
		String contenido="";
		byte[] decodedBytes;
		try {
			decodedBytes = decoder.decodeBuffer(code);
			contenido=new String(decodedBytes);
		} catch (IOException e) {
			
		}
		
		return contenido;
	}
}
