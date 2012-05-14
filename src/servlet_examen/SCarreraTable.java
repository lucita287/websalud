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

import data.CDependencia;
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
				if(action.equalsIgnoreCase("dependencia") &&(user_permiso.getIdpermiso().indexOf(249)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
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
