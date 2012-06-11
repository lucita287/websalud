package servlet;

import java.io.IOException;
import java.util.ArrayList;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import data.CConfiguracion;
import data.CPaciente;
import data.CUsuario;
import data.CUsuarioPermiso;


import framework.CDataExam;
import framework.CSeleccionExamen;
import framework.CValidation;
import framework.CWebService;
/**
 * Servlet implementation class SLogin
 */
@WebServlet("/SLogin")
public class SLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SLogin() {
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
		CValidation valid=new CValidation();
		CDataExam dbo=new CDataExam();
		String user=valid.ValidarRequest(request.getParameter("user").toLowerCase()).trim(); 
		if(dbo.Connect() && !user.isEmpty()){
		 response.setContentType("text/html;charset=UTF-8"); 
		 
		 
		 String pass=valid.ValidarRequest(request.getParameter("pass"));
		 String perfil=valid.ValidarRequest(request.getParameter("perfil"));
		 if(perfil.equalsIgnoreCase("2")){
			 
			 CUsuario usuario=dbo.getUsuario(user);
			 if( usuario!=null && usuario.getpassword().compareTo(pass)==0&& usuario.getEstado()==1){
				 HttpSession session = request.getSession(true);
					session.setAttribute("username", user);
					session.setAttribute("user", user);
					session.setAttribute("portal",1);
					usuario.setPassword("");
					ArrayList<Integer> lista_permisos=dbo.getListaPermisoInt(usuario.getidusuario());
					ArrayList<Integer> area=null;
					if(usuario.getidusuario()==1) area=dbo.getAreaListaInt();
					else area=dbo.getAreaListaInt(usuario.getidusuario());
					
					CUsuarioPermiso user_permiso=new CUsuarioPermiso(usuario,lista_permisos,area);
					
					session.setAttribute("user_permiso",user_permiso);
					response.sendRedirect("admin/index.jsp");
					
			 }else{
				 response.sendRedirect("index.jsp?e=Error en el usuario y/o password");
			 }
		 }else if(perfil.equalsIgnoreCase("1")){
			 
			 HttpSession session = request.getSession(true);
			 CConfiguracion config=dbo.getConfiguracion();
			 CWebService servicio=new CWebService(config.getCiclo());
			 int carnemin=config.getCiclo()*100000;
			 int carnemax=(config.getCiclo()+1)*100000;
			
			 int validcarne=valid.ConvertEntero(user);
			 if(validcarne>=carnemin && validcarne<carnemax){
			 int status=servicio.VerificarPin(user, pass);
			 
			 
			 switch(status) { // Eleige la opcion acorde al numero de mes
			 case 1:
				 CPaciente paciente= dbo.getEstudianteEspecifica(user);
				 session.setAttribute("estudiante", user);
				 session.setAttribute("pin", pass);
				 
				 if(paciente!=null){
					 session.setAttribute("paciente",paciente);
					 if(paciente.getEstado()<=1){
						 CSeleccionExamen examen=new CSeleccionExamen(config.getRandom_carne(),validcarne,dbo.getListaConfiguracion_Examen());
						 paciente.setEstado(examen.getExamen()+1);
						 dbo.UpdatePacienteEstado(paciente);
						 
					 }
					 
					 session.setAttribute("examen",1);
					 response.sendRedirect("estudiante/index.jsp");
					 
				 }else{
					 paciente=servicio.DatosGenerales(user, dbo);//.VerificarEstudiante(user,dbo);
					 if(paciente!=null){
					 CSeleccionExamen examen=new CSeleccionExamen(config.getRandom_carne(),validcarne,dbo.getListaConfiguracion_Examen());
					 paciente.setEstado(examen.getExamen()+1);
					 dbo.SafePaciente(paciente);
					 int idusuario=dbo.getIdPaciente(paciente.getCarne()+"");
					 
					 paciente.setIdpaciente(idusuario);
					 paciente.setCrecio_en("");
					 paciente.setEstado_civilidestado_civil(0);
					 paciente.setIdtipo_sangre(0);
					 paciente.setIdemer_parentesco(0);
					 paciente.setEmer_movil("");
					 paciente.setEmer_telefono("");
					 paciente.setEmer_nombre("");
					 paciente.setTitulo_secundaria("");
					 session.setAttribute("paciente",paciente);
					 session.setAttribute("examen",1);
					 response.sendRedirect("estudiante/index.jsp");
					 }else{
						 response.sendRedirect("index.jsp?e=Estudiante no inscrito");
					 }
				 }
				 break;	
			 case 2:
				 response.sendRedirect("index.jsp?e=Estudiante no inscrito");
				 break;
			 case 3:
				 response.sendRedirect("index.jsp?e=Usuario no registrado");
				 break;
			 default:
				 response.sendRedirect("index.jsp?e=Error en la conexion con registro y estadistica");
				 break;
			 	 
			 }
			 
			 }else{
				 
				 response.sendRedirect("index.jsp?e=Unicamente para estudiantes con carne "+config.getCiclo());
			 }
			 //CPaciente pac= dbo.getEstudianteEspecifica(user, pass);
			 //if(pac!=null){
			 //	 session.setAttribute("estudiante", user);
			 //	 session.setAttribute("examen",1);
			 //	 session.setAttribute("paciente",pac);
			 //	 response.sendRedirect("estudiante/index.jsp?portal=1");
				 
			 // }else
			 //response.sendRedirect("index.jsp?e=1");
		 }else{
			 
			 CUsuario usuario=dbo.getUsuario(user);
			 if( usuario!=null && usuario.getpassword().compareTo(pass)==0&& usuario.getEstado()==1){
				 HttpSession session = request.getSession(true);
					session.setAttribute("username", user);
					session.setAttribute("user", user);
					session.setAttribute("portal",1);
					usuario.setPassword("");
					ArrayList<Integer> lista_permisos=dbo.getListaPermisoInt(usuario.getidusuario());
					ArrayList<Integer> area=null;
					if(usuario.getidusuario()==1) area=dbo.getAreaListaInt();
					else area=dbo.getAreaListaInt(usuario.getidusuario());
					
					CUsuarioPermiso user_permiso=new CUsuarioPermiso(usuario,lista_permisos,area);
					if( (user_permiso.getIdpermiso().indexOf(253)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
								session.setAttribute("user_secretaria",user_permiso);
								response.sendRedirect("secretaria/index.jsp?portal=1");
					}
			 }else{
				 response.sendRedirect("index.jsp?e=Error en el usuario y/o password");
			 }
		 }
		 dbo.Close();
		 }else response.sendRedirect("index.jsp?e=Campos vacios");
	}

}
