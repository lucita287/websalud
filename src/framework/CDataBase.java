package framework;

import java.util.ArrayList;
import java.util.GregorianCalendar;
import java.sql.DriverManager;
import java.sql.ResultSet;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.PreparedStatement;

import data.CActividad;
import data.CArea;
import data.CCategoria_permiso;
import data.CConfiguracion;
import data.CContenido;
import data.CDetalleActividad;
import data.CEdificio;
import data.CEncabezado;
import data.CMultimedia;
import data.CMenu;
import data.CNoticia;
import data.CPermiso;
import data.CResponsable;
import data.CUsuario;

public class CDataBase {

	Connection conn = null;
	private String schema="websalud";
	private String user="root"; 
	private String pass="123456";
	private String host="localhost";
	private static String webhost="http://localhost:8080/";

	
	
	/**
	 * @return the webhost
	 */
	public static String getWebhost() {
		return webhost;
	}
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
	public Connection getconnection(){
		return conn;
	}
	public String ConvertString(ArrayList<Integer> lista){
		String data="";
		for(int i=0; i<lista.size();i++){
			 data+=((data.compareTo("")==0)?"":",");
			 data+="?";
		}
		return data;
		
	}
	public CUsuario getUsuario(String user){
		
		CUsuario temp=null;
		try{    
        	PreparedStatement stm=(PreparedStatement)conn.prepareStatement("SELECT idusuario, nombre, apellido, nick, password, telefono, email,  estado, ifnull(no_personal,'') no_personal FROM usuario where nick=? ");
        	stm.setString(1,user);
                ResultSet rs=stm.executeQuery();
                while(rs.next()){                							
                                temp=new CUsuario(rs.getInt("idusuario"),rs.getString("nombre"),rs.getString("apellido"),rs.getString("nick"),rs.getString("password"),rs.getString("telefono"),rs.getString("email"),rs.getInt("estado"),rs.getString("no_personal"));
                               
                }
                rs.close();
                stm.close();
		}catch(Throwable e){
			
			 CLogger.write("1", this, e);
		}
		return temp;
	}
	public ArrayList<CUsuario> getListaUsuarios(){
		ArrayList<CUsuario> lista=new ArrayList<CUsuario>();
		try{    
        	PreparedStatement stm=(PreparedStatement)conn.prepareStatement("SELECT idusuario, nombre, apellido, nick, telefono, email,  estado, ifnull(no_personal,'') no_personal FROM usuario where estado=1 ");
        	    ResultSet rs=stm.executeQuery();
                while(rs.next()){                	
                	CUsuario temp=new CUsuario(rs.getInt("idusuario"),rs.getString("nombre"),rs.getString("apellido"),rs.getString("nick"),"",rs.getString("telefono"),rs.getString("email"),rs.getInt("estado"),rs.getString("no_personal"));
                	lista.add(temp);           
                }
                rs.close();
                stm.close();
        }catch(Throwable e){
			
			 CLogger.write("2", this, e);
		}
		return lista;
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
		}catch(Throwable e){
			
			 CLogger.write("3", this, e);
		}
		
