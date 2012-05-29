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

import data.CPregunta;
import data.CTitulo_Respuesta;
import data.CUsuarioPermiso;
import framework.CDataExam;
import framework.CValidation;

/**
 * Servlet implementation class SPreguntaTable
 */
@WebServlet("/SPreguntaTable")
public class SPreguntaTable extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SPreguntaTable() {
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
			 if((user_permiso.getIdpermiso().indexOf(259)>-1 || user_permiso.getIdusuario().getidusuario()==1)){
				String action=valid.ValidarRequest(request.getParameter("a"));
				if(action.equalsIgnoreCase("preguntas")){
					
					CDataExam dbo=new CDataExam();
					 dbo.Connect();
					 int page=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("page")));
					 int rp=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("rp")));
					 String order=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("sortname")),codificacion);
					 String typeorder=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("sortorder")),codificacion);
					 String busqueda=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("query")),codificacion);
					 int idcategoria=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("cate")));
					 
					 int min=((page-1)*rp)+1;
					 int max=page*(rp);
					 int ordenar=1;					 
					 if(order.equalsIgnoreCase("orden")){
					 	 ordenar=2;
					 }else if(order.equalsIgnoreCase("categoria")){
						 ordenar=6;
					 }else if(order.equalsIgnoreCase("pregunta")){
						 ordenar=4;
					 }else if(order.equalsIgnoreCase("estado")){
						 ordenar=11;
					 }else if(order.equalsIgnoreCase("auto")){
						 ordenar=8;
					 }else if(order.equalsIgnoreCase("multi")){
						 ordenar=9;
					 }
					 
					 int asc=0;
					 if(typeorder.equalsIgnoreCase("asc")){
						 asc=1;
					 }
					 
					 		ArrayList<CPregunta> lista=dbo.getListaPreguntas(ordenar, asc, min, max,busqueda,idcategoria);
					 		String info="<?xml version=\"1.0\" encoding=\"utf-8\"?>";
							 info+="<rows><page>"+page+"</page><total>"+dbo.getPreguntaTotal(idcategoria)+"</total>";
							 
							 String data="";
							 for(int i=0; i<lista.size();i++){
								 CPregunta temp=lista.get(i);
								 	data+="<row  id='"+temp.getIdpregunta()+"'><cell><![CDATA[<a class=\"ui-state-default ui-corner-all button-save\"   onclick=\"EditarPregunta("+temp.getIdpregunta()+")\"><img src=\"../images/modificar.png\"/></a>]]></cell><cell><![CDATA[<a class=\"ui-state-default ui-corner-all button-save\"   onclick=\"ElimPregunta("+temp.getIdpregunta()+")\"><img width=\"18px\" height=\"18px\" src=\"../images/delete.png\"/></a>]]></cell><cell><![CDATA["+temp.getIdpregunta()+"]]></cell><cell><![CDATA["+temp.getOrden()+"]]></cell><cell><![CDATA["+temp.getPregunta()+"]]></cell><cell><![CDATA["+temp.getEstadoMensaje()+"]]></cell><cell><![CDATA["+temp.getMensaje(temp.getAuto_evaluacion())+"]]></cell><cell><![CDATA["+temp.getMensaje(temp.getMultifasico())+"]]></cell><cell><![CDATA["+temp.getIdcategoria().getDescripcion()+"]]></cell></row>";	 
							 }
							 info+=data+"</rows>";
							 out.println(info);
					 dbo.Close();
				}else if(action.equalsIgnoreCase("titulo_respuesta")){
					CDataExam dbo=new CDataExam();
					 dbo.Connect();
					 int page=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("page")));
					 int rp=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("rp")));
					 String typeorder=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("sortorder")),codificacion);
					 String busqueda=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("query")),codificacion);
					 
					 int min=((page-1)*rp)+1;
					 int max=page*(rp);
					 
					 int asc=0;
					 if(typeorder.equalsIgnoreCase("asc")){
						 asc=1;
					 }
					 
					 		ArrayList<CTitulo_Respuesta> lista=dbo.getListaTitulo_Respuesta( asc, min, max,busqueda);
					 		String info="<?xml version=\"1.0\" encoding=\"utf-8\"?>";
							 info+="<rows><page>"+page+"</page><total>"+dbo.getTitulo_RespuestaTotal()+"</total>";
							 
							 String data="";
							 for(int i=0; i<lista.size();i++){
								 CTitulo_Respuesta temp=lista.get(i);
								 	data+="<row  id='"+temp.getIdtitulo_respuesta()+"'><cell><![CDATA[<input type='radio' class='menu_radio' onclick='EditarTitulo("+temp.getIdtitulo_respuesta()+")' name='idcentro_radio' value='"+temp.getIdtitulo_respuesta()+"' />]]></cell><cell><![CDATA["+temp.getIdtitulo_respuesta()+"]]></cell><cell><![CDATA["+temp.getDescripcion()+"]]></cell></row>";	 
							 }
							 info+=data+"</rows>";
							 out.println(info);
					 dbo.Close();
				}
			 }	
		 }
	}

}
