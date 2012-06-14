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

import data.CActividad;
import data.CArea;
import data.CEdificio;
import data.CUsuarioPermiso;
import framework.Base64core;
import framework.CDataBase;
import framework.CValidation;

/**
 * Servlet implementation class SActividad
 */
@WebServlet("/SActividad")
public class SActividad extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SActividad() {
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
    	CValidation valid=new CValidation();
    	String action=valid.ValidarRequest(request.getParameter("a"));
		Base64core base64=new Base64core();
		String codificacion=request.getCharacterEncoding();
		codificacion=(codificacion==null)?"ISO-8859-1":codificacion;
		
		
		HttpSession sessiones = request.getSession(false);
		 if(sessiones!=null &&  sessiones.getAttribute("user_permiso")!=null){
					 CUsuarioPermiso user_permiso=(CUsuarioPermiso)sessiones.getAttribute("user_permiso");
					 
								CDataBase dbo=new CDataBase();
								 dbo.Connect();
								
								 //MODIFICAR ACTIVIDAD
								 if(action.equalsIgnoreCase("new_actividad")&& (user_permiso.getIdpermiso().indexOf(229)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
									String result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
									int idedificio=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idedificio")));
									int idarea=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idarea")));
									String responsable=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("responsable")),codificacion);
									String salon=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("salon")),codificacion);
									String titulo=valid.ValidarRequest(request.getParameter("titulo"));
									titulo=base64.decodificar(titulo);
									titulo=valid.Limpiarvalor(titulo,codificacion);
									String contenido=(valid.ValidarRequest(request.getParameter("descripcion")));		
									contenido=base64.decodificar(contenido);
									contenido=valid.Limpiarvalor(contenido,codificacion);
									int color=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("color")));
									
									ArrayList<Integer>lista= valid.ValidarListaNumeros(responsable);
									String validacion=valid.ValidarSiesMayor(idarea, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar un area\"}");
									validacion=(validacion.compareTo("")==0)?valid.ValidarSiesMayor(idedificio, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar un lugar\"}"):validacion;
									validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(titulo, 150, "Titulo"):validacion;
									validacion=(validacion.compareTo("")==0)?valid.ValidarCampoVacio(contenido, "Descripcion"):validacion;
									validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(contenido, 4990, "Descripcion"):validacion;
									validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(salon, 100, "Salon"):validacion;
									validacion=(validacion.compareTo("")==0)?valid.ValidarCampoVacio(titulo, "Titulo"):validacion;
									if(validacion.compareTo("")==0){
										CArea area=dbo.getCAreaEspecifico(idarea);
										CEdificio edi=dbo.getEdificioEspecifica(idedificio);
										CActividad act=new CActividad(0,titulo,area,contenido,edi,salon,color);
										boolean b=dbo.SafeActividad(act);
										if(b){ 
											int actividad=dbo.BuscarActividad(act);
											dbo.saferesponsable_actividad(actividad,lista);
											result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
											
											}
										else result="{\"resultado\":\"ERROR\",\"mensaje\":\"Error al guardar\"}";
										
										
									}else{
										result=validacion;
									}
									
									out.println(result);
									//MOSTRAR ACTIVIDAD
								 }else if(action.equalsIgnoreCase("show_actividad")&& (user_permiso.getIdpermiso().indexOf(228)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
									String result=" ";
									int idactividad=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idactividad")));
									CActividad act=dbo.getActividadEspecifica(idactividad);
									 if(act!=null){
										 
										 ArrayList<Integer> resp=dbo.getActividadResponsableEspecifica(idactividad);
										 String data="";
										 for(int j=0; j<resp.size();j++){ 
												Integer responsable=resp.get(j);
												 data+=(data.equalsIgnoreCase(""))?"":",";	
													data+="{idresponsable:"+responsable+"}";
										 }
										 data="responsables:["+data+"]";
										 result= "{color:\""+act.getColor()+"\",titulo:\""+valid.Limpiarvalor3(act.getTitulo())+"\",descripcion:\""+valid.Limpiarvalor3(act.getDescripcion())+"\",salon:\""+valid.Limpiarvalor3(act.getSalon())+"\",idedificio:\""+act.getEdificioidedificio().getIdedificio()+"\","+
										 		"idarea:\""+act.getAreaidarea().getidarea()+"\","+data+"}";
									 }
									 response.setContentType("text/html;charset="+codificacion);
									 out.println(base64.codificar(valid.Imprimirvalor(result,codificacion)));
									//MODIFICAR NOTICIA 
								}else if(action.equalsIgnoreCase("safe_actividad")&& (user_permiso.getIdpermiso().indexOf(229)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
									String result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
									int idactividad=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idactividad")));
									int idedificio=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idedificio")));
									int idarea=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idarea")));
									String responsable=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("responsable")),codificacion);
									String salon=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("salon")),codificacion);
									String titulo=valid.ValidarRequest(request.getParameter("titulo"));
									titulo=base64.decodificar(titulo);
									titulo=valid.Limpiarvalor(titulo,codificacion);
									String contenido=(valid.ValidarRequest(request.getParameter("descripcion")));		
									contenido=base64.decodificar(contenido);
									contenido=valid.Limpiarvalor(contenido,codificacion);
									int color=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("color")));
									ArrayList<Integer>lista= valid.ValidarListaNumeros(responsable);
									String validacion=valid.ValidarSiesMayor(idactividad, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar una actividad\"}");
									validacion=(validacion.compareTo("")==0)?valid.ValidarSiesMayor(idarea, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar un area\"}"):validacion;
									validacion=(validacion.compareTo("")==0)?valid.ValidarSiesMayor(idedificio, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar un lugar\"}"):validacion;
									validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(titulo, 150, "Titulo"):validacion;
									validacion=(validacion.compareTo("")==0)?valid.ValidarCampoVacio(contenido, "Descripcion"):validacion;
									validacion=(validacion.compareTo("")==0)?valid.ValidarCampoVacio(titulo, "Titulo"):validacion;
									validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(contenido, 4990, "Descripcion"):validacion;
									validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(salon, 100, "Salon"):validacion;
									if(validacion.compareTo("")==0){
										CArea area=dbo.getCAreaEspecifico(idarea);
										CEdificio edi=dbo.getEdificioEspecifica(idedificio);
										CActividad act=new CActividad(idactividad,titulo,area,contenido,edi,salon,color);
										boolean b=dbo.UpdateActividad(act);
										if(b){ 
											dbo.saferesponsable_actividad(idactividad,lista);
											result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
											
											}
										else result="{\"resultado\":\"ERROR\",\"mensaje\":\"Error al guardar\"}";
										
										
									}else{
										result=validacion;
									}
									
									out.println(result);
									//ELIMINAR ACTIVIDAD	
								}else if(action.equalsIgnoreCase("eliminar_actividad")&& (user_permiso.getIdpermiso().indexOf(230)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
									String result="{\"resultado\":\"OK\",\"mensaje\":\"Eliminado\"}";
									int idactividad=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idactividad")));
									String validacion=valid.ValidarSiesMayor(idactividad, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar un item\"}");
									if(validacion.compareTo("")==0){
										int res=dbo.DeleteActividad(idactividad);
										if(res!=1) result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se puede eliminar el elemento seleccionado\"}";
										else result="{\"resultado\":\"OK\",\"mensaje\":\"Eliminado\"}";
										
									}else{
										result=validacion;
									}
									
									out.println(result);
									
								}
								dbo.Close();
		 }		
	}

}
