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

import data.CCarrera;
import data.CCentro_Regional;
import data.CDependencia;
import data.CUnidad_Academica;
import data.CUsuarioPermiso;
import framework.CDataExam;
import framework.CValidation;

/**
 * Servlet implementation class SCarreraTable
 */
@WebServlet("/SCarreraTable")
public class SCarreraTable extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SCarreraTable() {
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
		CValidation valid=new CValidation();			
		
		HttpSession sessiones = request.getSession(false);
		 if(sessiones!=null &&  sessiones.getAttribute("user_permiso")!=null){
				CUsuarioPermiso user_permiso=(CUsuarioPermiso)sessiones.getAttribute("user_permiso");
				String action=valid.ValidarRequest(request.getParameter("a"));
				if(action.equalsIgnoreCase("carrera") &&(user_permiso.getIdpermiso().indexOf(243)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
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
					 
					 		ArrayList<CCarrera> lista=dbo.getListaCarrera(ordenar, asc, min, max,  busqueda);
					 		String info="<?xml version=\"1.0\" encoding=\"utf-8\"?>";
							 info+="<rows><page>"+page+"</page><total>"+dbo.getCarreraTotal(busqueda)+"</total>";
							 
							 String data="";
							 for(int i=0; i<lista.size();i++){
								 CCarrera temp=lista.get(i);
								 	data+="<row id='"+temp.getIdcarrera()+"'><cell><![CDATA[<input type='radio' class='menu_radio' onclick='Editarcarrera("+temp.getIdcarrera()+",\""+temp.getNombre()+"\")' name='idtsangre_radio' value='"+temp.getIdcarrera()+"' />]]></cell><cell><![CDATA["+temp.getIdcarrera()+"]]></cell><cell><![CDATA["+temp.getNombre()+"]]></cell></row>";	 
							 }
							 info+=data+"</rows>";
							 out.println(info);
					 dbo.Close();
				
				}else if(action.equalsIgnoreCase("centro") &&(user_permiso.getIdpermiso().indexOf(244)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
					CDataExam dbo=new CDataExam();
					 dbo.Connect();
					 int page=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("page")));
					 int rp=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("rp")));
					 String order=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("sortname")),codificacion);
					 String qtype=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("qtype")),codificacion);
					 String typeorder=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("sortorder")),codificacion);
					 String busqueda=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("query")),codificacion);
					 
					 int min=((page-1)*rp)+1;
					 int max=page*(rp);
					 int ordenar=1;					 
					 if(order.equalsIgnoreCase("nombre")){
					 	 ordenar=2;
					 }
					 int type=1;
					 if(qtype.equalsIgnoreCase("departamento")){
					 	 type=2;
					 }
					 int asc=0;
					 if(typeorder.equalsIgnoreCase("asc")){
						 asc=1;
					 }
					 
					 		ArrayList<CCentro_Regional> lista=dbo.getListaCentro_Regional(ordenar, type, asc, min, max, busqueda);
					 		String info="<?xml version=\"1.0\" encoding=\"utf-8\"?>";
							 info+="<rows><page>"+page+"</page><total>"+dbo.getCentro_RegionalTotal(type,busqueda)+"</total>";
							 
							 String data="";
							 for(int i=0; i<lista.size();i++){
								 CCentro_Regional temp=lista.get(i);
								 	data+="<row id='"+temp.getIdcentro_regional()+"'><cell><![CDATA[<input type='radio' class='menu_radio' onclick='Editarcentro("+temp.getIdcentro_regional()+",\""+temp.getNombre()+"\",\""+temp.getDepartamento().getIddepartamento()+"\")' name='idcentro_radio' value='"+temp.getIdcentro_regional()+"' />]]></cell><cell><![CDATA["+temp.getIdcentro_regional()+"]]></cell><cell><![CDATA["+temp.getNombre()+"]]></cell><cell><![CDATA["+temp.getDepartamento().getNombre()+"]]></cell></row>";	 
							 }
							 info+=data+"</rows>";
							 out.println(info);
					 dbo.Close();
				
				}else if(action.equalsIgnoreCase("facultad") &&(user_permiso.getIdpermiso().indexOf(245)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
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
					 
					 		ArrayList<CUnidad_Academica> lista=dbo.getListaUnidad_Academica(ordenar, asc, min, max, busqueda);
					 		String info="<?xml version=\"1.0\" encoding=\"utf-8\"?>";
							 info+="<rows><page>"+page+"</page><total>"+dbo.getUnidadAcademicaTotal(busqueda)+"</total>";
							 
							 String data="";
							 for(int i=0; i<lista.size();i++){
								 CUnidad_Academica temp=lista.get(i);
								 	data+="<row id='"+temp.getIdunidad_academica()+"'><cell><![CDATA[<input type='radio' class='menu_radio' onclick='Editarfacultad("+temp.getIdunidad_academica()+",\""+temp.getNombre()+"\")' name='idcentro_radio' value='"+temp.getIdunidad_academica()+"' />]]></cell><cell><![CDATA["+temp.getIdunidad_academica()+"]]></cell><cell><![CDATA["+temp.getNombre()+"]]></cell></row>";	 
							 }
							 info+=data+"</rows>";
							 out.println(info);
					 dbo.Close();
				
				}else if(action.equalsIgnoreCase("dependencia") &&(user_permiso.getIdpermiso().indexOf(249)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
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
					 
					 ArrayList<CDependencia> lista=dbo.getListaDependencia(ordenar, asc, min, max, busqueda);
					 		String info="<?xml version=\"1.0\" encoding=\"utf-8\"?>";
							 info+="<rows><page>"+page+"</page><total>"+dbo.getDependenciaTotal(busqueda)+"</total>";
							 
							 String data="";
							 for(int i=0; i<lista.size();i++){
								 CDependencia temp=lista.get(i);
								 	data+="<row id='"+temp.getIddependencia()+"'><cell><![CDATA[<input type='radio' class='menu_radio' onclick='Editardependencia("+temp.getIddependencia()+",\""+temp.getNombre()+"\")' name='idcentro_radio' value='"+temp.getIddependencia()+"' />]]></cell><cell><![CDATA["+temp.getIddependencia()+"]]></cell><cell><![CDATA["+temp.getNombre()+"]]></cell></row>";	 
							 }
							 info+=data+"</rows>";
							 out.println(info);
					 dbo.Close();
				
				}
		 }
	}

}
