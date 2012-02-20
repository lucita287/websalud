package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import data.CContenido;

import framework.CDataBase;
import framework.CValidation;

/**
 * Servlet implementation class SContenidoTable
 */
@WebServlet("/SContenidoTable")
public class SContenidoTable extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SContenidoTable() {
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
		 CDataBase dbo=new CDataBase();
		 dbo.Connect(); 
		 CValidation valid=new CValidation();
		 int tipo=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("ptipo")));
		 int idmenu=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("pmenu")));
		 
		 String info="{";
         info+="total: "+dbo.getContenidoTotal(tipo,idmenu);
         info+=", page: 1,";
         info+="rows: [";
         String data="";
         
         ArrayList<CContenido> list=dbo.getContenidoLista(tipo, idmenu);
         for(int i=0; i<list.size();i++){
        	 CContenido temp=list.get(i);
                        data+=(data=="")?"":",";
                                          data+="{ cell: [\"<input type='radio' onclick='editar_conte"+tipo+"("+temp.getidcontenido()+")' name='idconte_radio' value='"+temp.getidcontenido()+"' />\",\""+temp.getidcontenido()+"\", \""+temp.gettitulo()+"\" , \""+temp.getmultimedia().getdireccion_relativa()+"\"  ] }";
         }
         info+=data+"] }";
         
         out.print(info);
         dbo.Close();
	}

}
