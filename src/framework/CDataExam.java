package framework;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import com.mysql.jdbc.PreparedStatement;

import data.CCarrera;
import data.CCategoria;
import data.CCategoria_Interpretacion;
import data.CCentro_Regional;
import data.CDepartamento;
import data.CDependencia;
import data.CEstado_Civil;
import data.CMenu_Categoria;
import data.CPaciente;
import data.CPaciente_Menu_Categoria;
import data.CParentesco;
import data.CPregunta;
import data.CPregunta_Paciente;
import data.CPregunta_Titulo_Respuesta;
import data.CTipo_Pregunta;
import data.CTipo_Sangre;
import data.CTitulo_Respuesta;
import data.CTitulo_Secundaria;
import data.CUnidad_Academica;

public class CDataExam extends CDataBase {

	public CDataExam(){
		super();
	}
	public ArrayList<CDepartamento> getListaDepartamentos(){
		ArrayList<CDepartamento> list=new ArrayList<CDepartamento>();
		try{

			String sql="select iddepartamento, nombre from departamento ";
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			
			ResultSet rs=stm.executeQuery();
			while(rs.next()){
				CDepartamento dep=new CDepartamento(rs.getInt("iddepartamento"),rs.getString("nombre"));
				list.add(dep);
				
			}
			rs.close();
			stm.close();
		}
		catch(Throwable e){
			e.printStackTrace();
		}
		
		return list;
	}
	public ArrayList<CEstado_Civil> getListaEstadoCivil(){
		ArrayList<CEstado_Civil> list=new ArrayList<CEstado_Civil>();
		try{

			String sql="SELECT idestado_civil, nombre FROM estado_civil";
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			
			ResultSet rs=stm.executeQuery();
			while(rs.next()){
				CEstado_Civil dep=new CEstado_Civil(rs.getInt("idestado_civil"),rs.getString("nombre"));
				list.add(dep);
				
			}
			rs.close();
			stm.close();
		}
		catch(Throwable e){
			e.printStackTrace();
		}
		
		return list;
	}
	public boolean UpdateEstadoCivil(CEstado_Civil civil){
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("UPDATE estado_civil SET nombre = ? WHERE  idestado_civil = ?");
			
			stm.setString(1, civil.getNombre());
			stm.setInt(2,civil.getIdestado_civil());
			if(stm.executeUpdate()>0)
				return true;
			
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return false;
	}
	public boolean SafeEstadoCivil(CEstado_Civil civil){
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("INSERT INTO estado_civil ( nombre) VALUES (?)");
			
			stm.setString(1,civil.getNombre());
			if(stm.executeUpdate()>0)
				return true;
			
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return false;
	}

