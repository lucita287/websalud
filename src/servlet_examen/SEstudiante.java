package servlet_examen;

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
		CValidation valid=new CValidation();
		CDataExam dbo=new CDataExam();
		dbo.Connect();
		String user=valid.ValidarRequest(request.getParameter("user")).trim().toLowerCase(); 
		HttpSession session = request.getSession(true);
		if(!user.isEmpty()){	 
			CPaciente pac= dbo.getEstudianteEspecifica(user);
			if(pac==null){
			 CWebService servicio=new CWebService(2012);
			 pac=servicio.VerificarEstudiante(user, dbo);
					 if(pac!=null){
						 session.setAttribute("resultado","1");
						 session.setAttribute("paci_consulta",pac);
						 dbo.SafePaciente(pac);
					 }else{
						 session.setAttribute("resultado","0");
						 session.setAttribute("paci_consulta",null);
					 }
					 
			}else{
			session.setAttribute("paci_consulta",pac);
			session.setAttribute("resultado","1");
			
			}
		 dbo.Close();
		 }else {
			 session.setAttribute("resultado","0");
			 session.setAttribute("paci_consulta",null);
		 }
		response.sendRedirect("interno/index.jsp?portal=3");
	}

}
