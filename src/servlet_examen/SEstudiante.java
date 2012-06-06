package servlet_examen;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;

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
					 pac=servicio.DatosGenerales(user, dbo);//.VerificarEstudiante(user, dbo);
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
					 pac=servicio.DatosGenerales(carne, dbo);//VerificarEstudiante(carne, dbo);
							 if(pac!=null){
								 dbo.SafePaciente(pac);
								 int idpaciente=dbo.getIdPaciente(pac.getUsuario());
								 pac.setIdpaciente(idpaciente);
								 
							 }
				}
				
					
			}
			if(pac!=null){
				session.setAttribute("paci_consulta",pac);
				result="<div  style='border: 1px solid blue'><table>";
				result+="<tr><td><b>Nombre</b></td><td>"+pac.getNombre()+"</td><td><b>Apellido</b></td><td>"+pac.getApellido()+"</td></tr>";
				result+="<tr><td><b>Telefono</b></td><td>"+pac.getTelefono()+"</td><td><b>Movil</b></td><td>"+pac.getMovil()+"</td></tr>";
				result+="<tr><td><b>Email</b></td><td>"+pac.getEmail()+"</td><td><b>Facultad</b></td><td>"+dbo.getUnidadAcademica(pac.getIdunidad_academica())+"</td></tr>";
				result+="</table></div>";
			}else{
				result="ERROR CARNE NO ENCONTRADO";
				session.setAttribute("paci_consulta",null);
			}
			
			out.println(result);
			
		}else if(action.equalsIgnoreCase("buscar_nombre")){
			String nombre=valid.ValidarRequest(request.getParameter("nombre"));
			String apellido=valid.ValidarRequest(request.getParameter("apellido"));
			ArrayList<CPaciente> listpaciente=dbo.getListaPacientes(nombre, apellido);
			String result="";
			Iterator<CPaciente> it=listpaciente.iterator();
			while(it.hasNext()){
				CPaciente pac=it.next();
				result+="<div  style='border: 1px solid blue'>";
				result+="<table  >";
				result+="<tr><td><b>Nombre</b></td><td>"+pac.getNombre()+"</td><td><b>Apellido</b></td><td>"+pac.getApellido()+"</td></tr>";
				result+="<tr><td><b>Telefono</b></td><td>"+pac.getTelefono()+"</td><td><b>Movil</b></td><td>"+pac.getMovil()+"</td></tr>";
				result+="<tr><td><b>Email</b></td><td>"+pac.getEmail()+"</td><td><b>Facultad</b></td><td>"+dbo.getUnidadAcademica(pac.getIdunidad_academica())+"</td></tr>";
				result+="</table>";
				result+="</div>";
			}
			out.println(result);
		}
		dbo.Close();
	}

}
