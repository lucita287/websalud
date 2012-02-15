package framework;

import java.util.ArrayList;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
//import java.sql.SQLException;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.PreparedStatement;

import data.CArea;
import data.CCategoria;
import data.CConfiguracion;
import data.CMenu;
import data.CNoticia;
import data.CPregunta;
import data.CSubcategoria;

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
	public CCategoria getEspecificoCategoria(int idcategoria){
		CCategoria temp=null;
		try{    
        	PreparedStatement stm=(PreparedStatement)conn.prepareStatement("SELECT idcategoria,descripcion FROM Categoria where idcategoria =? ");
        	stm.setInt(1,idcategoria);
                ResultSet rs=stm.executeQuery();
                while(rs.next()){
                                
                                temp=new CCategoria( rs.getInt("idcategoria"),rs.getString("descripcion"));
                               
                }
                rs.close();
                stm.close();
        }
        
        catch(Throwable e){
                
        }
        return temp;
	}
	public CSubcategoria getEspecificosubcategoria(int idsubcategoria){
		CSubcategoria temp=null;
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("SELECT idsubcategoria,descripcion FROM subcategoria where  idsubcategoria=? ");
			stm.setInt(1, idsubcategoria);
			ResultSet rs2=stm.executeQuery();
			if(rs2.next()){
				temp=new CSubcategoria( rs2.getInt("idsubcategoria"),rs2.getString("descripcion"));
			}
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return temp;
	}
	public ArrayList<CPregunta> getPreguntas(int idcategoria){
		ArrayList<CPregunta> list=new ArrayList<CPregunta>();
		
		try {
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement("SELECT idpregunta, descripcion, categoriaidcategoria, subcategoriaidsubcategoria from pregunta where categoriaidcategoria=? ");
        	stm.setInt(1,idcategoria);
                ResultSet rs=stm.executeQuery();
                while(rs.next()){
                				CCategoria cate= this.getEspecificoCategoria(idcategoria);
                				CSubcategoria subcate=this.getEspecificosubcategoria(rs.getInt("subcategoriaidsubcategoria"));
                                CPregunta preg=null;
                				preg=new CPregunta( rs.getInt("idpregunta"),rs.getString("descripcion"),cate,subcate);
                               list.add(preg);
                }
                rs.close();
                stm.close();
		} catch (SQLException e) {
	
			e.printStackTrace();
		}
		return list;
	}
	public int getPreguntasTotal(int idcategoria){
		int temp=0;
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("SELECT max(idpregunta) cant  FROM pregunta where categoriaidcategoria= ?");
			stm.setInt(1,idcategoria);
			ResultSet rs2=stm.executeQuery();
			if(rs2.next())
			temp=rs2.getInt("cant");
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return temp;
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
			stm = (PreparedStatement)conn.prepareStatement("SELECT idarea,descripcion, ifnull(areaidarea,0) areaidarea  FROM area where  idarea=? ");
			stm.setInt(1, idarea);
			ResultSet rs2=stm.executeQuery();
			if(rs2.next())
			temp=new CArea( rs2.getInt("idarea"),rs2.getString("descripcion"),null);
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
	public ArrayList<CMenu> getMenuLista(int min,int max,int type,String busqueda ,int ordenar,int asc){
        ArrayList<CMenu> ret=new ArrayList<CMenu>();
        try{
        	String query="select * from "
				+"(SELECT @rownum:=@rownum+1 rownum, m.idmenu,m.descripcion,m.contenido,ifnull(m.idmenu_rec,0) idmenu_rec,  m.size,"
				+"a.idarea,a.descripcion descripcion_area,IF(idmenu_rec is null,'',(select descripcion from menu where idmenu=m.idmenu_rec) ) descripcion_menu "
				+"FROM Menu m, (SELECT @rownum:=0) ro, Area a  "
				+"where a.idarea=m.areaidarea and"
				+" if(? <>'',if(?=1,upper(m.descripcion) like upper(?),upper(a.descripcion) like upper(?)),true )"
				+") data "
				+"where rownum>=? and rownum<=? ORDER BY ? "+((asc==1)?"ASC":"DESC");

                PreparedStatement stm=(PreparedStatement)conn.prepareStatement(query);
                stm.setString(1,busqueda.trim());
                stm.setInt(2,type);
                stm.setString(3,"%"+busqueda.trim()+"%");
                stm.setString(4,"%"+busqueda.trim()+"%");
                stm.setInt(5, min);
                stm.setInt(6, max);
                stm.setInt(7, ordenar);
                ResultSet rs=stm.executeQuery();
                while(rs.next()){
                				ArrayList<CMenu> templist=null;
                				
                                CMenu temp=new CMenu(rs.getInt("idmenu_rec"),rs.getString("descripcion_menu"),null,"",0,templist);
                                CArea temp_c=new CArea(rs.getInt("idarea"),rs.getString("descripcion_area"),null);
                                CMenu temp_menu=new CMenu( rs.getInt("idmenu"),rs.getString("descripcion"),temp_c,rs.getString("contenido"),rs.getInt("size"),temp);
                                ret.add(temp_menu);                        
                }
                rs.close();
                stm.close();
        }
        
        catch(Throwable e){
                
        }
        return ret;
	}
	
	public int getCMenuTotal(int type,String busqueda){
		int temp=0;
		try {
			String query="SELECT count(m.idmenu) cant "
					+"FROM Menu m , Area a "
					+"where a.idarea=m.areaidarea and"
					+" if(? <>'',if(?=1,upper(m.descripcion) like upper(?),upper(a.descripcion) like upper(?)),true )";

	                PreparedStatement stm=(PreparedStatement)conn.prepareStatement(query);
	                stm.setString(1,busqueda.trim());
	                stm.setInt(2,type);
	                stm.setString(3,"%"+busqueda.trim()+"%");
	                stm.setString(4,"%"+busqueda.trim()+"%");
	                
			ResultSet rs2=stm.executeQuery();
			if(rs2.next())
			temp=rs2.getInt("cant");
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return temp;
	}
	
	public ArrayList<CCategoria> getListaCategoria(){
        ArrayList<CCategoria> ret=new ArrayList<CCategoria>();
        try{
                PreparedStatement stm=(PreparedStatement)conn.prepareStatement("SELECT idcategoria,descripcion FROM Categoria ");
                ResultSet rs=stm.executeQuery();
                while(rs.next()){
                                CCategoria temp=null;
                                temp=new CCategoria( rs.getInt("idcategoria"),rs.getString("descripcion"));
                                ret.add(temp);
                }
                rs.close();
                stm.close();
        }
        
        catch(Throwable e){
                
        }
        return ret;
	}
	public ArrayList<CSubcategoria> getListaSubCategoria(){
        ArrayList<CSubcategoria> ret=new ArrayList<CSubcategoria>();
        try{
                PreparedStatement stm=(PreparedStatement)conn.prepareStatement("SELECT idsubcategoria,descripcion FROM subcategoria ");
                ResultSet rs=stm.executeQuery();
                while(rs.next()){
                				CSubcategoria temp=null;
                                temp=new CSubcategoria( rs.getInt("idsubcategoria"),rs.getString("descripcion"));
                                ret.add(temp);
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
                PreparedStatement stm=(PreparedStatement)conn.prepareStatement("SELECT idarea,descripcion, ifnull(areaidarea,0) areaidarea, direccion,direccion_relativa from area");
                ResultSet rs=stm.executeQuery();
                while(rs.next()){
                		CArea temp_menu=null;
                        temp_menu=new CArea( rs.getInt("idarea"),rs.getString("descripcion"),null );
                        ret.add(temp_menu);
                        
                }
                rs.close();
                stm.close();
        }
        
        catch(Throwable e){
                
        }
        return ret;
	}
	public ArrayList<CArea> getAreaListaMenu(){
        ArrayList<CArea> ret=new ArrayList<CArea>();
        try{
                PreparedStatement stm=(PreparedStatement)conn.prepareStatement("SELECT idarea,descripcion, ifnull(areaidarea,0) areaidarea, direccion,direccion_relativa from area where areaidarea is null and idarea!=1");
                ResultSet rs=stm.executeQuery();
                while(rs.next()){
                		CArea temp_menu=null;
                        temp_menu=new CArea( rs.getInt("idarea"),rs.getString("descripcion"),null);
                        ret.add(temp_menu);
                        
                }
                rs.close();
                stm.close();
        }
        
        catch(Throwable e){
                
        }
        return ret;
	}
	public ArrayList<CArea> getAreaListaMenuSubmenu(){
        ArrayList<CArea> ret=new ArrayList<CArea>();
        try{
                PreparedStatement stm=(PreparedStatement)conn.prepareStatement("SELECT idarea,descripcion, ifnull(areaidarea,0) areaidarea, direccion,direccion_relativa  from area where areaidarea is not null");
                ResultSet rs=stm.executeQuery();
                while(rs.next()){
                		CArea temp_menu=null;
                        temp_menu=new CArea( rs.getInt("idarea"),rs.getString("descripcion"),null);
                        ret.add(temp_menu);
                        
                }
                rs.close();
                stm.close();
        }
        
        catch(Throwable e){
                
        }
        return ret;
	}
	public CConfiguracion getConfiguracion(){
		CConfiguracion temp=null;
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement(" SELECT idconfiguracion, telefono, correo_electronico, fax, direccion_imagen, direccion_pdf, tamanio_sub, dir_rel_imagen, dir_rel_pdf, direccion FROM configuracion where idconfiguracion=? ");
			stm.setInt(1, 1);
			ResultSet rs2=stm.executeQuery();
			if(rs2.next()){
				temp=new CConfiguracion( rs2.getInt("idconfiguracion"),rs2.getString("telefono"),rs2.getString("correo_electronico"),rs2.getString("fax"),rs2.getString("direccion_imagen"),rs2.getString("direccion_pdf"),rs2.getInt("tamanio_sub"),rs2.getString("dir_rel_imagen"),rs2.getString("dir_rel_pdf"),rs2.getString("direccion"));
			}
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return temp;
	}
	public void Close(){
		try{
			conn.close();
		}
		catch(Throwable e){

		}
	}
}