		return temp;
	}
	public ArrayList<CNoticia> getNoticias(){
		ArrayList<CNoticia> ret=new ArrayList<CNoticia>();
		try{
			String sql="SELECT noti.idnoticia, noti.titulo noti_titulo, noti.descripcion noti_descripcion,descripcion_corta, noti.areaidarea idarea, noti.fecha_inicio fecha_inicio, "+
"noti.fecha_fin fecha_fin, noti.prioridad prioridad, a.nombre nombre_area, m.idmultimedia idmultimedia, m.direccion direccion_m, m.direccion_relativa direccion_rel, m2.idmultimedia idmultimedia2, m2.direccion direccion_m2, m2.direccion_relativa direccion_rel2, noti.estado  "+
  "FROM noticia noti inner join area a on a.idarea=noti.areaidarea "+
  "left outer join multimedia m on noti.multimediaidmultimedia=m.idmultimedia "+
  "left outer join multimedia m2 on noti.multimediaidmultimedia_pdf=m2.idmultimedia "+
  "  where estado = 1 and fecha_inicio<=now() and adddate(fecha_fin,1)>=now()  order by prioridad desc ";
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			ResultSet rs=stm.executeQuery();
			while(rs.next()){
				CArea area=new CArea(rs.getInt("idarea"),rs.getString("nombre_area"),"",0,null,null,"");
				CMultimedia multi=new CMultimedia(rs.getInt("idmultimedia"),rs.getString("direccion_m"),rs.getString("direccion_rel"),0L,0,null);
				CMultimedia multi2=new CMultimedia(rs.getInt("idmultimedia2"),rs.getString("direccion_m2"),rs.getString("direccion_rel2"),0L,0,null);
				CNoticia news=new CNoticia(rs.getString("noti_titulo"),rs.getString("noti_descripcion"),rs.getString("descripcion_corta"),multi,
						new java.util.Date(rs.getDate("fecha_inicio").getTime()),new java.util.Date(rs.getDate("fecha_fin").getTime()),rs.getInt("prioridad"),rs.getInt("idnoticia"), rs.getInt("estado"),area,multi2);
				ret.add(news);
				
			}
			rs.close();
			stm.close();
		}catch(Throwable e){
			
			 CLogger.write("4", this, e);
		}
		return ret;
	}
	public CMenu getMenuEspecifico(int idmenu){
		CMenu temp_menu=null;
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("SELECT m.idmenu,m.descripcion,ifnull(m.areaidarea,0) areaidarea,m.contenido, ifnull(m.idmenu_rec,0) idmenu_rec, m.size, a.nombre area_nombre, m.estado estado_menu FROM menu m inner join area a on a.idarea=m.areaidarea where  idmenu=? ");
			stm.setInt(1, idmenu);
			ResultSet rs2=stm.executeQuery();
			if(rs2.next()){
				CArea temp_c=new CArea(rs2.getInt("areaidarea"),rs2.getString("area_nombre"),"", 0,null,null,"");
						//this.getCAreaEspecifico(rs2.getInt("areaidarea"));
				CMenu temp_menu1=(rs2.getInt("idmenu")!=0)?getMenuEspecifico(rs2.getInt("idmenu_rec")):null;
				temp_menu=new CMenu( rs2.getInt("idmenu"),rs2.getString("descripcion"),temp_c,rs2.getString("contenido"),rs2.getInt("size"),temp_menu1,rs2.getInt("estado_menu"));
			}
		}catch(Throwable e){
			
			 CLogger.write("5", this, e);
		}
		
		return temp_menu;
	}
	public CArea getCAreaEspecifico(int idarea){
		CArea temp=null;
		PreparedStatement stm;
		try {
			
			String sql="SELECT a.idarea,a.nombre, ifnull(a.descripcion,' ') descripcion,a.size , ifnull(a.areaidarea,0) areaidarea , ifnull(m.idmultimedia,0) idmultimedia , "
					+" ifnull(m.direccion,'') direccion, ifnull(m.direccion_relativa,'No se ha seleccionado Imagen') direccion_relativa, ifnull (a.areaidarea,0 ) areaidarea, ifnull ((select ar.nombre rec_nomb from area ar where ar.idarea=a.areaidarea),'') rec_nombre, ifnull(a.html_adicional,'') html_adicional "
					+" FROM area a left outer join multimedia m on a.multimediaidmultimedia=m.idmultimedia " 
					+" where  a.idarea=? ";
			stm = (PreparedStatement)conn.prepareStatement(sql);
			stm.setInt(1, idarea);
			ResultSet rs=stm.executeQuery();
			if(rs.next()){
				CMultimedia multi=new CMultimedia(rs.getInt("idmultimedia"),rs.getString("direccion"),rs.getString("direccion_relativa"),0L,1,null);
            	CArea sarea=new CArea( rs.getInt("areaidarea"),rs.getString("rec_nombre"),"",0,null,null,"");
            	temp=new CArea( rs.getInt("idarea"),rs.getString("nombre"),rs.getString("descripcion"),rs.getInt("size"),multi,sarea,rs.getString("html_adicional"));
            	
			}
		}catch(Throwable e){
			
			 CLogger.write("6", this, e);
		}
		return temp;
	}
	
	
	public ArrayList<CMenu> getMenu(int area){
		ArrayList<CMenu> ret=new ArrayList<CMenu>();
		try{
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement("SELECT m.idmenu,m.descripcion, m.areaidarea ,m.contenido,m.size , a.nombre area_nombre,m.estado estado_menu  FROM menu m inner join area a  on a.idarea=m.areaidarea  where m.areaidarea=? and  idmenu_rec is null and m.estado=1 ");
			stm.setInt(1, area);
			ResultSet rs=stm.executeQuery();
			while(rs.next()){
				CMenu temp_menu=null;
				
				PreparedStatement stm2=(PreparedStatement)conn.prepareStatement("SELECT m.idmenu,m.descripcion,m.areaidarea,m.contenido,m.size, m.idmenu_rec, a.nombre area_nombre,m.estado estado_menu  FROM menu m inner join area a on a.idarea=m.areaidarea where  idmenu_rec=?  and m.estado=1 ");
				stm2.setInt(1, rs.getInt("idmenu"));
				ResultSet rs2=stm2.executeQuery();
				ArrayList<CMenu> temp_list=new ArrayList<CMenu>();
				while(rs2.next()){
					CArea temp_c=new CArea( rs.getInt("areaidarea"),rs.getString("area_nombre"),"",0,null,null,"");
							//this.getCAreaEspecifico(rs2.getInt("areaidarea"));
					CMenu temp_menu1=null;
					CMenu temp_menu2=null;
					temp_menu1=new CMenu( rs2.getInt("idmenu"),rs2.getString("descripcion"),temp_c,rs2.getString("contenido"),rs2.getInt("size"),temp_menu2,rs2.getInt("estado_menu"));
					temp_list.add(temp_menu1);
				}
				//CArea temp_c1=this.getCAreaEspecifico(rs.getInt("areaidarea"));
				CArea temp_c1=new CArea( rs.getInt("areaidarea"),rs.getString("area_nombre"),"",0,null,null,"");
				temp_menu=new CMenu( rs.getInt("idmenu"),rs.getString("descripcion"),temp_c1,rs.getString("contenido"),rs.getInt("size"),temp_list,rs.getInt("estado_menu"));
				ret.add(temp_menu);
				
			}
			rs.close();
			stm.close();
		}catch(Throwable e){
			
			 CLogger.write("7", this, e);
		}
		return ret;
	}
	public boolean UpdateMenu(CMenu menu){
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("UPDATE menu SET descripcion = ?, areaidarea = ?, contenido = ?, idmenu_rec = ?, size= ?,estado=? WHERE idmenu=?");
			
			stm.setString(1, menu.getdescripcion());
			stm.setInt(2, menu.getareaidarea().getidarea());
			stm.setString(3, menu.getcontenido());
			
			if(menu.getidmenu_rec()==null){
				stm.setNull(4,java.sql.Types.INTEGER);
			}else {
				stm.setInt(4, menu.getidmenu_rec().getidmenu());
			}
			stm.setInt(5,menu.getsize());
			stm.setInt(6,menu.getEstado());
			stm.setInt(7,menu.getidmenu());
			if(stm.executeUpdate()>0)
				return true;
			
		}catch(Throwable e){
			
			 CLogger.write("8", this, e);
		}
		
		return false;
	}
	public boolean SafeMenu(CMenu menu){
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("INSERT INTO menu (descripcion,areaidarea,contenido,idmenu_rec,size,estado)VALUES (?,?,?,?,?,?)");
			
			stm.setString(1, menu.getdescripcion());
			stm.setInt(2, menu.getareaidarea().getidarea());
			stm.setString(3, menu.getcontenido());
			
			if(menu.getidmenu_rec()==null){
				stm.setNull(4,java.sql.Types.INTEGER);
			}else {
				stm.setInt(4, menu.getidmenu_rec().getidmenu());
			}
			stm.setInt(5,menu.getsize());
			stm.setInt(6, menu.getEstado());
			if(stm.executeUpdate()>0)
				return true;
			
		}catch(Throwable e){
			
			 CLogger.write("9", this, e);
		}
		
		return false;
	}
	public ArrayList<CMenu> getMenuLista(int min,int max,int type,String busqueda ,int ordenar,int asc,ArrayList<Integer> lista){
		ArrayList<CMenu> ret=new ArrayList<CMenu>();
		if(lista.size()>0){
        try{
                String query="select * from "
                                +"(SELECT @rownum:=@rownum+1 rownum, m.idmenu,m.descripcion, '' contenido,ifnull(m.idmenu_rec,0) idmenu_rec,  m.size,"
                                +"a.idarea,a.nombre nombre_area,IF(idmenu_rec is null,'',(select descripcion from menu where idmenu=m.idmenu_rec) ) descripcion_menu, m.estado estado_menu "
                                +"FROM menu m, (SELECT @rownum:=0) ro, area a  "
                                +"where a.idarea=m.areaidarea and"
                                +" upper("+(type==1?"m.descripcion":"a.nombre")+") like ?  and a.idarea in ("+ConvertString(lista)+")"
                                +") data "
                                +"where  rownum>=? and rownum<=? ORDER BY ? "+((asc==1)?"ASC":"DESC");
                
                		PreparedStatement stm=(PreparedStatement)conn.prepareStatement(query);
                
                stm.setString(1,"%"+busqueda.trim().toUpperCase()+"%");
                int id=2;
                
                for(int i=0; i<lista.size();i++){
                	stm.setInt(id++, lista.get(i));
                }
                stm.setInt(id++, min);
                stm.setInt(id++, max);
                stm.setInt(id++, ordenar);
                ResultSet rs=stm.executeQuery();
                while(rs.next()){
                                                ArrayList<CMenu> templist=null;
                                                
                                CMenu temp=new CMenu(rs.getInt("idmenu_rec"),rs.getString("descripcion_menu"),null,"",0,templist,0);
                                
                                CArea temp_c=new CArea(rs.getInt("idarea"),rs.getString("nombre_area"),"",0,null,null,"");
                                CMenu temp_menu=new CMenu( rs.getInt("idmenu"),rs.getString("descripcion"),temp_c,rs.getString("contenido"),rs.getInt("size"),temp,rs.getInt("estado_menu"));
                                ret.add(temp_menu);                        
                }
                rs.close();
                stm.close();
        }catch(Throwable e){
			
			 CLogger.write("10", this, e);
		}
		}
        return ret;
	}
	
	public int getCMenuTotal(int type,String busqueda,ArrayList<Integer> lista){
		int temp=0;
		if(lista.size()>0){
		try {
			String query="";
        		query="select count(m.idmenu) cant from "
				+" menu m , area a  "
				+"where m.areaidarea=a.idarea and upper("+(type==1?"m.descripcion":"a.nombre")+") like ? and a.idarea in ("+ConvertString(lista)+")";
        		
			
	                PreparedStatement stm=(PreparedStatement)conn.prepareStatement(query);
	                stm.setString(1,"%"+busqueda.toUpperCase().trim()+"%");
	                int id=2;
	                for(int i=0; i<lista.size();i++){
	                	stm.setInt(id++, lista.get(i));
	                }
			ResultSet rs2=stm.executeQuery();
			if(rs2.next())
			temp=rs2.getInt("cant");
		}catch(Throwable e){
			
			 CLogger.write("11", this, e);
		}
		}
		return temp;
	}
	

	public ArrayList<CArea> getAreaLista(){
        ArrayList<CArea> ret=new ArrayList<CArea>();
        try{
        	String sql="SELECT a.idarea,a.nombre, ifnull(a.descripcion,'') descripcion,a.size , ifnull(a.areaidarea,0) areaidarea , m.idmultimedia, "+
        				"m.direccion, m.direccion_relativa, ifnull (a.areaidarea,0 ) areaidarea, ifnull ((select ar.nombre rec_nomb from area ar where ar.idarea=a.areaidarea),'') rec_nombre, ifnull(html_adicional,'') html_adicional " +
        				"FROM area a left outer join multimedia m on a.multimediaidmultimedia=m.idmultimedia" ;
                PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
                ResultSet rs=stm.executeQuery();
                while(rs.next()){
                	CMultimedia multi=new CMultimedia(rs.getInt("idmultimedia"),rs.getString("direccion"),rs.getString("direccion_relativa"),0L,1,null);
                	CArea sarea=new CArea( rs.getInt("areaidarea"),rs.getString("rec_nombre"),"",0,null,null,rs.getString("html_adicional"));
                	
                	CArea temp=new CArea( rs.getInt("idarea"),rs.getString("nombre"),rs.getString("descripcion"),rs.getInt("size"),multi,sarea,"");
                	ret.add(temp);
                        
                }
                rs.close();
                stm.close();
        }catch(Throwable e){
			
			 CLogger.write("12", this, e);
		}
        return ret;
	}
	public ArrayList<CArea> getAreaLista(ArrayList<Integer> lista){
        ArrayList<CArea> ret=new ArrayList<CArea>();
        if(lista.size()>0){
        try{
        	
        	String sql="SELECT a.idarea,a.nombre, ifnull(a.descripcion,'') descripcion,a.size , ifnull(a.areaidarea,0) areaidarea , m.idmultimedia, "+
    				"m.direccion, m.direccion_relativa, ifnull (a.areaidarea,0 ) areaidarea, ifnull ((select ar.nombre rec_nomb from area ar where ar.idarea=a.areaidarea),'') rec_nombre, ifnull(html_adicional,'') html_adicional " +
    				"FROM area a left outer join multimedia m on a.multimediaidmultimedia=m.idmultimedia " +
    				" where a.idarea in  ("+this.ConvertString(lista)+")";

                PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
                int id=1;
                for(int i=0; i<lista.size();i++){
                	stm.setInt(id++, lista.get(i));
                }
                ResultSet rs=stm.executeQuery();
                while(rs.next()){
                	CMultimedia multi=new CMultimedia(rs.getInt("idmultimedia"),rs.getString("direccion"),rs.getString("direccion_relativa"),0L,1,null);
                	CArea sarea=new CArea( rs.getInt("areaidarea"),rs.getString("rec_nombre"),"",0,null,null,"");
                	CArea temp=new CArea( rs.getInt("idarea"),rs.getString("nombre"),rs.getString("descripcion"),rs.getInt("size"),multi,sarea,rs.getString("html_adicional"));
                	ret.add(temp);
                        
                }
                rs.close();
                stm.close();
        }catch(Throwable e){
			
			 CLogger.write("13", this, e);
		}
        }
        return ret;
	}
	public ArrayList<Integer> getAreaListaInt(int idusuario){
        ArrayList<Integer> ret=new ArrayList<Integer>();
        try{
        	String sql="SELECT a.idarea from area a inner join area_usuario au on au.areaidarea=a.idarea where au.usuarioidusuario=?" ;
                PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
                stm.setInt(1,idusuario);
                ResultSet rs=stm.executeQuery();
                
                while(rs.next()){
                	ret.add(rs.getInt("idarea"));    
                }
                rs.close();
                stm.close();
        }catch(Throwable e){
			
			 CLogger.write("14", this, e);
		}
        return ret;
	}
	public ArrayList<Integer> getAreaListaInt(){
        ArrayList<Integer> ret=new ArrayList<Integer>();
        try{
        	String sql="SELECT a.idarea from area a " ;
                PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
                ResultSet rs=stm.executeQuery();
                
                while(rs.next()){
                	ret.add(rs.getInt("idarea"));    
                }
                rs.close();
                stm.close();
        }catch(Throwable e){
			
			 CLogger.write("15", this, e);
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
        			CArea temp=new CArea( rs2.getInt("idarea"),rs2.getString("nombre"),"",0,null,null,"");
                	ret.add(temp);
                        
                }
                rs2.close();
                stm.close();
        }catch(Throwable e){
			
			 CLogger.write("16", this, e);
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
                	CArea temp=new CArea( rs2.getInt("idarea"),rs2.getString("nombre"),"",0,null,null,"");
                	ret.add(temp);
                        
                }
                rs2.close();
                stm.close();
        }catch(Throwable e){
			
			 CLogger.write("17", this, e);
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
		}catch(Throwable e){
			
			 CLogger.write("18", this, e);
		}
		
		return temp;
	}
	public int getMultimediaTotal(){
		int temp=0;
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("SELECT ifnull(count(idmultimedia),0)+1 cant  FROM multimedia");
			ResultSet rs2=stm.executeQuery();
			if(rs2.next())
			temp=rs2.getInt("cant");
		}catch(Throwable e){
			
			 CLogger.write("19", this, e);
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
			
		}catch(Throwable e){
			
			 CLogger.write("20", this, e);
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
		}catch(Throwable e){
			
			 CLogger.write("21", this, e);
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
		}catch(Throwable e){
			
			 CLogger.write("22", this, e);
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
			
		}catch(Throwable e){
			
			 CLogger.write("23", this, e);
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
		} catch(Throwable e){
			
			 CLogger.write("24", this, e);
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
        }catch(Throwable e){
			
			 CLogger.write("25", this, e);
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
        }catch(Throwable e){
			
			 CLogger.write("26", this, e);
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
			
		} catch(Throwable e){
			
			 CLogger.write("27", this, e);
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
		}catch(Throwable e){
			
			 CLogger.write("28", this, e);
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
		}catch(Throwable e){
			
			 CLogger.write("29", this, e);
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
			
		}catch(Throwable e){
			
			 CLogger.write("30", this, e);
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
                        CArea temp=new CArea(rs.getInt("idarea"),rs.getString("nombre"),rs.getString("descripcion"),rs.getInt("size"),temp_mult,null,"");
                        CEncabezado encabezado=new CEncabezado(temp,temp_mult);
                        ret.add(encabezado);
                        
                }
                rs.close();
                stm.close();
        }catch(Throwable e){
			
			 CLogger.write("31", this, e);
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
			
		}catch(Throwable e){
			
			 CLogger.write("32", this, e);
		}
		
		return false;
	}
	public boolean deleteEncabezado(int idarea,ArrayList<Integer> lista){
		
		if(lista.size()>0){
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("DELETE FROM encabezado   WHERE areaidarea = ?  and multimediaidmultimedia in ( "+this.ConvertString(lista)+")");
			int id=1;
			stm.setInt(id++, idarea);
			
			for(int i=0; i<lista.size();i++){
				
            	stm.setInt(id++, lista.get(i));
            }
			if(stm.executeUpdate()>0)
				return true;
		}catch(Throwable e){
			
			 CLogger.write("33", this, e);
		}
		}
		return false;
	}
	public ArrayList<CNoticia> getListaNoticias(int ordenar,int asc,int min,int max,int type, String busqueda,ArrayList<Integer> lista){
		ArrayList<CNoticia> ret=new ArrayList<CNoticia>();
		if(lista.size()>0){
		try{
			String sql="select * from (SELECT noti.idnoticia, noti.titulo noti_titulo, noti.descripcion noti_descripcion,descripcion_corta, noti.areaidarea idarea, noti.fecha_inicio fecha_inicio, "+
						"noti.fecha_fin fecha_fin, noti.prioridad prioridad, a.nombre nombre_area, m.idmultimedia idmultimedia, m.direccion direccion_m, m.direccion_relativa direccion_rel, m2.idmultimedia idmultimedia2, m2.direccion direccion_m2, m2.direccion_relativa direccion_rel2, noti.estado, @rownum:=@rownum+1 rownum  "+
						"FROM noticia noti inner join area a on a.idarea=noti.areaidarea "+
						"left outer join multimedia m on noti.multimediaidmultimedia=m.idmultimedia "+
						"left outer join multimedia m2 on noti.multimediaidmultimedia_pdf=m2.idmultimedia "+
						" , (SELECT @rownum:=0) ro "+
						"where  upper("+(type==1?"noti.titulo":"a.nombre")+") like ? "+
						" and noti.areaidarea in ("+this.ConvertString(lista)+") "+
						" ) table1 "+
						" where rownum>=? and rownum<=? order by ? "+((asc==1)?"ASC":"DESC") +"";
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			int id=1;
			stm.setString(id++,"%"+busqueda.trim().toUpperCase()+"%");
			for(int i=0; i<lista.size();i++){
            	stm.setInt(id++, lista.get(i));
            }
			stm.setInt(id++,min);
			stm.setInt(id++,max);
			stm.setInt(id++,ordenar);
			ResultSet rs=stm.executeQuery();
			while(rs.next()){
				CArea area=new CArea(rs.getInt("idarea"),rs.getString("nombre_area"),"",0,null,null,"");
				CMultimedia multi=new CMultimedia(rs.getInt("idmultimedia"),rs.getString("direccion_m"),rs.getString("direccion_rel"),0L,0,null);
				CMultimedia multi2=new CMultimedia(rs.getInt("idmultimedia2"),rs.getString("direccion_m2"),rs.getString("direccion_rel2"),0L,0,null);
				CNoticia news=new CNoticia(rs.getString("noti_titulo"),rs.getString("noti_descripcion"),rs.getString("descripcion_corta"),multi,
						new java.util.Date(rs.getDate("fecha_inicio").getTime()),new java.util.Date(rs.getDate("fecha_fin").getTime()),rs.getInt("prioridad"),rs.getInt("idnoticia"),rs.getInt("estado"),area,multi2);;
				ret.add(news);
				
			}
			rs.close();
			stm.close();
		}catch(Throwable e){
			
			 CLogger.write("34", this, e);
		}
		}
		return ret;
	}
	

	public int getNoticiasTotal(int type,String busqueda,ArrayList<Integer> lista){
		int temp=0;
		if(lista.size()>0){
				try {
					String sql="SELECT count(*) cant FROM noticia noti inner join area a on a.idarea=noti.areaidarea "+
							" where  upper("+(type==1?"noti.titulo":"a.nombre")+") like ? and  a.idarea in ("+this.ConvertString(lista)+") ";
					PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
					int id=1;
					stm.setString(id++,"%"+busqueda.trim().toUpperCase()+"%");
					for(int i=0; i<lista.size();i++){
		            	stm.setInt(id++, lista.get(i));
		            }
					ResultSet rs2=stm.executeQuery();
					if(rs2.next())
					temp=rs2.getInt("cant");
				}catch(Throwable e){
					
					 CLogger.write("35", this, e);
				}
		}
		return temp;
	}
	public boolean SafeNoticia(CNoticia noti){
		PreparedStatement stm;
		try {

			stm = (PreparedStatement)conn.prepareStatement("INSERT INTO noticia   (titulo, descripcion, areaidarea, fecha_inicio, fecha_fin, prioridad, multimediaidmultimedia,descripcion_corta,estado,multimediaidmultimedia_pdf)  VALUES    (?,    ?,    ?,    ?,    ?,    ?,    ?,   ?,  ?,  ?)");
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
			if(noti.getMultimediaidmultimedia_pdf()!=null &&noti.getMultimediaidmultimedia_pdf().getidimagen()>0){
				stm.setInt(10,noti.getMultimediaidmultimedia_pdf().getidimagen());
			}else stm.setNull(10, java.sql.Types.INTEGER);
			if(stm.executeUpdate()>0)
				return true;
			
		}catch(Throwable e){
			
			 CLogger.write("36", this, e);
		}
		
		return false;
	}
	public CNoticia getNoticiaEspecifica(int idnoticia){
		CNoticia news=null;
		try{
			String sql="SELECT noti.idnoticia, noti.titulo noti_titulo, noti.descripcion noti_descripcion, noti.descripcion_corta, noti.areaidarea idarea, noti.fecha_inicio fecha_inicio, "+
"noti.fecha_fin fecha_fin, noti.prioridad prioridad, noti.estado, a.nombre nombre_area, ifnull( m.idmultimedia,0) idmultimedia, ifnull(m.direccion,'') direccion_m, ifnull(m.direccion_relativa,'NO SE HA SUBIDO IMAGEN') direccion_rel,  ifnull( m2.idmultimedia,0) idmultimedia2, ifnull(m2.direccion,'') direccion_m2, ifnull(m2.direccion_relativa,'NO SE HA SUBIDO IMAGEN') direccion_rel2  "+
  "FROM noticia noti inner join area a on a.idarea=noti.areaidarea "+
  "left outer join multimedia m on noti.multimediaidmultimedia=m.idmultimedia "+
  "left outer join multimedia m2 on noti.multimediaidmultimedia_pdf=m2.idmultimedia "+
  "where noti.idnoticia=?  ";
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			stm.setInt(1,idnoticia);
			ResultSet rs=stm.executeQuery();
			if(rs.next()){
				CArea area=new CArea(rs.getInt("idarea"),rs.getString("nombre_area"),"",0,null,null,"");
				CMultimedia multi=new CMultimedia(rs.getInt("idmultimedia"),rs.getString("direccion_m"),rs.getString("direccion_rel"),0L,0,null);
				CMultimedia multi2=new CMultimedia(rs.getInt("idmultimedia2"),rs.getString("direccion_m2"),rs.getString("direccion_rel2"),0L,0,null);
				news=new CNoticia(rs.getString("noti_titulo"),rs.getString("noti_descripcion"),rs.getString("descripcion_corta"),multi,
						new java.util.Date(rs.getDate("fecha_inicio").getTime()),new java.util.Date(rs.getDate("fecha_fin").getTime()),rs.getInt("prioridad"),rs.getInt("idnoticia"),rs.getInt("estado"),area,multi2);
				
			}
			rs.close();
			stm.close();
		}catch(Throwable e){
			
			 CLogger.write("37", this, e);
		}
		return news;
	}
	public CNoticia getNoticiaEspecificaV(int idnoticia){
		CNoticia news=null;
		try{
			String sql="SELECT noti.idnoticia, noti.titulo noti_titulo, noti.descripcion noti_descripcion, noti.descripcion_corta, noti.areaidarea idarea, noti.fecha_inicio fecha_inicio, "+
"noti.fecha_fin fecha_fin, noti.prioridad prioridad, noti.estado, a.nombre nombre_area, ifnull( m.idmultimedia,0) idmultimedia, ifnull(m.direccion,'') direccion_m, ifnull(m.direccion_relativa,'NO SE HA SUBIDO IMAGEN') direccion_rel, ifnull( m2.idmultimedia,0) idmultimedia2, ifnull(m2.direccion,'') direccion_m2, ifnull(m2.direccion_relativa,'NO SE HA SUBIDO IMAGEN') direccion_rel2   "+
  "FROM noticia noti inner join area a on a.idarea=noti.areaidarea "+
  "left outer join multimedia m on noti.multimediaidmultimedia=m.idmultimedia "+
  "left outer join multimedia m2 on noti.multimediaidmultimedia_pdf=m2.idmultimedia "+
  "where noti.idnoticia=? and noti.estado=1  ";
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			stm.setInt(1,idnoticia);
			ResultSet rs=stm.executeQuery();
			if(rs.next()){
				CArea area=new CArea(rs.getInt("idarea"),rs.getString("nombre_area"),"",0,null,null,"");
				CMultimedia multi=new CMultimedia(rs.getInt("idmultimedia"),rs.getString("direccion_m"),rs.getString("direccion_rel"),0L,0,null);
				CMultimedia multi2=new CMultimedia(rs.getInt("idmultimedia2"),rs.getString("direccion_m2"),rs.getString("direccion_rel2"),0L,0,null);
				news=new CNoticia(rs.getString("noti_titulo"),rs.getString("noti_descripcion"),rs.getString("descripcion_corta"),multi,
						new java.util.Date(rs.getDate("fecha_inicio").getTime()),new java.util.Date(rs.getDate("fecha_fin").getTime()),rs.getInt("prioridad"),rs.getInt("idnoticia"),rs.getInt("estado"),area,multi2);
				
			}
			rs.close();
			stm.close();
		}catch(Throwable e){
			
			 CLogger.write("38", this, e);
		}
		return news;
	}
	public boolean UpdateNoticia(CNoticia noti){
		PreparedStatement stm;
		try {
			String sql="UPDATE noticia SET   titulo = ?, descripcion = ?, areaidarea = ?, fecha_inicio = ?, fecha_fin = ?, prioridad = ?,   multimediaidmultimedia = ?, descripcion_corta=?, estado=?, multimediaidmultimedia_pdf=?  WHERE  idnoticia = ?";
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
			if(noti.getMultimediaidmultimedia_pdf()!=null &&noti.getMultimediaidmultimedia_pdf().getidimagen()>0){
				stm.setInt(10,noti.getMultimediaidmultimedia_pdf().getidimagen());
			}else stm.setNull(10, java.sql.Types.INTEGER);
			stm.setInt(11,noti.getIdnoticia());
			
			
			if(stm.executeUpdate()>0)
				return true;
			
		}catch(Throwable e){
			
			 CLogger.write("39", this, e);
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
						"@rownum:=@rownum+1 rownum, idusuario,nombre,apellido,nick,telefono,email,estado, ifnull(no_personal,'') no_personal "+ 
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
				CUsuario user=new CUsuario(rs.getInt("idusuario"),rs.getString("nombre"),rs.getString("apellido"),rs.getString("nick"),"",rs.getString("telefono"),rs.getString("email"),rs.getInt("estado"),rs.getString("no_personal"));
				ret.add(user);
				
			}
			rs.close();
			stm.close();
		}catch(Throwable e){
			
			 CLogger.write("40", this, e);
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
				+" usuario m "
				+"where  upper("+pqtype+") like ?";
        		
			
	                PreparedStatement stm=(PreparedStatement)conn.prepareStatement(query);
	                stm.setString(1,"%"+busqueda.toUpperCase().trim()+"%");
	                
			ResultSet rs2=stm.executeQuery();
			if(rs2.next())
			temp=rs2.getInt("cant");
		}catch(Throwable e){
			
			 CLogger.write("41", this, e);
		}
		
		return temp;
	}
	public CUsuario getUsuarioEspecifico(int iduser){
		CUsuario temp=null;
		try{    
        	PreparedStatement stm=(PreparedStatement)conn.prepareStatement("SELECT idusuario, nombre, apellido, nick,  telefono, email, estado, ifnull(no_personal,'') no_personal FROM usuario where idusuario=? ");
        	stm.setInt(1,iduser);
                ResultSet rs=stm.executeQuery();
                while(rs.next()){
                				temp=new CUsuario(rs.getInt("idusuario"),rs.getString("nombre"),rs.getString("apellido"),rs.getString("nick"),"",rs.getString("telefono"),rs.getString("email"),rs.getInt("estado"),rs.getString("no_personal"));
                               
                }
                rs.close();
                stm.close();
        }catch(Throwable e){
			
			 CLogger.write("42", this, e);
		}
		return temp;
	}
	public boolean UpdateUsuario(CUsuario user){
		PreparedStatement stm;
		try {
		String sql="";	
			if(user.getpassword().compareTo("")==0){
				sql="UPDATE  usuario SET  nombre  = ?, apellido  = ?,  telefono  = ?, email  = ?, no_personal  = ?,  updateusuario =? WHERE idusuario=?";
				stm = (PreparedStatement)conn.prepareStatement(sql);
				stm.setString(1, user.getnombre());
				stm.setString(2, user.getapellido());
				stm.setString(3, user.gettelefono());
				stm.setString(4, user.getemail());
				stm.setString(5, user.getNo_personal());
				stm.setInt(6, user.getidusuario());
				stm.setInt(7,user.getidusuario());
			}else{
				sql="UPDATE  usuario SET  nombre  = ?, apellido  = ?,  password  = ?, telefono  = ?, email  = ?, no_personal  = ?,  updateusuario =? WHERE idusuario=?";	
				stm = (PreparedStatement)conn.prepareStatement(sql);
				stm.setString(1, user.getnombre());
				stm.setString(2, user.getapellido());
				stm.setString(3, user.getpassword());
				stm.setString(4, user.gettelefono());
				stm.setString(5, user.getemail());
				stm.setString(6, user.getNo_personal());
				stm.setInt(7, user.getidusuario());
				stm.setInt(8,user.getidusuario());
			}
			
			if(stm.executeUpdate()>0)
				return true;
			
		}catch(Throwable e){
			
			 CLogger.write("43", this, e);
		}
		
		return false;
	}
	
	public boolean UpdateUsuario(CUsuario user,int idusuario){
		PreparedStatement stm;
		try {
		String sql="";	
			if(user.getpassword().compareTo("")==0){
				sql="UPDATE  usuario SET  nombre  = ?, apellido  = ?, nick  = ?,  telefono  = ?, email  = ?, no_personal  = ?,  updateusuario =?, estado=? WHERE idusuario=?";
				stm = (PreparedStatement)conn.prepareStatement(sql);
				stm.setString(1, user.getnombre());
				stm.setString(2, user.getapellido());
				stm.setString(3, user.getnick());
				stm.setString(4, user.gettelefono());
				stm.setString(5, user.getemail());
				stm.setString(6, user.getNo_personal());
				stm.setInt(7, idusuario);
				stm.setInt(8, user.getEstado());
				stm.setInt(9,user.getidusuario());
			}else{
				sql="UPDATE  usuario SET  nombre  = ?, apellido  = ?, nick  = ?, password  = ?, telefono  = ?, email  = ?, no_personal  = ?,  updateusuario =?, estado=? WHERE idusuario=?";	
				stm = (PreparedStatement)conn.prepareStatement(sql);
				stm.setString(1, user.getnombre());
				stm.setString(2, user.getapellido());
				stm.setString(3, user.getnick());
				stm.setString(4, user.getpassword());
				stm.setString(5, user.gettelefono());
				stm.setString(6, user.getemail());
				stm.setString(7, user.getNo_personal());
				stm.setInt(8, idusuario);
				stm.setInt(9, user.getEstado());
				stm.setInt(10,user.getidusuario());
			}
			
			if(stm.executeUpdate()>0)
				return true;
			
		}catch(Throwable e){
			
			 CLogger.write("44", this, e);
		}
		
		return false;
	}
	public boolean SafeUser(CUsuario user,int idusuario){
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("INSERT INTO usuario (nombre,apellido,nick,password,telefono,email,no_personal,estado,updateusuario) VALUES (?,?,?,?,?,?,?,?,?)");
			
			stm.setString(1,user.getnombre());
			stm.setString(2, user.getapellido());
			stm.setString(3, user.getnick());
			stm.setString(4, user.getpassword());
			stm.setString(5, user.gettelefono());
			stm.setString(6, user.getemail());
			stm.setString(7, user.getNo_personal());
			stm.setInt(8, user.getEstado());
			stm.setInt(9, idusuario);
			if(stm.executeUpdate()>0)
				return true;
			
		}catch(Throwable e){
			
			 CLogger.write("45", this, e);
		}
		
		return false;
	}
