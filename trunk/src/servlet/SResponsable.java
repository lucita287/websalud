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

import data.CArea;
import data.CResponsable;
import data.CUsuario;
import data.CUsuarioPermiso;
import framework.CDataBase;
import framework.CValidation;

/**
 * Servlet implementation class SResponsable
 */
@WebServlet("/SResponsable")
public class SResponsable extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SResponsable() {
       
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
		
		HttpSession sessiones = request.getSession(false);
		 if(sessiones!=null &&  sessiones.getAttribute("user_permiso")!=null){
					 CUsuarioPermiso user_permiso=(CUsuarioPermiso)sessiones.getAttribute("user_permiso");
					 
								CDataBase dbo=new CDataBase();
								 dbo.Connect();
								
								 //MODIFICAR RESPONSABLE
								 if(action.equalsIgnoreCase("guardar_responsable")&& (user_permiso.getIdpermiso().indexOf(229)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
									String result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
									int idusuario=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("usuario")));
									int idarea=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idarea")));
									String nombre=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("nombre")),codificacion);
									String apellido=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("apellido")),codificacion);

									String validacion=valid.ValidarCampoVacio(nombre, "nombre");
									validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(nombre, 150, "Nombre"):validacion;
									validacion=(validacion.compareTo("")==0)?valid.ValidarCampoVacio(apellido, "Apellido"):validacion;
									validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(apellido, 150, "Apellido"):validacion;
									validacion=(validacion.compareTo("")==0)?valid.ValidarSiesMayor(idarea, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar un area profesional\"}"):validacion;
									if(validacion.compareTo("")==0){
										CArea area=dbo.getCAreaEspecifico(idarea);
										CUsuario user=dbo.getUsuarioEspecifico(idusuario);
										CResponsable respon=new CResponsable(0,nombre,apellido,user,area);
										boolean b=dbo.SafeResponsable(respon);
										if(b) result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
										else result="{\"resultado\":\"ERROR\",\"mensaje\":\"Error al guardar\"}";
									}else{
										result=validacion;
									}
									
									out.println(result);
									//MOSTRAR RESPONSABLE
								 }else if(action.equalsIgnoreCase("show_responsable")&& (user_permiso.getIdpermiso().indexOf(228)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
									String result=" ";
									int idresponsable=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idresponsable")));
									CResponsable respon=dbo.getResponsableEspecifica(idresponsable);
									 if(respon!=null){
										 result= "{nombre:\""+respon.getNombre()+"\",apellido:\""+respon.getApellido()+"\",areanombre:\""+
												 respon.getAreaidarea().getnombre()+"\",idarea:"+respon.getAreaidarea().getidarea()+",idusuario:\""+respon.getUsuariosidusuario().getidusuario()+"\"}";
									 }
									 out.println(result);
									//MODIFICAR RESPONSABLE 
								}else if(action.equalsIgnoreCase("modificar_responsable")&& (user_permiso.getIdpermiso().indexOf(229)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
									String result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
									int idresponsable=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idresponsable")));
									int idusuario=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("usuario")));
									int idarea=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idarea")));
									String nombre=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("nombre")),codificacion);
									String apellido=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("apellido")),codificacion);

									String validacion=valid.ValidarSiesMayor(idarea, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar un item\"}");
											validacion=(validacion.compareTo("")==0)?valid.ValidarCampoVacio(nombre, "Nombre"):validacion;
									validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(nombre, 150, "Nombre"):validacion;
									validacion=(validacion.compareTo("")==0)?valid.ValidarCampoVacio(apellido, "Apellido"):validacion;
									validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(apellido, 150, "Apellido"):validacion;
									validacion=(validacion.compareTo("")==0)?valid.ValidarSiesMayor(idarea, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar un area profesional\"}"):validacion;
									if(validacion.compareTo("")==0){
										CArea area=dbo.getCAreaEspecifico(idarea);
										CUsuario user=dbo.getUsuarioEspecifico(idusuario);
										CResponsable respon=dbo.getResponsableEspecifica(idresponsable);
										respon.setApellido(apellido);
										respon.setNombre(nombre);
										respon.setUsuariosidusuario(user);
										respon.setAreaidarea(area);
										boolean b=dbo.UpdateResponsable(respon);
										if(b) result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
										else result="{\"resultado\":\"ERROR\",\"mensaje\":\"Error al guardar\"}";
									}else{
										result=validacion;
									}
									 
									out.println(result);
									//ELIMINAR RESPONSABLE
								}else if(action.equalsIgnoreCase("eliminar_responsable")&& (user_permiso.getIdpermiso().indexOf(230)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
									String result="{\"resultado\":\"OK\",\"mensaje\":\"Eliminado\"}";
									int idresponsable=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idresponsable")));
									String validacion=valid.ValidarSiesMayor(idresponsable, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar un item\"}");
									if(validacion.compareTo("")==0){
										boolean res=dbo.deleteResponsable(idresponsable);
										if(!res){
											result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se puede eliminar el elemento seleccionado\"}";
										} else result="{\"resultado\":\"OK\",\"mensaje\":\"Eliminado\"}";
										
									}else{
										result=validacion;
									}
									
									out.println(result);
									
								}else if(action.equalsIgnoreCase("show_list")&& (user_permiso.getIdpermiso().indexOf(228)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
									ArrayList<CResponsable> list_respon=dbo.getListaResponsables();
									String result="{total:"+list_respon.size()+",rows:[";
									String data="";
									for(int j=0; j<list_respon.size();j++){ 
										CResponsable respon=list_respon.get(j);
										data+=(data.compareTo("")==0)?"":",";
										data+="{value:"+respon.getIdresponsable()+",text:'"+respon.getAreaidarea().getnombre()+"/"+respon.getNombre()+" "+respon.getApellido()+"'}";
									}
									result+=data+"]}";
									out.println(result);
								}
								dbo.Close();
		 }				
	}

}
