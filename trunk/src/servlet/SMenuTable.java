package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import data.CMenu;
import data.CUsuarioPermiso;
import framework.CDataBase;
import framework.CValidation;

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
			
			HttpSession sessiones = request.getSession(false);
			 if(sessiones!=null &&  sessiones.getAttribute("user_permiso")!=null){
					CUsuarioPermiso user_permiso=(CUsuarioPermiso)sessiones.getAttribute("user_permiso");
					if( (user_permiso.getIdpermiso().indexOf(221)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
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
								 if(qtype.trim().equalsIgnoreCase("area")){
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
								 
								int maximo=dbo.getCMenuTotal(pqtype,busqueda);
								ArrayList<CMenu> list=dbo.getMenuLista(min,max,pqtype,busqueda,ordenar,asc,maximo);
								
								 String info="<?xml version=\"1.0\" encoding=\"utf-8\"?>";
								 info+="<rows><page>"+page+"</page><total>"+maximo+"</total>";
								 
								 String data="";
								 for(int i=0; i<list.size();i++){
									 CMenu temp=list.get(i);
								data+="<row id='"+temp.getidmenu()+"'><cell><![CDATA[<input type='radio' class='menu_radio' onclick='editar("+temp.getidmenu()+")' name='idmenu_radio' value='"+temp.getidmenu()+"' />]]></cell><cell><![CDATA["+temp.getidmenu()+"]]></cell><cell><![CDATA["+temp.getdescripcion()+"]]></cell><cell><![CDATA["+temp.getareaidarea().getnombre()+"]]></cell><cell><![CDATA["+((temp.getidmenu_rec()!=null)?temp.getidmenu_rec().getdescripcion():"")+"]]></cell></row>";	 
						
								 }
								 info+=data+"</rows>";
								 out.println(info);
								 dbo.Close();
					}					 
			 }		 
	}

}
