package servlet_examen;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import data.CCategoria;
import data.CCategoria_Interpretacion;
import data.CUsuarioPermiso;
import framework.CDataExam;
import framework.CValidation;

/**
 * Servlet implementation class SCategoriaTable
 */
@WebServlet("/SCategoriaTable")
public class SCategoriaTable extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SCategoriaTable() {
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
		String codificacion=request.getCharacterEncoding();
		codificacion=(codificacion==null)?"ISO-8859-1":codificacion;
		PrintWriter out = response.getWriter(); 
		CValidation valid=new CValidation();			
		
		HttpSession sessiones = request.getSession(false);
		 if(sessiones!=null &&  sessiones.getAttribute("user_permiso")!=null){
				CUsuarioPermiso user_permiso=(CUsuarioPermiso)sessiones.getAttribute("user_permiso");
				String action=valid.ValidarRequest(request.getParameter("a"));
						if(action.equalsIgnoreCase("categoria") &&(user_permiso.getIdpermiso().indexOf(250)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
							CDataExam dbo=new CDataExam();
							 dbo.Connect();
							 int page=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("page")));
							 int rp=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("rp")));
							 String order=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("sortname")),codificacion);
							 String typeorder=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("sortorder")),codificacion);
							 String busqueda=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("query")),codificacion);
							 
							 int min=((page-1)*rp)+1;
							 int max=page*(rp);
							 int ordenar=1;					 
							 if(order.equalsIgnoreCase("nombre")){
							 	 ordenar=2;
							 }
							 
							 int asc=0;
							 if(typeorder.equalsIgnoreCase("asc")){
								 asc=1;
							 }
							 
							 		ArrayList<CCategoria> lista=dbo.getListaCategoria(ordenar, asc, min, max,  busqueda);
							 		String info="<?xml version=\"1.0\" encoding=\"utf-8\"?>";
									 info+="<rows><page>"+page+"</page><total>"+dbo.getCategoriaTotal(busqueda)+"</total>";
									 
									 String data="";
									 for(int i=0; i<lista.size();i++){
										 CCategoria temp=lista.get(i);
										 	data+="<row id='"+temp.getIdcategoria()+"'><cell><![CDATA[<input type='radio' class='menu_radio' onclick='Editarcategoria("+temp.getIdcategoria()+",\""+temp.getDescripcion()+"\","+temp.getOrden()+","+temp.getBooleano(temp.getAutoevaluacion())+","+temp.getBooleano(temp.getMultifasico())+")' name='idcategoria' value='"+temp.getIdcategoria()+"' />]]></cell><cell><![CDATA["+temp.getIdcategoria()+"]]></cell><cell><![CDATA["+temp.getOrden()+"]]></cell><cell><![CDATA["+temp.getDescripcion()+"]]></cell><cell><![CDATA["+temp.getEstadoMensaje()+"]]></cell><cell><![CDATA["+temp.getMensaje(temp.getAutoevaluacion())+"]]></cell><cell><![CDATA["+temp.getMensaje(temp.getMultifasico())+"]]></cell></row>";	 
									 }
									 info+=data+"</rows>";
									 out.println(info);
							 dbo.Close();
						
						}else if(action.equalsIgnoreCase("ponderacion") &&(user_permiso.getIdpermiso().indexOf(251)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
							CDataExam dbo=new CDataExam();
							 dbo.Connect();
							 int idcategoria=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idcategoria")));
							 String order=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("sortname")),codificacion);
							 String typeorder=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("sortorder")),codificacion);
							 
							 int ordenar=1;					 
							 if(order.equalsIgnoreCase("min")){
							 	 ordenar=2;
							 }else if(order.equalsIgnoreCase("max")){
							 	 ordenar=3;
							 }
							 
							 int asc=0;
							 if(typeorder.equalsIgnoreCase("asc")){
								 asc=1;
							 }
							 
							 		ArrayList<CCategoria_Interpretacion> lista=dbo.getListaCategoria(ordenar, asc,idcategoria);
							 		String info="<?xml version=\"1.0\" encoding=\"utf-8\"?>";
									 info+="<rows><page>1</page><total>"+lista.size()+"</total>";
									 
									 String data="";
									 for(int i=0; i<lista.size();i++){
										 CCategoria_Interpretacion temp=lista.get(i);
										 	data+="<row id='"+temp.getIdcategoria_interpretacion()+"'><cell><![CDATA[<input type='radio' class='menu_categoria' onclick='EditarCatePonderacion("+temp.getIdcategoria_interpretacion()+")' name='idcategoria_ponderacion' value='"+temp.getIdcategoria()+"' />]]></cell><cell><![CDATA["+temp.getIdcategoria_interpretacion()+"]]></cell><cell><![CDATA["+temp.getPonderacion_max()+"]]></cell><cell><![CDATA["+temp.getPonderacion_min()+"]]></cell><cell><![CDATA["+temp.getIdcategoria().getDescripcion()+"]]></cell></row>";	 
									 }
									 info+=data+"</rows>";
									 out.println(info);
							 dbo.Close();
						
						}
		 }		
	}

}
