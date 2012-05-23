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

import data.CCondicion;
import data.CEncabezado_Condicion;
import data.CResultado_Examen;
import data.CTipo_Interpretacion;
import framework.CDataExam;
import framework.CValidation;

/**
 * Servlet implementation class SInterpretacionTable
 */
@WebServlet("/SInterpretacionTable")
public class SInterpretacionTable extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SInterpretacionTable() {
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
				String action=valid.ValidarRequest(request.getParameter("a"));
		
					if(action.equalsIgnoreCase("tipo")){
						CDataExam dbo=new CDataExam();
						 dbo.Connect();
						 int page=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("page")));
						 int rp=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("rp")));
						 String typeorder=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("sortorder")),codificacion);
						 String busqueda=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("query")),codificacion);
						 String order=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("sortname")),codificacion);
						 
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
						 
						 
						 		ArrayList<CTipo_Interpretacion> lista=dbo.getListatipo_interpretacion( asc, min, max,busqueda,ordenar);
						 		String info="<?xml version=\"1.0\" encoding=\"utf-8\"?>";
								 info+="<rows><page>"+page+"</page><total>"+dbo.gettipo_interpretacionTotal()+"</total>";
								 
								 String data="";
								 for(int i=0; i<lista.size();i++){
									 CTipo_Interpretacion temp=lista.get(i);
									 	data+="<row  id='"+temp.getIdtipo_interpretacion()+"'><cell><![CDATA[<input type='radio' class='menu_radio' onclick='EditarInter_tipo("+temp.getIdtipo_interpretacion()+",\""+temp.getDescripcion()+"\")' name='idcentro_radio' value='"+temp.getIdtipo_interpretacion()+"' />]]></cell><cell><![CDATA["+temp.getIdtipo_interpretacion()+"]]></cell><cell><![CDATA["+temp.getDescripcion()+"]]></cell></row>";	 
								 }
								 info+=data+"</rows>";
								 out.println(info);
						 dbo.Close();
					}else if(action.equalsIgnoreCase("interpre")){
						CDataExam dbo=new CDataExam();
						 dbo.Connect();
						 
						 
						 
						 int page=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("page")));
						 int rp=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("rp")));
						 String order=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("sortname")),codificacion);
						 String typeorder=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("sortorder")),codificacion);
						 String busqueda=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("query")),codificacion);
						 int idtipo=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idtipo")));
						 
						 int min=((page-1)*rp)+1;
						 int max=page*(rp);
						 int ordenar=1;					 
						 if(order.equalsIgnoreCase("titulo")){
						 	 ordenar=2;
						 }else if(order.equalsIgnoreCase("tipo")){
							 ordenar=5;
						 }
						 
						 int asc=0;
						 if(typeorder.equalsIgnoreCase("asc")){
							 asc=1;
						 }
						 
						 		ArrayList<CResultado_Examen> lista=dbo.getListaresultado_examen(ordenar, asc, min, max,busqueda,idtipo);
						 		String info="<?xml version=\"1.0\" encoding=\"utf-8\"?>";
								 info+="<rows><page>"+page+"</page><total>"+dbo.getresultado_examenTotal(idtipo)+"</total>";
								 
								 String data="";
								 for(int i=0; i<lista.size();i++){
									 CResultado_Examen temp=lista.get(i);
									 data+="<row  id='"+temp.getIdresultado_examen()+"'><cell><![CDATA[<input type='radio' class='menu_radio' onclick='EditarInterpre("+temp.getIdresultado_examen()+")' name='idcentro_radio' value='"+temp.getIdresultado_examen()+"' />]]></cell><cell><![CDATA["+temp.getIdresultado_examen()+"]]></cell><cell><![CDATA["+temp.getTitulo()+"]]></cell><cell><![CDATA["+temp.getInterpretacion()+"]]></cell></row>";	 
								 }
								 info+=data+"</rows>";
								 out.println(info);
						 
						 
						dbo.Close();
					}else if(action.equalsIgnoreCase("condicional")){
						CDataExam dbo=new CDataExam();
						 dbo.Connect();
						 
						 
						 
						 int page=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("page")));
						 int rp=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("rp")));
						 String order=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("sortname")),codificacion);
						 String typeorder=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("sortorder")),codificacion);
						 String busqueda=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("query")),codificacion);
						 int idtipo=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idtipo")));
						 
						 int min=((page-1)*rp)+1;
						 int max=page*(rp);
						 int ordenar=1;					 
						 if(order.equalsIgnoreCase("descripcion")){
						 	 ordenar=2;
						 }else if(order.equalsIgnoreCase("tipo")){
							 ordenar=3;
						 }
						 
						 int asc=0;
						 if(typeorder.equalsIgnoreCase("asc")){
							 asc=1;
						 }

						 ArrayList<CEncabezado_Condicion> lista=dbo.getListaEncabezado_Condicion(ordenar, asc, min, max,busqueda,idtipo);
						 		String info="<?xml version=\"1.0\" encoding=\"utf-8\"?>";
								 info+="<rows><page>"+page+"</page><total>"+dbo.getEncabezado_CondicionTotal(idtipo)+"</total>";
								 
								 String data="";
								 for(int i=0; i<lista.size();i++){
									 CEncabezado_Condicion temp=lista.get(i);
									 data+="<row  id='"+temp.getIdencabezado_condicion()+"'><cell><![CDATA[<input type='radio' class='menu_radio' onclick='EditarEncabezado("+temp.getIdencabezado_condicion()+")' name='idcentro_radio' value='"+temp.getIdencabezado_condicion()+"' />]]></cell><cell><![CDATA[<a class=\"ui-state-default ui-corner-all button-save\"   onclick=\"ElimCondicion("+temp.getIdencabezado_condicion()+")\"><img width=\"18px\" height=\"18px\" src=\"../images/delete.png\"/></a>]]></cell><cell><![CDATA["+temp.getIdencabezado_condicion()+"]]></cell><cell><![CDATA["+temp.getDescripcion()+"]]></cell><cell><![CDATA["+temp.getTipo()+"]]></cell></row>";	 
								 }
								 info+=data+"</rows>";
								 out.println(info);
						 
						 
						dbo.Close();
					}else if(action.equalsIgnoreCase("mcondicion")){
						CDataExam dbo=new CDataExam();
						 dbo.Connect();
						
						int idencabe=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("id")));
						ArrayList<CCondicion> lista=dbo.getListaCondicion1(idencabe);
						
						String info="<?xml version=\"1.0\" encoding=\"utf-8\"?>";
						 info+="<rows><total>"+lista.size()+"</total>";
						 
						 String data="";
						 for(int i=0; i<lista.size();i++){
							 CCondicion temp=lista.get(i);
							 data+="<row  id='"+temp.getIdcondicion()+"'><cell><![CDATA[<a class=\"ui-state-default ui-corner-all button-save\"   onclick=\"EliminarCond("+temp.getIdcondicion()+")\"><img width=\"18px\" height=\"18px\" src=\"../images/delete.png\"/></a>]]></cell><cell><![CDATA["+temp.getIdcondicion()+"]]></cell><cell><![CDATA["+temp.getPregunta1()+"]]></cell><cell><![CDATA["+temp.getSignoR()+"]]></cell><cell><![CDATA["+temp.getValor()+"]]></cell></row>";	 
						 }
						 info+=data+"</rows>";
						 out.println(info);
						dbo.Close();
					}
		 }			
	}

}
