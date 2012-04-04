package servlet_estudiantes;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import framework.CDataExam;
import framework.CValidation;

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

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8"); 
		PrintWriter out = response.getWriter(); 
		CValidation valid=new CValidation();
		String action=valid.ValidarRequest(request.getParameter("a"));
		
		CDataExam dbo=new CDataExam();
		dbo.Connect();
		if(action.equalsIgnoreCase("user_disponibilidad")){
			String result="{\"mensaje\":\"Disponible\"}";
			String username=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("user")));
			String validacion=valid.ValidarUsername(username);
			
			if(validacion.isEmpty()){
				int cant=dbo.getPacienteDisponiblidad(username);
				if(cant==0) result="{\"mensaje\":\"Disponible\"}";
				else result="{\"mensaje\":\"Usuario ya registrado \"}";
			}else{
				result=validacion;
			}
			
			out.println(result);
		}
		dbo.Close();
	}

}
