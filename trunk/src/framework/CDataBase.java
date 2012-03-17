package framework;

import java.util.ArrayList;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.PreparedStatement;

import data.CActividad;
import data.CArea;
import data.CCategoria;
import data.CConfiguracion;
import data.CContenido;
import data.CDetalleActividad;
import data.CEdificio;
import data.CEncabezado;
import data.CMultimedia;
import data.CMenu;
import data.CNoticia;
import data.CPermiso;
import data.CPregunta;
import data.CResponsable;
import data.CSubcategoria;
import data.CUsuario;

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
	public CUsuario getUsuario(String user){
		CUsuario temp=null;
		try{    
        	PreparedStatement stm=(PreparedStatement)conn.prepareStatement("SELECT idusuario, nombre, apellido, nick, password, telefono, email, areaidarea, estado FROM usuario where nick=? ");
        	stm.setString(1,user);
                ResultSet rs=stm.executeQuery();
                while(rs.next()){                							
                                temp=new CUsuario(rs.getInt("idusuario"),rs.getString("nombre"),rs.getString("apellido"),rs.getString("nick"),rs.getString("password"),rs.getString("telefono"),rs.getString("email"),rs.getInt("estado"),null);
                               
                }
                rs.close();
                stm.close();
        }
        
        catch(Throwable e){
                
        }
		return temp;
	}
	public ArrayList<CUsuario> getListaUsuarios(){
		ArrayList<CUsuario> lista=new ArrayList<CUsuario>();
		try{    
        	PreparedStatement stm=(PreparedStatement)conn.prepareStatement("SELECT idusuario, nombre, apellido, nick, telefono, email, areaidarea, estado FROM usuario where estado=1 ");
        	    ResultSet rs=stm.executeQuery();
                while(rs.next()){                	
                	CUsuario temp=new CUsuario(rs.getInt("idusuario"),rs.getString("nombre"),rs.getString("apellido"),rs.getString("nick"),"",rs.getString("telefono"),rs.getString("email"),rs.getInt("estado"),null);
                	lista.add(temp);           
                }
                rs.close();
                stm.close();
        }
        
        catch(Throwable e){
                
        }
		return lista;
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
			stm = (PreparedStatement)conn.prepareStatement("SELECT ifnull(count(idpregunta),0) cant  FROM pregunta where categoriaidcategoria= ?");
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
			String sql="SELECT noti.idnoticia, noti.titulo noti_titulo, noti.descripcion noti_descripcion,descripcion_corta, noti.areaidarea idarea, noti.fecha_inicio fecha_inicio, "+
"noti.fecha_fin fecha_fin, noti.prioridad prioridad, a.nombre nombre_area, m.idmultimedia idmultimedia, m.direccion direccion_m, m.direccion_relativa direccion_rel, noti.estado  "+
  "FROM noticia noti inner join area a on a.idarea=noti.areaidarea "+
  "left outer join multimedia m on noti.multimediaidmultimedia=m.idmultimedia "+
  "  where estado = 1 and fecha_inicio<=now() and adddate(fecha_fin,1)>=now()  order by prioridad desc ";
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			ResultSet rs=stm.executeQuery();
			while(rs.next()){
				CArea area=new CArea(rs.getInt("idarea"),rs.getString("nombre_area"),"",0,null,null);
				CMultimedia multi=new CMultimedia(rs.getInt("idmultimedia"),rs.getString("direccion_m"),rs.getString("direccion_rel"),0L,0,null);
				CNoticia news=new CNoticia(rs.getString("noti_titulo"),rs.getString("noti_descripcion"),rs.getString("descripcion_corta"),multi,
						new java.util.Date(rs.getDate("fecha_inicio").getTime()),new java.util.Date(rs.getDate("fecha_fin").getTime()),rs.getInt("prioridad"),rs.getInt("idnoticia"), rs.getInt("estado"),area);
				ret.add(news);
				
			}
			rs.close();
			stm.close();
		}
		catch(Throwable e){
			e.printStackTrace();
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
			
			String sql="SELECT a.idarea,a.nombre, ifnull(a.descripcion,' ') descripcion,a.size , ifnull(a.areaidarea,0) areaidarea , ifnull(m.idmultimedia,0) idmultimedia , "
					+" ifnull(m.direccion,'') direccion, ifnull(m.direccion_relativa,'No se ha seleccionado Imagen') direccion_relativa, ifnull (a.areaidarea,0 ) areaidarea, ifnull ((select ar.nombre rec_nomb from area ar where ar.idarea=a.areaidarea),'') rec_nombre "
					+" FROM area a left outer join multimedia m on a.multimediaidmultimedia=m.idmultimedia " 
					+" where  a.idarea=? ";
			stm = (PreparedStatement)conn.prepareStatement(sql);
			stm.setInt(1, idarea);
			ResultSet rs=stm.executeQuery();
			if(rs.next()){
				CMultimedia multi=new CMultimedia(rs.getInt("idmultimedia"),rs.getString("direccion"),rs.getString("direccion_relativa"),0L,1,null);
            	CArea sarea=new CArea( rs.getInt("areaidarea"),rs.getString("rec_nombre"),"",0,null,null);
            	temp=new CArea( rs.getInt("idarea"),rs.getString("nombre"),rs.getString("descripcion"),rs.getInt("size"),multi,sarea);
            	
			}
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
        	String query="";
        	
        		query="select * from "
				+"(SELECT @rownum:=@rownum+1 rownum, m.idmenu,m.descripcion, '' contenido,ifnull(m.idmenu_rec,0) idmenu_rec,  m.size,"
				+"a.idarea,a.nombre nombre_area,IF(idmenu_rec is null,'',(select descripcion from menu where idmenu=m.idmenu_rec) ) descripcion_menu "
				+"FROM Menu m, (SELECT @rownum:=0) ro, Area a  "
				+"where a.idarea=m.areaidarea and"
				+" upper("+(type==1?"m.descripcion":"a.nombre")+") like ? "
				+") data "
				+"where rownum>=? and rownum<=? ORDER BY ? "+((asc==1)?"ASC":"DESC");


        		PreparedStatement stm=(PreparedStatement)conn.prepareStatement(query);
                stm.setString(1,"%"+busqueda.trim().toUpperCase()+"%");
                stm.setInt(2, min);
                stm.setInt(3, max);
                stm.setInt(4, ordenar);
                ResultSet rs=stm.executeQuery();
                while(rs.next()){
                				ArrayList<CMenu> templist=null;
                				
                                CMenu temp=new CMenu(rs.getInt("idmenu_rec"),rs.getString("descripcion_menu"),null,"",0,templist);
                                
                                CArea temp_c=new CArea(rs.getInt("idarea"),rs.getString("nombre_area"),"",0,null,null);
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
			String query="";

        		query="select count(m.idmenu) cant from "
				+" Menu m , Area a  "
				+"where m.areaidarea=a.idarea and upper("+(type==1?"m.descripcion":"a.nombre")+") like ?";
        		
			
	                PreparedStatement stm=(PreparedStatement)conn.prepareStatement(query);
	                stm.setString(1,"%"+busqueda.toUpperCase().trim()+"%");
	                
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
        	String sql="SELECT a.idarea,a.nombre, ifnull(a.descripcion,'') descripcion,a.size , ifnull(a.areaidarea,0) areaidarea , m.idmultimedia, "+
        				"m.direccion, m.direccion_relativa, ifnull (a.areaidarea,0 ) areaidarea, ifnull ((select ar.nombre rec_nomb from area ar where ar.idarea=a.areaidarea),'') rec_nombre " +
        				"FROM area a left outer join multimedia m on a.multimediaidmultimedia=m.idmultimedia" ;
                PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
                ResultSet rs=stm.executeQuery();
                while(rs.next()){
                	CMultimedia multi=new CMultimedia(rs.getInt("idmultimedia"),rs.getString("direccion"),rs.getString("direccion_relativa"),0L,1,null);
                	CArea sarea=new CArea( rs.getInt("areaidarea"),rs.getString("rec_nombre"),"",0,null,null);
                	CArea temp=new CArea( rs.getInt("idarea"),rs.getString("nombre"),rs.getString("descripcion"),rs.getInt("size"),multi,sarea);
                	ret.add(temp);
                        
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
        	String sql="SELECT a.idarea,a.nombre  FROM area a where  areaidarea is null and idarea!=1 order by nombre asc";
                PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
                ResultSet rs2=stm.executeQuery();
                while(rs2.next()){
        			CArea temp=new CArea( rs2.getInt("idarea"),rs2.getString("nombre"),"",0,null,null);
                	ret.add(temp);
                        
                }
                rs2.close();
                stm.close();
        }
        
        catch(Throwable e){
                
        }
        return ret;
	}
	public ArrayList<CArea> getAreaListaMenuSubmenu(int idarea){
        ArrayList<CArea> ret=new ArrayList<CArea>();
        try{
        	String sql="SELECT a.idarea,a.nombre  FROM area a where  areaidarea is not null and  areaidarea=? order by nombre asc ";
        		PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
        		stm.setInt(1,idarea);
                ResultSet rs2=stm.executeQuery();
                while(rs2.next()){
                	CArea temp=new CArea( rs2.getInt("idarea"),rs2.getString("nombre"),"",0,null,null);
                	ret.add(temp);
                        
                }
                rs2.close();
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
	public int getMultimediaTotal(){
		int temp=0;
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("SELECT ifnull(count(idmultimedia),0) cant  FROM multimedia");
			ResultSet rs2=stm.executeQuery();
			if(rs2.next())
			temp=rs2.getInt("cant");
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return temp;
	}
	public boolean SafeMultimedia(CMultimedia imagen){
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("INSERT INTO multimedia   ( direccion, direccion_relativa, tamanio, usuarioidusuario,tipo) VALUES ( ?, ?, ?, ?,?)");
			
			stm.setString(1, imagen.getdireccion());
			stm.setString(2, imagen.getdireccion_relativa());
			stm.setInt(3, imagen.gettamanio());
			stm.setInt(4, imagen.getusuarioidusuario().getidusuario());
			stm.setInt(5, imagen.gettipo());
			if(stm.executeUpdate()>0)
				return true;
			
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return false;
	}
	public CMultimedia getMultimediaEspecifica(String path){
		CMultimedia temp=null;
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("SELECT idmultimedia, direccion, direccion_relativa, tamanio, usuarioidusuario, tipo FROM multimedia where  direccion = ?");
			stm.setString(1, path);
			ResultSet rs2=stm.executeQuery();
			if(rs2.next()){
				temp=new CMultimedia( rs2.getInt("idmultimedia"),rs2.getString("direccion"),rs2.getString("direccion_relativa"),rs2.getInt("tamanio"),rs2.getInt("tipo"),null);
			}
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return temp;
	}
	public CMultimedia getMultimediaEspecifica(int idmultimedia){
		CMultimedia temp=null;
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("SELECT idmultimedia, direccion, direccion_relativa, tamanio, usuarioidusuario, tipo FROM multimedia where  idmultimedia = ?");
			stm.setInt(1, idmultimedia);
			ResultSet rs2=stm.executeQuery();
			if(rs2.next()){
				temp=new CMultimedia( rs2.getInt("idmultimedia"),rs2.getString("direccion"),rs2.getString("direccion_relativa"),rs2.getInt("tamanio"),rs2.getInt("tipo"),null);
			}
		} catch (SQLException e) {

			e.printStackTrace();
		}
		return temp;
	}
	public boolean SafeContenido(CContenido conte){
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("INSERT INTO contenido(menuidmenu,  descripcion, titulo,  multimediaidmultimedia) VALUES  (?, ?, ?, ?)");
			
			stm.setInt(1, conte.getidmenu().getidmenu());
			stm.setString(2, conte.getdescripcion());
			stm.setString(3, conte.gettitulo());
			stm.setInt(4, conte.getmultimedia().getidimagen());
			if(stm.executeUpdate()>0)
				return true;
			
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return false;
	}
	public int getContenidoTotal(int tipo,int idmenu){
		int temp=0;
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("SELECT ifnull(count(idcontenido),0) cant  FROM contenido c,multimedia m where  c.multimediaidmultimedia=m.idmultimedia and m.tipo=? and  c.menuidmenu=?");
			stm.setInt(1, tipo);
			stm.setInt(2, idmenu);
			ResultSet rs2=stm.executeQuery();
			if(rs2.next())
			temp=rs2.getInt("cant");
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return temp;
	}
	public ArrayList<CContenido> getContenidoLista(int tipo,int idmenu){
		
		
		ArrayList<CContenido> ret=new ArrayList<CContenido>();
        try{
                PreparedStatement stm=(PreparedStatement)conn.prepareStatement("SELECT c.idcontenido,c.descripcion, c.titulo, m.idmultimedia, m.direccion, m.direccion_relativa FROM contenido c,multimedia m  where  c.multimediaidmultimedia=m.idmultimedia and m.tipo=? and  c.menuidmenu=?");
                stm.setInt(1, tipo);
    			stm.setInt(2, idmenu);
                ResultSet rs=stm.executeQuery();
                while(rs.next()){
                		CMultimedia temp_mult=new CMultimedia(rs.getInt("idmultimedia"),rs.getString("direccion"),rs.getString("direccion_relativa"),0,0,null);
                        CContenido temp=new CContenido( rs.getInt("idcontenido"),rs.getString("descripcion"),rs.getString("titulo"),temp_mult,null);
                        ret.add(temp);
                        
                }
                rs.close();
                stm.close();
        }
        
        catch(Throwable e){
        	e.printStackTrace();
        }
        return ret;
	}
public CContenido getContenido(int idcontenido){
		
		
		CContenido temp=null;
        try{
                PreparedStatement stm=(PreparedStatement)conn.prepareStatement("SELECT c.idcontenido,c.descripcion, c.titulo, m.idmultimedia, m.direccion, m.direccion_relativa FROM contenido c,multimedia m  where  c.multimediaidmultimedia=m.idmultimedia and  c.idcontenido=?");
                stm.setInt(1, idcontenido);
                ResultSet rs=stm.executeQuery();
                while(rs.next()){
                		CMultimedia temp_mult=new CMultimedia(rs.getInt("idmultimedia"),rs.getString("direccion"),rs.getString("direccion_relativa"),0,0,null);
                        temp=new CContenido( rs.getInt("idcontenido"),rs.getString("descripcion"),rs.getString("titulo"),temp_mult,null);
                        
                }
                rs.close();
                stm.close();
        }
        
        catch(Throwable e){
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
	public boolean UpdateContenido(CContenido contenido){
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("UPDATE contenido SET descripcion = ?, titulo = ?, multimediaidmultimedia = ? WHERE idcontenido =?");
			
			stm.setString(1, contenido.getdescripcion());
			stm.setString(2, contenido.gettitulo());
			stm.setInt(3, contenido.getmultimedia().getidimagen());
			stm.setInt(4, contenido.getidcontenido());
			if(stm.executeUpdate()>0)
				return true;
			
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return false;
	}
	public int deleteMenu(int idmenu){
		int temp=0;
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("select EliminarMenu(?) result");
			stm.setInt(1, idmenu);
			ResultSet rs2=stm.executeQuery();
			if(rs2.next())
			temp=rs2.getInt("result");
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return temp;
	}
	public int deleteContenido(int idcontenido){
		int temp=0;
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("select EliminarContenido(?) result");
			stm.setInt(1, idcontenido);
			ResultSet rs2=stm.executeQuery();
			if(rs2.next())
			temp=rs2.getInt("result");
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return temp;
	}
	public boolean UpdateArea(CArea area){
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("UPDATE area SET descripcion = ?, size = ?, multimediaidmultimedia = ? WHERE idarea=?");
			
			stm.setString(1, area.getdescripcion());
			stm.setInt(2, area.getsize());
			if(area.getidmultimedia()!=null)
				stm.setInt(3, area.getidmultimedia().getidimagen());
			else stm.setNull(3, java.sql.Types.INTEGER);
			stm.setInt(4, area.getidarea());
			
			if(stm.executeUpdate()>0)
				return true;
			
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return false;
	}
	public ArrayList<CEncabezado> getEncabezadoLista(int idarea){
		
		
		ArrayList<CEncabezado> ret=new ArrayList<CEncabezado>();
        try{
        	String sql="SELECT a.idarea,a.nombre, a.areaidarea, a.descripcion, a.size,"+
				" m.idmultimedia, m.direccion, m.direccion_relativa "+
				" FROM encabezado e Inner join area a on a.idarea=e.areaidarea "+
				" inner join multimedia m on e.multimediaidmultimedia=m.idmultimedia " +
				" where idarea=? ";
                PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
                stm.setInt(1, idarea);
                ResultSet rs=stm.executeQuery();
                while(rs.next()){
                		CMultimedia temp_mult=new CMultimedia(rs.getInt("idmultimedia"),rs.getString("direccion"),rs.getString("direccion_relativa"),0,0,null);
                        CArea temp=new CArea(rs.getInt("idarea"),rs.getString("nombre"),rs.getString("descripcion"),rs.getInt("size"),temp_mult,null);
                        CEncabezado encabezado=new CEncabezado(temp,temp_mult);
                        ret.add(encabezado);
                        
                }
                rs.close();
                stm.close();
        }
        
        catch(Throwable e){
        	e.printStackTrace();
        }
        return ret;
	}
	public boolean SafeEncabezado(CEncabezado enca){
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("INSERT INTO encabezado (areaidarea,multimediaidmultimedia) VALUES (?,?)");
			
			stm.setInt(1, enca.getAreaidarea().getidarea());
			stm.setInt(2, enca.getMultimediaidmultimedia().getidimagen());
			if(stm.executeUpdate()>0)
				return true;
			
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return false;
	}
	public int deleteEncabezado(int idarea,int idmultimedia){
		int temp=0;
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("select EliminarEncabezado(?,? ) result");
			stm.setInt(1, idarea);
			stm.setInt(2, idmultimedia);
			ResultSet rs2=stm.executeQuery();
			if(rs2.next())
			temp=rs2.getInt("result");
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return temp;
	}
	public ArrayList<CNoticia> getListaNoticias(int ordenar,int asc,int min,int max,int type, String busqueda){
		ArrayList<CNoticia> ret=new ArrayList<CNoticia>();
		try{
			String sql="select * from (SELECT noti.idnoticia, noti.titulo noti_titulo, noti.descripcion noti_descripcion,descripcion_corta, noti.areaidarea idarea, noti.fecha_inicio fecha_inicio, "+
						"noti.fecha_fin fecha_fin, noti.prioridad prioridad, a.nombre nombre_area, m.idmultimedia idmultimedia, m.direccion direccion_m, m.direccion_relativa direccion_rel, noti.estado, @rownum:=@rownum+1 rownum  "+
						"FROM noticia noti inner join area a on a.idarea=noti.areaidarea "+
						"left outer join multimedia m on noti.multimediaidmultimedia=m.idmultimedia, (SELECT @rownum:=0) ro "+
						"where  upper("+(type==1?"noti.titulo":"a.nombre")+") like ? "+
						" ) table1 "+
						" where rownum>=? and rownum<=? order by ? "+((asc==1)?"ASC":"DESC") +"";
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			stm.setString(1,"%"+busqueda.trim().toUpperCase()+"%");
			stm.setInt(2,min);
			stm.setInt(3,max);
			stm.setInt(4,ordenar);
			ResultSet rs=stm.executeQuery();
			while(rs.next()){
				CArea area=new CArea(rs.getInt("idarea"),rs.getString("nombre_area"),"",0,null,null);
				CMultimedia multi=new CMultimedia(rs.getInt("idmultimedia"),rs.getString("direccion_m"),rs.getString("direccion_rel"),0L,0,null);
				CNoticia news=new CNoticia(rs.getString("noti_titulo"),rs.getString("noti_descripcion"),rs.getString("descripcion_corta"),multi,
						new java.util.Date(rs.getDate("fecha_inicio").getTime()),new java.util.Date(rs.getDate("fecha_fin").getTime()),rs.getInt("prioridad"),rs.getInt("idnoticia"),rs.getInt("estado"),area);;
				ret.add(news);
				
			}
			rs.close();
			stm.close();
		}
		catch(Throwable e){
			
		}
		return ret;
	}
	

	public int getNoticiasTotal(int type,String busqueda){
		int temp=0;
		try {
			String sql="SELECT count(*) cant FROM noticia noti inner join area a on a.idarea=noti.areaidarea "+
					" where  upper("+(type==1?"noti.titulo":"a.nombre")+") like ? ";
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			stm.setString(1,"%"+busqueda.trim().toUpperCase()+"%");
			ResultSet rs2=stm.executeQuery();
			if(rs2.next())
			temp=rs2.getInt("cant");
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return temp;
	}
	public boolean SafeNoticia(CNoticia noti){
		PreparedStatement stm;
		try {

			stm = (PreparedStatement)conn.prepareStatement("INSERT INTO noticia   (titulo, descripcion, areaidarea, fecha_inicio, fecha_fin, prioridad, multimediaidmultimedia,descripcion_corta,estado)  VALUES    (?,    ?,    ?,    ?,    ?,    ?,    ?,   ?,  ?)");
			stm.setString(1, noti.getTitulo());
			stm.setString(2, noti.getDescripcion());
			stm.setInt(3,noti.getAreaidarea().getidarea());
			stm.setDate(4, new java.sql.Date(noti.getFecha_inicio().getTime()));
			stm.setDate(5,new java.sql.Date(noti.getFecha_fin().getTime()));
			stm.setInt(6,noti.getPrioridad());
			if(noti.getMultimediaidmultimedia()!=null &&noti.getMultimediaidmultimedia().getidimagen()>0){
				stm.setInt(7,noti.getMultimediaidmultimedia().getidimagen());
			}else stm.setNull(7, java.sql.Types.INTEGER);
			stm.setString(8,noti.getDescripcion_corta());
			stm.setInt(9,noti.getEstado());
			if(stm.executeUpdate()>0)
				return true;
			
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return false;
	}
	public CNoticia getNoticiaEspecifica(int idnoticia){
		CNoticia news=null;
		try{
			String sql="SELECT noti.idnoticia, noti.titulo noti_titulo, noti.descripcion noti_descripcion, noti.descripcion_corta, noti.areaidarea idarea, noti.fecha_inicio fecha_inicio, "+
"noti.fecha_fin fecha_fin, noti.prioridad prioridad, noti.estado, a.nombre nombre_area, ifnull( m.idmultimedia,0) idmultimedia, ifnull(m.direccion,'') direccion_m, ifnull(m.direccion_relativa,'NO SE HA SUBIDO IMAGEN') direccion_rel  "+
  "FROM noticia noti inner join area a on a.idarea=noti.areaidarea "+
  "left outer join multimedia m on noti.multimediaidmultimedia=m.idmultimedia where noti.idnoticia=?  ";
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			stm.setInt(1,idnoticia);
			ResultSet rs=stm.executeQuery();
			if(rs.next()){
				CArea area=new CArea(rs.getInt("idarea"),rs.getString("nombre_area"),"",0,null,null);
				CMultimedia multi=new CMultimedia(rs.getInt("idmultimedia"),rs.getString("direccion_m"),rs.getString("direccion_rel"),0L,0,null);
				news=new CNoticia(rs.getString("noti_titulo"),rs.getString("noti_descripcion"),rs.getString("descripcion_corta"),multi,
						new java.util.Date(rs.getDate("fecha_inicio").getTime()),new java.util.Date(rs.getDate("fecha_fin").getTime()),rs.getInt("prioridad"),rs.getInt("idnoticia"),rs.getInt("estado"),area);
				
			}
			rs.close();
			stm.close();
		}
		catch(Throwable e){
			e.printStackTrace();
		}
		return news;
	}
	public CNoticia getNoticiaEspecificaV(int idnoticia){
		CNoticia news=null;
		try{
			String sql="SELECT noti.idnoticia, noti.titulo noti_titulo, noti.descripcion noti_descripcion, noti.descripcion_corta, noti.areaidarea idarea, noti.fecha_inicio fecha_inicio, "+
"noti.fecha_fin fecha_fin, noti.prioridad prioridad, noti.estado, a.nombre nombre_area, ifnull( m.idmultimedia,0) idmultimedia, ifnull(m.direccion,'') direccion_m, ifnull(m.direccion_relativa,'NO SE HA SUBIDO IMAGEN') direccion_rel  "+
  "FROM noticia noti inner join area a on a.idarea=noti.areaidarea "+
  "left outer join multimedia m on noti.multimediaidmultimedia=m.idmultimedia where noti.idnoticia=? and noti.estado=1  ";
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			stm.setInt(1,idnoticia);
			ResultSet rs=stm.executeQuery();
			if(rs.next()){
				CArea area=new CArea(rs.getInt("idarea"),rs.getString("nombre_area"),"",0,null,null);
				CMultimedia multi=new CMultimedia(rs.getInt("idmultimedia"),rs.getString("direccion_m"),rs.getString("direccion_rel"),0L,0,null);
				news=new CNoticia(rs.getString("noti_titulo"),rs.getString("noti_descripcion"),rs.getString("descripcion_corta"),multi,
						new java.util.Date(rs.getDate("fecha_inicio").getTime()),new java.util.Date(rs.getDate("fecha_fin").getTime()),rs.getInt("prioridad"),rs.getInt("idnoticia"),rs.getInt("estado"),area);
				
			}
			rs.close();
			stm.close();
		}
		catch(Throwable e){
			e.printStackTrace();
		}
		return news;
	}
	public boolean UpdateNoticia(CNoticia noti){
		PreparedStatement stm;
		try {
			String sql="UPDATE noticia SET   titulo = ?, descripcion = ?, areaidarea = ?, fecha_inicio = ?, fecha_fin = ?, prioridad = ?,   multimediaidmultimedia = ?, descripcion_corta=?, estado=?  WHERE  idnoticia = ?";
			stm = (PreparedStatement)conn.prepareStatement(sql);
			stm.setString(1, noti.getTitulo());
			stm.setString(2, noti.getDescripcion());
			stm.setInt(3,noti.getAreaidarea().getidarea());
			stm.setDate(4, new java.sql.Date(noti.getFecha_inicio().getTime()));
			stm.setDate(5,new java.sql.Date(noti.getFecha_fin().getTime()));
			stm.setInt(6,noti.getPrioridad());
			if(noti.getMultimediaidmultimedia()!=null &&noti.getMultimediaidmultimedia().getidimagen()>0){
				stm.setInt(7,noti.getMultimediaidmultimedia().getidimagen());
			}else stm.setNull(7, java.sql.Types.INTEGER);
			stm.setString(8,noti.getDescripcion_corta());
			stm.setInt(9,noti.getEstado());
			stm.setInt(10,noti.getIdnoticia());
			
			if(stm.executeUpdate()>0)
				return true;
			
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return false;
	}
	public ArrayList<CUsuario> getListaUsuarios(int ordenar,int asc,int min,int max,int type, String busqueda){
		ArrayList<CUsuario> ret=new ArrayList<CUsuario>();
		try{
			String pqtype="nick";
			 if(type==2)
				 pqtype="nombre";
			 else if(type==3)
				 pqtype="apellido";
			
			String sql=" select * from "+
						"(SELECT  "+
						"@rownum:=@rownum+1 rownum, idusuario,nombre,apellido,nick,telefono,email,estado "+ 
						"FROM usuario, (SELECT @rownum:=0) ro "+
						"where "+
						"upper("+pqtype+") like ? "+
						") subselect "+
						" where rownum>=? and rownum<=? "+
						" order by ? "+((asc==1)?"ASC":"DESC") +" ";
			
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			stm.setString(1,"%"+busqueda.trim().toUpperCase()+"%");
			
			stm.setInt(2,min);
			stm.setInt(3,max);
			stm.setInt(4,ordenar);
			ResultSet rs=stm.executeQuery();
			while(rs.next()){
				CUsuario user=new CUsuario(rs.getInt("idusuario"),rs.getString("nombre"),rs.getString("apellido"),rs.getString("nick"),"",rs.getString("telefono"),rs.getString("email"),rs.getInt("estado"),null);
				ret.add(user);
				
			}
			rs.close();
			stm.close();
		}
		catch(Throwable e){
			e.printStackTrace();
		}
		return ret;
	}
	public int getUsuarioTotal(int type,String busqueda){
		int temp=0;
		try {
			String pqtype="nick";
			 if(type==2)
				 pqtype="nombre";
			 else if(type==3)
				 pqtype="apellido";

			String query="";

        		query="select count(m.idusuario) cant from "
				+" Usuario m "
				+"where  upper("+pqtype+") like ?";
        		
			
	                PreparedStatement stm=(PreparedStatement)conn.prepareStatement(query);
	                stm.setString(1,"%"+busqueda.toUpperCase().trim()+"%");
	                
			ResultSet rs2=stm.executeQuery();
			if(rs2.next())
			temp=rs2.getInt("cant");
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return temp;
	}
	public CUsuario getUsuarioEspecifico(int iduser){
		CUsuario temp=null;
		try{    
        	PreparedStatement stm=(PreparedStatement)conn.prepareStatement("SELECT idusuario, nombre, apellido, nick,  telefono, email, areaidarea,estado FROM usuario where idusuario=? ");
        	stm.setInt(1,iduser);
                ResultSet rs=stm.executeQuery();
                while(rs.next()){
                				CArea area=new CArea(rs.getInt("idusuario"),"","",0,null,null);
                				//CArea(int idarea,String nombre,String descripcion, int size, CMultimedia idmultimedia,CArea areaidarea)
                                temp=new CUsuario(rs.getInt("idusuario"),rs.getString("nombre"),rs.getString("apellido"),rs.getString("nick"),"",rs.getString("telefono"),rs.getString("email"),rs.getInt("estado"),area);
                               
                }
                rs.close();
                stm.close();
        }
        
        catch(Throwable e){
        	e.printStackTrace();
        }
		return temp;
	}
	public boolean UpdateUsuario(CUsuario user,int idusuario){
		PreparedStatement stm;
		try {
		String sql="";	
			if(user.getpassword().compareTo("")==0){
				sql="UPDATE  usuario SET  nombre  = ?, apellido  = ?, nick  = ?,  telefono  = ?, email  = ?, areaidarea  = ?,  updateusuario =?, estado=? WHERE idusuario=?";
				stm = (PreparedStatement)conn.prepareStatement(sql);
				stm.setString(1, user.getnombre());
				stm.setString(2, user.getapellido());
				stm.setString(3, user.getnick());
				stm.setString(4, user.gettelefono());
				stm.setString(5, user.getemail());
				stm.setInt(6, user.getAreaidarea().getidarea());
				stm.setInt(7, idusuario);
				stm.setInt(8, user.getEstado());
				stm.setInt(9,user.getidusuario());
			}else{
				sql="UPDATE  usuario SET  nombre  = ?, apellido  = ?, nick  = ?, password  = ?, telefono  = ?, email  = ?, areaidarea  = ?,  updateusuario =?, estado=? WHERE idusuario=?";	
				stm = (PreparedStatement)conn.prepareStatement(sql);
				stm.setString(1, user.getnombre());
				stm.setString(2, user.getapellido());
				stm.setString(3, user.getnick());
				stm.setString(4, user.getpassword());
				stm.setString(5, user.gettelefono());
				stm.setString(6, user.getemail());
				stm.setInt(7, user.getAreaidarea().getidarea());
				stm.setInt(8, idusuario);
				stm.setInt(9, user.getEstado());
				stm.setInt(10,user.getidusuario());
			}
			
			if(stm.executeUpdate()>0)
				return true;
			
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return false;
	}
	public boolean SafeUser(CUsuario user,int idusuario){
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("INSERT INTO usuario (nombre,apellido,nick,password,telefono,email,areaidarea,estado,updateusuario) VALUES (?,?,?,?,?,?,?,?,?)");
			
			stm.setString(1,user.getnombre());
			stm.setString(2, user.getapellido());
			stm.setString(3, user.getnick());
			stm.setString(4, user.getpassword());
			stm.setString(5, user.gettelefono());
			stm.setString(6, user.getemail());
			stm.setInt(7, user.getAreaidarea().getidarea());
			stm.setInt(8, user.getEstado());
			stm.setInt(9, idusuario);
			if(stm.executeUpdate()>0)
				return true;
			
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return false;
	}
public ArrayList<CPermiso> getListaPermiso(){
		
		
		ArrayList<CPermiso> ret=new ArrayList<CPermiso>();
        try{
        	String sql="SELECT idpermiso, descripcion FROM permiso ";
                PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
                ResultSet rs=stm.executeQuery();
                while(rs.next()){
                		CPermiso permiso=new CPermiso(rs.getInt("idpermiso"),rs.getString("descripcion"));
                        ret.add(permiso);
                        
                }
                rs.close();
                stm.close();
        }
        
        catch(Throwable e){
        	e.printStackTrace();
        }
        return ret;
	}
public ArrayList<CPermiso> getListaPermiso(int idusuario){
	
	
	ArrayList<CPermiso> ret=new ArrayList<CPermiso>();
    try{
    	String sql="SELECT p.idpermiso, p.descripcion FROM usuario_permisos up inner join  permiso p on p.idpermiso=up.permisosidpermiso where usuarioidusuario = ?";
            PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
            stm.setInt(1, idusuario);
            ResultSet rs=stm.executeQuery();
            while(rs.next()){
            		CPermiso permiso=new CPermiso(rs.getInt("idpermiso"),rs.getString("descripcion"));
                    ret.add(permiso);
                    
            }
            rs.close();
            stm.close();
    }
    
    catch(Throwable e){
    	e.printStackTrace();
    }
    return ret;
}
public ArrayList<Integer> getListaPermisoInt(int idusuario){
	
	
	ArrayList<Integer> ret=new ArrayList<Integer>();
    try{
    	String sql="SELECT p.idpermiso FROM usuario_permisos up inner join  permiso p on p.idpermiso=up.permisosidpermiso where usuarioidusuario = ?";
            PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
            stm.setInt(1, idusuario);
            ResultSet rs=stm.executeQuery();
            while(rs.next()){
            		ret.add(rs.getInt("idpermiso"));
                    
            }
            rs.close();
            stm.close();
    }
    
    catch(Throwable e){
    	e.printStackTrace();
    }
    return ret;
}
public boolean safePermisoUsuario(int idusuario,ArrayList<Integer> list){
	PreparedStatement stm;
	boolean b=true;
	try {
		
		stm = (PreparedStatement)conn.prepareStatement("DELETE FROM usuario_permisos WHERE  usuarioidusuario=?");
		stm.setInt(1, idusuario);
		 stm.executeUpdate();
	 
		
		 for(int j=0; j<list.size();j++){ 
			 stm = (PreparedStatement)conn.prepareStatement("INSERT INTO usuario_permisos(usuarioidusuario,permisosidpermiso) VALUES (?,?)");
				stm.setInt(1, idusuario);
				stm.setInt(2, list.get(j));
			 if(stm.executeUpdate()>0)
				 b= true;
			 else  return false;
		 }
	} catch (SQLException e) {

		e.printStackTrace();
	}
	
	return b;
}
public int deleteNoticia(int idnoticia){
	int temp=0;
	PreparedStatement stm;
	try {
		stm = (PreparedStatement)conn.prepareStatement("select EliminarNoticia(?) result");
		stm.setInt(1, idnoticia);
		ResultSet rs2=stm.executeQuery();
		if(rs2.next())
		temp=rs2.getInt("result");
	} catch (SQLException e) {

		e.printStackTrace();
	}
	
	return temp;
}
public ArrayList<CResponsable> getListaResponsables(int ordenar,int asc,int min,int max,int type, String busqueda){
	ArrayList<CResponsable> ret=new ArrayList<CResponsable>();
	try{
		String pqtype="respon.nombre";
		 if(type==2)
			 pqtype="respon.apellido";
		 else if(type==3)
			 pqtype="a.nombre";
		
		String sql="select * from (SELECT respon.idresponsable, respon.nombre nombre, respon.apellido apellido,a.idarea ,a.nombre nombre_area, @rownum:=@rownum+1 rownum "+
	" FROM responsable respon inner join area a on a.idarea=respon.areaidarea, (SELECT @rownum:=0) ro "+
	" where  upper("+pqtype+") like ? " +
	" ) table1 "+
	" where rownum>=? and rownum<=? order by ? "+((asc==1)?"ASC":"DESC");
		PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
		stm.setString(1,"%"+busqueda.trim().toUpperCase()+"%");
		stm.setInt(2,min);
		stm.setInt(3,max);
		stm.setInt(4,ordenar);
		ResultSet rs=stm.executeQuery();
		while(rs.next()){
			CArea area=new CArea(rs.getInt("idarea"),rs.getString("nombre_area"),"",0,null,null);
			CResponsable cr=new CResponsable(rs.getInt("idresponsable"),rs.getString("nombre"),rs.getString("apellido"),null,area);
			ret.add(cr);
			
		}
		rs.close();
		stm.close();
	}
	catch(Throwable e){
		
	}
	return ret;
}

public int getResponsableTotal(int type,String busqueda){
	int temp=0;
	try {
		String pqtype="respon.nombre";
		 if(type==2)
			 pqtype="respon.apellido";
		 else if(type==3)
			 pqtype="a.nombre";
		String sql="SELECT count(*) cant FROM responsable respon inner join area a on a.idarea=respon.areaidarea "+
				" where  upper("+ pqtype+") like ? ";
		PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
		stm.setString(1,"%"+busqueda.trim().toUpperCase()+"%");
		ResultSet rs2=stm.executeQuery();
		if(rs2.next())
		temp=rs2.getInt("cant");
	} catch (SQLException e) {

		e.printStackTrace();
	}
	
	return temp;
}
	public boolean SafeResponsable(CResponsable respon){
	PreparedStatement stm;
	try {
		stm = (PreparedStatement)conn.prepareStatement(" INSERT INTO responsable (nombre, apellido, usuarioidusuario, areaidarea) VALUES ( ?, ?, ?, ?)");
		
		stm.setString(1, respon.getNombre());
		stm.setString(2, respon.getApellido());
		
		if(respon.getUsuariosidusuario()==null){
			stm.setNull(3,java.sql.Types.INTEGER);
		}else {
			stm.setInt(3, respon.getUsuariosidusuario().getidusuario());
		}
		stm.setInt(4,respon.getAreaidarea().getidarea());
		if(stm.executeUpdate()>0)
			return true;
		
	} catch (SQLException e) {

		e.printStackTrace();
	}
	
	return false;
}
	public CResponsable getResponsableEspecifica(int idresponsable){
		CResponsable ret=null;
		try{
			
			String sql="SELECT r.idresponsable, r.nombre r_nombre, r.apellido r_apellido, ifnull(r.usuarioidusuario,0) idusuario, "+
					" r.areaidarea  idarea, a.nombre nombre_area, ifnull(u.nombre,'')  user_nombre, ifnull(u.apellido,'') user_apellido "+
					" FROM responsable r inner join area a on  r.areaidarea=a.idarea "+
					" left outer join usuario u on u.idusuario=r.usuarioidusuario "+
					" where r.idresponsable=? ";
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			stm.setInt(1,idresponsable);
			ResultSet rs=stm.executeQuery();
			while(rs.next()){
				CArea area=new CArea(rs.getInt("idarea"),rs.getString("nombre_area"),"",0,null,null);
				CUsuario user=new CUsuario(rs.getInt("idusuario"),rs.getString("user_nombre"),rs.getString("user_apellido"),"","","","",0,null);
				ret=new CResponsable(rs.getInt("idresponsable"),rs.getString("r_nombre"),rs.getString("r_apellido"),user,area);
				
			}
			rs.close();
			stm.close();
		}
		catch(Throwable e){
			e.printStackTrace();
		}
		return ret;
	}
	public boolean UpdateResponsable(CResponsable respon){
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("UPDATE responsable SET   nombre = ?,   apellido = ?,   usuarioidusuario = ?,   areaidarea = ?  WHERE  idresponsable = ?");
			
			stm.setString(1, respon.getNombre());
			stm.setString(2, respon.getApellido());
			
			if(respon.getUsuariosidusuario()==null){
				stm.setNull(3,java.sql.Types.INTEGER);
			}else {
				stm.setInt(3, respon.getUsuariosidusuario().getidusuario());
			}
			stm.setInt(4,respon.getAreaidarea().getidarea());
			stm.setInt(5,respon.getIdresponsable());
			if(stm.executeUpdate()>0)
				return true;
			
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return false;
	}
	public boolean deleteResponsable(int idresponsable){
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("DELETE FROM responsable   WHERE idresponsable = ?");
			stm.setInt(1, idresponsable);
			if(stm.executeUpdate()>0)
				return true;
			
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return false;
	}
	public ArrayList<CResponsable> getListaResponsables(){
		ArrayList<CResponsable> ret=new ArrayList<CResponsable>();
		try{
			String sql="SELECT respon.idresponsable, respon.nombre nombre, respon.apellido apellido,a.idarea ,a.nombre nombre_area, @rownum:=@rownum+1 rownum "+
		" FROM responsable respon inner join area a on a.idarea=respon.areaidarea order by 5 ";
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			ResultSet rs=stm.executeQuery();
			while(rs.next()){
				CArea area=new CArea(rs.getInt("idarea"),rs.getString("nombre_area"),"",0,null,null);
				CResponsable cr=new CResponsable(rs.getInt("idresponsable"),rs.getString("nombre"),rs.getString("apellido"),null,area);
				ret.add(cr);
				
			}
			rs.close();
			stm.close();
		}
		catch(Throwable e){
			
		}
		return ret;
	}
	public ArrayList<CEdificio> getListaEdificio(int ordenar,int asc,int min,int max,int type, String busqueda){
		ArrayList<CEdificio> ret=new ArrayList<CEdificio>();
		try{
			String pqtype="edi.nombre";
			 if(type==1)
				 pqtype="edi.direccion";
			
			String sql="select * from (SELECT edi.idedificio, edi.nombre nombre, edi.direccion direccion, edi.telefono telefono, @rownum:=@rownum+1 rownum "+
		" FROM edificio edi, (SELECT @rownum:=0) ro "+
		" where  upper("+pqtype+") like ? " +
		" ) table1 "+
		" where rownum>=? and rownum<=? order by ? "+((asc==1)?"ASC":"DESC");
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			stm.setString(1,"%"+busqueda.trim().toUpperCase()+"%");
			stm.setInt(2,min);
			stm.setInt(3,max);
			stm.setInt(4,ordenar);
			ResultSet rs=stm.executeQuery();
			while(rs.next()){
				CEdificio cr=new CEdificio(rs.getInt("idedificio"),rs.getString("nombre"),rs.getString("direccion"),rs.getString("telefono"));
				ret.add(cr);
				
			}
			rs.close();
			stm.close();
		}
		catch(Throwable e){
			
		}
		return ret;
	}
	public ArrayList<CEdificio> getListaEdificio(){
		ArrayList<CEdificio> ret=new ArrayList<CEdificio>();
		try{

			String sql="SELECT edi.idedificio, edi.nombre nombre, edi.direccion direccion, edi.telefono telefono "+
		" FROM edificio edi";
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			ResultSet rs=stm.executeQuery();
			while(rs.next()){
				CEdificio cr=new CEdificio(rs.getInt("idedificio"),rs.getString("nombre"),rs.getString("direccion"),rs.getString("telefono"));
				ret.add(cr);
				
			}
			rs.close();
			stm.close();
		}
		catch(Throwable e){
			
		}
		return ret;
	}
	public int getEdificioTotal(int type,String busqueda){
		int temp=0;
		try {
			String pqtype="edi.nombre";
			 if(type==1)
				 pqtype="edi.direccion";
			
			String sql="SELECT count(*) cant FROM edificio edi  "+
					" where  upper("+ pqtype+") like ? ";
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			stm.setString(1,"%"+busqueda.trim().toUpperCase()+"%");
			ResultSet rs2=stm.executeQuery();
			if(rs2.next())
			temp=rs2.getInt("cant");
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return temp;
	}
	public boolean SafeEdificio(CEdificio edi){
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("INSERT INTO edificio(nombre, direccion, telefono) VALUES ( ?, ?, ?)");
			
			stm.setString(1, edi.getNombre());
			stm.setString(2, edi.getDireccion());
			stm.setString(3, edi.getTelefono());
			if(stm.executeUpdate()>0)
				return true;
			
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return false;
	}
	public boolean UpdateEdificio(CEdificio edi){
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("UPDATE edificio SET nombre = ?, direccion = ?, telefono = ? WHERE idedificio = ?");
			
			stm.setString(1, edi.getNombre());
			stm.setString(2, edi.getDireccion());
			stm.setString(3, edi.getTelefono());
			stm.setInt(4, edi.getIdedificio());
			if(stm.executeUpdate()>0)
				return true;
			
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return false;
	}
	public CEdificio getEdificioEspecifica(int idedificio){
		CEdificio ret=null;
		try{
			
			String sql="SELECT idedificio , nombre, direccion, telefono from edificio where idedificio=? ";
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			stm.setInt(1,idedificio);
			ResultSet rs=stm.executeQuery();
			while(rs.next()){
				ret=new CEdificio(rs.getInt("idedificio"),rs.getString("nombre"),rs.getString("direccion"),rs.getString("telefono"));
				
			}
			rs.close();
			stm.close();
		}
		catch(Throwable e){
			e.printStackTrace();
		}
		return ret;
	}
	public boolean deleteEdificio(int idedificio){
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("DELETE FROM edificio WHERE idedificio = ?");
			stm.setInt(1, idedificio);
			if(stm.executeUpdate()>0)
				return true;
			
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return false;
	}
	public ArrayList<CActividad> getListaActividades(int ordenar,int asc,int min,int max,int type, String busqueda){
		ArrayList<CActividad> ret=new ArrayList<CActividad>();
		try{
			String pqtype="act.titulo";
			if(type==2)
				 pqtype="edi.nombre";
			else if(type==3)
				pqtype="a.nombre";
			
			String sql="select * from (SELECT act.idactividad, act.titulo act_titulo, act.descripcion act_descripcion, act.areaidarea idarea,act.salon , "+
						" a.nombre nombre_area, edi.idedificio, edi.nombre edificio_nombre,  @rownum:=@rownum+1 rownum  "+
						"FROM actividad act inner join area a on a.idarea=act.areaidarea "+
						"inner join edificio edi on edi.idedificio=act.edificioidedificio,(SELECT @rownum:=0) ro "+
						"where  upper("+pqtype+") like ? "+
						" ) table1 "+
						" where rownum>=? and rownum<=? order by ? "+((asc==1)?"ASC":"DESC") +"";
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			stm.setString(1,"%"+busqueda.trim().toUpperCase()+"%");
			stm.setInt(2,min);
			stm.setInt(3,max);
			stm.setInt(4,ordenar);
			ResultSet rs=stm.executeQuery();
			while(rs.next()){
				CArea area=new CArea(rs.getInt("idarea"),rs.getString("nombre_area"),"",0,null,null);
				CEdificio edi=new CEdificio(rs.getInt("idedificio"),rs.getString("edificio_nombre"),"","");
				CActividad act=new CActividad(rs.getInt("idactividad"),rs.getString("act_titulo"),area,rs.getString("act_descripcion"),edi,rs.getString("salon"));
				//CActividad(int idactividad, String titulo, CArea areaidarea,String descripcion, CResponsable responsableidresponsable,CEdificio edificioidedificio)
				ret.add(act);
				
			}
			rs.close();
			stm.close();
		}
		catch(Throwable e){
			e.printStackTrace();
		}
		return ret;
	}
	public int getActividadesTotal(int type,String busqueda){
		int temp=0;
		String pqtype="act.titulo";
		if(type==2)
			 pqtype="edi.nombre";
		else if(type==3)
			pqtype="a.nombre";
		try {
			String sql="SELECT count(*) cant FROM actividad act inner join area a on a.idarea=act.areaidarea "+
					" inner join edificio edi on edi.idedificio=act.edificioidedificio "+
					" where  upper("+pqtype+") like ? ";
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			stm.setString(1,"%"+busqueda.trim().toUpperCase()+"%");
			ResultSet rs2=stm.executeQuery();
			if(rs2.next())
			temp=rs2.getInt("cant");
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return temp;
	}
	public boolean saferesponsable_actividad(int idactividad,ArrayList<Integer> list){
		PreparedStatement stm;
		boolean b=true;
		try {
			
			stm = (PreparedStatement)conn.prepareStatement("DELETE FROM responsable_actividad WHERE actividadidactividad =?");
			stm.setInt(1, idactividad);
			 stm.executeUpdate();
		 
			
			 for(int j=0; j<list.size();j++){ 
				 stm = (PreparedStatement)conn.prepareStatement("INSERT INTO responsable_actividad(responsableidresponsable,actividadidactividad) VALUES(?,?)");
				 stm.setInt(1, list.get(j));	
				 stm.setInt(2, idactividad);
					
				 if(stm.executeUpdate()>0)
					 b= true;
				 else  return false;
			 }
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return b;
	}
	public boolean SafeActividad(CActividad act){
		PreparedStatement stm;
		try {

			stm = (PreparedStatement)conn.prepareStatement("INSERT INTO actividad ( titulo, areaidarea, descripcion, edificioidedificio, salon) VALUES ( ?, ?, ?, ?, ?)");
			stm.setString(1, act.getTitulo());
			stm.setInt(2,act.getAreaidarea().getidarea());
			stm.setString(3,act.getDescripcion());
			stm.setInt(4,act.getEdificioidedificio().getIdedificio());
			stm.setString(5,act.getSalon());
			if(stm.executeUpdate()>0)
				return true;
			
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return false;
	}
	public int BuscarActividad(CActividad act){
		int temp=0;
		try {
			String sql="select max(idactividad) cant from actividad where titulo=? and areaidarea=? and edificioidedificio=?  ";
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			stm.setString(1, act.getTitulo());
			stm.setInt(2,act.getAreaidarea().getidarea());
			stm.setInt(3,act.getEdificioidedificio().getIdedificio());
			
			ResultSet rs2=stm.executeQuery();
			if(rs2.next())
			temp=rs2.getInt("cant");
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return temp;
	}
	public CActividad getActividadEspecifica(int idactividad){
		CActividad news=null;
		try{
			String sql="SELECT act.idactividad, act.titulo act_titulo, act.descripcion act_descripcion, act.areaidarea idarea, act.salon, "+
  " a.nombre nombre_area, edi.idedificio, edi.nombre edi_nombre  "+
  "FROM actividad act inner join area a on a.idarea=act.areaidarea "+
  " inner join edificio edi on edi.idedificio=act.edificioidedificio where idactividad=?  ";
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			stm.setInt(1,idactividad);
			ResultSet rs=stm.executeQuery();
			if(rs.next()){
				CArea area=new CArea(rs.getInt("idarea"),rs.getString("nombre_area"),"",0,null,null);
				CEdificio edi=new CEdificio(rs.getInt("idedificio"),rs.getString("edi_nombre"),"","");
				news=new CActividad(rs.getInt("idactividad"),rs.getString("act_titulo"),area,rs.getString("act_descripcion"),edi,rs.getString("salon"));
				
			}
			rs.close();
			stm.close();
		}
		catch(Throwable e){
			e.printStackTrace();
		}
		return news;
	}
	public ArrayList<Integer> getActividadResponsableEspecifica(int idactividad){
		ArrayList<Integer> ret=new ArrayList<Integer>();
		try{
			String sql="SELECT responsableidresponsable, actividadidactividad  FROM responsable_actividad where actividadidactividad=?  ";
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			stm.setInt(1,idactividad);
			ResultSet rs=stm.executeQuery();
			while(rs.next()){
				ret.add(rs.getInt("responsableidresponsable"));
			}
			rs.close();
			stm.close();
		}
		catch(Throwable e){
			e.printStackTrace();
		}
		return ret;
	}
	public boolean UpdateActividad(CActividad act){
		PreparedStatement stm;
		try {

			stm = (PreparedStatement)conn.prepareStatement("UPDATE actividad SET titulo = ?, areaidarea = ?, descripcion = ?, edificioidedificio = ?, salon = ? WHERE idactividad = ?");
			stm.setString(1, act.getTitulo());
			stm.setInt(2,act.getAreaidarea().getidarea());
			stm.setString(3,act.getDescripcion());
			stm.setInt(4,act.getEdificioidedificio().getIdedificio());
			stm.setString(5,act.getSalon());
			stm.setInt(6, act.getIdactividad());
			if(stm.executeUpdate()>0)
				return true;
			
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return false;
	}
	public int SafeActividadDetalle(int idactividad,java.util.Date fechaInicio,java.util.Date fechaFin, java.util.Date horaInicio, java.util.Date horaFin,int lunes,int martes,int miercoles,int jueves,int viernes, int sabado, int domingo){
		int temp=0;
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("select Rango_fechas(?,?,?,?,?,?,?,?,?,?,?,?) result");
			stm.setInt(1, idactividad);
			stm.setDate(2, new java.sql.Date(fechaInicio.getTime()));
			stm.setDate(3, new java.sql.Date(fechaFin.getTime()));
			stm.setTimestamp(4,new java.sql.Timestamp(horaInicio.getTime()));
			stm.setTimestamp(5, new java.sql.Timestamp(horaFin.getTime()));
			stm.setInt(6, lunes);
			stm.setInt(7, martes);
			stm.setInt(8, miercoles);
			stm.setInt(9, jueves);
			stm.setInt(10, viernes);
			stm.setInt(11, sabado);
			stm.setInt(12, domingo);
			
			ResultSet rs2=stm.executeQuery();
			if(rs2.next())
			temp=rs2.getInt("result");
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return temp;
	}
	public ArrayList<CDetalleActividad> getListaDetalleActividad(int idactividad,int ordenar,int asc,int min,int max){
		ArrayList<CDetalleActividad> ret=new ArrayList<CDetalleActividad>();
		try{
			String sql="select * from (SELECT da.iddetalleactividad, da.fecha, da.horainicio, da.horafin, da.actividadidactividad , act.titulo, @rownum:=@rownum+1 rownum "+
			"  FROM detalleactividad da inner join actividad act on act.idactividad=da.actividadidactividad,(SELECT @rownum:=0) ro "+
			" where idactividad=?) table1 where rownum>=? and rownum<=? order by ? "+((asc==1)?"ASC":"DESC") ;
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			stm.setInt(1,idactividad);
			stm.setInt(2,min);
			stm.setInt(3,max);
			stm.setInt(4,ordenar);
			ResultSet rs=stm.executeQuery();
			while(rs.next()){
				CActividad act=new CActividad(idactividad,rs.getString("titulo"),null,"",null,"");
				CDetalleActividad dacti=new CDetalleActividad(rs.getInt("iddetalleactividad"),new java.util.Date(rs.getDate("fecha").getTime()),new java.util.Date(rs.getTimestamp("horainicio").getTime()),new java.util.Date(rs.getTimestamp("horafin").getTime()),act);
				ret.add(dacti);
				
			}
			rs.close();
			stm.close();
		}
		catch(Throwable e){
			
		}
		return ret;
	}
	public ArrayList<CDetalleActividad> getListaDetalleActividad(int idactividad){
		ArrayList<CDetalleActividad> ret=new ArrayList<CDetalleActividad>();
		try{
			String sql="SELECT count(da.iddetalleactividad) FROM detalleactividad  where da.actividadidactividad=? " ;
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			stm.setInt(1,idactividad);
			ResultSet rs=stm.executeQuery();
			while(rs.next()){
				CActividad act=new CActividad(idactividad,rs.getString("titulo"),null,"",null,"");
				CDetalleActividad dacti=new CDetalleActividad(rs.getInt("iddetalleactividad"),new java.util.Date(rs.getDate("fecha").getTime()),new java.util.Date(rs.getTimestamp("horainicio").getTime()),new java.util.Date(rs.getTimestamp("horafin").getTime()),act);
				ret.add(dacti);
				
			}
			rs.close();
			stm.close();
		}
		catch(Throwable e){
			
		}
		return ret;
	}
	public int getDetalleActividadTotal(int idactividad){
		int temp=0;
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("SELECT ifnull(count(da.iddetalleactividad),0) cant FROM detalleactividad da  where da.actividadidactividad=?");
			stm.setInt(1,idactividad);
			ResultSet rs2=stm.executeQuery();
			if(rs2.next())
			temp=rs2.getInt("cant");
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return temp;
	}
	public int SafeActividadDetalle(int idactividad,java.util.Date fecha, java.util.Date horaInicio, java.util.Date horaFin){
		int temp=0;
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("select InsertarActividadFecha(?,?,?,?) result");
			stm.setInt(1, idactividad);
			stm.setDate(2, new java.sql.Date(fecha.getTime()));
			stm.setTimestamp(3,new java.sql.Timestamp(horaInicio.getTime()));
			stm.setTimestamp(4, new java.sql.Timestamp(horaFin.getTime()));
			
			ResultSet rs2=stm.executeQuery();
			if(rs2.next())
			temp=rs2.getInt("result");
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return temp;
	}
	public int DeleteActividadDetalle(int idactividad,ArrayList<Integer> detalleactividad){
		int cant=0;
		
		try {
		PreparedStatement stm;
		 for(int j=0; j<detalleactividad.size();j++){ 
			 stm = (PreparedStatement)conn.prepareStatement("DELETE FROM detalleactividad WHERE iddetalleactividad = ?");
				stm.setInt(1, detalleactividad.get(j));
			 if(stm.executeUpdate()>0)
				 cant++;
			 
		 }
		} catch (SQLException e) {

			e.printStackTrace();
		} 
		
		return cant;
	}
	public int DeleteActividadDetalle(int idactividad){
		int temp=0;
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("select EliminarDetalleActividad(?) result");
			stm.setInt(1, idactividad);
			ResultSet rs2=stm.executeQuery();
			if(rs2.next())
			temp=rs2.getInt("result");
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return temp;
	}
	public int DeleteActividad(int idactividad){
		int temp=0;
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("select EliminarActividad(?) result");
			stm.setInt(1, idactividad);
			ResultSet rs2=stm.executeQuery();
			if(rs2.next())
			temp=rs2.getInt("result");
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return temp;
	}
}
