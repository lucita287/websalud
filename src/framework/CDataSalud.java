package framework;

import java.sql.DriverManager;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Locale;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.PreparedStatement;

import data.CPaciente;
import data.CTarjeta_Impresa_S;

public class CDataSalud {
	
	Connection conn = null;
	private String schema="salud";
	private String user="saludadmin"; 
	private String pass="@dmin_sa1ud";
	private String host="localhost";
	
	public CDataSalud(){}
	public Connection connHostDevelopment(){
		try{
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			String sql="jdbc:mysql://"+host+"/"+schema+"?user="+user+"&password="+pass;
			
			Connection conexion = (Connection) DriverManager.getConnection(sql);
			return conexion;
		}
		catch(Throwable e){
			
			return null;
		}
	}
	public boolean Connect(){
		DriverManager.setLoginTimeout(1);
		conn=connHostDevelopment();
		
		if(conn!=null){
			return true;
		}else  return false;
		
	}
	public void Close(){
		try{
			conn.close();
		}
		catch(Throwable e){

		}
	}
	public boolean InsertarPaciente(CPaciente pac,String unidad){
		boolean result=false;
		
		int temp=0;
		int edad=0;
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("select count(carne) cant from alumno where carne=?");
			stm.setInt(1, pac.getCarne());
			
			ResultSet rs2=stm.executeQuery();
			if(rs2.next()){
			temp=rs2.getInt("cant");
			
			}
			
			if(temp==0){
				stm = (PreparedStatement)conn.prepareStatement("select  year(now())-year(?) edad");
				stm.setDate(1, new java.sql.Date(pac.getFecha_nacimiento().getTime()));
				ResultSet rs3=stm.executeQuery();
				if(rs3.next()) edad=rs3.getInt("edad");
				
				stm = (PreparedStatement)conn.prepareStatement("INSERT INTO alumno (carne,nombre,apellido,nacimiento,edad,sexo,direccion,telefono,celular,mail,facultad,fecha_hoy)VALUES(?,?,?,?,?,?,?,?,?,?,?,now())");
				stm.setInt(1,pac.getCarne());
				stm.setString(2,pac.getNombre());
				stm.setString(3,pac.getApellido());
				stm.setDate(4, new java.sql.Date(pac.getFecha_nacimiento().getTime()));
				stm.setInt(5,edad);
				stm.setString(6,(pac.getSexo()==1?"MASCULINO":"FEMENINO"));
				stm.setString(7,pac.getDireccion());
				stm.setString(8,pac.getTelefono());
				stm.setString(9,pac.getMovil());
				stm.setString(10,pac.getEmail());
				stm.setString(11, unidad);
				if(stm.executeUpdate()>0){	
					return true;
				}
				
			}
			
		}catch(Throwable e){
			
		}
		
		return result;
	} 
	
	
	
	public boolean UpdatePaciente(CTarjeta_Impresa_S  pac){
		boolean result=false;
		
		int temp=0;
		
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("select count(carne) cant from alumno where carne=? and fecha_examen is null");
			stm.setInt(1, pac.getCarne());
			
			ResultSet rs2=stm.executeQuery();
			if(rs2.next()){
			temp=rs2.getInt("cant");
			
			}
			
			if(temp>0){
				
				stm = (PreparedStatement)conn.prepareStatement("UPDATE alumno SET fecha_examen = ? WHERE carne = ?");
				stm.setDate(1, new java.sql.Date(pac.getFecha().getTime()));
				stm.setInt(2, pac.getCarne());
				if(stm.executeUpdate()>0){	
					return true;
				}
				
			}
			
		}catch(Throwable e){
			
		}
		
		return result;
	}
	public boolean UpdateTarjeta_impresa(CTarjeta_Impresa_S  pac){
		boolean result=false;
		
		int temp=0;
		
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("select count(*) cant from tarjeta_impresa where carne=? and CAST(fecha AS DATE)=?");
			stm.setInt(1, pac.getCarne());
			stm.setDate(2, new java.sql.Date(pac.getFecha().getTime()));
			ResultSet rs2=stm.executeQuery();
			if(rs2.next()){
			temp=rs2.getInt("cant");
			
			}
			
			if(temp==0){
				SimpleDateFormat formatter = new SimpleDateFormat("yyyy'-'MM'-'dd", new Locale("es"));
				stm = (PreparedStatement)conn.prepareStatement("INSERT INTO tarjeta_impresa (carne,nombre,fecha) VALUES ("+pac.getCarne()+",'"+pac.getNombre()+"','"+formatter.format(pac.getFecha())+"')");
				if(stm.executeUpdate()>0){	
					return true;
				}
				
			}
			
		}catch(Throwable e){
			
		}
		
		return result;
	}
	public boolean UpdateTarjeta_imprimir(CTarjeta_Impresa_S  pac){
		boolean result=false;
		
		int temp=0;
		
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("select count(*) cant from tarjeta_imprimir where carne=? and CAST(fecha AS DATE)=?");
			stm.setInt(1, pac.getCarne());
			stm.setDate(2, new java.sql.Date(pac.getFecha().getTime()));
			ResultSet rs2=stm.executeQuery();
			if(rs2.next()){
			temp=rs2.getInt("cant");
			
			}
			
			if(temp==0){
				SimpleDateFormat formatter = new SimpleDateFormat("yyyy'-'MM'-'dd", new Locale("es"));
				stm = (PreparedStatement)conn.prepareStatement("INSERT INTO tarjeta_imprimir (carne,nombre,fecha) VALUES ("+pac.getCarne()+",'"+pac.getNombre()+"','"+formatter.format(pac.getFecha())+"')");
				if(stm.executeUpdate()>0){	
					return true;
				}
				
			}
			
		}catch(Throwable e){
			
		}
		
		return result;
	}
	
}
