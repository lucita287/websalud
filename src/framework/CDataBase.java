package framework;

import java.util.ArrayList;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
//import java.sql.SQLException;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.PreparedStatement;

import data.CMenu;
import data.CNoticia;

public class CDataBase {

	Connection conn = null;
	private String schema="salud";
	private String user="root"; 
	private String pass="123456";
	private String host="localhost";
	
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
	public CDataBase(){

	}
	
	
	public boolean Connect(){
		DriverManager.setLoginTimeout(1);
		conn=connHostDevelopment();
		
		if(conn!=null){
			return true;
		}else  return false;
			
		
		
	}
	
	public ArrayList<CNoticia> getNoticias(){
		ArrayList<CNoticia> ret=new ArrayList<CNoticia>();
		try{
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement("SELECT idnoticia,titulo, descripcion, imagen FROM noticia");
			ResultSet rs=stm.executeQuery();
			while(rs.next()){
				CNoticia news=null;
				news=new CNoticia( rs.getInt("idnoticia"), rs.getString("titulo"),rs.getString("descripcion"),rs.getString("imagen"));
				ret.add(news);
				
			}
			rs.close();
			stm.close();
		}
		catch(Throwable e){
			
		}
		return ret;
	}
	public CMenu getMenuEspecifico(int idmenu){
		CMenu temp_menu=null;
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("SELECT idmenu,descripcion,areaidarea,contenido FROM Menu where  idmenu=? ");
			stm.setInt(1, idmenu);
			ResultSet rs2=stm.executeQuery();
			rs2.next();
			temp_menu=new CMenu( rs2.getInt("idmenu"),rs2.getString("descripcion"),rs2.getInt("areaidarea"),rs2.getString("contenido"),null);
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return temp_menu;
	}
	
	public ArrayList<CMenu> getMenu(int area){
		ArrayList<CMenu> ret=new ArrayList<CMenu>();
		try{
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement("SELECT idmenu,descripcion,areaidarea FROM Menu where areaidarea=? and  idmenu_rec is null");
			stm.setInt(1, area);
			ResultSet rs=stm.executeQuery();
			while(rs.next()){
				CMenu temp_menu=null;
				
				PreparedStatement stm2=(PreparedStatement)conn.prepareStatement("SELECT idmenu,descripcion,areaidarea FROM Menu where  idmenu_rec=? ");
				stm2.setInt(1, rs.getInt("idmenu"));
				ResultSet rs2=stm2.executeQuery();
				ArrayList<CMenu> temp_list=new ArrayList<CMenu>();
				while(rs2.next()){
					temp_menu=new CMenu( rs2.getInt("idmenu"),rs2.getString("descripcion"),rs2.getInt("areaidarea"),"",null);
					temp_list.add(temp_menu);
				}
				temp_menu=new CMenu( rs.getInt("idmenu"),rs.getString("descripcion"),rs.getInt("areaidarea"),"",temp_list);
				ret.add(temp_menu);
				
			}
			rs.close();
			stm.close();
		}
		
		catch(Throwable e){
			
		}
		return ret;
	}
	
	public void Close(){
		try{
			conn.close();
		}
		catch(Throwable e){

		}
	}
}
