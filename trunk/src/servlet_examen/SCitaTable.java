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

import data.CCita;
import framework.CDataExam;
import framework.CValidation;

/**
 * Servlet implementation class SCitaTable
 */
@WebServlet("/SCitaTable")
public class SCitaTable extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SCitaTable() {
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
			String codificacion=request.getCharacterEncoding();
			codificacion=(codificacion==null)?"ISO-8859-1":codificacion;
			CDataExam dbo=new CDataExam();
						if( dbo.Connect()){
						 CValidation valid=new CValidation();
						 String a=valid.Imprimirvalor(valid.ValidarRequest(request.getParameter("a")), codificacion);
						 
						 
						 if(a.compareTo("allcitas")==0){
						 String order=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("sortname")),codificacion);
						 String typeorder=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("sortorder")),codificacion);
						 int mes = valid.ConvertEntero(valid.ValidarRequest(request.getParameter("mes")));
						 int anio = valid.ConvertEntero(valid.ValidarRequest(request.getParameter("anio")));
						 int tipo_examen= valid.ConvertEntero(valid.ValidarRequest(request.getParameter("tipo_examen")));
						 
						 						
												 
												 int ordenar=1;
												 
												 if(order.equalsIgnoreCase("idcita")){
												 	 ordenar=1;
												 }else if(order.equalsIgnoreCase("fecha")){
												 	 ordenar=5;
												 }else if(order.equalsIgnoreCase("hora")){
												 	 ordenar=6;
												 }else if(order.equalsIgnoreCase("tipo")){
												 	 ordenar=3;
												 }else if(order.equalsIgnoreCase("cupo")){
												 	 ordenar=4;
												 }
												 
												 int asc=0;
												 if(typeorder.equalsIgnoreCase("asc")){
													 asc=1;
												 }
												 
												 ArrayList<CCita> list=dbo.ListCitas(ordenar,asc,tipo_examen,mes,anio);
												 int maximo=list.size();
												 
												 String info="<?xml version=\"1.0\" encoding=\"utf-8\"?>";
												 info+="<rows><total>"+maximo+"</total>";
												 
												 String data="";
												 for(int i=0; i<list.size();i++){
													 CCita temp=list.get(i);
													 
												data+="<row id='"+temp.getIdcita()+"'><cell><![CDATA[<input type='checkbox'  name='deleteactivity' class='dele_activity' value='"+temp.getIdcita()+"' />]]></cell><cell><![CDATA["+temp.getIdcita()+"]]></cell><cell><![CDATA["+temp.getFormatoFechaddmmyy(temp.getFecha())+"]]></cell><cell><![CDATA["+temp.getFormatoFechaDes(temp.getFecha())+"]]></cell><cell><![CDATA["+temp.getFormatoFechahhmm(temp.getHora_inicio())+"]]></cell><cell><![CDATA["+temp.getTipo_examenD()+"]]></cell><cell><![CDATA["+temp.getCupo()+"]]></cell><cell><![CDATA["+temp.getCupo_disp()+"]]></cell></row>";	 
										
												 }
												 info+=data+"</rows>";
												 out.println(info);
						 
						 }else if(a.compareTo("est_cita")==0){
							 ArrayList<CCita> list=(ArrayList<CCita>)sessiones.getAttribute("paci_list");
							 if(list==null) list=new ArrayList<CCita>();
							 String info="<?xml version=\"1.0\" encoding=\"utf-8\"?>";
							 info+="<rows><total>"+list.size()+"</total>";
							 
							 String data="";
							 for(int i=0; i<list.size();i++){
								 CCita temp=list.get(i);
								 
							data+="<row id='"+temp.getIdcita()+"'><cell><![CDATA["+temp.getIdcita()+"]]></cell><cell><![CDATA["+temp.getFormatoFechaddmmyy(temp.getFecha())+"]]></cell><cell><![CDATA["+temp.getFormatoFechaDes(temp.getFecha())+"]]></cell><cell><![CDATA["+temp.getFormatoFechahhmm(temp.getHora_inicio())+"]]></cell><cell><![CDATA["+temp.getTipo_examenD()+"]]></cell><cell><![CDATA[<button onclick='Modificar(\""+temp.getIdcita()+"\")' ><img width='32px' height='32px' src="+((temp.getCupo_disp()==1)?"'../images/on.png'":"'../images/off.png'")+" /></button>]]></cell></row>";	 
					
							 }
							 info+=data+"</rows>";
							 out.println(info);
						 }
												 
						 
						 dbo.Close();
					
			}
		
	}

}