public ArrayList<CCategoria_permiso> getListaCategoriaPermisos(){
	ArrayList<CCategoria_permiso> list=new ArrayList<CCategoria_permiso>();
	try{
    	String sql="SELECT cp.idcategoria_permiso, cp.nombre FROM categoria_permiso cp ";
            PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
            ResultSet rs=stm.executeQuery();
            while(rs.next()){
            		CCategoria_permiso cp=new CCategoria_permiso(rs.getInt("idcategoria_permiso"),rs.getString("nombre"));
            		list.add(cp);
                    
            }
            rs.close();
            stm.close();
    }catch(Throwable e){
		
		 CLogger.write("46", this, e);
	}
    return list;
    
}
public ArrayList<CPermiso> getListaPermiso(){
		
		
		ArrayList<CPermiso> ret=new ArrayList<CPermiso>();
        try{
        	String sql="SELECT p.idpermiso, p.descripcion, cp.idcategoria_permiso, cp.nombre FROM permiso p inner join categoria_permiso cp on p.idcategoria_permiso=cp.idcategoria_permiso ";
                PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
                ResultSet rs=stm.executeQuery();
                while(rs.next()){
                		CCategoria_permiso cp=new CCategoria_permiso(rs.getInt("idcategoria_permiso"),rs.getString("nombre"));
                		CPermiso permiso=new CPermiso(rs.getInt("idpermiso"),rs.getString("descripcion"),cp);
                        ret.add(permiso);
                        
                }
                rs.close();
                stm.close();
        }catch(Throwable e){
			
			 CLogger.write("47", this, e);
		}
        return ret;
	}
