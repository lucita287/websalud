package servlet;

import java.io.IOException;
import java.util.ArrayList;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import data.CPaciente;
import data.CUsuario;
import data.CUsuarioPermiso;


import framework.CDataExam;
import framework.CValidation;
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
		CDataExam dbo=new CDataExam();
		 dbo.Connect();
		 response.setContentType("text/html;charset=UTF-8"); 
		 CValidation valid=new CValidation();
		 String user=valid.ValidarRequest(request.getParameter("user").toLowerCase());
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
				 response.sendRedirect("index.jsp?e=1");
			 }
		 }else{
			 
			 HttpSession session = request.getSession(true);
			 CPaciente pac= dbo.getEstudianteEspecifica(user, pass);
			 if(pac!=null){
				 session.setAttribute("estudiante", user);
				 session.setAttribute("examen",1);
				 session.setAttribute("paciente",pac);
				 response.sendRedirect("estudiante/index.jsp?portal=1");
				 
			 }else
			 response.sendRedirect("index.jsp?e=1");
		 }
		 dbo.Close();
	}

}
