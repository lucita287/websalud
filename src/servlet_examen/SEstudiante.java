package servlet_examen;

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
import framework.CValidation;
import framework.CWebService;

/**
 * Servlet implementation class SEstudiante
 */
@WebServlet("/SEstudiante")
public class SEstudiante extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SEstudiante() {
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
		CDataExam dbo=new CDataExam();
		dbo.Connect();
		String user=valid.ValidarRequest(request.getParameter("user")).trim().toLowerCase(); 
		String action=valid.ValidarRequest(request.getParameter("a"));
		HttpSession session = request.getSession(true);
		if(action.equalsIgnoreCase("estudiante_ver")){
				
				if(!user.isEmpty()){	 
					CPaciente pac= dbo.getEstudianteEspecifica(user);
					int idpaciente=0;
					if(pac==null){
					 CWebService servicio=new CWebService(2012);
					 pac=servicio.VerificarEstudiante(user, dbo);
							 if(pac!=null){
								 dbo.SafePaciente(pac);
								 idpaciente=dbo.getIdPaciente(pac.getUsuario());
								 pac.setIdpaciente(idpaciente);
								 session.setAttribute("resultado","1");
								 session.setAttribute("paci_consulta",pac);
								 
							 }else{
								 session.setAttribute("resultado","0");
								 session.setAttribute("paci_consulta",null);
								 
							 }
							 
					}else{
						idpaciente=pac.getIdpaciente();
						session.setAttribute("paci_consulta",pac);
						session.setAttribute("resultado","1");
					
					}
				 }else {
					 session.setAttribute("resultado","0");
					 session.setAttribute("paci_consulta",null);
					 
				 }
				response.sendRedirect("secretaria/index.jsp?portal=3");
		}else if(action.equalsIgnoreCase("estudiante_consulta")){
			String carne=valid.ValidarRequest(request.getParameter("carne"));
			String result="ERROR<br/>Debe ingrese el carne";
			CPaciente pac=null;
			if(!carne.isEmpty()){
				
				pac= dbo.getEstudianteEspecifica(carne);
				if(pac==null){
					CWebService servicio=new CWebService(2012);
					 pac=servicio.VerificarEstudiante(carne, dbo);
							 if(pac!=null){
								 dbo.SafePaciente(pac);
								 int idpaciente=dbo.getIdPaciente(pac.getUsuario());
								 pac.setIdpaciente(idpaciente);
								 
							 }
				}
				
					
			}
			if(pac!=null){
				session.setAttribute("paci_consulta",pac);
				result="<table>";
				result+="<tr><td>Nombre</td><td>"+pac.getNombre()+"</td><td>Apellido</td><td>"+pac.getApellido()+"</td></tr>";
				result+="<tr><td>Telefono</td><td>"+pac.getTelefono()+"</td><td>Movil</td><td>"+pac.getMovil()+"</td></tr>";
				result+="<tr><td>Email</td><td>"+pac.getEmail()+"</td><td>Facultad</td><td></td></tr>";
				result+="</table>";
			}else{
				result="ERROR CARNE NO ENCONTRADO";
				session.setAttribute("paci_consulta",null);
			}
			
			out.println(result);
			
		}else if(action.equalsIgnoreCase("estudiante_consulta")){
			String nombre=valid.ValidarRequest(request.getParameter("nombre"));
			String apellido=valid.ValidarRequest(request.getParameter("apellido"));
		}
		dbo.Close();
	}

}
