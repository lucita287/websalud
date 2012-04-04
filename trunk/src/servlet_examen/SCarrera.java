package servlet_examen;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import data.CCarrera;
import data.CCentro_Regional;
import data.CDepartamento;
import data.CDependencia;
import data.CUnidad_Academica;
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
    	String action=valid.ValidarRequest(request.getParameter("a"));
    	HttpSession sessiones = request.getSession(false);
		 if(sessiones!=null &&  sessiones.getAttribute("user_permiso")!=null){
					 CUsuarioPermiso user_permiso=(CUsuarioPermiso)sessiones.getAttribute("user_permiso");
					 
					CDataExam dbo=new CDataExam();
					dbo.Connect();
		

		
						if(action.equalsIgnoreCase("guardarcarrera")&& (user_permiso.getIdpermiso().indexOf(243)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
							String result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
							int idcarrera=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("id_carrera")));
							String nombre=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("nombre")));
							String validacion=valid.ValidarSiesMayor(idcarrera, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar un item\"}");
							validacion=(validacion.compareTo("")==0)?valid.ValidarCampoVacio(nombre, "Descripcion"):validacion;
							validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(nombre, 100, "Descripcion"):validacion;
							
							
							if(validacion.compareTo("")==0){
								CCarrera car=new CCarrera(idcarrera,nombre);
								boolean b=dbo.UpdateCarrera(car);
								if(!b){
									result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se ha almacenado\"}";
								}else{
									result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
								}
							}else result=validacion;
							out.println(result);
							
						}else if(action.equalsIgnoreCase("newcarrera")&& (user_permiso.getIdpermiso().indexOf(243)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
							String result="";
							String nombre=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("nombre")));
							String validacion=valid.ValidarCampoVacio(nombre, "Descripcion");
							validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(nombre, 100, "Descripcion"):validacion;
							
							if(validacion.compareTo("")==0){
								CCarrera car=new CCarrera(0,nombre);
								boolean b=dbo.SafeCarrera(car);
								if(!b){
									result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se ha almacenado\"}";
								}else{
									result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
								}
							}else result=validacion;
							out.println(result);
								
						}else if(action.equalsIgnoreCase("deletecarrera")&& (user_permiso.getIdpermiso().indexOf(243)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
							String result="";
							int idcarrera=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("id_carrera")));
							String validacion=valid.ValidarSiesMayor(idcarrera, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar un item\"}");
							
							if(validacion.compareTo("")==0){
								boolean b=dbo.deleteCarrera(idcarrera);
								if(!b){
									result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se ha eliminado\"}";
								}else{
									result="{\"resultado\":\"OK\",\"mensaje\":\"Eliminado\"}";
								}
							}else result=validacion;
							out.println(result);
								
						}else if(action.equalsIgnoreCase("guardarcentro")&& (user_permiso.getIdpermiso().indexOf(244)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
							String result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
							int idcentro=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("id_centro")));
							String nombre=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("nombre")));
							int iddepartamento=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("departamento")));
							String validacion=valid.ValidarSiesMayor(idcentro, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar un item\"}");
							validacion=(validacion.compareTo("")==0)?valid.ValidarCampoVacio(nombre, "Descripcion"):validacion;
							validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(nombre, 100, "Descripcion"):validacion;
							
							
							if(validacion.compareTo("")==0){
								CDepartamento depto=dbo.getDepartamentoEspecifico(iddepartamento);
								CCentro_Regional car=new CCentro_Regional(idcentro,nombre,depto);
								boolean b=dbo.UpdateCentro_Regional(car);
								if(!b){
									result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se ha almacenado\"}";
								}else{
									result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
								}
							}else result=validacion;
							out.println(result);
							
						}else if(action.equalsIgnoreCase("newcentro")&& (user_permiso.getIdpermiso().indexOf(244)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
							String result="";
							String nombre=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("nombre")));
							int iddepartamento=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("departamento")));
							String validacion=valid.ValidarCampoVacio(nombre, "Descripcion");
							validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(nombre, 100, "Descripcion"):validacion;
							
							if(validacion.compareTo("")==0){
								CDepartamento depto=dbo.getDepartamentoEspecifico(iddepartamento);
								CCentro_Regional car=new CCentro_Regional(0,nombre,depto);
								boolean b=dbo.SafeCentro_Regional(car);
								if(!b){
									result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se ha almacenado\"}";
								}else{
									result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
								}
							}else result=validacion;
							out.println(result);
								
						}else if(action.equalsIgnoreCase("deletecentro")&& (user_permiso.getIdpermiso().indexOf(244)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
							String result="";
							int idcentro=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("id_centro")));
							String validacion=valid.ValidarSiesMayor(idcentro, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar un item\"}");
							
							if(validacion.compareTo("")==0){
								boolean b=dbo.deleteCentro_Regional(idcentro);
								if(!b){
									result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se ha eliminado\"}";
								}else{
									result="{\"resultado\":\"OK\",\"mensaje\":\"Eliminado\"}";
								}
							}else result=validacion;
							out.println(result);
								
						}else if(action.equalsIgnoreCase("guardarfacultad")&& (user_permiso.getIdpermiso().indexOf(245)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
							String result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
							int idfacultad=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("id_facultad")));
							String nombre=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("nombre")));
							String validacion=valid.ValidarSiesMayor(idfacultad, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar un item\"}");
							validacion=(validacion.compareTo("")==0)?valid.ValidarCampoVacio(nombre, "Descripcion"):validacion;
							validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(nombre, 100, "Descripcion"):validacion;
							
							
							if(validacion.compareTo("")==0){
								CUnidad_Academica car=new CUnidad_Academica(idfacultad,nombre);
								boolean b=dbo.UpdateUnidadAcademica(car);
								if(!b){
									result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se ha almacenado\"}";
								}else{
									result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
								}
							}else result=validacion;
							out.println(result);
							
						}else if(action.equalsIgnoreCase("newfacultad")&& (user_permiso.getIdpermiso().indexOf(245)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
							String result="";
							String nombre=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("nombre")));
							String validacion=valid.ValidarCampoVacio(nombre, "Descripcion");
							validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(nombre, 100, "Descripcion"):validacion;
							
							if(validacion.compareTo("")==0){
								CUnidad_Academica car=new CUnidad_Academica(0,nombre);
								boolean b=dbo.SafeUnidadAcademica(car);
								if(!b){
									result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se ha almacenado\"}";
								}else{
									result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
								}
							}else result=validacion;
							out.println(result);
								
						}else if(action.equalsIgnoreCase("deletefacultad")&& (user_permiso.getIdpermiso().indexOf(245)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
							String result="";
							int idfacultad=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("id_facultad")));
							String validacion=valid.ValidarSiesMayor(idfacultad, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar un item\"}");
							
							if(validacion.compareTo("")==0){
								boolean b=dbo.deleteUnidadAcademica(idfacultad);
								if(!b){
									result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se ha eliminado\"}";
								}else{
									result="{\"resultado\":\"OK\",\"mensaje\":\"Eliminado\"}";
								}
							}else result=validacion;
							out.println(result);
								
						}if(action.equalsIgnoreCase("guardardependencia")&& (user_permiso.getIdpermiso().indexOf(249)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
							String result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
							int iddependencia=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("id_dependencia")));
							String nombre=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("nombre")));
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
							String nombre=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("nombre")));
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