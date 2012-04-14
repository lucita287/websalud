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

import data.CEstado_Civil;
import data.CParentesco;
import data.CTipo_Sangre;
import data.CTitulo_Secundaria;
import data.CUsuarioPermiso;
import framework.CDataExam;
import framework.CValidation;

/**
 * Servlet implementation class SPropiedadTable
 */
@WebServlet("/SPropiedadTable")
public class SPropiedadTable extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SPropiedadTable() {
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
		CValidation valid=new CValidation();			
		String codificacion=request.getCharacterEncoding();
		codificacion=(codificacion==null)?"ISO-8859-1":codificacion;
		HttpSession sessiones = request.getSession(false);
		 if(sessiones!=null &&  sessiones.getAttribute("user_permiso")!=null){
				CUsuarioPermiso user_permiso=(CUsuarioPermiso)sessiones.getAttribute("user_permiso");
				String action=valid.ValidarRequest(request.getParameter("a"));
				
				if(action.equalsIgnoreCase("civil") &&(user_permiso.getIdpermiso().indexOf(239)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
					CDataExam dbo=new CDataExam();
					 dbo.Connect();
					 		ArrayList<CEstado_Civil> lista=dbo.getListaEstadoCivil();
					 		String info="<?xml version=\"1.0\" encoding=\"utf-8\"?>";
							 info+="<rows><page>1</page><total>"+lista.size()+"</total>";
							 
							 String data="";
							 for(int i=0; i<lista.size();i++){
								 CEstado_Civil temp=lista.get(i);
								 	data+="<row id='"+temp.getIdestado_civil()+"'><cell><![CDATA[<input type='radio' class='menu_radio' onclick='EditarEstadoCivil("+temp.getIdestado_civil()+",\""+temp.getNombre()+"\")' name='idcivil_radio' value='"+temp.getIdestado_civil()+"' />]]></cell><cell><![CDATA["+temp.getIdestado_civil()+"]]></cell><cell><![CDATA["+temp.getNombre()+"]]></cell></row>";	 
							 }
							 info+=data+"</rows>";
							 out.println(info);
					 dbo.Close();
				
				}else if(action.equalsIgnoreCase("tsangre") &&(user_permiso.getIdpermiso().indexOf(240)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
					CDataExam dbo=new CDataExam();
					 dbo.Connect();
					 		ArrayList<CTipo_Sangre> lista=dbo.getListaTipo_Sangre();
					 		String info="<?xml version=\"1.0\" encoding=\"utf-8\"?>";
							 info+="<rows><page>1</page><total>"+lista.size()+"</total>";
							 
							 String data="";
							 for(int i=0; i<lista.size();i++){
								 CTipo_Sangre temp=lista.get(i);
								 	data+="<row id='"+temp.getIdtipo_sangre()+"'><cell><![CDATA[<input type='radio' class='menu_radio' onclick='Editartsangre("+temp.getIdtipo_sangre()+",\""+temp.getNombre()+"\")' name='idtsangre_radio' value='"+temp.getIdtipo_sangre()+"' />]]></cell><cell><![CDATA["+temp.getIdtipo_sangre()+"]]></cell><cell><![CDATA["+temp.getNombre()+"]]></cell></row>";	 
							 }
							 info+=data+"</rows>";
							 out.println(info);
					 dbo.Close();
				
				}else if(action.equalsIgnoreCase("tsecundaria") &&(user_permiso.getIdpermiso().indexOf(240)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
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
					 
					 		ArrayList<CTitulo_Secundaria> lista=dbo.getListaTitulo_Secundaria(ordenar, asc, min, max,  busqueda);
					 		String info="<?xml version=\"1.0\" encoding=\"utf-8\"?>";
							 info+="<rows><page>"+page+"</page><total>"+dbo.getTitulo_SecundariaTotal(busqueda)+"</total>";
							 
							 String data="";
							 for(int i=0; i<lista.size();i++){
								 CTitulo_Secundaria temp=lista.get(i);
								 	data+="<row id='"+temp.getIdtitulo_secundaria()+"'><cell><![CDATA[<input type='radio' class='menu_radio' onclick='Editartsecundaria("+temp.getIdtitulo_secundaria()+",\""+temp.getNombre()+"\")' name='idtsangre_radio' value='"+temp.getIdtitulo_secundaria()+"' />]]></cell><cell><![CDATA["+temp.getIdtitulo_secundaria()+"]]></cell><cell><![CDATA["+temp.getNombre()+"]]></cell></row>";	 
							 }
							 info+=data+"</rows>";
							 out.println(info);
					 dbo.Close();
				
				} else if(action.equalsIgnoreCase("parentesco") &&(user_permiso.getIdpermiso().indexOf(241)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
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
					 }else if(order.equalsIgnoreCase("grupo_familiar")){
						 ordenar=3;
					 }else if(order.equalsIgnoreCase("antec_familiar")){
						 ordenar=4;
					 }else if(order.equalsIgnoreCase("emergencia")){
						 ordenar=5;
					 }
					 
					 int asc=0;
					 if(typeorder.equalsIgnoreCase("asc")){
						 asc=1;
					 }
					 
					 		ArrayList<CParentesco> lista=dbo.getListaParentesco(ordenar, asc, min, max, busqueda);
					 		String info="<?xml version=\"1.0\" encoding=\"utf-8\"?>";
							 info+="<rows><page>"+page+"</page><total>"+dbo.getParentescoTotal(busqueda)+"</total>";
							 
							 String data="";
							 for(int i=0; i<lista.size();i++){
								 CParentesco temp=lista.get(i);
								 	data+="<row id='"+temp.getIdparentesco()+"'><cell><![CDATA[<input type='radio' class='menu_radio' onclick='Editarparentesco("+temp.getIdparentesco()+",\""+temp.getNombre()+"\","+temp.getBooleano(temp.getGrupo_familiar())+","+temp.getBooleano(temp.getAntecendentes_familiares())+","+temp.getBooleano(temp.getEmergencias())+")' name='idparentesco' value='"+temp.getIdparentesco()+"' />]]></cell><cell><![CDATA["+temp.getIdparentesco()+"]]></cell><cell><![CDATA["+temp.getNombre()+"]]></cell><cell><![CDATA["+temp.getMensaje(temp.getGrupo_familiar())+"]]></cell><cell><![CDATA["+temp.getMensaje(temp.getAntecendentes_familiares())+"]]></cell><cell><![CDATA["+temp.getMensaje(temp.getEmergencias())+"]]></cell></row>";	 
							 }
							 info+=data+"</rows>";
							 out.println(info);
					 dbo.Close();
				
				} 
		  
		 }
	}

}
