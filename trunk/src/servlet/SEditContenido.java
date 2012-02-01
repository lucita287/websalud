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
 * Servlet implementation class SEditContenido
 */
@WebServlet("/SEditContenido")
public class SEditContenido extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
	
	
    public SEditContenido() {
        super();
        // TODO Auto-generated constructor stub
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
			 CDataBase dbo=new CDataBase();
			 dbo.Connect();
			 	
			 String info="{ total: 2, page: 1, rows: [{ cell: [\"test\", \"localhost\" , 8080 , \"ERROR\" , 0.0 ] }, { cell: [\"drew\" , \"localhost\" , 8080 , \"UNKNOWN\" , 0.0 ]}] }";
			 out.println(info);
			 
	}

}