public ArrayList<CPermiso> getListaPermisoCate(int idcategoria){
	
	
	ArrayList<CPermiso> ret=new ArrayList<CPermiso>();
    try{
    	String sql="SELECT p.idpermiso, p.descripcion, cp.idcategoria_permiso, cp.nombre FROM   permiso p inner join categoria_permiso cp on p.idcategoria_permiso=cp.idcategoria_permiso where cp.idcategoria_permiso = ?";
            PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
            stm.setInt(1, idcategoria);
            ResultSet rs=stm.executeQuery();
            while(rs.next()){
            	CCategoria_permiso cp=new CCategoria_permiso(rs.getInt("idcategoria_permiso"),rs.getString("nombre"));
            		CPermiso permiso=new CPermiso(rs.getInt("idpermiso"),rs.getString("descripcion"),cp);
                    ret.add(permiso);
                    
            }
            rs.close();
            stm.close();
    }catch(Throwable e){
		
		 CLogger.write("48", this, e);
	}
    return ret;
}
public ArrayList<CPermiso> getListaPermiso(int idusuario){
	
	
	ArrayList<CPermiso> ret=new ArrayList<CPermiso>();
    try{
    	String sql="SELECT p.idpermiso, p.descripcion, cp.idcategoria_permiso, cp.nombre FROM usuario_permisos up inner join  permiso p on p.idpermiso=up.permisosidpermiso inner join categoria_permiso cp on p.idcategoria_permiso=cp.idcategoria_permiso where usuarioidusuario = ?";
            PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
            stm.setInt(1, idusuario);
            ResultSet rs=stm.executeQuery();
            while(rs.next()){
            	CCategoria_permiso cp=new CCategoria_permiso(rs.getInt("idcategoria_permiso"),rs.getString("nombre"));
            		CPermiso permiso=new CPermiso(rs.getInt("idpermiso"),rs.getString("descripcion"),cp);
                    ret.add(permiso);
                    
            }
            rs.close();
            stm.close();
    }catch(Throwable e){
		
		 CLogger.write("49", this, e);
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
    }catch(Throwable e){
		
		 CLogger.write("50", this, e);
	}
    return ret;
}

