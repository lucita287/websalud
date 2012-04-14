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
import data.CParentesco;
import data.CTipo_Sangre;
import data.CTitulo_Secundaria;
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
    	String codificacion=request.getCharacterEncoding();
		codificacion=(codificacion==null)?"ISO-8859-1":codificacion;
    	String action=valid.ValidarRequest(request.getParameter("a"));
    	HttpSession sessiones = request.getSession(false);
		 if(sessiones!=null &&  sessiones.getAttribute("user_permiso")!=null){
					 CUsuarioPermiso user_permiso=(CUsuarioPermiso)sessiones.getAttribute("user_permiso");
					 
					CDataExam dbo=new CDataExam();
					dbo.Connect();
					
					if(action.equalsIgnoreCase("guardarcivil")&& (user_permiso.getIdpermiso().indexOf(239)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
						String result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
						int idcivil=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("id_civil")));
						String nombre=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("nombre")),codificacion);
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
						String nombre=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("nombre")),codificacion);
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
						String nombre=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("nombre")),codificacion);
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
						String nombre=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("nombre")),codificacion);
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
							
					}else if(action.equalsIgnoreCase("guardartsecundaria")&& (user_permiso.getIdpermiso().indexOf(242)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
						String result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
						int idtsecundaria=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("id_tsecundaria")));
						String nombre=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("nombre")),codificacion);
						String validacion=valid.ValidarSiesMayor(idtsecundaria, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar un item\"}");
						validacion=(validacion.compareTo("")==0)?valid.ValidarCampoVacio(nombre, "Descripcion"):validacion;
						validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(nombre, 150, "Descripcion"):validacion;
						
						
						if(validacion.compareTo("")==0){
							CTitulo_Secundaria tsecundaria=new CTitulo_Secundaria(idtsecundaria,nombre);
							boolean b=dbo.UpdateTitulo_Secundaria(tsecundaria);
							if(!b){
								result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se ha almacenado\"}";
							}else{
								result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
							}
						}else result=validacion;
						out.println(result);
						
					}else if(action.equalsIgnoreCase("newtsecundaria")&& (user_permiso.getIdpermiso().indexOf(242)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
						String result="";
						String nombre=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("nombre")),codificacion);
						String validacion=valid.ValidarCampoVacio(nombre, "Descripcion");
						validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(nombre, 100, "Descripcion"):validacion;
						
						if(validacion.compareTo("")==0){
							CTitulo_Secundaria tsecun=new CTitulo_Secundaria(0,nombre);
							boolean b=dbo.SafeTitulo_Secundaria(tsecun);
							if(!b){
								result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se ha almacenado\"}";
							}else{
								result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
							}
						}else result=validacion;
						out.println(result);
							
					}else if(action.equalsIgnoreCase("deletetsecundaria")&& (user_permiso.getIdpermiso().indexOf(242)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
						String result="";
						int idtsecun=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("id_tsecundaria")));
						String validacion=valid.ValidarSiesMayor(idtsecun, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar un item\"}");
						
						if(validacion.compareTo("")==0){
							boolean b=dbo.deleteTitulo_Secundaria(idtsecun);
							if(!b){
								result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se ha eliminado\"}";
							}else{
								result="{\"resultado\":\"OK\",\"mensaje\":\"Eliminado\"}";
							}
						}else result=validacion;
						out.println(result);
							
					}else if(action.equalsIgnoreCase("guardarparen")&& (user_permiso.getIdpermiso().indexOf(241)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
						String result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
						int idparen=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("id_paren")));
						String nombre=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("nombre")),codificacion);
						int grupo_familiar=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("grupo_familiar")));
						int antecedentes=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("antecedentes")));
						int emergencias=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("emergencias")));
						String validacion=valid.ValidarSiesMayor(idparen, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar un item\"}");
						validacion=(validacion.compareTo("")==0)?valid.ValidarCampoVacio(nombre, "Descripcion"):validacion;
						validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(nombre, 150, "Descripcion"):validacion;						
						if(validacion.compareTo("")==0){
							
							CParentesco parentesco=new CParentesco(idparen,nombre,grupo_familiar,antecedentes, emergencias);
							boolean b=dbo.UpdateParentesco(parentesco);
							if(!b){
								result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se ha almacenado\"}";
							}else{
								result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
							}
						}else result=validacion;
						out.println(result);
						
					}else if(action.equalsIgnoreCase("newparen")&& (user_permiso.getIdpermiso().indexOf(241)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
						String result="";
						String nombre=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("nombre")),codificacion);
						int grupo_familiar=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("grupo_familiar")));
						int antecedentes=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("antecedentes")));
						int emergencias=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("emergencias")));
						String validacion=valid.ValidarCampoVacio(nombre, "Descripcion");
						validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(nombre, 100, "Descripcion"):validacion;
						
						if(validacion.compareTo("")==0){
							CParentesco parentesco=new CParentesco(0,nombre,grupo_familiar,antecedentes, emergencias);
							boolean b=dbo.SafeParentesco(parentesco);
							if(!b){
								result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se ha almacenado\"}";
							}else{
								result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
							}
						}else result=validacion;
						out.println(result);
							
					}else if(action.equalsIgnoreCase("deleteparen")&& (user_permiso.getIdpermiso().indexOf(241)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
						String result="";
						int idparen=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("id_paren")));
						String validacion=valid.ValidarSiesMayor(idparen, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar un item\"}");
						
						if(validacion.compareTo("")==0){
							boolean b=dbo.deleteTipoSangre(idparen);
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
