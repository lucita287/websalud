package framework;

import java.util.ArrayList;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
//import java.sql.SQLException;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.PreparedStatement;

import data.CArea;
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
			stm = (PreparedStatement)conn.prepareStatement("SELECT idmenu,descripcion,ifnull(areaidarea,0) areaidarea,contenido, ifnull(idmenu_rec,0) idmenu_rec, size FROM Menu where  idmenu=? ");
			stm.setInt(1, idmenu);
			ResultSet rs2=stm.executeQuery();
			if(rs2.next()){
				CArea temp_c=this.getCAreaEspecifico(rs2.getInt("areaidarea"));
				CMenu temp_menu1=(rs2.getInt("idmenu")!=0)?getMenuEspecifico(rs2.getInt("idmenu_rec")):null;
				temp_menu=new CMenu( rs2.getInt("idmenu"),rs2.getString("descripcion"),temp_c,rs2.getString("contenido"),rs2.getInt("size"),temp_menu1);
			}
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return temp_menu;
	}
	public CArea getCAreaEspecifico(int idarea){
		CArea temp=null;
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("SELECT idarea,descripcion  FROM area where  idarea=? ");
			stm.setInt(1, idarea);
			ResultSet rs2=stm.executeQuery();
			if(rs2.next())
			temp=new CArea( rs2.getInt("idarea"),rs2.getString("descripcion"));
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return temp;
	}
	
	public int getCMenuTotal(){
		int temp=0;
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("SELECT max(idmenu) cant  FROM menu ");
			ResultSet rs2=stm.executeQuery();
			if(rs2.next())
			temp=rs2.getInt("cant");
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return temp;
	}
	
	public ArrayList<CMenu> getMenu(int area){
		ArrayList<CMenu> ret=new ArrayList<CMenu>();
		try{
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement("SELECT idmenu,descripcion,ifnull(areaidarea,0) areaidarea,contenido,size FROM Menu where areaidarea=? and  idmenu_rec is null");
			stm.setInt(1, area);
			ResultSet rs=stm.executeQuery();
			while(rs.next()){
				CMenu temp_menu=null;
				
				PreparedStatement stm2=(PreparedStatement)conn.prepareStatement("SELECT idmenu,descripcion,ifnull(areaidarea,0) areaidarea,contenido,size,idmenu_rec FROM Menu where  idmenu_rec=? ");
				stm2.setInt(1, rs.getInt("idmenu"));
				ResultSet rs2=stm2.executeQuery();
				ArrayList<CMenu> temp_list=new ArrayList<CMenu>();
				while(rs2.next()){
					CArea temp_c=this.getCAreaEspecifico(rs2.getInt("areaidarea"));
					CMenu temp_menu1=null;
					CMenu temp_menu2=null;
					temp_menu1=new CMenu( rs2.getInt("idmenu"),rs2.getString("descripcion"),temp_c,rs2.getString("contenido"),rs2.getInt("size"),temp_menu2);
					temp_list.add(temp_menu1);
				}
				CArea temp_c1=this.getCAreaEspecifico(rs.getInt("areaidarea"));
				temp_menu=new CMenu( rs.getInt("idmenu"),rs.getString("descripcion"),temp_c1,rs.getString("contenido"),rs.getInt("size"),temp_list);
				ret.add(temp_menu);
				
			}
			rs.close();
			stm.close();
		}
		
		catch(Throwable e){
			
		}
		return ret;
	}
	public boolean UpdateMenu(CMenu menu){
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("UPDATE menu SET descripcion = ?, areaidarea = ?, contenido = ?, idmenu_rec = ?, size= ? WHERE idmenu=?");
			
			stm.setString(1, menu.getdescripcion());
			stm.setInt(2, menu.getareaidarea().getidarea());
			stm.setString(3, menu.getcontenido());
			
			if(menu.getidmenu_rec()==null){
				stm.setNull(4,java.sql.Types.INTEGER);
			}else {
				stm.setInt(4, menu.getidmenu_rec().getidmenu());
			}
			stm.setInt(5,menu.getsize());
			stm.setInt(6,menu.getidmenu());
			if(stm.executeUpdate()>0)
				return true;
			
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return false;
	}
	public boolean SafeMenu(CMenu menu){
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("INSERT INTO menu (descripcion,areaidarea,contenido,idmenu_rec,size)VALUES (?,?,?,?,?)");
			
			stm.setString(1, menu.getdescripcion());
			stm.setInt(2, menu.getareaidarea().getidarea());
			stm.setString(3, menu.getcontenido());
			
			if(menu.getidmenu_rec()==null){
				stm.setNull(4,java.sql.Types.INTEGER);
			}else {
				stm.setInt(4, menu.getidmenu_rec().getidmenu());
			}
			stm.setInt(5,menu.getsize());
			if(stm.executeUpdate()>0)
				return true;
			
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return false;
	}
	public ArrayList<CMenu> getMenuLista(){
        ArrayList<CMenu> ret=new ArrayList<CMenu>();
        try{
                PreparedStatement stm=(PreparedStatement)conn.prepareStatement("SELECT idmenu,descripcion,ifnull(areaidarea,0) areaidarea,contenido,ifnull(idmenu_rec,0) idmenu_rec,size FROM Menu ");
                ResultSet rs=stm.executeQuery();
                while(rs.next()){
                                CMenu temp_menu=null;
                                temp_menu=this.getMenuEspecifico(rs.getInt("idmenu_rec"));
                                CArea temp_c=this.getCAreaEspecifico(rs.getInt("areaidarea"));
                                temp_menu=new CMenu( rs.getInt("idmenu"),rs.getString("descripcion"),temp_c,rs.getString("contenido"),rs.getInt("size"),temp_menu);
                        ret.add(temp_menu);
                        
                }
                rs.close();
                stm.close();
        }
        
        catch(Throwable e){
                
        }
        return ret;
	}
	public ArrayList<CArea> getAreaLista(){
        ArrayList<CArea> ret=new ArrayList<CArea>();
        try{
                PreparedStatement stm=(PreparedStatement)conn.prepareStatement("SELECT idarea,descripcion from area");
                ResultSet rs=stm.executeQuery();
                while(rs.next()){
                		CArea temp_menu=null;
                        temp_menu=new CArea( rs.getInt("idarea"),rs.getString("descripcion"));
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