	public boolean deleteEstadoCivil(int civil){
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("DELETE FROM estado_civil WHERE idestado_civil = ?");
			
			stm.setInt(1,civil);
			if(stm.executeUpdate()>0)
				return true;
			
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return false;
	}
	public ArrayList<CTipo_Sangre> getListaTipo_Sangre(){
		ArrayList<CTipo_Sangre> list=new ArrayList<CTipo_Sangre>();
		try{

			String sql="SELECT idtipo_sangre, nombre   FROM tipo_sangre";
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			
			ResultSet rs=stm.executeQuery();
			while(rs.next()){
				CTipo_Sangre dep=new CTipo_Sangre(rs.getInt("idtipo_sangre"),rs.getString("nombre"));
				list.add(dep);
				
			}
			rs.close();
			stm.close();
		}
		catch(Throwable e){
			e.printStackTrace();
		}
		
		return list;
	}
	public boolean UpdateTipoSangre(CTipo_Sangre ctipo){
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("UPDATE tipo_sangre SET  nombre = ? WHERE idtipo_sangre = ?");
			
			stm.setString(1, ctipo.getNombre());
			stm.setInt(2,ctipo.getIdtipo_sangre());
			if(stm.executeUpdate()>0)
				return true;
			
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return false;
	}
	public boolean SafeTipo_Sangre(CTipo_Sangre sangre){
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("INSERT INTO tipo_sangre ( nombre) VALUES (?)");
			
			stm.setString(1,sangre.getNombre());
			if(stm.executeUpdate()>0)
				return true;
			
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return false;
	}
	public boolean deleteTipoSangre(int idtipo){
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("DELETE FROM tipo_sangre WHERE idtipo_sangre = ?");
			
			stm.setInt(1,idtipo);
			if(stm.executeUpdate()>0)
				return true;
			
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return false;
	}
	public ArrayList<CTitulo_Secundaria> getListaTitulo_Secundaria(int ordenar,int asc,int min,int max, String busqueda){
		ArrayList<CTitulo_Secundaria> ret=new ArrayList<CTitulo_Secundaria>();
		try{
			String sql="select * from (SELECT tc.idtitulo_secundaria, tc.nombre, @rownum:=@rownum+1 rownum  "+
						"FROM titulo_secundaria tc, (SELECT @rownum:=0) ro  "+
						"where  upper(tc.nombre) like ? "+
						" ) table1 "+
						" where rownum>=? and rownum<=? order by ? "+((asc==1)?"ASC":"DESC") +"";
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			int id=1;
			stm.setString(id++,"%"+busqueda.trim().toUpperCase()+"%");
			stm.setInt(id++,min);
			stm.setInt(id++,max);
			stm.setInt(id++,ordenar);
			ResultSet rs=stm.executeQuery();
			while(rs.next()){
				CTitulo_Secundaria news=new CTitulo_Secundaria(rs.getInt("idtitulo_secundaria"),rs.getString("nombre"));
				ret.add(news);
				
			}
			rs.close();
			stm.close();
		} catch (SQLException e) {

			e.printStackTrace();
		}
		return ret;
	}
	public int getTitulo_SecundariaTotal(String busqueda){
		int temp=0;
		
				try {
					String sql="SELECT count(*) cant  "+
						" FROM titulo_secundaria tc where upper(tc.nombre) like ? ";
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
	public boolean UpdateTitulo_Secundaria(CTitulo_Secundaria ctipo){
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("UPDATE titulo_secundaria SET nombre = ? WHERE idtitulo_secundaria = ?");
			
			stm.setString(1, ctipo.getNombre());
			stm.setInt(2,ctipo.getIdtitulo_secundaria());
			if(stm.executeUpdate()>0)
				return true;
			
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return false;
	}
	public boolean SafeTitulo_Secundaria(CTitulo_Secundaria ctipo){
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("INSERT INTO titulo_secundaria(nombre) VALUES (?)");
			
			stm.setString(1,ctipo.getNombre());
			if(stm.executeUpdate()>0)
				return true;
			
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return false;
	}
	public boolean deleteTitulo_Secundaria(int ctipo){
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("DELETE FROM titulo_secundaria WHERE idtitulo_secundaria = ?");
			
			stm.setInt(1,ctipo);
			if(stm.executeUpdate()>0)
				return true;
			
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return false;
	}
	public ArrayList<CCarrera> getListaCarrera(int ordenar,int asc,int min,int max, String busqueda){
		ArrayList<CCarrera> ret=new ArrayList<CCarrera>();
		try{
			String sql="select * from (SELECT tc.idcarrera, tc.nombre, @rownum:=@rownum+1 rownum  "+
						"FROM carrera tc, (SELECT @rownum:=0) ro  "+
						"where  upper(tc.nombre) like ? "+
						" ) table1 "+
						" where rownum>=? and rownum<=? order by ? "+((asc==1)?"ASC":"DESC") +"";
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			int id=1;
			stm.setString(id++,"%"+busqueda.trim().toUpperCase()+"%");
			stm.setInt(id++,min);
			stm.setInt(id++,max);
			stm.setInt(id++,ordenar);
			ResultSet rs=stm.executeQuery();
			while(rs.next()){
				CCarrera news=new CCarrera(rs.getInt("idcarrera"),rs.getString("nombre"));
				ret.add(news);
				
			}
			rs.close();
			stm.close();
		} catch (SQLException e) {

			e.printStackTrace();
		}
		return ret;
	}
	public int getCarreraTotal(String busqueda){
		int temp=0;
		
				try {
					String sql="SELECT count(*) cant  "+
						" FROM carrera tc where upper(tc.nombre) like ? ";
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
	
	public boolean UpdateCarrera(CCarrera ctipo){
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("UPDATE carrera SET nombre = ? WHERE idcarrera = ?");
			
			stm.setString(1, ctipo.getNombre());
			stm.setInt(2,ctipo.getIdcarrera());
			if(stm.executeUpdate()>0)
				return true;
			
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return false;
	}
	public boolean SafeCarrera(CCarrera ctipo){
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("INSERT INTO carrera(nombre) VALUES (?)");
			
			stm.setString(1,ctipo.getNombre());
			if(stm.executeUpdate()>0)
				return true;
			
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return false;
	}
	public boolean deleteCarrera(int ctipo){
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("DELETE FROM carrera WHERE idcarrera = ?");
			
			stm.setInt(1,ctipo);
			if(stm.executeUpdate()>0)
				return true;
			
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return false;
	}
	public ArrayList<CCentro_Regional> getListaCentro_Regional(int ordenar,int type,int asc,int min,int max, String busqueda){
		ArrayList<CCentro_Regional> ret=new ArrayList<CCentro_Regional>();
		String qtype="tc.nombre";
		if(type==2){
			qtype="d.nombre";	
		}
		try{
			String sql="select * from (SELECT tc.idcentro_regional, tc.nombre, ifnull(d.iddepartamento,0) iddepartamento, ifnull(d.nombre,0) depto_nombre, @rownum:=@rownum+1 rownum  "+
						"FROM centro_regional tc  left outer join  departamento d on tc.departamentoiddepartamento=d.iddepartamento, (SELECT @rownum:=0) ro  "+
						"where  upper("+qtype+") like ? "+
						" ) table1 "+
						" where rownum>=? and rownum<=? order by ? "+((asc==1)?"ASC":"DESC") +"";
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			int id=1;
			stm.setString(id++,"%"+busqueda.trim().toUpperCase()+"%");
			stm.setInt(id++,min);
			stm.setInt(id++,max);
			stm.setInt(id++,ordenar);
			ResultSet rs=stm.executeQuery();
			while(rs.next()){
				CDepartamento depto=new CDepartamento(rs.getInt("iddepartamento"),rs.getString("depto_nombre"));
				CCentro_Regional news=new CCentro_Regional(rs.getInt("idcentro_regional"),rs.getString("nombre"),depto);
				ret.add(news);
				
			}
			rs.close();
			stm.close();
		} catch (SQLException e) {

			e.printStackTrace();
		}
		return ret;
	}
	public int getCentro_RegionalTotal(int type,String busqueda){
		int temp=0;
		String qtype="tc.nombre";
		if(type==2){
			qtype="d.nombre";	
		}
				try {
					String sql="SELECT count(*) cant  "+
						" FROM centro_regional tc left outer join departamento d  on tc.departamentoiddepartamento=d.iddepartamento where upper("+qtype+") like ? ";
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
	public CDepartamento getDepartamentoEspecifico(int iddepartamento){
		CDepartamento ret=null;
		try{
			String sql="select depto.iddepartamento,depto.nombre from departamento depto where depto.iddepartamento=?";
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			stm.setInt(1,iddepartamento);
			ResultSet rs=stm.executeQuery();
			while(rs.next()){
				ret=new CDepartamento(rs.getInt("iddepartamento"),rs.getString("nombre"));
				
				
			}
			rs.close();
			stm.close();
		} catch (SQLException e) {

			e.printStackTrace();
		}
		return ret;
	}
	public boolean UpdateCentro_Regional(CCentro_Regional ctipo){
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("UPDATE centro_regional SET nombre = ?,  departamentoiddepartamento = ? WHERE idcentro_regional = ?");
			
			stm.setString(1, ctipo.getNombre());
			if(ctipo.getDepartamento()!=null) stm.setInt(2, ctipo.getDepartamento().getIddepartamento());
			else stm.setNull(2, java.sql.Types.INTEGER);
			stm.setInt(3,ctipo.getIdcentro_regional());
			if(stm.executeUpdate()>0)
				return true;
			
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return false;
	}
	public boolean SafeCentro_Regional(CCentro_Regional ctipo){
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("INSERT INTO centro_regional (nombre, departamentoiddepartamento) VALUES  (?,  ?)");
			
			stm.setString(1,ctipo.getNombre());
			if(ctipo.getDepartamento()!=null) stm.setInt(2, ctipo.getDepartamento().getIddepartamento());
			else stm.setNull(2, java.sql.Types.INTEGER);
			if(stm.executeUpdate()>0)
				return true;
			
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return false;
	}
	public boolean deleteCentro_Regional(int ctipo){
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("DELETE FROM centro_regional WHERE idcentro_regional = ?");
			
			stm.setInt(1,ctipo);
			if(stm.executeUpdate()>0)
				return true;
			
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return false;
	}
	public ArrayList<CUnidad_Academica> getListaUnidad_Academica(int ordenar,int asc,int min,int max, String busqueda){
		ArrayList<CUnidad_Academica> ret=new ArrayList<CUnidad_Academica>();
		try{
			String sql="select * from (SELECT tc.idunidad_academica, tc.nombre, @rownum:=@rownum+1 rownum  "+
						"FROM unidad_academica tc, (SELECT @rownum:=0) ro  "+
						"where  upper(tc.nombre) like ? "+
						" ) table1 "+
						" where rownum>=? and rownum<=? order by ? "+((asc==1)?"ASC":"DESC") +"";
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			int id=1;
			stm.setString(id++,"%"+busqueda.trim().toUpperCase()+"%");
			stm.setInt(id++,min);
			stm.setInt(id++,max);
			stm.setInt(id++,ordenar);
			ResultSet rs=stm.executeQuery();
			while(rs.next()){
				CUnidad_Academica news=new CUnidad_Academica(rs.getInt("idunidad_academica"),rs.getString("nombre"));
				ret.add(news);
				
			}
			rs.close();
			stm.close();
		} catch (SQLException e) {

			e.printStackTrace();
		}
		return ret;
	}
	public int getUnidadAcademicaTotal(String busqueda){
		int temp=0;
		
				try {
					String sql="SELECT count(*) cant  "+
						" FROM unidad_academica tc where upper(tc.nombre) like ? ";
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
	public boolean UpdateUnidadAcademica(CUnidad_Academica ctipo){
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("UPDATE unidad_academica SET nombre = ? WHERE idunidad_academica = ?");
			
			stm.setString(1, ctipo.getNombre());
			stm.setInt(2,ctipo.getIdunidad_academica());
			if(stm.executeUpdate()>0)
				return true;
			
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return false;
	}
	public boolean SafeUnidadAcademica(CUnidad_Academica ctipo){
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("INSERT INTO unidad_academica(nombre)VALUES (?)");
			
			stm.setString(1,ctipo.getNombre());
			if(stm.executeUpdate()>0)
				return true;
			
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return false;
	}
	public boolean deleteUnidadAcademica(int ctipo){
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("DELETE FROM unidad_academica WHERE idunidad_academica = ?");
			
			stm.setInt(1,ctipo);
			if(stm.executeUpdate()>0)
				return true;
			
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return false;
	}
	public ArrayList<CDependencia> getListaDependencia(int ordenar,int asc,int min,int max, String busqueda){
		ArrayList<CDependencia> ret=new ArrayList<CDependencia>();
		try{
			String sql="select * from (SELECT tc.iddependencia, tc.nombre, @rownum:=@rownum+1 rownum  "+
						"FROM dependencia tc, (SELECT @rownum:=0) ro  "+
						"where  upper(tc.nombre) like ? "+
						" ) table1 "+
						" where rownum>=? and rownum<=? order by ? "+((asc==1)?"ASC":"DESC") +"";
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			int id=1;
			stm.setString(id++,"%"+busqueda.trim().toUpperCase()+"%");
			stm.setInt(id++,min);
			stm.setInt(id++,max);
			stm.setInt(id++,ordenar);
			ResultSet rs=stm.executeQuery();
			while(rs.next()){
				CDependencia news=new CDependencia(rs.getInt("iddependencia"),rs.getString("nombre"));
				ret.add(news);
				
			}
			rs.close();
			stm.close();
		} catch (SQLException e) {

			e.printStackTrace();
		}
		return ret;
	}
	public int getDependenciaTotal(String busqueda){
		int temp=0;
		
				try {
					String sql="SELECT count(*) cant  "+
						" FROM dependencia tc where upper(tc.nombre) like ? ";
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
	public boolean UpdateDependencia(CDependencia ctipo){
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("UPDATE dependencia SET nombre = ? WHERE iddependencia = ?");
			
			stm.setString(1, ctipo.getNombre());
			stm.setInt(2,ctipo.getIddependencia());
			if(stm.executeUpdate()>0)
				return true;
			
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return false;
	}
	public boolean SafeDependencia(CDependencia ctipo){
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("INSERT INTO dependencia ( nombre) VALUES (?)");
			
			stm.setString(1,ctipo.getNombre());
			if(stm.executeUpdate()>0)
				return true;
			
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return false;
	}
	public boolean deleteDependencia(int ctipo){
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("DELETE FROM dependencia WHERE iddependencia = ?");
			
			stm.setInt(1,ctipo);
			if(stm.executeUpdate()>0)
				return true;
			
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return false;
	}
	public ArrayList<CCentro_Regional> getListaCentro_Regional(){
		ArrayList<CCentro_Regional> lista=new ArrayList<CCentro_Regional>();
		try{
			String sql=" SELECT ct.idcentro_regional, ct.nombre centro_regional, ct.departamentoiddepartamento , dep.nombre depto_nombre"+
					" FROM centro_regional ct left outer join departamento dep on dep.iddepartamento=ct.departamentoiddepartamento order by  ct.nombre asc";
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			ResultSet rs=stm.executeQuery();
			while(rs.next()){
				CDepartamento depto=new CDepartamento(rs.getInt("departamentoiddepartamento"),rs.getString("depto_nombre"));
				CCentro_Regional news=new CCentro_Regional(rs.getInt("idcentro_regional"),rs.getString("centro_regional"),depto);
				lista.add(news);
				
			}
			rs.close();
			stm.close();
		} catch (SQLException e) {

			e.printStackTrace();
		}
		return lista;
	}
	public ArrayList<CUnidad_Academica> getListaUnidad_Academica(){
		ArrayList<CUnidad_Academica> lista=new ArrayList<CUnidad_Academica>();
		try{
			String sql=" SELECT idunidad_academica, nombre FROM unidad_academica order by nombre asc";
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			ResultSet rs=stm.executeQuery();
			while(rs.next()){
				CUnidad_Academica news=new CUnidad_Academica(rs.getInt("idunidad_academica"),rs.getString("nombre"));
				lista.add(news);				
			}
			rs.close();
			stm.close();
		} catch (SQLException e) {

			e.printStackTrace();
		}
		return lista;
	}
	public ArrayList<CCarrera> getListaCarrera(){
		ArrayList<CCarrera> lista=new ArrayList<CCarrera>();
		try{
			String sql=" SELECT idcarrera, nombre FROM carrera order by nombre asc ";
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			ResultSet rs=stm.executeQuery();
			while(rs.next()){
				CCarrera news=new CCarrera(rs.getInt("idcarrera"),rs.getString("nombre"));
				lista.add(news);				
			}
			rs.close();
			stm.close();
		} catch (SQLException e) {

			e.printStackTrace();
		}
		return lista;
	}
	public ArrayList<CDependencia> getListaDependencia(){
		ArrayList<CDependencia> lista=new ArrayList<CDependencia>();
		try{
			String sql=" SELECT iddependencia, nombre FROM dependencia";
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			ResultSet rs=stm.executeQuery();
			while(rs.next()){
				CDependencia news=new CDependencia(rs.getInt("iddependencia"),rs.getString("nombre"));
				lista.add(news);				
			}
			rs.close();
			stm.close();
		} catch (SQLException e) {

			e.printStackTrace();
		}
		return lista;
	}
	public int getPacienteDisponiblidad(String user){
		int temp=0;
		
				try {
					String sql="SELECT count(*) cant  "+
						" FROM paciente tc where usuario = ? ";
					PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
					
					stm.setString(1,user.trim().toLowerCase());
					ResultSet rs2=stm.executeQuery();
					if(rs2.next())
					temp=rs2.getInt("cant");
				} catch (SQLException e) {
		
					e.printStackTrace();
				}
		
		return temp;
	}
	public int getPacienteCarneDisponiblidad(int carne){
		int temp=0;
		
				try {
					String sql="SELECT count(*) cant  "+
						" FROM paciente tc where carne = ? ";
					PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
					
					stm.setInt(1,carne);
					ResultSet rs2=stm.executeQuery();
					if(rs2.next())
					temp=rs2.getInt("cant");
				} catch (SQLException e) {
		
					e.printStackTrace();
				}
		
		return temp;
	}
	public CCarrera getEspecificoCarrera(int idcarrera){
		CCarrera temp=null;
		try{    
        	PreparedStatement stm=(PreparedStatement)conn.prepareStatement("SELECT idcarrera,nombre FROM carrera car where idcarrera=? ");
        	stm.setInt(1,idcarrera);
                ResultSet rs=stm.executeQuery();
                while(rs.next()){
                                
                                temp=new CCarrera( rs.getInt("idcarrera"),rs.getString("nombre"));
                               
                }
                rs.close();
                stm.close();
		} catch (SQLException e) {

			e.printStackTrace();
		}
        return temp;
	}
	public CCentro_Regional getEspecificoCentro_Regional(int idCentro_Regional){
		CCentro_Regional temp=null;
		try{
			String sql=" SELECT ct.idcentro_regional, ct.nombre centro_regional, ct.departamentoiddepartamento , dep.nombre depto_nombre"+
					" FROM centro_regional ct left outer join departamento dep on dep.iddepartamento=ct.departamentoiddepartamento "+
					" where ct.idcentro_regional=? ";
        	PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
        	stm.setInt(1,idCentro_Regional);
                ResultSet rs=stm.executeQuery();
                while(rs.next()){
                	CDepartamento depto=new CDepartamento(rs.getInt("departamentoiddepartamento"),rs.getString("depto_nombre"));
    				temp=new CCentro_Regional(rs.getInt("idcentro_regional"),rs.getString("centro_regional"),depto);
                               
                }
                rs.close();
                stm.close();
		} catch (SQLException e) {

			e.printStackTrace();
		}
        return temp;
	}
	public CUnidad_Academica getEspecificoUnidadAcademica(int idunidad_academica){
		CUnidad_Academica temp=null;
		try{    
        	PreparedStatement stm=(PreparedStatement)conn.prepareStatement("SELECT idunidad_academica, nombre FROM unidad_academica where  idunidad_academica=?");
        	stm.setInt(1,idunidad_academica);
                ResultSet rs=stm.executeQuery();
                while(rs.next()){
                                
                                temp=new CUnidad_Academica( rs.getInt("idunidad_academica"),rs.getString("nombre"));
                               
                }
                rs.close();
                stm.close();
		} catch (SQLException e) {

			e.printStackTrace();
		}
        return temp;
	}
	public CDependencia getEspecificoDependencia(int iddependencia){
		CDependencia temp=null;
		try{    
        	PreparedStatement stm=(PreparedStatement)conn.prepareStatement("SELECT iddependencia, nombre FROM dependencia where  iddependencia=?");
        	stm.setInt(1,iddependencia);
                ResultSet rs=stm.executeQuery();
                while(rs.next()){
                                
                                temp=new CDependencia( rs.getInt("iddependencia"),rs.getString("nombre"));
                               
                }
                rs.close();
                stm.close();
		} catch (SQLException e) {

			e.printStackTrace();
		}
        return temp;
	}
	public boolean SafePaciente(CPaciente paciente){
		PreparedStatement stm;
		try {
			String sql="INSERT INTO paciente( nombre, fecha_nac, carne, direccion, telefono, movil,  "
					+"  email, carreraidcarrera, centro_regionalidcentro_regional, unidad_academicaidunidad_academica,  "
					+"  dependenciaiddependencia,  "
					+"   password, usuario, parentesco_ced,  ced,sexo,no_personal)  "
					+"   VALUES (?, ?, ?, ?, ?, ?,  ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ) ";
			
			stm = (PreparedStatement)conn.prepareStatement(sql);
			
			stm.setString(1,paciente.getNombre());
			stm.setDate(2, new java.sql.Date(paciente.getFecha_nacimiento().getTime()));
			stm.setInt(3, paciente.getCarne());
			stm.setString(4,paciente.getDireccion());
			stm.setString(5,paciente.getTelefono());
			stm.setString(6,paciente.getMovil());
			stm.setString(7,paciente.getEmail());
			if(paciente.getIdcarrera()>0) stm.setInt(8,paciente.getIdcarrera());
			else stm.setNull(8,java.sql.Types.NULL );
			if(paciente.getIdcentro()>0) stm.setInt(9,paciente.getIdcentro());
			else stm.setNull(9,java.sql.Types.NULL );
			if(paciente.getIdunidad()>0) stm.setInt(10,paciente.getIdunidad());
			else stm.setNull(10,java.sql.Types.NULL );
			if(paciente.getIddependencia()>0) stm.setInt(11,paciente.getIddependencia());
			else stm.setNull(11,java.sql.Types.NULL );
			stm.setString(12, paciente.getPassword());
			stm.setString(13, paciente.getUsuario());
			if(paciente.getParentesco_ced()>0)
			stm.setInt(14, paciente.getParentesco_ced());
			else stm.setNull(14,java.sql.Types.NULL );
			stm.setString(15, paciente.getCedula());
			stm.setInt(16, paciente.getSexo());
			if(paciente.getNo_personal()>0) stm.setInt(17,paciente.getNo_personal());
			else stm.setNull(17,java.sql.Types.NULL );
			
			if(stm.executeUpdate()>0)
				return true;
			
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return false;
	}
	public boolean SafePacienteTrab(CPaciente paciente){
		PreparedStatement stm;
		try {
			String sql="INSERT INTO paciente( nombre, fecha_nac,  direccion, telefono, movil,  "
					+"  email, dependenciaiddependencia,   "
					+"   password, usuario, parentesco_ced,  ced,sexo,no_personal)  "
					+"   VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?,?) ";
			
			stm = (PreparedStatement)conn.prepareStatement(sql);
			
			stm.setString(1,paciente.getNombre());
			stm.setDate(2, new java.sql.Date(paciente.getFecha_nacimiento().getTime()));
			stm.setString(3,paciente.getDireccion());
			stm.setString(4,paciente.getTelefono());
			stm.setString(5,paciente.getMovil());
			stm.setString(6,paciente.getEmail());
			if(paciente.getIddependencia()>0) stm.setInt(7,paciente.getIddependencia());
			else stm.setNull(7, java.sql.Types.NULL);
			stm.setString(8, paciente.getPassword());
			stm.setString(9, paciente.getUsuario());
			if(paciente.getParentesco_ced()>0)
				stm.setInt(10, paciente.getParentesco_ced());
			else stm.setNull(10,java.sql.Types.NULL );
			stm.setString(11, paciente.getCedula());
			stm.setInt(12, paciente.getSexo());
			if(paciente.getNo_personal()>0) stm.setInt(13,paciente.getNo_personal());
			else stm.setNull(13,java.sql.Types.NULL );
			if(stm.executeUpdate()>0)
				return true;
			
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return false;
	}
	public int getIdPaciente(String user){
		int temp=0;
		
				try {
					String sql="SELECT idpaciente cant  "+
						" FROM paciente tc where usuario = ? ";
					PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
					
					stm.setString(1,user.trim().toLowerCase());
					ResultSet rs2=stm.executeQuery();
					if(rs2.next())
					temp=rs2.getInt("cant");
				} catch (SQLException e) {
		
					e.printStackTrace();
				}
		
		return temp;
	}
	public boolean UpdateParentesco(CParentesco paren){
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("UPDATE parentesco SET nombre = ?, grupo_familiar = ?, antecedentes_familiares = ?,  emergencia = ? WHERE idparentesco = ?");
			
			stm.setString(1, paren.getNombre());
			stm.setInt(2,paren.getGrupo_familiar());
			stm.setInt(3, paren.getAntecendentes_familiares());
			stm.setInt(4, paren.getEmergencias());
			stm.setInt(5,paren.getIdparentesco());
			if(stm.executeUpdate()>0)
				return true;
			
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return false;
	}
	public boolean SafeParentesco(CParentesco ctipo){
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("INSERT INTO parentesco (nombre, grupo_familiar,antecedentes_familiares, emergencia) VALUES (  ?, ?, ?, ?)");
			
			stm.setString(1,ctipo.getNombre());
			stm.setInt(2,ctipo.getGrupo_familiar());
			stm.setInt(3, ctipo.getAntecendentes_familiares());
			stm.setInt(4, ctipo.getEmergencias());
			if(stm.executeUpdate()>0)
				return true;
			
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return false;
	}
	public boolean deleteParentesco(int ctipo){
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("DELETE FROM parentesco WHERE idparentesco = ?");
			
			stm.setInt(1,ctipo);
			if(stm.executeUpdate()>0)
				return true;
			
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return false;
	}
	public ArrayList<CParentesco> getListaParentesco(int ordenar,int asc,int min,int max, String busqueda){
		ArrayList<CParentesco> ret=new ArrayList<CParentesco>();
		try{
			String sql="select * from (SELECT tc.idparentesco, tc.nombre,tc.grupo_familiar,tc.antecedentes_familiares, tc.emergencia, @rownum:=@rownum+1 rownum  "+
						"FROM parentesco tc, (SELECT @rownum:=0) ro  "+
						"where  upper(tc.nombre) like ? "+
						" ) table1 "+
						" where rownum>=? and rownum<=? order by ? "+((asc==1)?"ASC":"DESC") +"";
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			int id=1;
			stm.setString(id++,"%"+busqueda.trim().toUpperCase()+"%");
			stm.setInt(id++,min);
			stm.setInt(id++,max);
			stm.setInt(id++,ordenar);
			ResultSet rs=stm.executeQuery();
			while(rs.next()){
				CParentesco news=new CParentesco(rs.getInt("idparentesco"),rs.getString("nombre"),rs.getInt("grupo_familiar"),rs.getInt("antecedentes_familiares"),rs.getInt("emergencia"));
				ret.add(news);
				
			}
			rs.close();
			stm.close();
		} catch (SQLException e) {

			e.printStackTrace();
		}
		return ret;
	}
	public ArrayList<CParentesco> getListaParentesco(int grupo_fam, int ant_fam, int emer){
		ArrayList<CParentesco> ret=new ArrayList<CParentesco>();
		try{
			String sql="SELECT tc.idparentesco, tc.nombre,tc.grupo_familiar,tc.antecedentes_familiares, tc.emergencia, @rownum:=@rownum+1 rownum  "+
						"FROM parentesco tc where (tc.grupo_familiar=? or tc.antecedentes_familiares=? or tc.emergencia=?)";
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			int id=1;
			stm.setInt(id++,grupo_fam);
			stm.setInt(id++,ant_fam);
			stm.setInt(id++,emer);
			ResultSet rs=stm.executeQuery();
			while(rs.next()){
				CParentesco news=new CParentesco(rs.getInt("idparentesco"),rs.getString("nombre"),rs.getInt("grupo_familiar"),rs.getInt("antecedentes_familiares"),rs.getInt("emergencia"));
				ret.add(news);
				
			}
			rs.close();
			stm.close();
		} catch (SQLException e) {

			e.printStackTrace();
		}
		return ret;
	}
	public int getParentescoTotal(String busqueda){
		int temp=0;
		
				try {
					String sql="SELECT count(*) cant  "+
						" FROM parentesco tc where upper(tc.nombre) like ? ";
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
	public boolean UpdateCategoria(CCategoria cate){
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("UPDATE categoria SET descripcion = ?, orden = ?, autoevaluacion = ?, multifasico = ?, estado=?, idmenu_categoria = ? WHERE idcategoria = ?");
			
			stm.setString(1, cate.getDescripcion());
			stm.setInt(2,cate.getOrden());
			stm.setInt(3,cate.getAutoevaluacion());
			stm.setInt(4,cate.getMultifasico());
			stm.setInt(5, cate.getEstado());
			stm.setInt(6, cate.getIdmenu_categoria().getIdmenu_categoria());
			stm.setInt(7,cate.getIdcategoria());
			if(stm.executeUpdate()>0)
				return true;
			
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return false;
	}
	public boolean SafeCategoria(CCategoria cate){
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("INSERT INTO categoria (descripcion, orden, autoevaluacion, multifasico,estado,idmenu_categoria) VALUES (?, ?, ?,?,?,?)");			
			stm.setString(1, cate.getDescripcion());
			stm.setInt(2,cate.getOrden());
			stm.setInt(3,cate.getAutoevaluacion());
			stm.setInt(4,cate.getMultifasico());
			stm.setInt(5,cate.getEstado());
			stm.setInt(6, cate.getIdmenu_categoria().getIdmenu_categoria());
			if(stm.executeUpdate()>0)
				return true;
			
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return false;
	}

	public boolean deleteCategoria(int cate){
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("DELETE FROM categoria WHERE idcategoria = ?");
			
			stm.setInt(1,cate);
			if(stm.executeUpdate()>0)
				return true;
			
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return false;
	}
	public ArrayList<CCategoria> getListaCategoria(int ordenar,int asc,int min,int max, String busqueda){
		ArrayList<CCategoria> ret=new ArrayList<CCategoria>();
		try{
			String sql="select * from (SELECT tc.idcategoria, tc.descripcion, tc.orden, tc.autoevaluacion, tc.multifasico, tc.estado, tc.idmenu_categoria, @rownum:=@rownum+1 rownum  "+
						"FROM categoria tc, (SELECT @rownum:=0) ro  "+
						"where  upper(tc.descripcion) like ? "+
						" ) table1 "+
						" where rownum>=? and rownum<=? order by ? "+((asc==1)?"ASC":"DESC") +"";
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			int id=1;
			stm.setString(id++,"%"+busqueda.trim().toUpperCase()+"%");
			stm.setInt(id++,min);
			stm.setInt(id++,max);
			stm.setInt(id++,ordenar);
			ResultSet rs=stm.executeQuery();
			while(rs.next()){
				CCategoria news=new CCategoria(rs.getInt("idcategoria"),rs.getString("descripcion"),rs.getInt("orden"),rs.getInt("autoevaluacion"),rs.getInt("multifasico"),rs.getInt("estado"),new CMenu_Categoria(rs.getInt("idmenu_categoria"),""));
				ret.add(news);
				
			}
			rs.close();
			stm.close();
		} catch (SQLException e) {

			e.printStackTrace();
		}
		return ret;
	}
	public ArrayList<CCategoria> getListaCategoria(){
		ArrayList<CCategoria> ret=new ArrayList<CCategoria>();
		try{
			String sql="SELECT tc.idcategoria, tc.descripcion, tc.orden, tc.autoevaluacion, tc.multifasico,tc.estado,tc.idmenu_categoria "+
						"FROM categoria tc  ";
			
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			ResultSet rs=stm.executeQuery();
			while(rs.next()){
				CMenu_Categoria menu=new CMenu_Categoria(rs.getInt("idmenu_categoria"),"");
				CCategoria news=new CCategoria(rs.getInt("idcategoria"),rs.getString("descripcion"),rs.getInt("orden"),rs.getInt("autoevaluacion"),rs.getInt("multifasico"),rs.getInt("estado"),menu);
				ret.add(news);				
			}
			rs.close();
			stm.close();
		} catch (SQLException e) {

			e.printStackTrace();
		}
		return ret;
	}
	public int getCategoriaTotal(String busqueda){
		int temp=0;
		
				try {
					String sql="SELECT count(*) cant  "+
						" FROM categoria tc where upper(tc.descripcion) like ? ";
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
	public ArrayList<CCategoria_Interpretacion> getListaCategoria(int ordenar,int asc,int idcategoria){
		ArrayList<CCategoria_Interpretacion> ret=new ArrayList<CCategoria_Interpretacion>();
		try{
			String sql=" SELECT ci.idcategoria_interpretacion, ci.ponderacion_max, ci.ponderacion_min,  ca.idcategoria, ca.descripcion FROM categoria_interpretacion ci inner join categoria ca on ca.idcategoria=ci.idcategoria where ci.idcategoria=? order by ? "+((asc==1)?"ASC":"DESC") +"";
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			stm.setInt(1,idcategoria);
			stm.setInt(2,ordenar);
			ResultSet rs=stm.executeQuery();
			while(rs.next()){
				CCategoria cate=new CCategoria(rs.getInt("idcategoria"),rs.getString("descripcion"),0,0,0,0,null);
				CCategoria_Interpretacion news=new CCategoria_Interpretacion(rs.getInt("idcategoria_interpretacion"),rs.getInt("ponderacion_max"),rs.getInt("ponderacion_min"),"",cate);
				ret.add(news);
				
			}
			rs.close();
			stm.close();
		} catch (SQLException e) {

			e.printStackTrace();
		}
		return ret;
	}
	public CCategoria_Interpretacion getCategoria_InterpretacionEspecifico(int idcate){
		CCategoria_Interpretacion ret=null;
		try{
			String sql="SELECT idcategoria_interpretacion, ponderacion_max, ponderacion_min, interpretacion, idcategoria FROM categoria_interpretacion where idcategoria_interpretacion=?";
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			stm.setInt(1,idcate);
			ResultSet rs=stm.executeQuery();
			while(rs.next()){
				ret=new CCategoria_Interpretacion(rs.getInt("idcategoria_interpretacion"),rs.getInt("ponderacion_max"),rs.getInt("ponderacion_min"),rs.getString("interpretacion"),null);
			}
			rs.close();
			stm.close();
		} catch (SQLException e) {

			e.printStackTrace();
		}
		return ret;
	}
	public boolean UpdateCategoria_Interpretacion(CCategoria_Interpretacion cate){
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("UPDATE categoria_interpretacion SET ponderacion_max = ?, ponderacion_min = ?, interpretacion = ? WHERE idcategoria_interpretacion = ?");
			
			stm.setInt(1,cate.getPonderacion_max());
			stm.setInt(2,cate.getPonderacion_min());
			stm.setString(3,cate.getInterpretacion());
			stm.setInt(4,cate.getIdcategoria_interpretacion());
			if(stm.executeUpdate()>0)
				return true;
			
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return false;
	}
	public boolean SafeCategoria_Interpretacion(CCategoria_Interpretacion cate){
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("INSERT INTO categoria_interpretacion(ponderacion_max, ponderacion_min, interpretacion, idcategoria) VALUES (?,?,?,?)");
			stm.setInt(1,cate.getPonderacion_max());
			stm.setInt(2,cate.getPonderacion_min());
			stm.setString(3,cate.getInterpretacion());
			stm.setInt(4,cate.getIdcategoria().getIdcategoria());
			if(stm.executeUpdate()>0)
				return true;
			
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return false;
	}
	public boolean deleteCategoria_Interpretacion(int cate){
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("DELETE FROM categoria_interpretacion WHERE idcategoria_interpretacion = ?");
			
			stm.setInt(1,cate);
			if(stm.executeUpdate()>0)
				return true;
			
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return false;
	}
	
	public ArrayList<CTitulo_Respuesta> getListaTitulo_Respuesta(int grupo){
		ArrayList<CTitulo_Respuesta> ret=new ArrayList<CTitulo_Respuesta>();
		try{
			String sql=" select tr.idtitulo_respuesta, tr.descripcion from grupo_titulo_respuesta g inner join titulo_respuesta tr "+
					" on g.idtitulo_respuesta=tr.idtitulo_respuesta where g.idgrupo=? "+
					" order by  idgrupo,orden ";
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			stm.setInt(1,grupo);
			
			ResultSet rs=stm.executeQuery();
			while(rs.next()){
				CTitulo_Respuesta cate=new CTitulo_Respuesta(rs.getInt("idtitulo_respuesta"),rs.getString("descripcion"));
				ret.add(cate);
				
			}
			rs.close();
			stm.close();
		} catch (SQLException e) {

			e.printStackTrace();
		}
		return ret;
	}
	public ArrayList<CTitulo_Respuesta> getListaTitulo_Respuesta(){
		ArrayList<CTitulo_Respuesta> ret=new ArrayList<CTitulo_Respuesta>();
		try{
			String sql=" select tr.idtitulo_respuesta, tr.descripcion from  titulo_respuesta tr ";
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			ResultSet rs=stm.executeQuery();
			while(rs.next()){
				CTitulo_Respuesta cate=new CTitulo_Respuesta(rs.getInt("idtitulo_respuesta"),rs.getString("descripcion"));
				ret.add(cate);
				
			}
			rs.close();
			stm.close();
		} catch (SQLException e) {

			e.printStackTrace();
		}
		return ret;
	}
	public ArrayList<CTipo_Pregunta> getListaTipo_Pregunta(){
		ArrayList<CTipo_Pregunta> ret=new ArrayList<CTipo_Pregunta> ();
		try{
			String sql="SELECT idtipo_pregunta, descripcion, ifnull(idgrupo,0) idgrupo FROM tipo_pregunta";
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			ResultSet rs=stm.executeQuery();
			while(rs.next()){
				ArrayList<CTitulo_Respuesta> lista= this.getListaTitulo_Respuesta(rs.getInt("idgrupo"));
				CTipo_Pregunta ct=new CTipo_Pregunta(rs.getInt("idtipo_pregunta"),rs.getString("descripcion"),lista);
				ret.add(ct);
			}
			rs.close();
			stm.close();
		} catch (SQLException e) {

			e.printStackTrace();
		}
		return ret;
	}
	public CTipo_Pregunta getTipo_PreguntaEspecifica(int id){
		CTipo_Pregunta ret=null;
		try{
			String sql="SELECT idtipo_pregunta, descripcion, ifnull(idgrupo,0) idgrupo FROM tipo_pregunta where idtipo_pregunta=?";
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			stm.setInt(1, id);
			ResultSet rs=stm.executeQuery();
			while(rs.next()){
				ArrayList<CTitulo_Respuesta> lista= this.getListaTitulo_Respuesta(rs.getInt("idgrupo"));
				ret=new CTipo_Pregunta(rs.getInt("idtipo_pregunta"),rs.getString("descripcion"),lista);
				
			}
			rs.close();
			stm.close();
		} catch (SQLException e) {

			e.printStackTrace();
		}
		return ret;
	}
	public boolean SafePregunta(CPregunta ctipo){
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("INSERT INTO pregunta (orden, requerida, pregunta, categoriaidcategoria, descripcion, idtipo_pregunta, auto_evaluacion, multifasico, largo, multiple,estado)VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?)");
			
			stm.setInt(1,ctipo.getOrden());
			stm.setInt(2, ctipo.getRequerida());
			stm.setString(3, ctipo.getPregunta());
			stm.setInt(4, ctipo.getIdcategoria().getIdcategoria());
			stm.setString(5, ctipo.getDescripcion());
			stm.setInt(6, ctipo.getIdtipo_pregunta().getIdtipo_pregunta());
			stm.setInt(7, ctipo.getAuto_evaluacion());
			stm.setInt(8, ctipo.getMultifasico());
			stm.setInt(9, ctipo.getLargo());
			stm.setInt(10, ctipo.getMultiple());
			stm.setInt(11, ctipo.getEstado());
			if(stm.executeUpdate()>0)
				return true;
			
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return false;
	}
	public boolean UpdatePregunta(CPregunta ctipo){
		PreparedStatement stm;
		try {
			String sql="UPDATE pregunta SET orden = ?, requerida = ?, pregunta = ?, categoriaidcategoria = ?,  descripcion = ?, "+
						"  auto_evaluacion = ?,  multifasico = ?,  largo = ?,  multiple = ?,  estado = ?  "+
						" WHERE idpregunta = ?";
			stm = (PreparedStatement)conn.prepareStatement(sql);
			
			stm.setInt(1,ctipo.getOrden());
			stm.setInt(2, ctipo.getRequerida());
			stm.setString(3, ctipo.getPregunta());
			stm.setInt(4, ctipo.getIdcategoria().getIdcategoria());
			stm.setString(5, ctipo.getDescripcion());
			stm.setInt(6, ctipo.getAuto_evaluacion());
			stm.setInt(7, ctipo.getMultifasico());
			stm.setInt(8, ctipo.getLargo());
			stm.setInt(9, ctipo.getMultiple());
			stm.setInt(10, ctipo.getEstado());
			stm.setInt(11, ctipo.getIdpregunta());
			if(stm.executeUpdate()>0)
				return true;
			
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return false;
	}
	public CTitulo_Respuesta getTitulo_RespuestaEspecifica(String titulo){
		CTitulo_Respuesta ret=null;
		try{
			String sql="select idtitulo_respuesta, descripcion from titulo_respuesta where upper(descripcion)=upper(?) limit 1";
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			stm.setString(1, titulo);
			ResultSet rs=stm.executeQuery();
			while(rs.next()){
				ret=new CTitulo_Respuesta(rs.getInt("idtitulo_respuesta"),rs.getString("descripcion"));
			}
			rs.close();
			stm.close();
		} catch (SQLException e) {

			e.printStackTrace();
		}
		return ret;
	}
	public int getPreguntaEspecifica(CPregunta ctipo){
		int ret=0;
		try{
			String sql="select  max(idpregunta) max from pregunta where  orden=? and requerida=? and pregunta=? and categoriaidcategoria=? and descripcion=? and idtipo_pregunta=? and auto_evaluacion=? and multifasico=? and largo=? and multiple=? and estado=? ";
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			stm.setInt(1,ctipo.getOrden());
			stm.setInt(2, ctipo.getRequerida());
			stm.setString(3, ctipo.getPregunta());
			stm.setInt(4, ctipo.getIdcategoria().getIdcategoria());
			stm.setString(5, ctipo.getDescripcion());
			stm.setInt(6, ctipo.getIdtipo_pregunta().getIdtipo_pregunta());
			stm.setInt(7, ctipo.getAuto_evaluacion());
			stm.setInt(8, ctipo.getMultifasico());
			stm.setInt(9, ctipo.getLargo());
			stm.setInt(10,ctipo.getMultiple());
			stm.setInt(11,ctipo.getEstado());
			ResultSet rs=stm.executeQuery();
			while(rs.next()){
				ret=rs.getInt("max");
			}
			rs.close();
			stm.close();
		} catch (SQLException e) {

			e.printStackTrace();
		}
		return ret;
	}
	public int SafeTitulo_Respuesta(CTitulo_Respuesta titulo){
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("INSERT INTO titulo_respuesta (descripcion) VALUES (?)");
			
			stm.setString(1,titulo.getDescripcion());
			
			if(stm.executeUpdate()>0)
				{
					String sql="select  max(idtitulo_respuesta) max from titulo_respuesta where  descripcion=? ";
					PreparedStatement stm1=(PreparedStatement)conn.prepareStatement(sql);
					stm1.setString(1, titulo.getDescripcion());
					ResultSet rs=stm1.executeQuery();
					while(rs.next()){
						int max=rs.getInt("max");
						return max;
					}
				}
			
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return 0;
	}
	public boolean SafePregunta_Titulo_Respuesta(CPregunta ctipo,ArrayList<CPregunta_Titulo_Respuesta> lista){
		PreparedStatement stm;
		try {
			
			Iterator<CPregunta_Titulo_Respuesta> it=lista.iterator();
			while(it.hasNext()){
				CPregunta_Titulo_Respuesta preg=it.next();
				if(preg.getIdtitulo_respuesta().getIdtitulo_respuesta()<=0){
					int id=SafeTitulo_Respuesta(preg.getIdtitulo_respuesta());
					preg.getIdtitulo_respuesta().setIdtitulo_respuesta(id);
				}	
				stm = (PreparedStatement)conn.prepareStatement("INSERT INTO pregunta_titulo_respuesta (idtitulo_respuesta, idpregunta, ponderacion) VALUES (?,?,?)");
				stm.setInt(1,preg.getIdtitulo_respuesta().getIdtitulo_respuesta());
				stm.setInt(2,ctipo.getIdpregunta());
				stm.setInt(3,preg.getPonderacion());
				
				if(preg.getIdtitulo_respuesta().getIdtitulo_respuesta()<=0) return false;
				if(stm.executeUpdate()<=0) return false;
			}
			
			
			
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return true;
	}
	public boolean UpdatePregunta_Titulo_Respuesta(ArrayList<CPregunta_Titulo_Respuesta> lista){
		PreparedStatement stm;
		try {
			
			Iterator<CPregunta_Titulo_Respuesta> it=lista.iterator();
			while(it.hasNext()){
				CPregunta_Titulo_Respuesta preg=it.next();
				String sql=" UPDATE pregunta_titulo_respuesta SET "+
						   "  ponderacion = ? "+
						   " WHERE "+
						   "  idtitulo_respuesta = ? AND idpregunta = ?";
				stm = (PreparedStatement)conn.prepareStatement(sql);
				stm.setInt(1,preg.getPonderacion());
				stm.setInt(2,preg.getIdtitulo_respuesta().getIdtitulo_respuesta());
				stm.setInt(3,preg.getIdpregunta().getIdpregunta());
				
				
				if(preg.getIdtitulo_respuesta().getIdtitulo_respuesta()<=0) return false;
				if(stm.executeUpdate()<=0) return false;
			}
			
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return true;
	}
	public ArrayList<CPregunta> getListaPreguntas(int ordenar,int asc,int min,int max,int tipo,String valor){
		ArrayList<CPregunta> ret=new ArrayList<CPregunta>();
		try{
			String like="pe.pregunta";
			if(tipo==2) like="ca.descripcion";
			String sql="select * from  (SELECT pe.idpregunta, pe.orden, pe.requerida, pe.pregunta, ca.idcategoria, ca.descripcion cate_nombre, "+
					" pe.descripcion, pe.auto_evaluacion, pe.multifasico, @rownum:=@rownum+1 rownum, pe.estado "+
					" FROM pregunta pe inner join categoria ca on ca.idcategoria=pe.categoriaidcategoria, (SELECT @rownum:=0) ro " +
					" where upper("+like+") like ? ) table1 "+
					" where rownum>=? and rownum<=? order by ? "+((asc==1)?"ASC":"DESC") +"";
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			stm.setString(1, "%"+valor.trim().toUpperCase()+"%");
			stm.setInt(2,min);
			stm.setInt(3,max);
			stm.setInt(4,ordenar);
			ResultSet rs=stm.executeQuery();
			while(rs.next()){
				CCategoria cate=new CCategoria(rs.getInt("idcategoria"),rs.getString("cate_nombre"),0,0,0,0,null);
				CPregunta news=new CPregunta(rs.getInt("idpregunta"),rs.getInt("orden"), rs.getInt("requerida"),rs.getString("pregunta"),
						cate, rs.getString("descripcion"),null,rs.getInt("auto_evaluacion"),
						rs.getInt("multifasico"),0,0,rs.getInt("estado"));
				
				ret.add(news);
				
			}
			rs.close();
			stm.close();
		} catch (SQLException e) {

			e.printStackTrace();
		}
		return ret;
	}
	public int getPreguntaTotal(){
		int temp=0;
		
				try {
					String sql="SELECT count(*) cant  "+
						" FROM pregunta  ";
					PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
					ResultSet rs2=stm.executeQuery();
					if(rs2.next())
					temp=rs2.getInt("cant");
				} catch (SQLException e) {
		
					e.printStackTrace();
				}
		
		return temp;
	}
	public CPregunta getPreguntaEspecifica(int idpregunta){
		CPregunta news=null;
		try{
			String sql=" SELECT pe.idpregunta, pe.orden, pe.requerida, pe.pregunta, ca.idcategoria, ca.descripcion cate_nombre, pe.descripcion, pe.idtipo_pregunta,"+
					" pe.auto_evaluacion, pe.multifasico, pe.largo, pe.multiple, pe.estado  "+
					" FROM pregunta  pe inner join categoria ca on ca.idcategoria=pe.categoriaidcategoria "+
					" where idpregunta=? ";
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			stm.setInt(1,idpregunta);
			ResultSet rs=stm.executeQuery();
			while(rs.next()){
				CTipo_Pregunta tipo=this.getTipo_PreguntaEspecifica(rs.getInt("idtipo_pregunta"));
				CCategoria cate=new CCategoria(rs.getInt("idcategoria"),rs.getString("cate_nombre"),0,0,0,0,null);
				news=new CPregunta(rs.getInt("idpregunta"),rs.getInt("orden"), rs.getInt("requerida"),rs.getString("pregunta"),
						cate, rs.getString("descripcion"),tipo,rs.getInt("auto_evaluacion"),
						rs.getInt("multifasico"),rs.getInt("largo"),rs.getInt("multiple"),rs.getInt("estado"));
				
				
			}
			rs.close();
			stm.close();
		} catch (SQLException e) {

			e.printStackTrace();
		}
		return news;
	}
	public ArrayList<CPregunta_Titulo_Respuesta> getListaPregunta_Titulo_Respuesta(CPregunta preg){
		ArrayList<CPregunta_Titulo_Respuesta> ret=new ArrayList<CPregunta_Titulo_Respuesta>();
		try{
			String sql="SELECT ptr.idtitulo_respuesta, ptr.ponderacion, tr.descripcion "+
					" FROM pregunta_titulo_respuesta ptr inner join titulo_respuesta tr "+
					" on tr.idtitulo_respuesta=ptr.idtitulo_respuesta where ptr.idpregunta=? ";
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			stm.setInt(1,preg.getIdpregunta());

			ResultSet rs=stm.executeQuery();
			while(rs.next()){
				CTitulo_Respuesta idtitulo_respuesta =new CTitulo_Respuesta(rs.getInt("idtitulo_respuesta"),rs.getString("descripcion"));
				CPregunta_Titulo_Respuesta temp= new CPregunta_Titulo_Respuesta(preg,idtitulo_respuesta ,rs.getInt("ponderacion"));
				ret.add(temp);
			}
			rs.close();
			stm.close();
		} catch (SQLException e) {

			e.printStackTrace();
		}
		return ret;
	}
	public CPaciente getEstudianteEspecifica(String usuario,String password){
		CPaciente news=null;
		try{
			String sql=" SELECT p.idpaciente, p.nombre, p.fecha_nac, ifnull(p.carne,0) carne, p.direccion, ifnull(p.telefono,'') telefono, ifnull(p.movil,'') movil, ifnull(p.email,'') email, ifnull(p.emer_nombre,'') emer_nombre, ifnull(p.idemer_parentesco,0) idemer_parentesco, ifnull(p.emer_telefono,'') emer_telefono, ifnull(p.emer_movil,'') emer_movil, ifnull(p.carreraidcarrera,0) idcarrera, ifnull(p.tipo_sangreidtipo_sangre,0) idtipo_sangre, ifnull(p.estado_civilidestado_civil,0) idestado_civil, ifnull(p.centro_regionalidcentro_regional,0) idcentro_regional, ifnull(p.unidad_academicaidunidad_academica,0) idunidad_academica, ifnull(p.titulo_secundaria,'') titulo_secundaria, ifnull(p.dependenciaiddependencia,0) iddependencia, p.usuario, ifnull(p.parentesco_ced,0) idparentesco, p.ced, sexo, "+
		" ifnull(crecio_en,'') crecio_en, ifnull(titulo_secundaria,'') titulo_secundaria, "+			
		" ifnull(emer_nombre,'') emer_nombre, ifnull(emer_telefono,'') emer_telefono, ifnull(emer_movil,'') emer_movil,  "+
		" ifnull(idemer_parentesco,'') idemer_parentesco, "+
		" ifnull(p.tipo_sangreidtipo_sangre,0)  idtipo_sangre, "+
		" ifnull(p.estado_civilidestado_civil,0) idestado_civil, ifnull(no_personal,0) no_personal "+
		" FROM paciente p "+
		" where  usuario=? and password=? ";
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			stm.setString(1,usuario.toLowerCase());
			stm.setString(2, password);
			
			ResultSet rs=stm.executeQuery();
			while(rs.next()){
				
				news=new CPaciente(rs.getInt("idpaciente"), rs.getString("nombre"),new java.util.Date(rs.getDate("fecha_nac").getTime()),
						rs.getInt("carne"),  rs.getString("direccion"),rs.getString("telefono"),rs.getString("movil"),
						rs.getInt("idcarrera"), rs.getInt("idcentro_regional"), rs.getInt("idunidad_academica"),rs.getInt("iddependencia"), rs.getInt("sexo"),
						"", rs.getString("email"),
						rs.getString("usuario"), rs.getInt("idparentesco"), rs.getString("ced"), rs.getInt("no_personal"),
						rs.getInt("idestado_civil"), rs.getString("emer_nombre"),
						rs.getInt("idemer_parentesco"), rs.getString("emer_telefono"),
						rs.getString("emer_movil"), rs.getInt("idtipo_sangre"),
						rs.getString("titulo_secundaria"),
						rs.getString("crecio_en")
						);
			}
			rs.close();
			stm.close();
		} catch (SQLException e) {

			e.printStackTrace();
		}
		return news;
	}
	public ArrayList<CCategoria> getListaCategoriaMenu(int auto,int multi,int menu){
		ArrayList<CCategoria> ret=new ArrayList<CCategoria>();
		try{
			String sql="SELECT tc.idcategoria, tc.descripcion, tc.orden, tc.autoevaluacion, tc.multifasico, tc.estado "+
						"FROM categoria tc "+
						" where (tc.autoevaluacion=? or tc.multifasico=?) and tc.estado>0 and tc.idmenu_categoria=?  order by tc.orden ASC";
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			stm.setInt(1,auto);
			stm.setInt(2,multi);
			stm.setInt(3,menu);
			ResultSet rs=stm.executeQuery();
			while(rs.next()){
				CCategoria news=new CCategoria(rs.getInt("idcategoria"),rs.getString("descripcion"),rs.getInt("orden"),rs.getInt("autoevaluacion"),rs.getInt("multifasico"),rs.getInt("estado"),null);
				ret.add(news);
				
			}
			rs.close();
			stm.close();
		} catch (SQLException e) {

			e.printStackTrace();
		}
		return ret;
	}
	public void getListaPreguntaTitulo(CTipo_Pregunta ct, int idpregunta){
		if(ct.getIdtipo_pregunta()==3){
			String sql="SELECT pr.idtitulo_respuesta, tr.descripcion "+
					" FROM pregunta_titulo_respuesta  pr inner join titulo_respuesta tr on "+
					" tr.idtitulo_respuesta=pr.idtitulo_respuesta where pr.idpregunta=?";
			try{
				PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
				stm.setInt(1,idpregunta);
				ResultSet rs=stm.executeQuery();
				while(rs.next()){
					CTitulo_Respuesta titulo=new CTitulo_Respuesta(rs.getInt("idtitulo_respuesta"),rs.getString("descripcion"));
					ct.getIdgrupo_titulo_respuesta().add(titulo);
				}
				rs.close();
				stm.close();
			} catch (SQLException e) {

				e.printStackTrace();
			}
		}
	}
	public ArrayList<CTitulo_Secundaria> getListaTitulo_Secundaria(){
		ArrayList<CTitulo_Secundaria> ret=new ArrayList<CTitulo_Secundaria>();
		try{
			String sql="SELECT tc.idtitulo_secundaria, tc.nombre FROM titulo_secundaria tc  ";
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			ResultSet rs=stm.executeQuery();
			while(rs.next()){
				CTitulo_Secundaria news=new CTitulo_Secundaria(rs.getInt("idtitulo_secundaria"),rs.getString("nombre"));
				ret.add(news);
				
			}
			rs.close();
			stm.close();
		} catch (SQLException e) {

			e.printStackTrace();
		}
		return ret;
	}
	public boolean UpdatePaciente1(CPaciente  pac){
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("UPDATE paciente SET tipo_sangreidtipo_sangre = ?, estado_civilidestado_civil = ?, titulo_secundaria = ?, crecio_en = ?, emer_nombre = ?, emer_telefono = ?, emer_movil = ?, idemer_parentesco = ? WHERE idpaciente = ?");
			stm.setInt(1, pac.getIdtipo_sangre());
			stm.setInt(2, pac.getEstado_civilidestado_civil());
			stm.setString(3, pac.getTitulo_secundaria());
			stm.setString(4, pac.getCrecio_en());
			stm.setString(5, pac.getEmer_nombre());
			stm.setString(6, pac.getEmer_telefono());
			stm.setString(7, pac.getEmer_movil());
			stm.setInt(8, pac.getIdemer_parentesco());
			stm.setInt(9, pac.getIdpaciente());
			
			if(stm.executeUpdate()>0)
				return true;
			
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return false;
	}
	public boolean UpdateMenu_Categoria(CMenu_Categoria ctipo){
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("UPDATE menu_categoria SET nombre = ? WHERE idmenu_categoria = ?");
			
			stm.setString(1, ctipo.getNombre());
			stm.setInt(2,ctipo.getIdmenu_categoria());
			if(stm.executeUpdate()>0)
				return true;
			
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return false;
	}
	public boolean SafeMenu_Categoria(CMenu_Categoria ctipo){
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("INSERT INTO  menu_categoria(nombre) VALUES (?)");
			
			stm.setString(1,ctipo.getNombre());
			if(stm.executeUpdate()>0)
				return true;
			
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return false;
	}
	public ArrayList<CMenu_Categoria> getListaMenu_Categoria(int ordenar,int asc,int min,int max, String busqueda){
		ArrayList<CMenu_Categoria> ret=new ArrayList<CMenu_Categoria>();
		try{
			String sql="select * from (SELECT tc.idmenu_categoria, tc.nombre, @rownum:=@rownum+1 rownum  "+
						"FROM menu_categoria tc, (SELECT @rownum:=0) ro  "+
						"where  upper(tc.nombre) like ? "+
						" ) table1 "+
						" where rownum>=? and rownum<=? order by ? "+((asc==1)?"ASC":"DESC") +"";
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			int id=1;
			stm.setString(id++,"%"+busqueda.trim().toUpperCase()+"%");
			stm.setInt(id++,min);
			stm.setInt(id++,max);
			stm.setInt(id++,ordenar);
			ResultSet rs=stm.executeQuery();
			while(rs.next()){
				CMenu_Categoria news=new CMenu_Categoria(rs.getInt("idmenu_categoria"),rs.getString("nombre"));
				ret.add(news);
				
			}
			rs.close();
			stm.close();
		} catch (SQLException e) {

			e.printStackTrace();
		}
		return ret;
	}
	public int getMenu_CategoriaTotal(String busqueda){
		int temp=0;
		
				try {
					String sql="SELECT count(*) cant  "+
						" FROM menu_categoria tc where upper(tc.nombre) like ? ";
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
	public boolean deleteMenu_Categoria(int ctipo){
		PreparedStatement stm;
		try {
			stm = (PreparedStatement)conn.prepareStatement("DELETE FROM menu_categoria WHERE idmenu_categoria = ?");
			
			stm.setInt(1,ctipo);
			if(stm.executeUpdate()>0)
				return true;
			
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return false;
	}
	public ArrayList<CMenu_Categoria> getListaMenu_Categoria(){
		ArrayList<CMenu_Categoria> list=new ArrayList<CMenu_Categoria>();
		try{

			String sql="SELECT idmenu_categoria, nombre FROM menu_categoria";
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			
			ResultSet rs=stm.executeQuery();
			while(rs.next()){
				CMenu_Categoria dep=new CMenu_Categoria(rs.getInt("idmenu_categoria"),rs.getString("nombre"));
				list.add(dep);
				
			}
			rs.close();
			stm.close();
		}
		catch(Throwable e){
			e.printStackTrace();
		}
		
		return list;
	}
	public ArrayList<CPregunta> getListaPreguntas(CCategoria categoria, int auto, int multi){
		ArrayList<CPregunta> ret=new ArrayList<CPregunta>();
		try{
			String sql="SELECT pe.idpregunta, pe.orden, pe.requerida, pe.pregunta, pe.largo, pe.multiple, "+
					" pe.descripcion, pe.auto_evaluacion, pe.multifasico, pe.estado, tp.idtipo_pregunta, tp.descripcion  descripcion_preg, tp.idgrupo "+
					" FROM pregunta pe inner join tipo_pregunta tp on tp.idtipo_pregunta=pe.idtipo_pregunta " +
					" where pe.categoriaidcategoria=? and (pe.auto_evaluacion=? or pe.multifasico=?) order by pe.orden ASC";
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			stm.setInt(1, categoria.getIdcategoria());
			stm.setInt(2,auto);
			stm.setInt(3,multi);
			ResultSet rs=stm.executeQuery();
			while(rs.next()){
				ArrayList<CTitulo_Respuesta> lista=new ArrayList<CTitulo_Respuesta>();
					if(rs.getInt("idtipo_pregunta")>3){
						lista= this.getListaTitulo_Respuesta(rs.getInt("idgrupo"));
						
					}
					CTipo_Pregunta ct=new CTipo_Pregunta(rs.getInt("idtipo_pregunta"),rs.getString("descripcion_preg"),lista);
					getListaPreguntaTitulo(ct, rs.getInt("idpregunta"));
				CPregunta news=new CPregunta(rs.getInt("idpregunta"),rs.getInt("orden"), rs.getInt("requerida"),rs.getString("pregunta"),
						categoria, rs.getString("descripcion"),ct,rs.getInt("auto_evaluacion"),
						rs.getInt("multifasico"),rs.getInt("largo"),rs.getInt("multiple"),rs.getInt("estado"));
				
				ret.add(news);
				
			}
			rs.close();
			stm.close();
		} catch (SQLException e) {

			e.printStackTrace();
		}
		return ret;
	}
	/*** aqui ****/
	public ArrayList<CPregunta> getListaPreguntas(int menu ,int auto, int multi){
		ArrayList<CPregunta> ret=new ArrayList<CPregunta>();
		try{
			String sql="SELECT pe.idpregunta, pe.orden, pe.requerida, pe.pregunta, pe.largo, pe.multiple, "+
					" pe.descripcion, pe.auto_evaluacion, pe.multifasico, pe.estado, tp.idtipo_pregunta, tp.descripcion  descripcion_preg, tp.idgrupo, "+
					" cat.idcategoria idcate, cat.descripcion nombre_cat " +
					" FROM pregunta pe inner join tipo_pregunta tp on tp.idtipo_pregunta=pe.idtipo_pregunta " +
					" inner join categoria cat on cat.idcategoria=pe.categoriaidcategoria "+
					" inner join menu_categoria mc on mc.idmenu_categoria=cat.idmenu_categoria "+
					" where mc.idmenu_categoria=? and (pe.auto_evaluacion=? or pe.multifasico=?) order by pe.orden ASC";
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			stm.setInt(1, menu);
			stm.setInt(2,auto);
			stm.setInt(3,multi);
			ResultSet rs=stm.executeQuery();
			while(rs.next()){
				ArrayList<CTitulo_Respuesta> lista=new ArrayList<CTitulo_Respuesta>();
					if(rs.getInt("idtipo_pregunta")>3){
						lista= this.getListaTitulo_Respuesta(rs.getInt("idgrupo"));
						
					}
					CCategoria categoria=new CCategoria(rs.getInt("idcate"),rs.getString("nombre_cat"),0,0, 0, 0,null);
					CTipo_Pregunta ct=new CTipo_Pregunta(rs.getInt("idtipo_pregunta"),rs.getString("descripcion_preg"),lista);
					getListaPreguntaTitulo(ct, rs.getInt("idpregunta"));
					CPregunta news=new CPregunta(rs.getInt("idpregunta"),rs.getInt("orden"), rs.getInt("requerida"),rs.getString("pregunta"),
						categoria, rs.getString("descripcion"),ct,rs.getInt("auto_evaluacion"),
						rs.getInt("multifasico"),rs.getInt("largo"),rs.getInt("multiple"),rs.getInt("estado"));
				
				ret.add(news);
				
			}
			rs.close();
			stm.close();
		} catch (SQLException e) {

			e.printStackTrace();
		}
		return ret;
	}
	public ArrayList<CMenu_Categoria> getListaMenu_Categoria(int auto,int multi){
		ArrayList<CMenu_Categoria> list=new ArrayList<CMenu_Categoria>();
		try{

			String sql="SELECT  distinct mc.idmenu_categoria, mc.nombre FROM menu_categoria mc inner join categoria c on mc.idmenu_categoria=c.idmenu_categoria where c.autoevaluacion=? or c.multifasico=?";
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			stm.setInt(1, auto);
			stm.setInt(2, multi);
			ResultSet rs=stm.executeQuery();
			while(rs.next()){
				CMenu_Categoria dep=new CMenu_Categoria(rs.getInt("idmenu_categoria"),rs.getString("nombre"));
				list.add(dep);
				
			}
			rs.close();
			stm.close();
		}
		catch(Throwable e){
			e.printStackTrace();
		}
		
		return list;
	}
	public boolean SafeRespuesta(CPregunta_Paciente tipo){
		PreparedStatement stm;
		try {
			
			String sql=" SELECT ifnull(idpaciente,0) cant FROM pregunta_paciente where idpregunta=? and idpaciente=? ";
				stm=(PreparedStatement)conn.prepareStatement(sql);
				stm.setInt(1, tipo.getIdpregunta());
				stm.setInt(2, tipo.getIdpaciente());
				
				ResultSet rs2=stm.executeQuery();
				int temp=0;
				if(rs2.next()) temp=rs2.getInt("cant");
				
				if(temp==0){
				stm = (PreparedStatement)conn.prepareStatement("INSERT INTO pregunta_paciente (respuesta, cantidad,idpregunta, idpaciente) VALUES (?,?,?,?)");
				}else{

				stm = (PreparedStatement)conn.prepareStatement("UPDATE pregunta_paciente SET respuesta = ?, cantidad = ? WHERE idpregunta = ? AND idpaciente = ?");	
				}
				
				if(tipo.getRespuesta()==null) stm.setNull(1, java.sql.Types.NULL);
				else stm.setString(1, tipo.getRespuesta());
				if(tipo.getCantidad()==null) stm.setNull(2, java.sql.Types.NULL);
				else stm.setInt(2, tipo.getCantidad());
				stm.setInt(3,tipo.getIdpregunta());
				stm.setInt(4, tipo.getIdpaciente());
				
			if(stm.executeUpdate()>0 && tipo.getTipo()>=3 ){
					if(tipo.getLista().size()>0){
						stm = (PreparedStatement)conn.prepareStatement("DELETE FROM pregunta_paciente_titulo_respuesta WHERE idpregunta = ? AND idpaciente = ?");
						
						stm.setInt(1,tipo.getIdpregunta());
						stm.setInt(2, tipo.getIdpaciente());
						stm.executeUpdate();
						Iterator<Integer> it=tipo.getLista().iterator();
							while(it.hasNext()){
								int idtitulo=it.next();
								stm = (PreparedStatement)conn.prepareStatement("INSERT INTO pregunta_paciente_titulo_respuesta (idpregunta,idpaciente, idtitulo_respuesta) VALUES (?,?,?)");
								stm.setInt(1,tipo.getIdpregunta());
								stm.setInt(2, tipo.getIdpaciente());
								stm.setInt(3, idtitulo);
								stm.executeUpdate();
							}
						
						//return true;
					}	
				}
					return true;
				
				
				
				
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return false;
	}
	
	public Map<Integer,CPregunta_Paciente> getListaPreguntas_Paciente(int menu, int auto, int multi,int idpaciente){
		Map<Integer,CPregunta_Paciente> ret=new HashMap<Integer,CPregunta_Paciente>();
		try{
			PreparedStatement stm;
			String sql="select pp.idpregunta, pp.idpaciente, ifnull(pp.respuesta,'') respuesta, ifnull(pp.cantidad,0) cantidad , p.idtipo_pregunta "+
				" from pregunta  p "+
				" inner join pregunta_paciente pp on p.idpregunta=pp.idpregunta "+
				" inner join categoria cat on cat.idcategoria=p.categoriaidcategoria "+
				" inner join menu g on g.idmenu=cat.idmenu_categoria "+
				" where pp.idpaciente=? and g.idmenu=? and (p.multifasico=? or p.auto_evaluacion=?) ";
			stm=(PreparedStatement)conn.prepareStatement(sql);
			stm.setInt(1, idpaciente);
			stm.setInt(2, menu);
			stm.setInt(3, multi);
			stm.setInt(4, auto);
			ResultSet rs=stm.executeQuery();
			while(rs.next()){
				ArrayList<Integer>lista=new ArrayList<Integer>();
				CPregunta_Paciente cp=new CPregunta_Paciente(rs.getInt("idpregunta"),rs.getInt("idpaciente"),rs.getInt("cantidad"),rs.getString("respuesta"),lista,rs.getInt("idtipo_pregunta") );
				ret.put(rs.getInt("idpregunta"), cp);
				
				sql="select idtitulo_respuesta from  pregunta_paciente_titulo_respuesta pt where pt.idpregunta=? and pt.idpaciente=?";
				stm=(PreparedStatement)conn.prepareStatement(sql);
				stm.setInt(1, rs.getInt("idpregunta"));
				stm.setInt(2, idpaciente);
				ResultSet rs1=stm.executeQuery();
				while(rs1.next()){
					lista.add(rs1.getInt("idtitulo_respuesta"));
				}
			}
			rs.close();
			stm.close();
			
			
		}catch(Throwable e){
				e.printStackTrace();	
		}
		
		return ret;
	}
	public boolean SafeMenu_Paciente(CPaciente_Menu_Categoria tipo){
		PreparedStatement stm;
		try {
			
			String sql="SELECT idmenu_categoria cant,auto_evaluacion, multifasico FROM paciente_menu_categoria where idmenu_categoria=? and idpaciente=? ";
				stm=(PreparedStatement)conn.prepareStatement(sql);
				stm.setInt(1, tipo.getIdmenu_categoria());
				stm.setInt(2, tipo.getIdpaciente());
				
				ResultSet rs2=stm.executeQuery();
				int temp=0;
				if(rs2.next()){ 
					temp=rs2.getInt("cant");
					if(rs2.getInt("auto_evaluacion")==1){
						tipo.setAuto_evaluacion(1);
					}
					if(rs2.getInt("multifasico")==1){
						tipo.setMultifasico(1);
					}
				}
				if(temp==0){
				stm = (PreparedStatement)conn.prepareStatement("INSERT INTO paciente_menu_categoria (auto_evaluacion, multifasico,idpaciente, idmenu_categoria) VALUES (?, ?, ?, ?)");
				}else{

				stm = (PreparedStatement)conn.prepareStatement("UPDATE paciente_menu_categoria SET auto_evaluacion = ?, multifasico = ? WHERE idpaciente = ? AND idmenu_categoria = ?");	
				}
				
				stm.setInt(1,tipo.getAuto_evaluacion());
				stm.setInt(2, tipo.getMultifasico());
				stm.setInt(3, tipo.getIdpaciente());
				stm.setInt(4, tipo.getIdmenu_categoria());
				
			if(stm.executeUpdate()>0 ) return true;
				
				
				
				
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return false;
	}
	public ArrayList<Integer> ListaMenu_Categoria_Auto(int idpaciente){
		ArrayList<Integer> list=new ArrayList<Integer>();
		PreparedStatement stm;
		try{
			String sql=" select idmenu_categoria from paciente_menu_categoria where auto_evaluacion=1 and idpaciente=? ";
				stm=(PreparedStatement)conn.prepareStatement(sql);
				stm.setInt(1, idpaciente);
				ResultSet rs=stm.executeQuery();
				while(rs.next()){
					list.add(rs.getInt("idmenu_categoria"));
				}
		}catch(SQLException e){
			e.printStackTrace();
		}
		return list;
	}
	public ArrayList<Integer> ListaMenu_Categoria_Multi(int idpaciente){
		ArrayList<Integer> list=new ArrayList<Integer>();
		PreparedStatement stm;
		try{
			String sql=" select idmenu_categoria from paciente_menu_categoria where multifasico=1 and idpaciente=? ";
				stm=(PreparedStatement)conn.prepareStatement(sql);
				stm.setInt(1, idpaciente);
				ResultSet rs=stm.executeQuery();
				while(rs.next()){
					list.add(rs.getInt("idmenu_categoria"));
				}
		}catch(SQLException e){
			e.printStackTrace();
		}
		return list;
	}
	
}
