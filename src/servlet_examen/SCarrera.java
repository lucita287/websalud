package servlet_examen;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import data.CDependencia;
import data.CUsuarioPermiso;
import framework.CDataExam;
import framework.CValidation;

/**
 * Servlet implementation class SCarrera
 */
@WebServlet("/SCarrera")
public class SCarrera extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SCarrera() {
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
    	String codificacion=request.getCharacterEncoding();
		codificacion=(codificacion==null)?"ISO-8859-1":codificacion;
    	String action=valid.ValidarRequest(request.getParameter("a"));
    	HttpSession sessiones = request.getSession(false);
		 if(sessiones!=null &&  sessiones.getAttribute("user_permiso")!=null){
					 CUsuarioPermiso user_permiso=(CUsuarioPermiso)sessiones.getAttribute("user_permiso");
					 
					CDataExam dbo=new CDataExam();
					dbo.Connect();
		

		
						if(action.equalsIgnoreCase("guardardependencia")&& (user_permiso.getIdpermiso().indexOf(249)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
							String result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
							int iddependencia=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("id_dependencia")));
							String nombre=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("nombre")),codificacion);
							String validacion=valid.ValidarSiesMayor(iddependencia, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar un item\"}");
							validacion=(validacion.compareTo("")==0)?valid.ValidarCampoVacio(nombre, "Descripcion"):validacion;
							validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(nombre, 100, "Descripcion"):validacion;
							
							
							if(validacion.compareTo("")==0){
								CDependencia car=new CDependencia(iddependencia,nombre);
								boolean b=dbo.UpdateDependencia(car);
								if(!b){
									result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se ha almacenado\"}";
								}else{
									result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
								}
							}else result=validacion;
							out.println(result);
							
						}else if(action.equalsIgnoreCase("newdependencia")&& (user_permiso.getIdpermiso().indexOf(249)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
							String result="";
							String nombre=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("nombre")),codificacion);
							String validacion=valid.ValidarCampoVacio(nombre, "Descripcion");
							validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(nombre, 100, "Descripcion"):validacion;
							
							if(validacion.compareTo("")==0){
								CDependencia car=new CDependencia(0,nombre);
								boolean b=dbo.SafeDependencia(car);
								if(!b){
									result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se ha almacenado\"}";
								}else{
									result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
								}
							}else result=validacion;
							out.println(result);
								
						}else if(action.equalsIgnoreCase("deletedependencia")&& (user_permiso.getIdpermiso().indexOf(249)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
							String result="";
							int iddependencia=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("id_dependencia")));
							String validacion=valid.ValidarSiesMayor(iddependencia, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar un item\"}");
							
							if(validacion.compareTo("")==0){
								boolean b=dbo.deleteDependencia(iddependencia);
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