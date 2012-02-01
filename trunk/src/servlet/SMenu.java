package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import data.CMenu;

import framework.CDataBase;

/**
 * Servlet implementation class SMenu
 */
@WebServlet("/SMenu")
public class SMenu extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SMenu() {
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
		 int idmenu=Integer.parseInt(request.getParameter("idmenu"));
		 CDataBase dbo=new CDataBase();
		 dbo.Connect();
		 CMenu temp_menu=dbo.getMenuEspecifico(idmenu);
		 String result=(temp_menu!=null)?
				 "{\"descripcion\":\""+temp_menu.getdescripcion()+"\",\"area\":\""+temp_menu.getareaidarea().getidarea()+"\"," +
				 		"\"contenido\":\""+temp_menu.getcontenido()+"\"}"
				 :"";
		 out.println(result);
	}

}