public boolean safePermisoUsuario(int idusuario,ArrayList<Integer> list,ArrayList<Integer> areas){
	PreparedStatement stm;
	boolean b=true;
	try {
		
		stm = (PreparedStatement)conn.prepareStatement("DELETE FROM usuario_permisos WHERE  usuarioidusuario=?");
		stm.setInt(1, idusuario);
		 stm.executeUpdate();
	 
		 		
		stm = (PreparedStatement)conn.prepareStatement("DELETE FROM area_usuario WHERE  usuarioidusuario = ?");
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
		 for(int j=0; j<areas.size();j++){ 
			 stm = (PreparedStatement)conn.prepareStatement("INSERT INTO area_usuario (usuarioidusuario,areaidarea) VALUES   (?,   ?)");
				stm.setInt(1, idusuario);
				stm.setInt(2, areas.get(j));
			 if(stm.executeUpdate()>0)
				 b= true;
			 else  return false;
		 }
	}catch(Throwable e){
		
		 CLogger.write("51", this, e);
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
	}catch(Throwable e){
		
		 CLogger.write("52", this, e);
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
			CArea area=new CArea(rs.getInt("idarea"),rs.getString("nombre_area"),"",0,null,null,"");
			CResponsable cr=new CResponsable(rs.getInt("idresponsable"),rs.getString("nombre"),rs.getString("apellido"),null,area);
			ret.add(cr);
			
		}
		rs.close();
		stm.close();
	}catch(Throwable e){
		
		 CLogger.write("53", this, e);
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
	}catch(Throwable e){
		
		 CLogger.write("54", this, e);
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
		
	}catch(Throwable e){
		
		 CLogger.write("55", this, e);
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
				CArea area=new CArea(rs.getInt("idarea"),rs.getString("nombre_area"),"",0,null,null,"");
				CUsuario user=new CUsuario(rs.getInt("idusuario"),rs.getString("user_nombre"),rs.getString("user_apellido"),"","","","",0,"");
				ret=new CResponsable(rs.getInt("idresponsable"),rs.getString("r_nombre"),rs.getString("r_apellido"),user,area);
				
			}
			rs.close();
			stm.close();
		}catch(Throwable e){
			
			 CLogger.write("56", this, e);
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
			
		}catch(Throwable e){
			
			 CLogger.write("57", this, e);
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
			
		}catch(Throwable e){
			
			 CLogger.write("58", this, e);
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
				CArea area=new CArea(rs.getInt("idarea"),rs.getString("nombre_area"),"",0,null,null,"");
				CResponsable cr=new CResponsable(rs.getInt("idresponsable"),rs.getString("nombre"),rs.getString("apellido"),null,area);
				ret.add(cr);
				
			}
			rs.close();
			stm.close();
		}catch(Throwable e){
			
			 CLogger.write("59", this, e);
		}
		return ret;
	}
	public ArrayList<CResponsable> getListaResponsables(int idactividad){
		ArrayList<CResponsable> ret=new ArrayList<CResponsable>();
		try{
			String sql="SELECT respon.idresponsable, respon.nombre nombre, respon.apellido apellido,a.idarea ,a.nombre nombre_area "+
		" FROM responsable respon inner join area a on a.idarea=respon.areaidarea inner join responsable_actividad ra on ra.responsableidresponsable=respon.idresponsable  "+
		" where ra.actividadidactividad=? ";
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			stm.setInt(1,idactividad);
			ResultSet rs=stm.executeQuery();
			while(rs.next()){
				CArea area=new CArea(rs.getInt("idarea"),rs.getString("nombre_area"),"",0,null,null,"");
				CResponsable cr=new CResponsable(rs.getInt("idresponsable"),rs.getString("nombre"),rs.getString("apellido"),null,area);
				ret.add(cr);
				
			}
			rs.close();
			stm.close();
		}catch(Throwable e){
			
			 CLogger.write("60", this, e);
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
		}catch(Throwable e){
			
			 CLogger.write("61", this, e);
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
		}catch(Throwable e){
			
			 CLogger.write("62", this, e);
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
		}catch(Throwable e){
			
			 CLogger.write("63", this, e);
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
			
		}catch(Throwable e){
			
			 CLogger.write("64", this, e);
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
			
		}catch(Throwable e){
			
			 CLogger.write("65", this, e);
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
		}catch(Throwable e){
			
			 CLogger.write("66", this, e);
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
			
		}catch(Throwable e){
			
			 CLogger.write("67", this, e);
		}
		
		return false;
	}
	public ArrayList<CActividad> getListaActividades(int ordenar,int asc,int min,int max,int type, String busqueda,int cantidad,ArrayList<Integer> lista){
		ArrayList<CActividad> ret=new ArrayList<CActividad>();
		if(lista.size()>0){
		try{
			String pqtype="act.titulo";
			if(type==2){
				 pqtype="edi.nombre";
			}else if(type==3){
				pqtype="a.nombre";
			}
			cantidad=cantidad+1;
			String sql="select * from (SELECT act.idactividad, act.titulo act_titulo, act.descripcion act_descripcion, act.areaidarea idarea,act.salon , "+
						" a.nombre nombre_area, edi.idedificio, edi.nombre edificio_nombre,  @rownum:=@rownum+1 rownum "+
						"FROM actividad act inner join area a on a.idarea=act.areaidarea "+
						"inner join edificio edi on edi.idedificio=act.edificioidedificio,(SELECT @rownum:=0) ro "+
						"where  upper("+pqtype+") like ? and "+
						" a.idarea in ("+this.ConvertString(lista)+") "+
						"  ) table1 "+
						" where rownum<=? and rownum>=? order by ?  "+((asc==1)?"ASC":"DESC") +" ";
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			int id=1;
			stm.setString(id++,"%"+busqueda.trim().toUpperCase()+"%");
			for(int i=0; i<lista.size();i++){
            	stm.setInt(id++, lista.get(i));
            }
			stm.setInt(id++,cantidad-min);
			stm.setInt(id++,cantidad-max);
			stm.setInt(id++,ordenar);
			ResultSet rs=stm.executeQuery();
			while(rs.next()){
				CArea area=new CArea(rs.getInt("idarea"),rs.getString("nombre_area"),"",0,null,null,"");
				CEdificio edi=new CEdificio(rs.getInt("idedificio"),rs.getString("edificio_nombre"),"","");
				CActividad act=new CActividad(rs.getInt("idactividad"),rs.getString("act_titulo"),area,rs.getString("act_descripcion"),edi,rs.getString("salon"));
				//CActividad(int idactividad, String titulo, CArea areaidarea,String descripcion, CResponsable responsableidresponsable,CEdificio edificioidedificio)
				ret.add(act);
				
			}
			rs.close();
			stm.close();
		}catch(Throwable e){
			
			 CLogger.write("68", this, e);
		}
		}
		return ret;
	}
	public int getActividadesTotal(int type,String busqueda,ArrayList<Integer> lista){
		int temp=0;
		if(lista.size()>0){
				String pqtype="act.titulo";
				if(type==2)
					 pqtype="edi.nombre";
				else if(type==3)
					pqtype="a.nombre";
				try {
					String sql="SELECT count(*) cant FROM actividad act inner join area a on a.idarea=act.areaidarea "+
							" inner join edificio edi on edi.idedificio=act.edificioidedificio "+
							" where  upper("+pqtype+") like ? and a.idarea in ("+this.ConvertString(lista)+") ";
					PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
					int id=1;
					stm.setString(id++,"%"+busqueda.trim().toUpperCase()+"%");
					for(int i=0; i<lista.size();i++){
	                	stm.setInt(id++, lista.get(i));
	                }
					ResultSet rs2=stm.executeQuery();
					if(rs2.next())
					temp=rs2.getInt("cant");
				}catch(Throwable e){
					
					 CLogger.write("69", this, e);
				}
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
		}catch(Throwable e){
			
			 CLogger.write("70", this, e);
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
			
		}catch(Throwable e){
			
			 CLogger.write("71", this, e);
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
		} catch(Throwable e){
			
			 CLogger.write("72", this, e);
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
				CArea area=new CArea(rs.getInt("idarea"),rs.getString("nombre_area"),"",0,null,null,"");
				CEdificio edi=new CEdificio(rs.getInt("idedificio"),rs.getString("edi_nombre"),"","");
				news=new CActividad(rs.getInt("idactividad"),rs.getString("act_titulo"),area,rs.getString("act_descripcion"),edi,rs.getString("salon"));
				
			}
			rs.close();
			stm.close();
		}catch(Throwable e){
			
			 CLogger.write("73", this, e);
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
		}catch(Throwable e){
			
			 CLogger.write("74", this, e);
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
			
		}catch(Throwable e){
			
			 CLogger.write("75", this, e);
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
		}catch(Throwable e){
			
			 CLogger.write("76", this, e);
		}
		
		return temp;
	}
	public ArrayList<CDetalleActividad> getListaDetalleActividad(int idactividad,int ordenar,int asc,int mes,int anio){
		ArrayList<CDetalleActividad> ret=new ArrayList<CDetalleActividad>();
		try{
			String sql="SELECT da.iddetalleactividad, da.fecha, da.horainicio, da.horafin, da.actividadidactividad , act.titulo, @rownum:=@rownum+1 rownum "+
			"  FROM detalleactividad da inner join actividad act on act.idactividad=da.actividadidactividad,(SELECT @rownum:=0) ro "+
			" where idactividad=? and month(fecha)=? and year(fecha)=? order by ? "+((asc==1)?"ASC":"DESC") ;
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			stm.setInt(1,idactividad);
			stm.setInt(2,mes);
			stm.setInt(3,anio);
			stm.setInt(4,ordenar);
			ResultSet rs=stm.executeQuery();
			while(rs.next()){
				CActividad act=new CActividad(idactividad,rs.getString("titulo"),null,"",null,"");
				CDetalleActividad dacti=new CDetalleActividad(rs.getInt("iddetalleactividad"),new java.util.Date(rs.getDate("fecha").getTime()),new java.util.Date(rs.getTimestamp("horainicio").getTime()),new java.util.Date(rs.getTimestamp("horafin").getTime()),act);
				ret.add(dacti);
				
			}
			rs.close();
			stm.close();
		}catch(Throwable e){
			e.printStackTrace();
			 CLogger.write("77", this, e);
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
		}catch(Throwable e){
			
			 CLogger.write("78", this, e);
		}
		return ret;
	}
	public ArrayList<Integer> listaAnioDetalleActividad(){
		ArrayList<Integer> list=new ArrayList<Integer>();
		try{    
        	PreparedStatement stm=(PreparedStatement)conn.prepareStatement("select distinct (year(fecha)) anio from detalleactividad ");
        	    ResultSet rs=stm.executeQuery();
                while(rs.next()){                							
                                list.add(rs.getInt("anio")); 
                }
                rs.close();
                stm.close();
		}catch(Throwable e){
			CLogger.write("78a", this, e);
		}
		return list;
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
		}catch(Throwable e){
			
			 CLogger.write("82", this, e);
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
		}catch(Throwable e){
			
			 CLogger.write("83", this, e);
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
		}catch(Throwable e){
			
			 CLogger.write("84", this, e);
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
		}catch(Throwable e){
			
			 CLogger.write("85", this, e);
		}
		
		return temp;
	}
	
	public ArrayList<CDetalleActividad> getListaDetalleActividad(int idarea,java.util.Date fecha_inicio, java.util.Date fecha_fin){
		ArrayList<CDetalleActividad> ret=new ArrayList<CDetalleActividad>();
		try{
			String sql="SELECT da.iddetalleactividad, da.fecha, da.horainicio, da.horafin, da.actividadidactividad , act.titulo "+
			 " FROM detalleactividad da inner join actividad act on act.idactividad=da.actividadidactividad "+
			" where act.areaidarea=? and (da.fecha>=? and da.fecha<=?) ";
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			stm.setInt(1,idarea);
			stm.setDate(2, new java.sql.Date(fecha_inicio.getTime()));
			stm.setDate(3, new java.sql.Date(fecha_fin.getTime()));
			ResultSet rs=stm.executeQuery();
			while(rs.next()){
				CActividad act=new CActividad(rs.getInt("actividadidactividad"),rs.getString("titulo"),null,"",null,"");
				CDetalleActividad dacti=new CDetalleActividad(rs.getInt("iddetalleactividad"),new java.util.Date(rs.getDate("fecha").getTime()),new java.util.Date(rs.getTimestamp("horainicio").getTime()),new java.util.Date(rs.getTimestamp("horafin").getTime()),act);
				ret.add(dacti);
				
			}
			rs.close();
			stm.close();
		}catch(Throwable e){
			
			 CLogger.write("86", this, e);
		}
		return ret;
	}
	@SuppressWarnings("static-access")
	public ArrayList<CDetalleActividad> getDetalleActividad(int idarea,java.util.Date fecha_inicio, java.util.Date fecha_fin){
		ArrayList<CDetalleActividad> ret=new ArrayList<CDetalleActividad>();
		try{
			GregorianCalendar  calendar=new GregorianCalendar();
			calendar.setTime(fecha_inicio);
			GregorianCalendar  calendar2=new GregorianCalendar();
			calendar2.setTime(fecha_fin);
			String sql="SELECT da.iddetalleactividad, da.fecha, da.horainicio, da.horafin, da.actividadidactividad , act.titulo, act.descripcion, act.salon,edi.idedificio,edi.nombre nombre_edificio, edi.direccion " +
			"  FROM detalleactividad da inner join actividad act on act.idactividad=da.actividadidactividad inner join edificio edi on edi.idedificio=act.edificioidedificio "+
			" where act.areaidarea=? and da.fecha=? and hour(horainicio)=? and minute(horainicio)=? "+
            " and hour(horafin)=? and minute(horafin)=? ";
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			stm.setInt(1,idarea);
			stm.setDate(2,new java.sql.Date(fecha_inicio.getTime()));
			stm.setInt(3, calendar.get(calendar.HOUR_OF_DAY));
			stm.setInt(4, calendar.get(calendar.MINUTE));
			stm.setInt(5, calendar2.get(calendar.HOUR_OF_DAY));
			stm.setInt(6, calendar2.get(calendar.MINUTE));
			ResultSet rs=stm.executeQuery();
			while(rs.next()){
				CEdificio edi=new CEdificio(rs.getInt("idedificio"),rs.getString("nombre_edificio"),rs.getString("direccion"),"");
				CActividad act=new CActividad(rs.getInt("actividadidactividad"),rs.getString("titulo"),null,rs.getString("descripcion"),edi,rs.getString("salon"));
				CDetalleActividad dacti=new CDetalleActividad(rs.getInt("iddetalleactividad"),new java.util.Date(rs.getDate("fecha").getTime()),new java.util.Date(rs.getTimestamp("horainicio").getTime()),new java.util.Date(rs.getTimestamp("horafin").getTime()),act);
				ret.add(dacti);
				
			}
			rs.close();
			stm.close();
		}catch(Throwable e){
			
			 CLogger.write("87", this, e);
		}
		return ret;
	}
	
	public ArrayList<CDetalleActividad> getDetalleActividad(int idactividad){
		ArrayList<CDetalleActividad> ret=new ArrayList<CDetalleActividad>();
		try{
			String sql="SELECT da.iddetalleactividad, da.fecha, da.horainicio, da.horafin, da.actividadidactividad  " +
			"  FROM detalleactividad da where da.actividadidactividad=? ";
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			stm.setInt(1,idactividad);
			ResultSet rs=stm.executeQuery();
			while(rs.next()){
				CDetalleActividad dacti=new CDetalleActividad(rs.getInt("iddetalleactividad"),new java.util.Date(rs.getDate("fecha").getTime()),new java.util.Date(rs.getTimestamp("horainicio").getTime()),new java.util.Date(rs.getTimestamp("horafin").getTime()),null);
				ret.add(dacti);
				
			}
			rs.close();
			stm.close();
		}catch(Throwable e){
			
			 CLogger.write("88", this, e);
		}
		return ret;
	}
	
	public ArrayList<CActividad> getActividad(java.util.Date fecha_inicio){
		ArrayList<CActividad> ret=new ArrayList<CActividad>();
		try{
			
			String sql="SELECT act.idactividad , act.titulo, act.descripcion, act.salon,edi.idedificio,edi.nombre nombre_edificio, edi.direccion, a.idarea, a.nombre area_nombre, min(da.fecha) " +
			"  FROM detalleactividad da inner join actividad act on act.idactividad=da.actividadidactividad inner join edificio edi on edi.idedificio=act.edificioidedificio inner join area a on a.idarea=act.areaidarea "+
			" where  da.fecha>=? group by act.idactividad , act.titulo, act.descripcion, act.salon,edi.idedificio,edi.nombre, edi.direccion, a.idarea, a.nombre order by a.idarea, min(da.fecha)";
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			stm.setDate(1,new java.sql.Date(fecha_inicio.getTime()));
			ResultSet rs=stm.executeQuery();
			while(rs.next()){
				CArea area=new CArea(rs.getInt("idarea"),rs.getString("area_nombre"),"",0,null,null,"");
				CEdificio edi=new CEdificio(rs.getInt("idedificio"),rs.getString("nombre_edificio"),rs.getString("direccion"),"");
				CActividad act=new CActividad(rs.getInt("idactividad"),rs.getString("titulo"),area,rs.getString("descripcion"),edi,rs.getString("salon"));
				ret.add(act);
				
			}
			rs.close();
			stm.close();
		}catch(Throwable e){
			
			 CLogger.write("89", this, e);
		}
		return ret;
	}
	public ArrayList<java.util.Date> getDetalleActividad(int month,int year){
		ArrayList<java.util.Date> ret=new ArrayList<java.util.Date>();
		try{
			String sql="select distinct(fecha) dia "+
					" from detalleactividad where month(fecha)=? and year(fecha)=? "+
					" order by dia ";
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			stm.setInt(1,month);
			stm.setInt(2,year);
			ResultSet rs=stm.executeQuery();
			while(rs.next()){
				
				java.util.Date dacti=new java.util.Date(rs.getDate("dia").getTime());
				ret.add(dacti);
				
			}
			rs.close();
			stm.close();
		}catch(Throwable e){
			
			 CLogger.write("90", this, e);
		}
		return ret;
	}
	public ArrayList<CDetalleActividad> getDetalleActividad(java.util.Date fecha_inicio){
		ArrayList<CDetalleActividad> ret=new ArrayList<CDetalleActividad>();
		try{

			String sql="select act.idactividad,act.titulo,a.idarea, a.nombre nombre_area, act.descripcion, edi.idedificio, edi.nombre nombre_edificio,edi.direccion, act.salon,dc.iddetalleactividad,dc.horainicio,dc.horafin from actividad act "+
					"inner join detalleactividad dc on dc.actividadidactividad=act.idactividad "+
					"inner join area a on a.idarea=act.areaidarea "+
					"inner join edificio edi on  edi.idedificio=act.edificioidedificio "+
					"where dc.fecha=? order by dc.horainicio ";
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			stm.setDate(1,new java.sql.Date(fecha_inicio.getTime()));
	
			ResultSet rs=stm.executeQuery();
			while(rs.next()){
				CEdificio edi=new CEdificio(rs.getInt("idedificio"),rs.getString("nombre_edificio"),rs.getString("direccion"),"");
				CArea area=new CArea(rs.getInt("idarea"),rs.getString("nombre_area"),"", 0,null,null,"");
				CActividad act=new CActividad(rs.getInt("idactividad"),rs.getString("titulo"),area,rs.getString("descripcion"),edi,rs.getString("salon"));
				CDetalleActividad dacti=new CDetalleActividad(rs.getInt("iddetalleactividad"),fecha_inicio,new java.util.Date(rs.getTimestamp("horainicio").getTime()),new java.util.Date(rs.getTimestamp("horafin").getTime()),act);
				ret.add(dacti);
				
			}
			rs.close();
			stm.close();
		}catch(Throwable e){
			
			 CLogger.write("91", this, e);
		}
		return ret;
	}
	public boolean UpdateConfiguracion(CConfiguracion confi){
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("UPDATE configuracion SET telefono = ?, fax = ?,  tamanio_sub = ?,  direccion = ? WHERE  idconfiguracion = ?");
			
			stm.setString(1, confi.gettelefono());
			stm.setString(2, confi.getfax());
			stm.setInt(3, confi.gettamanio_sub());
			stm.setString(4, confi.getdireccion());
			stm.setInt(5, confi.getidconfiguracion());
			
			if(stm.executeUpdate()>0)
				return true;
			
		}catch(Throwable e){
			
			 CLogger.write("92", this, e);
		}
		
		return false;
	}
	public ArrayList<CMultimedia> getMultimediaEliminarLista(int min,int max,int ordenar, int asc, int tipo, String query){
		ArrayList<CMultimedia> list=new ArrayList<CMultimedia>();
		String like="m.direccion";
		if(tipo==2) like="concat(u.nombre,' ',u.apellido)";
		
		String sql=
				
				"select * from  (select @rownum:=@rownum+1 rownum, m.idmultimedia, m.direccion direccion_m, m.direccion_relativa direccion_rel, m.usuarioidusuario ,m.tipo, u.nombre,u.apellido, u.nick "+
				" from multimedia m inner join usuario u on u.idusuario=m.usuarioidusuario, (SELECT @rownum:=0) ro "+
				" where "+
				" (select n.multimediaidmultimedia from  noticia n where n.multimediaidmultimedia= m.idmultimedia limit 1) IS NULL "+
				" AND "+
				" (select n.multimediaidmultimedia_pdf from  noticia n where n.multimediaidmultimedia_pdf= m.idmultimedia limit 1) IS NULL "+
				" AND "+
				" (select a.multimediaidmultimedia from  area a where a.multimediaidmultimedia= m.idmultimedia limit 1) IS NULL "+
				" AND "+
				" (select e.multimediaidmultimedia from  encabezado e where e.multimediaidmultimedia= m.idmultimedia limit 1) IS NULL "+
				" AND "+
				" (select c.multimediaidmultimedia from  contenido c where c.multimediaidmultimedia= m.idmultimedia limit 1) IS NULL and "+
				" upper("+like+") like ? ) a "+
				"  where rownum>=? and rownum<=? ORDER BY ? "+((asc==1)?"ASC":"DESC");
		try{
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			stm.setString(1,"%"+query.trim().toUpperCase()+"%");
			stm.setInt(2,min);
			stm.setInt(3,max);
			stm.setInt(4,ordenar);
			ResultSet rs=stm.executeQuery();
			while(rs.next()){
				CUsuario user=new CUsuario(rs.getInt("usuarioidusuario"), rs.getString("nombre"),rs.getString("apellido"),rs.getString("nick"),"","", "",0,"");
				CMultimedia multi=new CMultimedia(rs.getInt("idmultimedia"),rs.getString("direccion_m"),rs.getString("direccion_rel"),0L,rs.getInt("tipo"),user);
				list.add(multi);
			}
			rs.close();
			stm.close();
		}catch(Throwable e){
			
			 CLogger.write("93", this, e);
		}
		return list;
	}
	public int getMultimediaEliminarTotal(int tipo,String query){
		int temp=0;
		String like="m.direccion";
		if(tipo==2) like="concat(u.nombre,' ',u.apellido)";
		String sql="select count( m.idmultimedia ) cant "+
				" from multimedia m inner join usuario u on u.idusuario=m.usuarioidusuario "+
				" where "+
				" (select n.multimediaidmultimedia from  noticia n where n.multimediaidmultimedia= m.idmultimedia limit 1) IS NULL "+
				" AND "+
				" (select n.multimediaidmultimedia_pdf from  noticia n where n.multimediaidmultimedia_pdf= m.idmultimedia limit 1) IS NULL "+
				" AND "+
				" (select a.multimediaidmultimedia from  area a where a.multimediaidmultimedia= m.idmultimedia limit 1) IS NULL "+
				" AND "+
				" (select e.multimediaidmultimedia from  encabezado e where e.multimediaidmultimedia= m.idmultimedia limit 1) IS NULL "+
				" AND "+
				" (select c.multimediaidmultimedia from  contenido c where c.multimediaidmultimedia= m.idmultimedia limit 1) IS NULL "+
				" AND upper("+like+") like ? ";
		
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement(sql);
			stm.setString(1,"%"+query.trim().toUpperCase()+"%");
			ResultSet rs2=stm.executeQuery();
			if(rs2.next())
			temp=rs2.getInt("cant");
		}catch(Throwable e){
			
			 CLogger.write("94", this, e);
		}
		
		return temp;
	}
	public ArrayList<CMultimedia> getMultimediaEliminarLista(ArrayList<Integer> lista){
		ArrayList<CMultimedia> list=new ArrayList<CMultimedia>();
		
		String sql=	"select  m.idmultimedia, m.direccion direccion_m, m.direccion_relativa direccion_rel, m.usuarioidusuario ,m.tipo"+
				" from multimedia m  where m.idmultimedia in ("+this.ConvertString(lista)+")";
		if(lista.size()>0){
			try{
				PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
				int id=1;
				for(int i=0; i<lista.size();i++){
                	stm.setInt(id++, lista.get(i));
                }
				ResultSet rs=stm.executeQuery();
				while(rs.next()){
					
					CMultimedia multi=new CMultimedia(rs.getInt("idmultimedia"),rs.getString("direccion_m"),rs.getString("direccion_rel"),0L,rs.getInt("tipo"),null);
					list.add(multi);
				}
				rs.close();
				stm.close();
			}catch(Throwable e){
				
				 CLogger.write("95", this, e);
			}
		}
		return list;
	}
	public boolean deleteMultimedia(int idmultimedia){
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("DELETE FROM multimedia  WHERE idmultimedia = ?");
			stm.setInt(1, idmultimedia);
			if(stm.executeUpdate()>0)
				return true;
			
		}catch(Throwable e){
			
			 CLogger.write("96", this, e);
		}
		
		return false;
	}
	public ArrayList<CMultimedia> getMultimediaEliminarLista(){
		ArrayList<CMultimedia> list=new ArrayList<CMultimedia>();
		
		String sql=
				
				"select m.idmultimedia, m.direccion direccion_m, m.direccion_relativa direccion_rel, m.usuarioidusuario ,m.tipo, u.nombre,u.apellido, u.nick "+
				" from multimedia m inner join usuario u on u.idusuario=m.usuarioidusuario "+
				" where "+
				" (select n.multimediaidmultimedia from  noticia n where n.multimediaidmultimedia= m.idmultimedia limit 1) IS NULL "+
				" AND "+
				" (select n.multimediaidmultimedia_pdf from  noticia n where n.multimediaidmultimedia_pdf= m.idmultimedia limit 1) IS NULL "+
				" AND "+
				" (select a.multimediaidmultimedia from  area a where a.multimediaidmultimedia= m.idmultimedia limit 1) IS NULL "+
				" AND "+
				" (select e.multimediaidmultimedia from  encabezado e where e.multimediaidmultimedia= m.idmultimedia limit 1) IS NULL "+
				" AND "+
				" (select c.multimediaidmultimedia from  contenido c where c.multimediaidmultimedia= m.idmultimedia limit 1) IS NULL ";
		try{
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			
			ResultSet rs=stm.executeQuery();
			while(rs.next()){
				CUsuario user=new CUsuario(rs.getInt("usuarioidusuario"), rs.getString("nombre"),rs.getString("apellido"),rs.getString("nick"),"","", "",0,"");
				CMultimedia multi=new CMultimedia(rs.getInt("idmultimedia"),rs.getString("direccion_m"),rs.getString("direccion_rel"),0L,rs.getInt("tipo"),user);
				list.add(multi);
			}
			rs.close();
			stm.close();
		}catch(Throwable e){
			
			 CLogger.write("96", this, e);
		}
		return list;
		
	}
}
