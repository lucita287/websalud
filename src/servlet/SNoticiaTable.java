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

import data.CNoticia;
import data.CUsuarioPermiso;
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
						
			
			HttpSession sessiones = request.getSession(false);
			 if(sessiones!=null &&  sessiones.getAttribute("user_permiso")!=null){
					CUsuarioPermiso user_permiso=(CUsuarioPermiso)sessiones.getAttribute("user_permiso");
					if( (user_permiso.getIdpermiso().indexOf(225)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
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
						 int ordenar=6;
						 
						 if(order.equalsIgnoreCase("idnoticia")){
						 	 ordenar=1;
						 }else if(order.equalsIgnoreCase("titulo")){
						 	 ordenar=3;
						 }else if(order.equalsIgnoreCase("area")){
						 	 ordenar=9;
						 }else if(order.equalsIgnoreCase("fecha")){
						 	 ordenar=6;
						 }else if(order.equalsIgnoreCase("estado")){
						 	 ordenar=6;
						 }
						 
						 int asc=0;
						 if(typeorder.equalsIgnoreCase("asc")){
							 asc=1;
						 }
						 
						 
						ArrayList<CNoticia> list=dbo.getListaNoticias(ordenar,asc,min,max,pqtype,busqueda);
						
						 String info="<?xml version=\"1.0\" encoding=\"utf-8\"?>";
						 info+="<rows><page>"+page+"</page><total>"+dbo.getNoticiasTotal(pqtype,busqueda)+"</total>";
						 
						 String data="";
						 for(int i=0; i<list.size();i++){
							 CNoticia temp=list.get(i);
							 
						data+="<row id='"+temp.getIdnoticia()+"'><cell><![CDATA[<input type='radio' class='menu_radio' onclick='editarnoticia("+temp.getIdnoticia()+")' name='idmenu_radio' value='"+temp.getIdnoticia()+"' />]]></cell><cell><![CDATA["+temp.getIdnoticia()+"]]></cell><cell><![CDATA["+temp.getTitulo()+"]]></cell><cell><![CDATA["+temp.getAreaidarea().getnombre()+"]]></cell><cell><![CDATA["+temp.getFormatoFechaDes(temp.getFecha_inicio())+"]]></cell><cell><![CDATA["+(temp.getEstado()==1?"ACTIVO":"DESACTIVADO")+"]]></cell></row>";	 
				
						 }
						 info+=data+"</rows>";
						 out.println(info);
						 dbo.Close();
					
			}
		}			
	}

}
