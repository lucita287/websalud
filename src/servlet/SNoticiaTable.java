package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import data.CNoticia;
import framework.CDataBase;
import framework.CValidation;

/**
 * Servlet implementation class SNoticiaTable
 */
@WebServlet("/SNoticiaTable")
public class SNoticiaTable extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SNoticiaTable() {
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
		 int page=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("page")));
		 int rp=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("rp")));
		 String order=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("sortname")));
		 String typeorder=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("sortorder")));
		 String qtype=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("qtype")));
		 String busqueda=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("query")));
		 int pqtype=1;
		 if(qtype.equalsIgnoreCase("area")){
			 pqtype=2;
		 }
		 
		 int min=((page-1)*rp)+1;
		 int max=page*(rp);
		 int ordenar=2;
		 
		 //if(order.equalsIgnoreCase("idmenu")){
		 //	 ordenar=2;
		 //}else if(order.equalsIgnoreCase("descripcion")){
		 //	 ordenar=3;
		 //}else if(order.equalsIgnoreCase("area")){
		 //	 ordenar=8;
		 //}else if(order.equalsIgnoreCase("menu_rec")){
		 //	 ordenar=9;
		 //}
		 
		 int asc=1;
		 if(typeorder.equalsIgnoreCase("desc")){
			 asc=0;
		 }
		 
		 
		ArrayList<CNoticia> list=dbo.getListaNoticias();
		
		 String info="<?xml version=\"1.0\" encoding=\"utf-8\"?>";
		 info+="<rows><page>"+page+"</page><total>"+list.size()+"</total>";
		 
		 String data="";
		 for(int i=0; i<list.size();i++){
			 CNoticia temp=list.get(i);
			 
		data+="<row id='"+temp.getIdnoticia()+"'><cell><![CDATA[<input type='radio' class='menu_radio' onclick='editarnoticia("+temp.getIdnoticia()+")' name='idmenu_radio' value='"+temp.getIdnoticia()+"' />]]></cell><cell><![CDATA["+temp.getIdnoticia()+"]]></cell><cell><![CDATA["+temp.getTitulo()+"]]></cell><cell><![CDATA["+temp.getAreaidarea().getnombre()+"]]></cell><cell><![CDATA["+temp.getFormatoFecha(temp.getFecha_inicio())+"]]></cell></row>";	 

		 }
		 info+=data+"</rows>";
		 out.println(info);
		 dbo.Close();
		
	}

}