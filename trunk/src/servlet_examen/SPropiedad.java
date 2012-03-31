package servlet_examen;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import data.CEstado_Civil;
import data.CTipo_Sangre;
import data.CUsuarioPermiso;

import framework.CDataExam;
import framework.CValidation;

/**
 * Servlet implementation class SPropiedad
 */
@WebServlet("/SPropiedad")
public class SPropiedad extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SPropiedad() {
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
					 
					CDataExam dbo=new CDataExam();
					dbo.Connect();
					
					if(action.equalsIgnoreCase("guardarcivil")&& (user_permiso.getIdpermiso().indexOf(239)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
						String result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
						int idcivil=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("id_civil")));
						String nombre=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("nombre")));
						String validacion=valid.ValidarSiesMayor(idcivil, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar un item\"}");
						validacion=(validacion.compareTo("")==0)?valid.ValidarCampoVacio(nombre, "Descripcion"):validacion;
						validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(nombre, 100, "Descripcion"):validacion;
						
						
						if(validacion.compareTo("")==0){
							CEstado_Civil civil=new CEstado_Civil(idcivil,nombre);
							boolean b=dbo.UpdateEstadoCivil(civil);
							if(!b){
								result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se ha almacenado\"}";
							}else{
								result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
							}
						}else result=validacion;
						out.println(result);
						
					}else if(action.equalsIgnoreCase("newcivil")&& (user_permiso.getIdpermiso().indexOf(239)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
						String result="";
						String nombre=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("nombre")));
						String validacion=valid.ValidarCampoVacio(nombre, "Descripcion");
						validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(nombre, 100, "Descripcion"):validacion;
						
						if(validacion.compareTo("")==0){
							CEstado_Civil civil=new CEstado_Civil(0,nombre);
							boolean b=dbo.SafeEstadoCivil(civil);
							if(!b){
								result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se ha almacenado\"}";
							}else{
								result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
							}
						}else result=validacion;
						out.println(result);
							
					}else if(action.equalsIgnoreCase("deletecivil")&& (user_permiso.getIdpermiso().indexOf(239)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
						String result="";
						int idcivil=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("id_civil")));
						String validacion=valid.ValidarSiesMayor(idcivil, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar un item\"}");
						
						if(validacion.compareTo("")==0){
							boolean b=dbo.deleteEstadoCivil(idcivil);
							if(!b){
								result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se ha eliminado\"}";
							}else{
								result="{\"resultado\":\"OK\",\"mensaje\":\"Eliminado\"}";
							}
						}else result=validacion;
						out.println(result);
							
					}else if(action.equalsIgnoreCase("guardartsangre")&& (user_permiso.getIdpermiso().indexOf(240)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
						String result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
						int idtsangre=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("id_tsangre")));
						String nombre=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("nombre")));
						String validacion=valid.ValidarSiesMayor(idtsangre, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar un item\"}");
						validacion=(validacion.compareTo("")==0)?valid.ValidarCampoVacio(nombre, "Descripcion"):validacion;
						validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(nombre, 100, "Descripcion"):validacion;
						
						
						if(validacion.compareTo("")==0){
							CTipo_Sangre civil=new CTipo_Sangre(idtsangre,nombre);
							boolean b=dbo.UpdateTipoSangre(civil);
							if(!b){
								result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se ha almacenado\"}";
							}else{
								result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
							}
						}else result=validacion;
						out.println(result);
						
					}else if(action.equalsIgnoreCase("newtsangre")&& (user_permiso.getIdpermiso().indexOf(240)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
						String result="";
						String nombre=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("nombre")));
						String validacion=valid.ValidarCampoVacio(nombre, "Descripcion");
						validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(nombre, 100, "Descripcion"):validacion;
						
						if(validacion.compareTo("")==0){
							CTipo_Sangre tsangre=new CTipo_Sangre(0,nombre);
							boolean b=dbo.SafeTipo_Sangre(tsangre);
							if(!b){
								result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se ha almacenado\"}";
							}else{
								result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
							}
						}else result=validacion;
						out.println(result);
							
					}else if(action.equalsIgnoreCase("deletetsangre")&& (user_permiso.getIdpermiso().indexOf(239)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
						String result="";
						int idsangre=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("id_tsangre")));
						String validacion=valid.ValidarSiesMayor(idsangre, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar un item\"}");
						
						if(validacion.compareTo("")==0){
							boolean b=dbo.deleteTipoSangre(idsangre);
							if(!b){
								result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se ha eliminado\"}";
							}else{
								result="{\"resultado\":\"OK\",\"mensaje\":\"Eliminado\"}";
							}
						}else result=validacion;
						out.println(result);
							
					}
					
					
					dbo.Close();
		 }						 
    	
    	
	}

}
