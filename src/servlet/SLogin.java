package servlet;

import java.io.IOException;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import data.CUsuario;


import framework.CDataBase;

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
		CDataBase dbo=new CDataBase();
		 dbo.Connect();
		 response.setContentType("text/html;charset=UTF-8"); 
		 String user=request.getParameter("user").toLowerCase();
		 String pass=request.getParameter("pass");
		 String perfil=request.getParameter("perfil");
		 if(perfil.equalsIgnoreCase("2")){
			 
			 CUsuario usuario=dbo.getUsuario(user);
			 if( usuario!=null && usuario.getpassword().compareTo(pass)==0){
				 HttpSession session = request.getSession(true);
					session.setAttribute("username", user);
					session.setAttribute("user", user);
					response.sendRedirect("admin/index.jsp");
			 }else{
				 response.sendRedirect("index.jsp?e=1");
			 }
		 }else{
			 response.sendRedirect("index.jsp?e=1");
		 }
	}

}
