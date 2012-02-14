package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import framework.Base64core;
import framework.CDataBase;

/**
 * Servlet implementation class SContenido
 */
@WebServlet("/SContenido")
public class SContenido extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SContenido() {
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
		String action=request.getParameter("a");
		Base64core base64=new Base64core();
		CDataBase dbo=new CDataBase();
		dbo.Connect();
		if(action.equalsIgnoreCase("guardaredit")){
			String titulo=base64.decodificar(request.getParameter("titulo"));
			String contenido=base64.decodificar(request.getParameter("contenido"));
			String result="{\"resultado\":\"ERROR\",\"mensaje\":\"Debe llenar todos los campos\"}";
			if(!titulo.trim().equalsIgnoreCase("")&&!contenido.trim().equalsIgnoreCase("")){
				//procesaFicheros(HttpServletRequest req,String repositorio,String temporal);
			}
			out.println(result);
		}
	}

}
