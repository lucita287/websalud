package framework;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.Random;

import data.CConfiguracion;
import data.CConfiguracion_Examen;

public class CSeleccionExamen {
	private int seleccion;
	private int numero;
	ArrayList<CConfiguracion_Examen> list ;
	public CSeleccionExamen(int seleccion,int carne,ArrayList<CConfiguracion_Examen> list){
		this.seleccion=seleccion;
		this.list=list;
		if(this.seleccion==0){
			Random rnd = new Random();
			this.numero=Math.abs(rnd.nextInt()%10);
		}else{
			this.numero=carne%10;
		}
	}
	public int getExamen(){
		int result=1;
		Iterator<CConfiguracion_Examen> it=list.iterator();
		
		while(it.hasNext()){
			CConfiguracion_Examen config=it.next();
			if(config.getTerminacion()==this.numero){
				return config.getTipo_examen();
			}
		}
		return result;
	}
	
	
	public static void main (String args[]) {
		CDataExam data=new CDataExam();
		data.Connect();
		CConfiguracion config=data.getConfiguracion();
		CSeleccionExamen selec=new CSeleccionExamen(config.getRandom_carne(),200614790,data.getListaConfiguracion_Examen());
		data.Close();
	}
	
	
}
