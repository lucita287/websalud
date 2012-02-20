package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import data.CPregunta;

import framework.CDataBase;

/**
 * Servlet implementation class SCategoria
 */
@WebServlet("/SCategoria")
public class SCategoria extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SCategoria() {
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
			
			CDataBase dbo=new CDataBase();
			 dbo.Connect();
			if(action.equalsIgnoreCase("show")){
				int idcategoria=Integer.parseInt(request.getParameter("categoria"));
				ArrayList<CPregunta> list=dbo.getPreguntas(idcategoria);
				String info="{";
				 info+="total: "+dbo.getPreguntasTotal(idcategoria);
				 info+=", page: 1,";
				 info+="rows: [";
				 String data="";
				 for(int i=0; i<list.size();i++){
						CPregunta temp=list.get(i);
						data+=(data=="")?"":",";
						data+="{ cell: [\"<input type='radio' onclick='editar("+temp.getidpregunta()+")' name='idmenu_radio' value='"+
						temp.getidpregunta()+"' />\",\""+temp.getidpregunta()+"\", \""+
								temp.getdescripcion()+"\" , \""+
									temp.getidcategoria().getdescripcion()+"\"  , \""+
										((temp.getsubcategoria()!=null)?temp.getsubcategoria().getdescripcion():"")+"\" ] }";
				 }
				 info+=data+"] }";
				 out.println(info);
			}
			dbo.Close();
	}

}
