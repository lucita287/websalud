package framework;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.mysql.jdbc.PreparedStatement;

import data.CCarrera;
import data.CCentro_Regional;
import data.CDepartamento;
import data.CDependencia;
import data.CEstado_Civil;
import data.CTipo_Sangre;
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
					" FROM centro_regional ct left outer join departamento dep on dep.iddepartamento=ct.departamentoiddepartamento ";
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
			String sql=" SELECT idunidad_academica, nombre FROM unidad_academica ";
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
			String sql=" SELECT idcarrera, nombre FROM carrera ";
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
}
