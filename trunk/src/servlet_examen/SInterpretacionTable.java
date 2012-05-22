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
        // TODO Auto-generated constructor stub
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
					}
		 }			
	}

}
