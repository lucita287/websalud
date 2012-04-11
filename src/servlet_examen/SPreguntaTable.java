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
		
		HttpSession sessiones = request.getSession(false);
		 if(sessiones!=null &&  sessiones.getAttribute("user_permiso")!=null){
				String action=valid.ValidarRequest(request.getParameter("a"));
				if(action.equalsIgnoreCase("preguntas")){
					
					CDataExam dbo=new CDataExam();
					 dbo.Connect();
					 int page=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("page")));
					 int rp=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("rp")));
					 String order=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("sortname")));
					 String typeorder=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("sortorder")));
					 
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
					 
					 		ArrayList<CPregunta> lista=dbo.getListaPreguntas(ordenar, asc, min, max);
					 		String info="<?xml version=\"1.0\" encoding=\"utf-8\"?>";
							 info+="<rows><page>"+page+"</page><total>"+dbo.getPreguntaTotal()+"</total>";
							 
							 String data="";
							 for(int i=0; i<lista.size();i++){
								 CPregunta temp=lista.get(i);
								 	data+="<row  id='"+temp.getIdpregunta()+"'><cell><![CDATA[<a class=\"ui-state-default ui-corner-all button-save\"   onclick=\"EditarPregunta("+temp.getIdpregunta()+")\"><img src=\"../images/modificar.png\"/></a>]]></cell><cell><![CDATA["+temp.getIdpregunta()+"]]></cell><cell><![CDATA["+temp.getOrden()+"]]></cell><cell><![CDATA["+temp.getIdcategoria().getDescripcion()+"]]></cell><cell><![CDATA["+temp.getPregunta()+"]]></cell><cell><![CDATA["+temp.getEstadoMensaje()+"]]></cell><cell><![CDATA["+temp.getMensaje(temp.getAuto_evaluacion())+"]]></cell><cell><![CDATA["+temp.getMensaje(temp.getMultifasico())+"]]></cell></row>";	 
							 }
							 info+=data+"</rows>";
							 out.println(info);
					 dbo.Close();
				}
				
		 }
	}

}
