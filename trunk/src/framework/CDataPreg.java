package framework;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;

import com.mysql.jdbc.PreparedStatement;

import data.CAnuncio;
import data.CCondicion;
import data.CEncabezado_Condicion;

public class CDataPreg extends CDataBase {
	public ArrayList<CEncabezado_Condicion> getListaEncabezadoCondicion(){
		ArrayList<CEncabezado_Condicion> list=new ArrayList<CEncabezado_Condicion>();		
			try{
				String sql="SELECT pe.idencabezado_condicion, pe.descripcion, pe.idtipo_interpretacion, c.idcondicion "+
						" FROM encabezado_condicion pe inner join condicion c on pe.idencabezado_condicion=c.idencabezado_condicion"
						+" where c.inicio=1 ";
				PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
				ResultSet rs=stm.executeQuery();
				while(rs.next()){
					CEncabezado_Condicion news=null;
					news=new CEncabezado_Condicion(rs.getInt("idencabezado_condicion"),rs.getString("descripcion"),
							rs.getInt("idtipo_interpretacion"));
					
					news.setIdinicio(rs.getInt("idcondicion"));
					list.add(news);
				}
				rs.close();
				stm.close();
			} catch (SQLException e) {

				e.printStackTrace();
			}
			return list;
		
	}	
	public CAnuncio getAnuncioEspecifico(int idanuncio){
		CAnuncio temp=null;
		PreparedStatement stm;
		try {
			
			String sql="SELECT idanuncio, nombre, descripcion, contenido  FROM anuncio where idanuncio=? ";
			stm = (PreparedStatement)conn.prepareStatement(sql);
			stm.setInt(1, idanuncio);
			ResultSet rs=stm.executeQuery();
			if(rs.next()){
				temp=new CAnuncio(rs.getInt("idanuncio"),rs.getString("nombre"),rs.getString("descripcion"),rs.getString("contenido"));
			}
		}catch(Throwable e){
			
			 e.printStackTrace();
		}
		return temp;
	}
	public String recursivo(int idpaciente,Integer init,CCondicion cond1){
		String sql="";
		init++;
		if(init==60) return sql;
		cond1=getCondicionEspecifico(cond1);
		if(cond1.getTipo()==0){
			int idpregunta=cond1.getIdpregunta1();
			int valor=cond1.getValor();
			
			String respuesta=this.SqlRespuesta(idpaciente, idpregunta).trim();
			if(respuesta.compareTo("")==0){
				respuesta+=" -101 ";
			}
				if(cond1.getSigno()==5) sql+=" "+valor+" in ("+respuesta+")";
				else if(cond1.getSigno()==6) sql+=" "+ valor+" not in ("+respuesta+") ";
				else if(cond1.getSigno()==1 && respuesta.contains(",")) sql+=" "+valor+" > GREATEST("+respuesta+") ";
				else if(cond1.getSigno()==2 && respuesta.contains(",")) sql+=" "+valor+" > LEAST("+respuesta+") ";
				else if(cond1.getSigno()==3 && respuesta.contains(",")) sql+=" "+valor+" >= GREATEST("+respuesta+") ";
				else if(cond1.getSigno()==4 && respuesta.contains(",")) sql+=" "+valor+" <= LEAST("+respuesta+") ";
				else if(cond1.getSigno()==1 ) sql+=" "+valor+" > "+respuesta+" ";
				else if(cond1.getSigno()==2 ) sql+=" "+valor+" > "+respuesta+" ";
				else if(cond1.getSigno()==3 ) sql+=" "+valor+" >= "+respuesta+" ";
				else if(cond1.getSigno()==4 ) sql+=" "+valor+" <= "+respuesta+" ";
				else sql+="  "+valor+" in ( "+respuesta+" ) ";
			
		}else if(cond1.getTipo()==1){
			String condicion1= recursivo(idpaciente,init,cond1.getCondicion1());
			String condicion2= recursivo(idpaciente,init,cond1.getCondicion2());
			sql+=" "+condicion1+" and "+condicion2+" ";
		}else if(cond1.getTipo()==2){
			String condicion1= recursivo(idpaciente,init,cond1.getCondicion1());
			String condicion2= recursivo(idpaciente,init,cond1.getCondicion2());
			sql+=" "+condicion1+" or "+condicion2+" ";
		}else if(cond1.getTipo()==3){
			String condicion1= recursivo(idpaciente,init,cond1.getCondicion1());
			sql+=" ("+condicion1+") ";
		}else if(cond1.getTipo()==4){
			String condicion1= recursivo(idpaciente,init,cond1.getCondicion1());
			sql+=" Not ("+condicion1+") ";
		}
		return sql;
	}
	public String SqlRespuesta(int idpaciente, int idpregunta){
		String sql="select  p.idpregunta, "+
				"ifnull(case idtipo_pregunta "+
				"when 1 then (select respuesta from pregunta_paciente where idpregunta=p.idpregunta and idpaciente=?) "+
				"when 2 then '' "+
				"else "+
				"(select GROUP_CONCAT(ptr.ponderacion) "+
				" from pregunta_paciente_titulo_respuesta pptr inner join pregunta_titulo_respuesta ptr on pptr.idpregunta=ptr.idpregunta and pptr.idtitulo_respuesta=ptr.idtitulo_respuesta "+
				" where pptr.idpregunta=p.idpregunta and pptr.idpaciente=?) "+
				" end, '') pond "+
				" from pregunta p where p.idpregunta=? ";
		String result="";
		try {
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			
			stm.setInt(1,idpaciente);
			stm.setInt(2,idpaciente);
			stm.setInt(3,idpregunta);
			ResultSet rs2=stm.executeQuery();
			if(rs2.next())
			result=rs2.getString("pond");
		} catch (SQLException e) {

			e.printStackTrace();
		}

		return result;
		
	}
	public String ConstruirWhere(int idpaciente, int idcondicion){
		Integer init=0;
		CCondicion cond1=new CCondicion(null,null,null,
				null,idcondicion,null,
				null,null,null, null);
		String sql=recursivo(idpaciente,init,cond1);
		
		return sql;
	}
	public ArrayList<Integer> getResultadoCondicion(ArrayList<String> sql ){
		ArrayList<Integer> list=new ArrayList<Integer>();
		Iterator<String> it=sql.iterator();
		String query="";
		while(it.hasNext()){
				try{
					query=it.next();
					PreparedStatement stm=(PreparedStatement)conn.prepareStatement(query);
					ResultSet rs=stm.executeQuery();
					while(rs.next()){
						list.add(rs.getInt("idresultado_examen"));
					}
					rs.close();
					stm.close();
				} catch (SQLException e) {
					System.out.println(query);
					e.printStackTrace();
				}
		}
		return list;
	}
	
