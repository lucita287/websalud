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
 * Servlet implementation class SMenuTable
 */
@WebServlet("/SMenuTable")
public class SMenuTable extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SMenuTable() {
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
	
		 int page=Integer.parseInt(request.getParameter("page"));
		 int rp=Integer.parseInt(request.getParameter("rp"));
		 String order=request.getParameter("sortname").trim();
		 String typeorder=request.getParameter("sortorder").trim();
		 String qtype=request.getParameter("qtype").trim();
		 String busqueda=request.getParameter("query").trim();
		 int pqtype=1;
		 if(qtype.equalsIgnoreCase("area")){
			 pqtype=2;
		 }
		 
		 int min=((page-1)*rp)+1;
		 int max=page*(rp);
		 int ordenar=2;
		 
		 if(order.equalsIgnoreCase("idmenu")){
			 ordenar=2;
		 }else if(order.equalsIgnoreCase("descripcion")){
			 ordenar=3;
		 }else if(order.equalsIgnoreCase("area")){
			 ordenar=4;
		 }else if(order.equalsIgnoreCase("menu_rec")){
			 ordenar=6;
		 }
		 
		 int asc=1;
		 if(typeorder.equalsIgnoreCase("desc")){
			 asc=0;
		 }
		 
		 
		ArrayList<CMenu> list=dbo.getMenuLista(min,max,pqtype,busqueda,ordenar,asc);
		
		 String info="<?xml version=\"1.0\" encoding=\"utf-8\"?>";
		 info+="<rows><page>"+page+"</page><total>"+dbo.getCMenuTotal(pqtype,busqueda)+"</total>";
		 
		 String data="";
		 for(int i=0; i<list.size();i++){
			 CMenu temp=list.get(i);
		data+="<row id='"+temp.getidmenu()+"'><cell><![CDATA[<input type='radio' onclick='editar("+temp.getidmenu()+")' name='idmenu_radio' value='"+temp.getidmenu()+"' />]]></cell><cell><![CDATA["+temp.getidmenu()+"]]></cell><cell><![CDATA["+temp.getdescripcion()+"]]></cell><cell><![CDATA["+temp.getareaidarea().getdescripcion()+"]]></cell><cell><![CDATA["+((temp.getidmenu_rec()!=null)?temp.getidmenu_rec().getdescripcion():"")+"]]></cell></row>";	 

		 }
		 info+=data+"</rows>";
		 out.println(info);
	}

}
