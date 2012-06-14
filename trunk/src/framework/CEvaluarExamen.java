package framework;

import java.util.ArrayList;
import java.util.Iterator;

import data.CEncabezado_Condicion;

public class CEvaluarExamen {
	private CDataPreg dbo;
	public CEvaluarExamen(){
		dbo=new CDataPreg();
	
	}
	public ArrayList<Integer> Evaluar(int idpaciente){
		ArrayList<Integer> list_result=null;
		if(dbo.Connect()){
				ArrayList<String> listsql=new ArrayList<String>();
			ArrayList<CEncabezado_Condicion> list=dbo.getListaEncabezadoCondicion();
			Iterator<CEncabezado_Condicion> it=list.iterator();
			while(it.hasNext()){
				CEncabezado_Condicion en=it.next();
				String condicion=dbo.ConstruirWhere(idpaciente, en.getIdinicio());
				String sql= " select idresultado_examen from encabezado_condicion ec "+
							" inner join resultado_condicion rc on "+
							" ec.idencabezado_condicion=rc.idencabezado_condicion "+
							" where rc.idencabezado_condicion="+en.getIdencabezado_condicion()+"  and ( "+condicion +") ";
				listsql.add(sql);
			}
			list_result=dbo.getResultadoCondicion(listsql);
		}
		dbo.Close();
		return list_result;
	}
	
	
	
}