	public CCondicion getCondicionEspecifico(CCondicion cond){
		try{
			String sql="SELECT idpregunta1, signo, valor, tipo, idcondicion, idencabezado_condicion, condicion1, condicion2, inicio "+
					"  FROM condicion c where idcondicion= ? ";
			PreparedStatement stm=(PreparedStatement)conn.prepareStatement(sql);
			stm.setInt(1,cond.getIdcondicion());
			ResultSet rs=stm.executeQuery();
			if(rs.next()){
				
				CCondicion cond1=new CCondicion(null,null,null,
						null,rs.getInt("condicion1"),null,
						null,null,null, null);
				CCondicion cond2=new CCondicion(null,null,null,
						null,rs.getInt("condicion2"),null,
						null,null,null, null);
				cond.setIdpregunta1(rs.getInt("idpregunta1"));
				cond.setSigno(rs.getInt("signo"));
				cond.setValor(rs.getInt("valor"));
				cond.setTipo(rs.getInt("tipo"));
				cond.setIdencabezado_condicion(rs.getInt("idencabezado_condicion"));
				cond.setCondicion1(cond1);
				cond.setCondicion2(cond2);
				cond.setInicio(rs.getInt("inicio"));
				
			}
			rs.close();
			stm.close();
		} catch (SQLException e) {

			e.printStackTrace();
		}
		return cond;
	}
}
