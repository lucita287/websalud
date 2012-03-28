package framework;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.mysql.jdbc.PreparedStatement;

import data.CActividad;
import data.CArea;
import data.CDepartamento;
import data.CDetalleActividad;
import data.CEdificio;

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
}
