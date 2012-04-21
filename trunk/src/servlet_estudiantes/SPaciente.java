package servlet_estudiantes;

import java.io.IOException;

import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import data.CPaciente;

import framework.CDataExam;
import framework.CValidationMensaje;

/**
 * Servlet implementation class SPaciente
 */
@WebServlet("/SPaciente")
public class SPaciente extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SPaciente() {
        
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request,response);
		
	}
	private void iniciarSession(boolean b, CDataExam dbo,String username,HttpServletRequest request, HttpServletResponse response, CPaciente paciente, PrintWriter out) throws IOException{
		if(b){
			int idusuario=dbo.getIdPaciente(username.toLowerCase());
			if(idusuario>0){
				paciente.setIdpaciente(idusuario);
				paciente.setCrecio_en("");
				paciente.setEstado_civilidestado_civil(0);
				paciente.setIdtipo_sangre(0);
				paciente.setIdemer_parentesco(0);
				paciente.setEmer_movil("");
				paciente.setEmer_telefono("");
				paciente.setEmer_nombre("");
				paciente.setTitulo_secundaria("");
				paciente.setPassword("");
				HttpSession session = request.getSession(true);
				 session.setAttribute("estudiante",username.toLowerCase() );
				 session.setAttribute("examen",1);
				 session.setAttribute("paciente",paciente);
				 response.sendRedirect("estudiante/index.jsp?portal=1");
			}else{
				ImprimirPaginas(out,"ERRORES DE VALIDACI&Oacute;N","Error al guardar");
			}
		}else{
			ImprimirPaginas(out,"ERRORES DE VALIDACI&Oacute;N","Error al guardar");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8"); 
		PrintWriter out = response.getWriter(); 
		String codificacion=request.getCharacterEncoding();
		codificacion=(codificacion==null)?"ISO-8859-1":codificacion;
		CValidationMensaje valid=new CValidationMensaje();
		String action=valid.ValidarRequest(request.getParameter("a"));
		
		CDataExam dbo=new CDataExam();
		dbo.Connect();
		if(action.equalsIgnoreCase("user_disponibilidad")){
			String result="{\"mensaje\":\"Disponible\"}";
			String username=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("user")),codificacion);
			String validacion=valid.ValidarUsername(username);
			
			if(validacion.isEmpty()){
				int cant=dbo.getPacienteDisponiblidad(username);
				if(cant==0) result="{\"mensaje\":\"Disponible\"}";
				else result="{\"mensaje\":\"Usuario ya registrado \"}";
			}else{
				result=validacion;
			}
			
			out.println(result);
		}else if(action.equalsIgnoreCase("guardarpaciente")){
			int carne = valid.ConvertEntero(valid.ValidarRequest(request.getParameter("carne")));
			
			int carrera = valid.ConvertEntero(valid.ValidarRequest(request.getParameter("carrera")));
			int centro = valid.ConvertEntero(valid.ValidarRequest(request.getParameter("centro_registro")));
			int facultad=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("facultad")));
			
			int no_personal=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("no_personal")));
			int dependencia = valid.ConvertEntero(valid.ValidarRequest(request.getParameter("dependencia")));
			int parentesco=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("paren_usuario")));
			String ced=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("ced_usuario")),codificacion);
			String nombre=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("nombre_usuario")),codificacion);
			String email=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("correo_electronico")),codificacion);
			String fecha=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("datepicker")),codificacion);
			
			
			int genero=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("genero")));
			String movil_usuario=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("movil_usuario")),codificacion);
			String tel_usuario=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("tel_usuario")),codificacion);
			String password=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("password")),codificacion);
			String password_confirm=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("password_confirm")),codificacion);
			String username=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("username")),codificacion).toLowerCase();
			String direccion=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("direccion")),codificacion);
			String mensaje=valid.ValidarMCaptcha(request);
			mensaje+=valid.ValidarMNombre(nombre,"NOMBRE");
			mensaje+=valid.ValidarMNombre(direccion,"DIRECCI&Oacute;N");
			mensaje+=valid.ValidarMNombre(ced,"CEDULA");
			mensaje+=valid.ValidarMCarne(carne,dbo);
			mensaje+=valid.ValidarMEmail(email);
			mensaje+=valid.ValidarMFecha(fecha);
			mensaje+=valid.ValidarMPassword(password, password_confirm);
			mensaje+=valid.ValidarMUsuario(username, dbo);
			mensaje+=valid.ValidarMCombo(carrera,"Carrera");
			mensaje+=valid.ValidarMCombo(facultad,"Facultad");
			mensaje+=valid.ValidarMCombo(centro,"Centro Regional");
			mensaje+=valid.ValidarMCombo(dependencia,"Dependenc&iacute;a");
			mensaje+=valid.ValidarMNoPersonal(no_personal);
			if(!mensaje.isEmpty()){
				ImprimirPaginas(out,"ERRORES DE VALIDACI&Oacute;N",mensaje);
			}else{
				
				CPaciente paciente =new CPaciente(0, nombre,valid.CambiarFormatoddmmyy(fecha),
						carne, direccion, tel_usuario, movil_usuario,
						carrera, centro,
						facultad, dependencia, genero,
						password, email,username,parentesco,ced,no_personal);
				boolean b=dbo.SafePaciente(paciente);
				iniciarSession(b, dbo,username, request, response, paciente, out);		
			}
		}else if(action.equalsIgnoreCase("guardartrabajador")){
			
			int no_personal=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("no_personal")));
			int dependencia = valid.ConvertEntero(valid.ValidarRequest(request.getParameter("dependencia")));
			
			String nombre=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("nombre_usuario")),codificacion);
			String email=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("correo_electronico")),codificacion);
			String fecha=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("datepicker")),codificacion);
			
			int parentesco=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("paren_usuario")));
			String ced=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("ced_usuario")),codificacion);
			int genero=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("genero")));
			String movil_usuario=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("movil_usuario")),codificacion);
			String tel_usuario=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("tel_usuario")),codificacion);
			String password=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("password")),codificacion);
			String password_confirm=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("password_confirm")),codificacion);
			String username=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("username")),codificacion).toLowerCase();
			String direccion=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("direccion")),codificacion);
			String mensaje=valid.ValidarMCaptcha(request);
			mensaje+=valid.ValidarMNombre(nombre,"NOMBRE");
			mensaje+=valid.ValidarMNombre(direccion,"DIRECCI&Oacute;N");
			mensaje+=valid.ValidarMNombre(ced,"CEDULA");
			mensaje+=valid.ValidarMEmail(email);
			mensaje+=valid.ValidarMFecha(fecha);
			mensaje+=valid.ValidarMPassword(password, password_confirm);
			mensaje+=valid.ValidarMUsuario(username, dbo);
			mensaje+=valid.ValidarMCombo(dependencia,"Dependenc&iacute;a");
			mensaje+=valid.ValidarMNoPersonal(no_personal);
			if(!mensaje.isEmpty()){
				ImprimirPaginas(out,"ERRORES DE VALIDACI&Oacute;N",mensaje);
			}else{
				CPaciente paciente =new CPaciente(0, nombre,valid.CambiarFormatoddmmyy(fecha),
						0, direccion, tel_usuario, movil_usuario,
						0, 0,0, dependencia, genero,
						password,email,username,parentesco,ced,no_personal);
				boolean b=dbo.SafePacienteTrab(paciente);
				iniciarSession(b, dbo,username, request, response, paciente, out);
			}	
		}else if(action.equalsIgnoreCase("guardarestudiante")){
			int carne = valid.ConvertEntero(valid.ValidarRequest(request.getParameter("carne")));
			int carrera = valid.ConvertEntero(valid.ValidarRequest(request.getParameter("carrera")));
			int centro = valid.ConvertEntero(valid.ValidarRequest(request.getParameter("centro_registro")));
			int facultad=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("facultad")));
			
			String nombre=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("nombre_usuario")),codificacion);
			String email=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("correo_electronico")),codificacion);
			String fecha=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("datepicker")),codificacion);
			int parentesco=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("paren_usuario")));
			String ced=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("ced_usuario")),codificacion);
			
			int genero=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("genero")));
			String movil_usuario=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("movil_usuario")),codificacion);
			String tel_usuario=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("tel_usuario")),codificacion);
			String password=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("password")),codificacion);
			String password_confirm=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("password_confirm")),codificacion);
			String username=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("username")),codificacion).toLowerCase();
			String direccion=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("direccion")),codificacion);
			String mensaje=valid.ValidarMCaptcha(request);
			mensaje+=valid.ValidarMNombre(nombre,"NOMBRE");
			mensaje+=valid.ValidarMNombre(direccion,"DIRECCI&Oacute;N");
			mensaje+=valid.ValidarMNombre(ced,"CEDULA");
			mensaje+=valid.ValidarMCarne(carne,dbo);
			mensaje+=valid.ValidarMEmail(email);
			mensaje+=valid.ValidarMFecha(fecha);
			mensaje+=valid.ValidarMPassword(password, password_confirm);
			mensaje+=valid.ValidarMUsuario(username, dbo);
			mensaje+=valid.ValidarMCombo(carrera,"Carrera");
			mensaje+=valid.ValidarMCombo(facultad,"Facultad");
			mensaje+=valid.ValidarMCombo(centro,"Centro Regional");
			if(!mensaje.isEmpty()){
				ImprimirPaginas(out,"ERRORES DE VALIDACI&Oacute;N",mensaje);
			}else{
				CPaciente paciente =new CPaciente(0, nombre,valid.CambiarFormatoddmmyy(fecha),
						carne, direccion, tel_usuario, movil_usuario,
						carrera, centro,
						facultad, 0, genero,
						password,email,username,parentesco,ced,0);
				boolean b=dbo.SafePaciente(paciente);
				iniciarSession(b, dbo,username, request, response, paciente, out);
			}
		}else if(action.equalsIgnoreCase("guardarcortesia")){
			
			
			String nombre=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("nombre_usuario")),codificacion);
			String email=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("correo_electronico")),codificacion);
			String fecha=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("datepicker")),codificacion);
			int parentesco=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("paren_usuario")));
			String ced=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("ced_usuario")),codificacion);
			
			int genero=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("genero")));
			String movil_usuario=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("movil_usuario")),codificacion);
			String tel_usuario=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("tel_usuario")),codificacion);
			String password=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("password")),codificacion);
			String password_confirm=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("password_confirm")),codificacion);
			String username=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("username")),codificacion).toLowerCase();
			String direccion=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("direccion")),codificacion);
			String mensaje=valid.ValidarMCaptcha(request);
			mensaje+=valid.ValidarMNombre(nombre,"NOMBRE");
			mensaje+=valid.ValidarMNombre(direccion,"DIRECCI&Oacute;N");
			mensaje+=valid.ValidarMNombre(ced,"CEDULA");
			mensaje+=valid.ValidarMEmail(email);
			mensaje+=valid.ValidarMFecha(fecha);
			
			mensaje+=valid.ValidarMPassword(password, password_confirm);
			mensaje+=valid.ValidarMUsuario(username, dbo);
			if(!mensaje.isEmpty()){
				ImprimirPaginas(out,"ERRORES DE VALIDACI&Oacute;N",mensaje);
			}else{
				CPaciente paciente =new CPaciente(0, nombre,valid.CambiarFormatoddmmyy(fecha),
						0, direccion, tel_usuario, movil_usuario,
						0, 0,0, 0, genero,
						password,email,username,parentesco,ced,0);
				
				
				boolean b=dbo.SafePacienteTrab(paciente);
				iniciarSession(b, dbo,username, request, response, paciente, out);
			}	
		}	
		dbo.Close();
	}
	
	private void  ImprimirPaginas(PrintWriter out,String titulo,String texto){
		out.println("<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">");
		out.println("<html xmlns=\"http://www.w3.org/1999/xhtml\">");
		out.println("<head>");
		out.println("<link type=\"text/css\" href=\"css/custom-theme/jquery-ui-1.8.17.custom.css\" rel=\"stylesheet\" />");
		out.println("<link href=\"css/styles.css\" rel=\"stylesheet\" type=\"text/css\" media=\"screen\" />");
		out.println("<script type=\"text/javascript\" src= \"lib/jquery-1.7.1.min.js\"></script>");
		out.println("<script type=\"text/javascript\" src=\"lib/jquery-ui-1.8.17.custom.min.js\"></script>");
		out.println("<style>");
		out.println(" .registro_validator{margin:0 auto 0 auto; width:600px; color:#00688B; border: 1px solid #AAAAAA; background:#D9D9D9; padding: 5px; border-bottom-right-radius: 4px;  border-bottom-left-radius: 4px;  border-top-right-radius: 4px;  border-top-left-radius: 4px;text-transform:uppercase; text-align: center;}");
		out.println(" #back_center{  width:100px; margin:0 auto 0 auto; margin-top:20px; margin-bottom:20px; } ");
		out.println("</style>");
		out.println("<script>");
		out.println(" $(document).ready(function () {");
		out.println("$( \"#back_btt\" ).button({ ");
		out.println("    icons: { ");
		out.println("        primary: \"ui-icon-circle-arrow-w\" ");
		out.println("    }}); ");
		out.println("});");
		out.println("function Back(){");
		out.println("window.history.back(-1);");
		out.println("}");
		out.println("</script>");
		out.println("</head>");
		out.println("<body>");
		out.println("<div class=\"back_all\">");
		out.println("	<div id=\"content\">");
		out.println("		<div id=\"back\" class=\"ui-widget-content ui-corner-all\">");
		out.println("			<div id=\"main\">");
		out.println("				<h2>"+titulo+"</h2>");
		out.println("					"+texto);
		out.println("				<div id=\"back_center\"><button id='back_btt' onclick=\"Back()\">Retroceder</button></div>");
		out.println("				<div style=\"clear: both;\"></div>");
		out.println("			</div>");	
		out.println("		</div>");
		out.println("	</div>");
		out.println("	</div>");
		out.println("</body>");
		out.println("</html>");
		
	}

}
