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

import data.CActividad;
import data.CUsuarioPermiso;
import framework.CDataBase;
import framework.CValidation;

/**
 * Servlet implementation class SActividadTable
 */
@WebServlet("/SActividadTable")
public class SActividadTable extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SActividadTable() {
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
					 String order=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("sortname")), codificacion);
					 String typeorder=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("sortorder")), codificacion);
					 String qtype=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("qtype")), codificacion);
					 String busqueda=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("query")), codificacion);
					 int pqtype=1;
					 if(qtype.equalsIgnoreCase("lugar")){
						 pqtype=2;
					 }else if(qtype.equalsIgnoreCase("area")){
						 pqtype=3;
					 }
					 
					 int min=((page-1)*rp)+1;
					 int max=page*(rp);
					 int ordenar=6;
					 
					 if(order.equalsIgnoreCase("idactividad")){
					 	 ordenar=1;
					 }else if(order.equalsIgnoreCase("titulo")){
					 	 ordenar=2;
					 }else if(order.equalsIgnoreCase("area")){
					 	 ordenar=5;
					 }else if(order.equalsIgnoreCase("lugar")){
					 	 ordenar=7;
					 }
					 
					 int asc=0;
					 if(typeorder.equalsIgnoreCase("asc")){
						 asc=1;
					 }
					 
					
					ArrayList<Integer> lista_numeros=user_permiso.getIdarea();
					 int maximo=dbo.getActividadesTotal(pqtype,busqueda,lista_numeros);
					 ArrayList<CActividad> list=dbo.getListaActividades(ordenar,asc,min,max,pqtype,busqueda,maximo,lista_numeros);
					
					 String info="<?xml version=\"1.0\" encoding=\"utf-8\"?>";
					 info+="<rows><page>"+page+"</page><total>"+maximo+"</total>";
					 
					 String data="";
					 for(int i=0; i<list.size();i++){
						 CActividad temp=list.get(i);
						 
					data+="<row id='"+temp.getIdactividad()+"'><cell><![CDATA[<input type='radio' class='menu_radio' onclick='editaractividad("+temp.getIdactividad()+")' name='idmenu_radio' value='"+temp.getIdactividad()+"' />]]></cell><cell><![CDATA["+temp.getIdactividad()+"]]></cell><cell><![CDATA["+temp.getTitulo()+"]]></cell><cell><![CDATA["+temp.getAreaidarea().getnombre()+"]]></cell><cell><![CDATA["+temp.getEdificioidedificio().getNombre()+"]]></cell></row>";	 
			
					 }
					 info+=data+"</rows>";
					 out.println(info);
					 dbo.Close();
				
		}
	}
	}

}
