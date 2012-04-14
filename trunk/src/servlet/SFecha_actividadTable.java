package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import data.CDetalleActividad;
import data.CUsuarioPermiso;
import framework.CDataBase;
import framework.CValidation;

/**
 * Servlet implementation class SFecha_actividadTable
 */
@WebServlet("/SFecha_actividadTable")
public class SFecha_actividadTable extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SFecha_actividadTable() {
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

		 response.setContentType("text/html;charset=UTF-8"); 
			PrintWriter out = response.getWriter(); 
						
			String codificacion=request.getCharacterEncoding();
			codificacion=(codificacion==null)?"ISO-8859-1":codificacion;
			HttpSession sessiones = request.getSession(false);
			 if(sessiones!=null &&  sessiones.getAttribute("user_permiso")!=null){
					CUsuarioPermiso user_permiso=(CUsuarioPermiso)sessiones.getAttribute("user_permiso");
					if( (user_permiso.getIdpermiso().indexOf(228)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
						CDataBase dbo=new CDataBase();
						 dbo.Connect();
						 CValidation valid=new CValidation();
						 int page=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("page")));
						 int rp=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("rp")));
						 String order=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("sortname")),codificacion);
						 String typeorder=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("sortorder")),codificacion);
						 String fecha_inicio=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("f_ini")),codificacion);
						 String fecha_fin=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("f_fin")),codificacion);
						 
						 fecha_inicio=(fecha_inicio.trim().compareTo("")==0)?fecha_fin:fecha_inicio;
						 fecha_fin=(fecha_fin.trim().compareTo("")==0)?fecha_inicio:fecha_fin;
						 int idactividad=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idactividad")));
						
						 						
												 
												 int min=((page-1)*rp)+1;
												 int max=page*(rp);
												 int ordenar=1;
												 
												 if(order.equalsIgnoreCase("idfecha_actividad")){
												 	 ordenar=1;
												 }else if(order.equalsIgnoreCase("fecha")){
												 	 ordenar=2;
												 }else if(order.equalsIgnoreCase("hora_inicio")){
												 	 ordenar=3;
												 }else if(order.equalsIgnoreCase("hora_fin")){
												 	 ordenar=4;
												 }
												 
												 int asc=0;
												 if(typeorder.equalsIgnoreCase("asc")){
													 asc=1;
												 }
												 
												 ArrayList<CDetalleActividad> list=new ArrayList<CDetalleActividad>();
												 int maximo=0;
												 if(fecha_inicio.compareTo("")==0){
													 maximo=dbo.getDetalleActividadTotal(idactividad);
													 list=dbo.getListaDetalleActividad(idactividad,ordenar,asc,min,max);
												 
												 }else{
													 
													 java.util.Date fecha1=valid.CambiarFormatoNull(fecha_inicio);
													 java.util.Date fecha2=valid.CambiarFormatoNull(fecha_fin);
													 if(fecha1!=null && fecha2!=null){
														 list=dbo.getListaDetalleActividad(idactividad,ordenar,asc,min,max,fecha1,fecha2);
														 maximo=dbo.getDetalleActividadTotal(idactividad,fecha1,fecha2);
													 }
												 }
												 String info="<?xml version=\"1.0\" encoding=\"utf-8\"?>";
												 info+="<rows><page>"+page+"</page><total>"+maximo+"</total>";
												 
												 String data="";
												 for(int i=0; i<list.size();i++){
													 CDetalleActividad temp=list.get(i);
													 
												data+="<row id='"+temp.getIddetalleactividad()+"'><cell><![CDATA[<input type='checkbox'  name='deleteactivity' class='dele_activity' value='"+temp.getIddetalleactividad()+"' />]]></cell><cell><![CDATA["+temp.getIddetalleactividad()+"]]></cell><cell><![CDATA["+temp.getFormatoFechaddmmyy(temp.getFecha())+"]]></cell><cell><![CDATA["+temp.getFormatoFechaDes(temp.getFecha())+"]]></cell><cell><![CDATA["+temp.getFormatoFechahhmm(temp.getHorainicio())+"]]></cell><cell><![CDATA["+temp.getFormatoFechahhmm(temp.getHorafin())+"]]></cell></row>";	 
										
												 }
												 info+=data+"</rows>";
												 out.println(info);
						 				 
						 
						 dbo.Close();
					
			}
		}
	}

}
