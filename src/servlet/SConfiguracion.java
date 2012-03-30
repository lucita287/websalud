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
import data.CUsuarioPermiso;
import framework.CDataBase;
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
		CValidation valid=new CValidation();
		String action=valid.ValidarRequest(request.getParameter("a"));
		 HttpSession sessiones = request.getSession(false);
		 if(sessiones!=null &&  sessiones.getAttribute("user_permiso")!=null){
					 CUsuarioPermiso user_permiso=(CUsuarioPermiso)sessiones.getAttribute("user_permiso");
								CDataBase dbo=new CDataBase();
								dbo.Connect();
								//MODIFICAR CONTENIDO
								if(action.equalsIgnoreCase("GuardarConfig")&& (user_permiso.getIdpermiso().indexOf(233)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
									String result="";
									CConfiguracion configurar=dbo.getConfiguracion();
									String telefono=valid.ValidarRequest(request.getParameter("telefono"));
									String fax=valid.ValidarRequest(request.getParameter("fax"));
									String direccion=valid.ValidarRequest(request.getParameter("dir"));
									int size=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("size")));
									String validacion=valid.ValidarRango(size, 1, 10, "{\"resultado\":\"ERROR\",\"mensaje\":\"El rango de tama&ntilde;o subir archivos debe ser entre [1-10]\"}");
									validacion=(validacion.compareTo("")==0)?valid.ValidarCampoVacio(telefono, "Telefono"):validacion;
									validacion=(validacion.compareTo("")==0)?valid.ValidarCampoVacio(fax, "Fax"):validacion;
									validacion=(validacion.compareTo("")==0)?valid.ValidarCampoVacio(direccion, "Direccion"):validacion;
									validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(telefono, 48, "Titulo"):validacion;
									validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(fax, 48, "Titulo"):validacion;
									validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(direccion, 250, "Titulo"):validacion;
									if(validacion.compareTo("")==0){
										configurar.setTelefono(telefono);
										configurar.setFax(fax);
										configurar.setDireccion(direccion);
										configurar.setTamanio_sub(size);
										boolean b=dbo.UpdateConfiguracion(configurar);
										if(b) result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
										else result="{\"resultado\":\"ERROR\",\"mensaje\":\"Error al guardar\"}";
										
									}else{
										result=validacion;
									}
									out.println(result);
								}
		 						dbo.Close();
		}					
		
		
	}

}
