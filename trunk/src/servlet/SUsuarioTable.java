package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import data.CUsuario;
import framework.CDataBase;
import framework.CValidation;

/**
 * Servlet implementation class SUsuarioTable
 */
@WebServlet("/SUsuarioTable")
public class SUsuarioTable extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SUsuarioTable() {
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
		 if(qtype.trim().equalsIgnoreCase("nombre"))
			 pqtype=2;
		 else if(qtype.trim().equalsIgnoreCase("apellido"))
			 pqtype=3;
		 
		 
		 int min=((page-1)*rp)+1;
		 int max=page*(rp);
		 int ordenar=2;
		 
		 if(order.equalsIgnoreCase("idusuario")){
			 ordenar=2;
		 }else if(order.equalsIgnoreCase("nombre")){
			 ordenar=3;
		 }else if(order.equalsIgnoreCase("apellido")){
			 ordenar=4;
		 }else if(order.equalsIgnoreCase("nick")){
			 ordenar=5;
		 }else if(order.equalsIgnoreCase("email")){
			 ordenar=6;
		 }else if(order.equalsIgnoreCase("telefono")){
			 ordenar=7;
		 }
		 
		 int asc=1;
		 if(typeorder.equalsIgnoreCase("desc")){
			 asc=0;
		 }
		 
		
		ArrayList<CUsuario> list=dbo.getListaUsuarios(ordenar,asc,min,max,pqtype,busqueda);
		
		 String info="<?xml version=\"1.0\" encoding=\"utf-8\"?>";
		 info+="<rows><page>"+page+"</page><total>"+dbo.getUsuarioTotal(pqtype,busqueda)+"</total>";
		 //info+="<rows><page>"+page+"</page><total>10</total>";
		 String data="";
		 for(int i=0; i<list.size();i++){
			 CUsuario temp=list.get(i);
		data+="<row id='"+temp.getidusuario()+"'><cell><![CDATA[<input type='radio' class='menu_radio' onclick='editarUser("+temp.getidusuario()+")' name='idmenu_radio' value='"+temp.getidusuario()+"' />]]></cell><cell><![CDATA["+temp.getidusuario()+"]]></cell><cell><![CDATA["+temp.getnombre()+"]]></cell><cell><![CDATA["+temp.getapellido()+"]]></cell><cell><![CDATA["+temp.getnick()+"]]></cell><cell><![CDATA["+temp.getemail()+"]]></cell><cell><![CDATA["+temp.gettelefono()+"]]></cell></row>";	 

		 }
		 info+=data+"</rows>";
		 out.println(info);
		 dbo.Close();
		
	}

}
