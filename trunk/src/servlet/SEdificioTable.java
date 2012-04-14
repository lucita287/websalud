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

import data.CEdificio;
import data.CUsuarioPermiso;
import framework.CDataBase;
import framework.CValidation;

/**
 * Servlet implementation class SEdificioTable
 */
@WebServlet("/SEdificioTable")
public class SEdificioTable extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SEdificioTable() {
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
		String codificacion=request.getCharacterEncoding();
		codificacion=(codificacion==null)?"ISO-8859-1":codificacion;
		
		HttpSession sessiones = request.getSession(false);
		 if(sessiones!=null &&  sessiones.getAttribute("user_permiso")!=null){
				CUsuarioPermiso user_permiso=(CUsuarioPermiso)sessiones.getAttribute("user_permiso");
				if( (user_permiso.getIdpermiso().indexOf(228)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
					CDataBase dbo=new CDataBase();
					 dbo.Connect();
					 CValidation valid=new CValidation();
					 int page=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("page")));
					 int rp=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("rp")));
					 String order=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("sortname")),codificacion);
					 String typeorder=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("sortorder")),codificacion);
					 String qtype=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("qtype")),codificacion);
					 String busqueda=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("query")),codificacion);
					 int pqtype=1;
					 if(qtype.equalsIgnoreCase("nombre")){
						 pqtype=2;
					 }
					 
					 int min=((page-1)*rp)+1;
					 int max=page*(rp);
					 int ordenar=1;
					 if(order.equalsIgnoreCase("idedificio")){
					 	 ordenar=1;
					 }else if(order.equalsIgnoreCase("nombre")){
					 	 ordenar=2;
					 }else if(order.equalsIgnoreCase("dir")){
					 	 ordenar=3;
					 }else if(order.equalsIgnoreCase("telefono")){
					 	 ordenar=4;
					 }
					 
					 int asc=0;
					 if(typeorder.equalsIgnoreCase("asc")){
						 asc=1;
					 }
					 
					 
					ArrayList<CEdificio> list=dbo.getListaEdificio(ordenar,asc,min,max,pqtype,busqueda);
					
					 String info="<?xml version=\"1.0\" encoding=\"utf-8\"?>";
					 info+="<rows><page>"+page+"</page><total>"+dbo.getEdificioTotal(pqtype,busqueda)+"</total>";
					 
					 String data="";
					 for(int i=0; i<list.size();i++){
						 CEdificio temp=list.get(i);
						 
					data+="<row id='"+temp.getIdedificio()+"'><cell><![CDATA[<input type='radio' class='menu_radio' onclick='EditarEdificio("+temp.getIdedificio()+")' name='idmenu_radio' value='"+temp.getIdedificio()+"' />]]></cell><cell><![CDATA["+temp.getIdedificio()+"]]></cell><cell><![CDATA["+temp.getNombre()+"]]></cell><cell><![CDATA["+temp.getDireccion()+"]]></cell><cell><![CDATA["+temp.getTelefono()+"]]></cell></row>";	 
			
					 }
					 info+=data+"</rows>";
					 out.println(info);
					 dbo.Close();
				
		}
	}
	}

}
