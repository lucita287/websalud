package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import data.CDetalleActividad;

import framework.CDataBase;
import framework.CValidation;

/**
 * Servlet implementation class SCalendario
 */
@WebServlet("/SCalendario")
public class SCalendario extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SCalendario() {
        super();
        
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json;charset=UTF-8"); 
    	PrintWriter out = response.getWriter(); 
    	CValidation valid=new CValidation();
    	String action=valid.ValidarRequest(request.getParameter("a"));	
    	
    	if(action.equalsIgnoreCase("showcalendar")){
    		Long start=valid.ConvertLong(valid.ValidarRequest(request.getParameter("start")));
    		if(start<1000000000000L){
    			start=start*1000;
    		}
    		
    		Long end=valid.ConvertLong(valid.ValidarRequest(request.getParameter("end")));
    		if(end<1000000000000L){
    			end=end*1000;
    		}
    		Date fecha_inicio=new Date();
    		int idarea=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idarea")));
    		fecha_inicio.setTime(start);
    		Date fecha_fin=new Date();
    		fecha_fin.setTime(end);
    		//getListaDetalleActividad
    		CDataBase dbo=new CDataBase();
			 dbo.Connect();
			 ArrayList<CDetalleActividad> lista=dbo.getListaDetalleActividad(idarea, fecha_inicio, fecha_fin);
			 String data="[";
			 String lista_data="";
			 for(int j=0; j<lista.size();j++){ 
				 CDetalleActividad da=lista.get(j);
				 lista_data+=(lista_data.compareTo("")==0)?"":",";
				// lista_data+="{\"id\":"+da.getIddetalleactividad()+", \"start\":\""+da.getFormatoFechaCalendar(da.getFecha(), da.getHorainicio())+"\", \"end\":\""+da.getFormatoFechaCalendar(da.getFecha(), da.getHorafin())+"\", \"title\":\""+da.getActividadidactividad().getTitulo()+"\"}";
				 lista_data+="{\"id\":"+da.getIddetalleactividad()+", \"start\":"+da.getFormatoFechaCalendar(da.getFecha(), da.getHorainicio())+", \"end\":"+da.getFormatoFechaCalendar(da.getFecha(), da.getHorafin())+", \"title\":\""+da.getActividadidactividad().getTitulo()+"\"}";
			 }
			 data+=lista_data+"]";
			 out.print(data);
			 dbo.Close();
    	}
	}

}
