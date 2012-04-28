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

import data.CEdificio;
import data.CUsuarioPermiso;
import framework.CDataBase;
import framework.CValidation;

/**
 * Servlet implementation class SEdificio
 */
@WebServlet("/SEdificio")
public class SEdificio extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SEdificio() {
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
		HttpSession sessiones = request.getSession(false);
		String action=valid.ValidarRequest(request.getParameter("a"));
		 if(sessiones!=null &&  sessiones.getAttribute("user_permiso")!=null){
					 CUsuarioPermiso user_permiso=(CUsuarioPermiso)sessiones.getAttribute("user_permiso");
					 
								CDataBase dbo=new CDataBase();
								 dbo.Connect();
								
								 //MODIFICAR EDIFICIO
								 if(action.equalsIgnoreCase("guardar_edificio")&& (user_permiso.getIdpermiso().indexOf(229)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
									String result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
									String nombre=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("nombre")),codificacion);
									String direccion=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("direccion")),codificacion);
									String telefono=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("telefono")),codificacion);

									String validacion=valid.ValidarCampoVacio(nombre, "Nombre");
									validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(nombre, 100, "Nombre"):validacion;
									validacion=(validacion.compareTo("")==0)?valid.ValidarCampoVacio(direccion, "Direccion"):validacion;
									validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(direccion, 250, "Direccion"):validacion;
									validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(telefono, 50, "Telefono"):validacion;
									if(validacion.compareTo("")==0){
										CEdificio edi=new CEdificio(0,nombre,direccion,telefono);
										boolean b=dbo.SafeEdificio(edi);
										if(b) result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
										else result="{\"resultado\":\"ERROR\",\"mensaje\":\"Error al guardar\"}";
									}else{
										result=validacion;
									}
									
									out.println(result);
									//MOSTRAR EDIFICIO
								 }else if(action.equalsIgnoreCase("show_edificio")&& (user_permiso.getIdpermiso().indexOf(228)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
									String result=" ";
									int idedificio=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idedificio")));
									CEdificio edi=dbo.getEdificioEspecifica(idedificio);
									 if(edi!=null){
										 result= "{nombre:\""+edi.getNombre()+"\",direccion:\""+edi.getDireccion()+"\",telefono:\""+
												 edi.getTelefono()+"\"}";
									 }
									 out.println(result);
									//MODIFICAR EDIFICIO 
								}else if(action.equalsIgnoreCase("modificar_edificio")&& (user_permiso.getIdpermiso().indexOf(229)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
									String result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
									String nombre=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("nombre")),codificacion);
									String direccion=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("direccion")),codificacion);
									String telefono=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("telefono")),codificacion);
									int idedificio=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idedificio")));
									
									String validacion=valid.ValidarSiesMayor(idedificio, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar un item\"}");
									validacion=(validacion.compareTo("")==0)?valid.ValidarCampoVacio(nombre, "Nombre"):validacion;
									validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(nombre, 100, "Nombre"):validacion;
									validacion=(validacion.compareTo("")==0)?valid.ValidarCampoVacio(direccion, "Direccion"):validacion;
									validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(direccion, 250, "Direccion"):validacion;
									validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(telefono, 50, "Telefono"):validacion;
									if(validacion.compareTo("")==0){
										CEdificio edi=new CEdificio(idedificio,nombre,direccion,telefono);
										boolean b=dbo.UpdateEdificio(edi);
										if(b) result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
										else result="{\"resultado\":\"ERROR\",\"mensaje\":\"Error al guardar\"}";
									}else{
										result=validacion;
									}
									
									out.println(result);
									//ELIMINAR EDIFICIO
								}else if(action.equalsIgnoreCase("eliminar_edificio")&& (user_permiso.getIdpermiso().indexOf(230)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
									String result="{\"resultado\":\"OK\",\"mensaje\":\"Eliminado\"}";
									int idedificio=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idedificio")));
									String validacion=valid.ValidarSiesMayor(idedificio, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar un item\"}");
									if(validacion.compareTo("")==0){
										boolean res=dbo.deleteEdificio(idedificio);
										if(!res){
											result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se puede eliminar el elemento seleccionado\"}";
										} else result="{\"resultado\":\"OK\",\"mensaje\":\"Eliminado\"}";
										
									}else{
										result=validacion;
									}
									
									out.println(result);
									
								}else if(action.equalsIgnoreCase("show_list")&& (user_permiso.getIdpermiso().indexOf(228)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
									ArrayList<CEdificio> list_edi=dbo.getListaEdificio();
									String result="{total:"+list_edi.size()+",rows:[";
									String data="";
									for(int j=0; j<list_edi.size();j++){ 
										CEdificio edi=list_edi.get(j);
										data+=(data.compareTo("")==0)?"":",";
										data+="{value:"+edi.getIdedificio()+",text:'"+edi.getNombre()+"'}";
									}
									result+=data+"]}";
									out.println(result);
								}
								dbo.Close();
		 }
	}

}
