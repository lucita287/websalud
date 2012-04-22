package framework;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.text.SimpleDateFormat;
import java.util.Calendar;

public class CLogger {

	static String file_path="/log.txt";
	static BufferedWriter bufferedWriter;
	static int onlinehost=0;
	
	public CLogger(){
		
	}
	
	static public void write(String str, Object obj, Throwable e){
		try {
			bufferedWriter = new BufferedWriter(new FileWriter(file_path,true));
			SimpleDateFormat dformat=new SimpleDateFormat("dd/MM/yyyy h:mm:ss a");
			Calendar date=Calendar.getInstance();
            bufferedWriter.write("Error: "+dformat.format(date.getTime())+"      "+obj.toString()+" "+str);
            bufferedWriter.newLine();
            bufferedWriter.write(e.getMessage());
            bufferedWriter.newLine();
            bufferedWriter.flush();
            bufferedWriter.close();
		} 
		catch (Throwable e1) {

		} 
		
	}
	
	static public void write_simple(String str, Object obj, String error){
		try {
			bufferedWriter = new BufferedWriter(new FileWriter(file_path,true));
			SimpleDateFormat dformat=new SimpleDateFormat("dd/MM/yyyy h:mm:ss a");
			Calendar date=Calendar.getInstance();
            bufferedWriter.write("Error: "+dformat.format(date.getTime())+"      "+obj.toString()+" "+str);
            bufferedWriter.newLine();
            bufferedWriter.write(error);
            bufferedWriter.newLine();
            bufferedWriter.flush();
            bufferedWriter.close();
		} 
		catch (Throwable e1) {

		} 
		
	}
	
	static public int getOnlinehost(){
		return onlinehost;
	}
	
	static public void setOnlinehost(int value){
		onlinehost=value;
		try{
			bufferedWriter = new BufferedWriter(new FileWriter(file_path,true));
			SimpleDateFormat dformat=new SimpleDateFormat("dd/MM/yyyy h:mm:ss a");
			Calendar date=Calendar.getInstance();
	        bufferedWriter.write("Switch Host: "+dformat.format(date.getTime())+"      ");
	        bufferedWriter.newLine();
	        bufferedWriter.write("Nuevo Host "+value);
	        bufferedWriter.newLine();
	        bufferedWriter.flush();
	        bufferedWriter.close();
		}
		catch(Throwable e1){
			
		}
	}
	
	static public void setOnlinehostInitial(int value){
		onlinehost=value;
	}
	
}
