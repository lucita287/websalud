package servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import data.CMultimedia;
import data.CUsuarioPermiso;
import framework.CDataBase;
import framework.CValidation;

/**
 * Servlet implementation class SMultimediaTable
 */
@WebServlet("/SMultimediaTable")
public class SMultimediaTable extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SMultimediaTable() {
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
				if( (user_permiso.getIdpermiso().indexOf(247)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
					CDataBase dbo=new CDataBase();
							 dbo.Connect();
							 CValidation valid=new CValidation();
							 int page=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("page")));
							 int rp=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("rp")));
							 String order=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("order")));
							 String qtype=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("qtype")));
							 String typeorder=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("sortorder")));
							 String busqueda=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("query")));
							 
							 int pqtype=1;
							 if(qtype.trim().equalsIgnoreCase("usuario")){
								 pqtype=2;
							 }
							 
							 int asc=1;
							 if(typeorder.equalsIgnoreCase("desc")){
								 asc=0;
							 }
							 
							 int ordenar=2;
							 if(order.trim().equalsIgnoreCase("idmultimedia")){
								 ordenar=2;
							 }else if(order.trim().equalsIgnoreCase("tipo")){
								 ordenar=6;
							 }else if(order.trim().equalsIgnoreCase("ubicacion")){
								 ordenar=3;
							 }else if(order.trim().equalsIgnoreCase("nombre")){
								 ordenar=7;
							 }else if(order.trim().equalsIgnoreCase("user")){
								 ordenar=9;
							 }
							 
							 int min=((page-1)*rp)+1;
							 int max=page*(rp);
							 							 
							 	
							int maximo=dbo.getMultimediaEliminarTotal(pqtype,busqueda);
							//(int min,int max,int ordenar, int asc, int tipo, String query)
							ArrayList<CMultimedia> list=dbo.getMultimediaEliminarLista(min,max,ordenar,asc,pqtype,busqueda);
							
							 String info="<?xml version=\"1.0\" encoding=\"utf-8\"?>";
							 info+="<rows><page>"+page+"</page><total>"+maximo+"</total>";
							 
							 String data="";
							 for(int i=0; i<list.size();i++){
								 CMultimedia temp=list.get(i);
								 String linK="<a target='_blank' href='../"+temp.getdireccion_relativa()+"'>VER ARCHIVO</a>";
								 File file = new File(temp.getdireccion());
								 data+="<row id='"+temp.getidimagen()+"'><cell><![CDATA[<input type='checkbox'  name='dele_multimedia' class='dele_multimedia' value='"+temp.getidimagen()+"' />]]></cell><cell><![CDATA["+temp.getidimagen()+"]]></cell><cell><![CDATA["+(temp.gettipo()==1?"IMAGEN":"PDF")+"]]></cell><cell><![CDATA["+linK+"]]></cell><cell><![CDATA["+file.getName()+"]]></cell><cell><![CDATA["+temp.getusuarioidusuario().getnombre()+" "+temp.getusuarioidusuario().getapellido()+"]]></cell><cell><![CDATA["+temp.getusuarioidusuario().getnick()+"]]></cell></row>";	
							 }
							 info+=data+"</rows>";
							 out.println(info);
							 dbo.Close();
				}					 
		 }
		
		
	}

}
