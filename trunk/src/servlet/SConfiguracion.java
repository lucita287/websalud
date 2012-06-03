package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import data.CConfiguracion;
import data.CConfiguracion_Examen;
import data.CUsuarioPermiso;
import framework.CDataExam;
import framework.CValidation;

/**
 * Servlet implementation class SConfiguracion
 */
@WebServlet("/SConfiguracion")
public class SConfiguracion extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SConfiguracion() {
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
		 HttpSession sessiones = request.getSession(false);
		 if(sessiones!=null &&  sessiones.getAttribute("user_permiso")!=null){
					 CUsuarioPermiso user_permiso=(CUsuarioPermiso)sessiones.getAttribute("user_permiso");
								CDataExam dbo=new CDataExam();
								dbo.Connect();
								//MODIFICAR CONTENIDO
								if(action.equalsIgnoreCase("GuardarConfig")&& (user_permiso.getIdpermiso().indexOf(233)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
									String result="";
									CConfiguracion configurar=dbo.getConfiguracion();
									String telefono=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("telefono")),codificacion);
									String fax=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("fax")),codificacion);
									String direccion=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("dir")),codificacion);
									int size=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("size")));
									int multifa=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("multifa")));
									int ciclo=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("ciclo")));
									String jefe=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("jefe")),codificacion);
									int random_carne=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("random_carne")));
									int imp_salud=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("imp_salud")));
									String fecha=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("fecha")),codificacion);
									String validacion=valid.ValidarRango(size, 1, 15, "{\"resultado\":\"ERROR\",\"mensaje\":\"El rango de tama&ntilde;o subir archivos debe ser entre [1-15]\"}");
									validacion=(validacion.compareTo("")==0)?valid.isFechaValida(fecha,  "Fecha inicio"):validacion;
									validacion=(validacion.compareTo("")==0)?valid.ValidarCampoVacio(jefe, "Jefe"):validacion;
									validacion=(validacion.compareTo("")==0)?valid.ValidarCampoVacio(telefono, "Telefono"):validacion;
									validacion=(validacion.compareTo("")==0)?valid.ValidarCampoVacio(fax, "Fax"):validacion;
									validacion=(validacion.compareTo("")==0)?valid.ValidarCampoVacio(direccion, "Direccion"):validacion;
									validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(telefono, 48, "Titulo"):validacion;
									validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(fax, 48, "Titulo"):validacion;
									validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(direccion, 250, "Titulo"):validacion;
									if(validacion.isEmpty() && ciclo<2000){
										validacion="{\"resultado\":\"ERROR\",\"mensaje\":\"Debe ingresar el ciclo actual, o el ciclo que se este ingresando\"}";
									}
									
									if(validacion.compareTo("")==0){
										configurar.setTelefono(telefono);
										configurar.setFax(fax);
										configurar.setDireccion(direccion);
										configurar.setTamanio_sub(size);
										configurar.setCiclo(ciclo);
										configurar.setMultifa_reporte(multifa);
										configurar.setJefe_actual(jefe);
										configurar.setRandom_carne(random_carne);
										configurar.setImpresion_salud(imp_salud);
										configurar.setFecha_examen(valid.CambiarFormatoddmmyy(fecha));
										boolean b=dbo.UpdateConfiguracion(configurar);
										if(b) result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
										else result="{\"resultado\":\"ERROR\",\"mensaje\":\"Error al guardar\"}";
										
									}else{
										result=validacion;
									}
									out.println(result);
								}else if(action.equalsIgnoreCase("GuardarCarne")&& (user_permiso.getIdpermiso().indexOf(233)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
									String result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
									int carne0=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("carne0")));
									int carne1=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("carne1")));
									int carne2=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("carne2")));
									int carne3=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("carne3")));
									int carne4=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("carne4")));
									int carne5=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("carne5")));
									int carne6=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("carne6")));
									int carne7=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("carne7")));
									int carne8=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("carne8")));
									int carne9=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("carne9")));
									String validacion=valid.ValidarRango(carne0, 1, 2, "{\"resultado\":\"ERROR\",\"mensaje\":\"Debe seleccionar un examen\"}");
									validacion=(validacion.compareTo("")==0)?valid.ValidarRango(carne0, 1, 2, "{\"resultado\":\"ERROR\",\"mensaje\":\"Debe seleccionar un examen\"}"):validacion;
									validacion=(validacion.compareTo("")==0)?valid.ValidarRango(carne1, 1, 2, "{\"resultado\":\"ERROR\",\"mensaje\":\"Debe seleccionar un examen\"}"):validacion;
									validacion=(validacion.compareTo("")==0)?valid.ValidarRango(carne2, 1, 2, "{\"resultado\":\"ERROR\",\"mensaje\":\"Debe seleccionar un examen\"}"):validacion;
									validacion=(validacion.compareTo("")==0)?valid.ValidarRango(carne3, 1, 2, "{\"resultado\":\"ERROR\",\"mensaje\":\"Debe seleccionar un examen\"}"):validacion;
									validacion=(validacion.compareTo("")==0)?valid.ValidarRango(carne4, 1, 2, "{\"resultado\":\"ERROR\",\"mensaje\":\"Debe seleccionar un examen\"}"):validacion;
									validacion=(validacion.compareTo("")==0)?valid.ValidarRango(carne5, 1, 2, "{\"resultado\":\"ERROR\",\"mensaje\":\"Debe seleccionar un examen\"}"):validacion;
									validacion=(validacion.compareTo("")==0)?valid.ValidarRango(carne6, 1, 2, "{\"resultado\":\"ERROR\",\"mensaje\":\"Debe seleccionar un examen\"}"):validacion;
									validacion=(validacion.compareTo("")==0)?valid.ValidarRango(carne7, 1, 2, "{\"resultado\":\"ERROR\",\"mensaje\":\"Debe seleccionar un examen\"}"):validacion;
									validacion=(validacion.compareTo("")==0)?valid.ValidarRango(carne8, 1, 2, "{\"resultado\":\"ERROR\",\"mensaje\":\"Debe seleccionar un examen\"}"):validacion;
									validacion=(validacion.compareTo("")==0)?valid.ValidarRango(carne9, 1, 2, "{\"resultado\":\"ERROR\",\"mensaje\":\"Debe seleccionar un examen\"}"):validacion;
									if(validacion.compareTo("")==0){
										CConfiguracion_Examen config0=new CConfiguracion_Examen(1,0,carne0);
										dbo.UpdateConfiguracionExamen(config0);
										config0=new CConfiguracion_Examen(2,1,carne1);
										dbo.UpdateConfiguracionExamen(config0);
										config0=new CConfiguracion_Examen(3,1,carne2);
										dbo.UpdateConfiguracionExamen(config0);
										config0=new CConfiguracion_Examen(4,1,carne3);
										dbo.UpdateConfiguracionExamen(config0);
										config0=new CConfiguracion_Examen(5,1,carne4);
										dbo.UpdateConfiguracionExamen(config0);
										config0=new CConfiguracion_Examen(6,1,carne5);
										dbo.UpdateConfiguracionExamen(config0);
										config0=new CConfiguracion_Examen(7,1,carne6);
										dbo.UpdateConfiguracionExamen(config0);
										config0=new CConfiguracion_Examen(8,1,carne7);
										dbo.UpdateConfiguracionExamen(config0);
										config0=new CConfiguracion_Examen(9,1,carne8);
										dbo.UpdateConfiguracionExamen(config0);
										config0=new CConfiguracion_Examen(10,1,carne9);
										dbo.UpdateConfiguracionExamen(config0);
									}else {
										result="{\"resultado\":\"OK\",\"mensaje\":\"Error en parametros\"}";
										
									}
									
									
									out.print(result);
								}
		 						dbo.Close();
		}					
		
		
	}

}
