package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

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
			 ArrayList<CMenu> list=dbo.getMenuLista();	
			 
			 String info="{";
			 info+="total: "+dbo.getCMenuTotal();
			 info+=", page: 1,";
			 info+="rows: [";
			 String data="";
			 for(int i=0; i<list.size();i++){
					CMenu temp=list.get(i);
					data+=(data=="")?"":",";
					data+="{ cell: [\"<input type='radio' onclick='editar("+temp.getidmenu()+")' name='idmenu_radio' value='"+temp.getidmenu()+"' />\",\""+temp.getidmenu()+"\", \""+temp.getdescripcion()+"\" , \""+temp.getareaidarea().getdescripcion()+"\" , \""+temp.getcontenido()+"\" , \""+((temp.getidmenu_rec()!=null)?temp.getidmenu_rec().getdescripcion():"")+"\" ] }";
			 }
			 info+=data+"] }";
			 out.println(info);
			 dbo.Close();
	}

}
