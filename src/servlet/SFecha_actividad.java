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

import data.CUsuarioPermiso;
import framework.Base64core;
import framework.CDataBase;
import framework.CValidation;

/**
 * Servlet implementation class SFecha_actividad
 */
@WebServlet("/SFecha_actividad")
public class SFecha_actividad extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SFecha_actividad() {
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
    	CValidation valid=new CValidation();
    	String action=valid.ValidarRequest(request.getParameter("a"));
		Base64core base64=new Base64core();
		
		
		HttpSession sessiones = request.getSession(false);
		 if(sessiones!=null &&  sessiones.getAttribute("user_permiso")!=null){
					 CUsuarioPermiso user_permiso=(CUsuarioPermiso)sessiones.getAttribute("user_permiso");
					 
								CDataBase dbo=new CDataBase();
								 dbo.Connect();
								
								 //MODIFICAR ACTIVIDAD
								 if(action.equalsIgnoreCase("guardar_rango")&& (user_permiso.getIdpermiso().indexOf(229)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
									String result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
									int idactividad=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idactividad")));
									String fecha_inicio=(valid.ValidarRequest(request.getParameter("fecha_inicio")));		
									fecha_inicio=valid.Limpiarvalor(base64.decodificar(fecha_inicio),codificacion);
									String fecha_fin=(valid.ValidarRequest(request.getParameter("fecha_fin")));		
									fecha_fin=valid.Limpiarvalor(base64.decodificar(fecha_fin),codificacion);
									String hora_inicio=(valid.ValidarRequest(request.getParameter("hora_inicio")));		
									hora_inicio=valid.Limpiarvalor(base64.decodificar(hora_inicio),codificacion);
									String hora_fin=(valid.ValidarRequest(request.getParameter("hora_fin")));		
									hora_fin=valid.Limpiarvalor(base64.decodificar(hora_fin),codificacion);
									String phora_inicio=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("hora_inicio_mm")),codificacion);
									String phora_fin=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("hora_fin_mm")),codificacion);
									String validacion=valid.ValidarSiesMayor(idactividad, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar una ACTIVIDAD\"}");
									int lunes=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("lunes")));
									int martes=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("martes")));
									int miercoles=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("miercoles")));
									int jueves=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("jueves")));
									int viernes=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("viernes")));
									int sabado=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("sabado")));
									int domingo=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("domingo")));
									
									validacion=(validacion.compareTo("")==0)?valid.isFechaValida(fecha_inicio,  "Fecha inicio"):validacion;
									validacion=(validacion.compareTo("")==0)?valid.isFechaValida(fecha_fin,  "Fecha fin"):validacion;
									validacion=(validacion.compareTo("")==0)?valid.validarFechaMayoraOtra(fecha_inicio,fecha_fin,"Fecha de Inicio","Fecha de Fin"):validacion;
									validacion=(validacion.compareTo("")==0)?valid.ValidarFormatoHora(hora_inicio,"Hora de Inicio"):validacion;
									validacion=(validacion.compareTo("")==0)?valid.ValidarFormatoHora(hora_fin,"Hora de Fin"):validacion;
									validacion=(validacion.compareTo("")==0)?valid.validarHoraMayoraOtra(hora_inicio,phora_inicio,hora_fin,phora_fin,"Hora de Inicio y Hora de Fin"):validacion;
									
									
									
									if(validacion.compareTo("")==0){
										if(lunes==1 || martes==1||miercoles==1||jueves==1||viernes==1||sabado==1||domingo==1){
											int r=dbo.SafeActividadDetalle(idactividad,valid.CambiarFormatoddmmyy(fecha_inicio),valid.CambiarFormatoddmmyy(fecha_fin), valid.CambiarFormatohhmm(hora_inicio,phora_inicio), valid.CambiarFormatohhmm(hora_fin,phora_fin),lunes,martes,miercoles,jueves,viernes,sabado,domingo);
											if(r>=1)
											result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
											else result="{\"resultado\":\"ERROR\",\"mensaje\":\" Error al guardar ó no existe ningun \n día de la semana  en el rango de fechas \"}";
										}else{
											result="{\"resultado\":\"ERROR\",\"mensaje\":\"Debe seleccionar almenos un d&iacute;a \"}";
										}
										
									}else{
										result=validacion;
									}
									out.println(result);
									
								 }else if(action.equalsIgnoreCase("guardarespecifico")&& (user_permiso.getIdpermiso().indexOf(229)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
									 String result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
									 int idactividad=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idactividad")));
										String fecha=(valid.ValidarRequest(request.getParameter("fecha")));		
										fecha=valid.Limpiarvalor(base64.decodificar(fecha),codificacion);
										String hora_inicio=(valid.ValidarRequest(request.getParameter("hora_inicio")));		
										hora_inicio=valid.Limpiarvalor(base64.decodificar(hora_inicio),codificacion);
										String hora_fin=(valid.ValidarRequest(request.getParameter("hora_fin")));		
										hora_fin=valid.Limpiarvalor(base64.decodificar(hora_fin),codificacion);
										String phora_inicio=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("hora_inicio_mm")),codificacion);
										String phora_fin=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("hora_fin_mm")),codificacion);
										String validacion=valid.ValidarSiesMayor(idactividad, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar una ACTIVIDAD\"}");
										validacion=(validacion.compareTo("")==0)?valid.isFechaValida(fecha,  "Fecha Especifica"):validacion;
										validacion=(validacion.compareTo("")==0)?valid.ValidarFormatoHora(hora_inicio,"Hora de Inicio"):validacion;
										validacion=(validacion.compareTo("")==0)?valid.ValidarFormatoHora(hora_fin,"Hora de Fin"):validacion;
										validacion=(validacion.compareTo("")==0)?valid.validarHoraMayoraOtra(hora_inicio,phora_inicio,hora_fin,phora_fin,"Hora de Inicio y Hora de Fin"):validacion;	
										
										if(validacion.compareTo("")==0){
											int r=dbo.SafeActividadDetalle(idactividad,valid.CambiarFormatoddmmyy(fecha), valid.CambiarFormatohhmm(hora_inicio,phora_inicio), valid.CambiarFormatohhmm(hora_fin,phora_fin));
											if(r==1)
												result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
												else result="{\"resultado\":\"ERROR\",\"mensaje\":\" Error al guardar \"}";
												
										}else{
											result=validacion;
										}
										out.println(result);
								 }else if(action.equalsIgnoreCase("eliminar_especifico")&& (user_permiso.getIdpermiso().indexOf(230)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
									 String result="{\"resultado\":\"OK\",\"mensaje\":\"Eliminado\"}";
									 int idactividad=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idactividad")));
									 ArrayList<Integer> lista=valid.ValidarListaNumeros(valid.ValidarRequest(request.getParameter("check_det_actividad")));
									 String validacion=valid.ValidarSiesMayor(idactividad, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar una ACTIVIDAD\"}");
									 if(validacion.compareTo("")==0){
										 int cant =dbo.DeleteActividadDetalle(idactividad,lista);
										 if(cant>0){
											result="{\"resultado\":\"OK\",\"mensaje\":\"Eliminado\"}";
										 }else{
											 result="{\"resultado\":\"OK\",\"mensaje\":\"No se ha Eliminado ningun elemento\"}"; 
										 }
									 }else{
											result=validacion;
										}
									 out.println(result); 
								 }else if(action.equalsIgnoreCase("eliminar_todos")&& (user_permiso.getIdpermiso().indexOf(230)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
									 String result="{\"resultado\":\"OK\",\"mensaje\":\"Eliminado\"}";
									 int idactividad=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idactividad")));
									 String validacion=valid.ValidarSiesMayor(idactividad, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar una ACTIVIDAD\"}");
									 if(validacion.compareTo("")==0){
										 int cant =dbo.DeleteActividadDetalle(idactividad);
										 if(cant>0){
											result="{\"resultado\":\"OK\",\"mensaje\":\"Eliminado\"}";
										 }else{
											 result="{\"resultado\":\"OK\",\"mensaje\":\"No se ha Eliminado ningun elemento\"}"; 
										 }
									 }else{
											result=validacion;
										}
									 out.println(result); 
								 }
								dbo.Close();
		 }
	}

}
