package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import data.CArea;
import data.CEncabezado;
import data.CMultimedia;
import data.CUsuarioPermiso;
import framework.CDataBase;
import framework.CValidation;

/**
 * Servlet implementation class SEncabezado
 */
@WebServlet("/SEncabezado")
public class SEncabezado extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SEncabezado() {
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
		
		
		HttpSession sessiones = request.getSession(false);
		 if(sessiones!=null &&  sessiones.getAttribute("user_permiso")!=null){
		CUsuarioPermiso user_permiso=(CUsuarioPermiso)sessiones.getAttribute("user_permiso");
		
		
						CDataBase dbo=new CDataBase();
						dbo.Connect();
						if(action.equalsIgnoreCase("show_encabezado")&&  (user_permiso.getIdpermiso().indexOf(231)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
							int idmultimedia=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idmultimedia")));
							CMultimedia multi=dbo.getMultimediaEspecifica(idmultimedia);
							String result="{\"path\":\""+multi.getdireccion_relativa()+"\"}";
							out.println(result);
						} else if(action.equalsIgnoreCase("guardaredit")&&  (user_permiso.getIdpermiso().indexOf(232)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
							int idmultimedia=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idimagen")));
							int idarea=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idarea")));
							String result="{\"resultado\":\"ERROR\",\"mensaje\":\"Debe llenar todos los campos\"}";
							
							String validacion=valid.ValidarSiesMayor(idarea, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar un item\"}");
							validacion=(validacion.compareTo("")==0)?valid.ValidarSiesMayor(idmultimedia, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe seleccionar un archivo\"}"):validacion;
							
								if(validacion.compareTo("")==0){
									CArea temp_area=dbo.getCAreaEspecifico(idarea);
									CMultimedia multi=dbo.getMultimediaEspecifica(idmultimedia);
									CEncabezado conte=new CEncabezado(temp_area,multi);
									boolean b=dbo.SafeEncabezado(conte);
									if(!b){
										result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se ha almacenado\"}";
									}else{
										result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
									}
								}else{
									 result=validacion;
								}
							
							out.println(result);
						}else if(action.equalsIgnoreCase("updateedit")&&  (user_permiso.getIdpermiso().indexOf(232)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
							int idmultimedia=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idimagen")));
							int idmultimedia2=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idimagen_ant")));
							int idarea=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idarea")));
							String result="{\"resultado\":\"ERROR\",\"mensaje\":\"Debe llenar todos los campos\"}";
							
							String validacion=valid.ValidarSiesMayor(idarea, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar un item\"}");
							validacion=(validacion.compareTo("")==0)?valid.ValidarSiesMayor(idmultimedia, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe seleccionar un archivo\"}"):validacion;
							validacion=(validacion.compareTo("")==0)?valid.ValidarSiesMayor(idmultimedia2, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe seleccionar un archivo\"}"):validacion;
							
								if(validacion.compareTo("")==0){
									CArea temp_area=dbo.getCAreaEspecifico(idarea);
									CMultimedia multi=dbo.getMultimediaEspecifica(idmultimedia);
									CEncabezado conte=new CEncabezado(temp_area,multi);
									int resp=dbo.deleteEncabezado(idarea,idmultimedia2);
									if(resp==1){	
										boolean b=dbo.SafeEncabezado(conte);
										if(!b){
											result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se ha almacenado\"}";
										}else{
											result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
										}
									}else{
										result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se ha almacenado\"}";
									}	
								}else{
									 result=validacion;
								}
							
							out.println(result);
						}else if(action.equalsIgnoreCase("deleteenca")&&  (user_permiso.getIdpermiso().indexOf(232)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
							int idmultimedia=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idimagen")));
							int idarea=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idarea")));
							String result="{\"resultado\":\"ERROR\",\"mensaje\":\"Debe llenar todos los campos\"}";
							String validacion=valid.ValidarSiesMayor(idarea, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar un item\"}");
							validacion=(validacion.compareTo("")==0)?valid.ValidarSiesMayor(idmultimedia, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe seleccionar un archivo\"}"):validacion;
							if(validacion.compareTo("")==0){
								int resp=dbo.deleteEncabezado(idarea,idmultimedia);
								if(resp==1){	
									result="{\"resultado\":\"OK\",\"mensaje\":\"Eliminado\"}";
								}else{
									result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se ha eliminado\"}";
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
