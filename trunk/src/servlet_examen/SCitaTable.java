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
import data.CCita_Paciente;
import data.CPaciente;
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
												 int maximo=dbo.ListTotalCitas(tipo_examen,mes,anio);
												 
												 String info="<?xml version=\"1.0\" encoding=\"utf-8\"?>";
												 info+="<rows><total>"+maximo+"</total>";
												 
												 String data="";
												 for(int i=0; i<list.size();i++){
													 CCita temp=list.get(i);
												String estado="";
													if(temp.getEstado()==0) estado="../images/close.png";
													else if(temp.getEstado()==1) estado="../images/on.png";
													else estado="../images/web.png";
												data+="<row id='"+temp.getIdcita()+"'><cell><![CDATA[<button onclick='Modificar("+temp.getIdcita()+")'><img  src='../images/modificar.png'/></button>]]></cell><cell><![CDATA[<button onclick='Delete("+temp.getIdcita()+")'><img  width='18px' height='18px' src='../images/delete.png'></button>]]></cell><cell><![CDATA[<button onclick='Estado("+temp.getIdcita()+")'><img  width='18px' height='18px' src='"+estado+"'/></button>]]></cell><cell><![CDATA["+temp.getIdcita()+"]]></cell><cell><![CDATA["+temp.getFormatoFechaddmmyy(temp.getFecha())+"]]></cell><cell><![CDATA["+temp.getFormatoFechaDes(temp.getFecha())+"]]></cell><cell><![CDATA["+temp.getFormatoFechahhmm(temp.getHora_inicio())+"]]></cell><cell><![CDATA["+temp.getTipo_examenD()+"]]></cell><cell><![CDATA["+temp.getCupo()+"]]></cell><cell><![CDATA["+temp.getCupo_disp()+"]]></cell></row>";	 
										
												 }
												 info+=data+"</rows>";
												 out.println(info);
						 
						 }else if(a.compareTo("est_cita")==0){
							 CPaciente pac=(CPaciente)sessiones.getAttribute("paci_consulta");
							 ArrayList<CCita_Paciente> list=new ArrayList<CCita_Paciente>();
							 if(pac!=null) list=dbo.ListCitasEstudiante(pac);
							 
							 String info="<?xml version=\"1.0\" encoding=\"utf-8\"?>";
							 info+="<rows><total>"+list.size()+"</total>";
							 
							 String data="";
							 for(int i=0; i<list.size();i++){
								 CCita_Paciente temp=list.get(i);
								 
							data+="<row id='"+temp.getIdcita().getIdcita()+"'><cell><![CDATA["+temp.getIdcita().getIdcita()+"]]></cell><cell><![CDATA["+temp.getIdcita().getFormatoFechaddmmyy(temp.getIdcita().getFecha())+"]]></cell><cell><![CDATA["+temp.getIdcita().getFormatoFechaDes(temp.getIdcita().getFecha())+"]]></cell><cell><![CDATA["+temp.getIdcita().getFormatoFechahhmm(temp.getIdcita().getHora_inicio())+"]]></cell><cell><![CDATA["+temp.getIdcita().getFormatoFechahhmm(temp.getIdcita().getHora_fin())+"]]></cell><cell><![CDATA["+temp.getIdcita().getTipo_examenD()+"]]></cell><cell><![CDATA[<button onclick='Modificar(\""+temp.getIdcita().getIdcita()+"\")' ><img width='32px' height='32px' src="+((temp.getEstado()==1)?"'../images/exclamation.png'":(temp.getEstado()==2)?"'../images/off.png'":(temp.getEstado()==3)?"'../images/on.png'":"'../images/close.png'")+" /></button>]]></cell><cell><![CDATA[<input type='text' value='"+temp.getRecibo_pago()+"' size='15' id='boleta"+temp.getIdcita().getIdcita()+"' name='boleta"+temp.getIdcita().getIdcita()+"' /><button onclick='ModificarBoleta("+temp.getIdcita().getIdcita()+")'><img width='24px' height='24px' src='../images/guardar.png' /></button>]]></cell><cell><![CDATA["+temp.getIdcita().getEstadoD()+"]]></cell></row>";	 
					
							 }
							 info+=data+"</rows>";
							 out.println(info);
						 }else if(a.compareTo("lista_estudiantes")==0){
							 		 int page=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("page")));
							 		 int idcita=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idcita")));
									 int rp=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("rp")));
									 String order=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("sortname")),codificacion);
									 String typeorder=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("sortorder")),codificacion);
									 String busqueda=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("query")),codificacion);
									 String qtype=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("qtype")),codificacion);
									 String estado=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("estado")),codificacion);
									 int pqtype=1;
									 if(qtype.trim().equalsIgnoreCase("nombre")){
										 pqtype=2;
									 }else if(qtype.trim().equalsIgnoreCase("apellido")){
										 pqtype=3;
									 }
									 
									 int min=((page-1)*rp)+1;
									 int max=page*(rp);
									 int ordenar=2;					 
									 if(order.equalsIgnoreCase("nombre")){
									 	 ordenar=3;
									 }else if(order.equalsIgnoreCase("apellido")){
										 ordenar=4;
									 }else if(order.equalsIgnoreCase("unidad")){
										 ordenar=6; 
									 }else if(order.equalsIgnoreCase("estado")){
										 ordenar=7; 
									 }
									 
									 int asc=0;
									 if(typeorder.equalsIgnoreCase("asc")){
										 asc=1;
									 }
									 
									 
									 
									 ArrayList<CPaciente> lista=dbo.getListaCitasEstudiante(ordenar,estado,asc,min,max,pqtype,busqueda,idcita);
									 
									 String info="<?xml version=\"1.0\" encoding=\"utf-8\"?>";
									 info+="<rows><page>"+page+"</page><total>"+dbo.getTotalCitasEstudiante(pqtype, busqueda,idcita)+"</total>";
									 
									 String data="";
									 for(int i=0; i<lista.size();i++){
										 CPaciente temp=lista.get(i);
										 
									data+="<row id='"+temp.getIdpaciente()+"'><cell><![CDATA["+temp.getIdpaciente()+"]]></cell><cell><![CDATA["+temp.getCarne()+"]]></cell><cell><![CDATA["+temp.getNombre()+"]]></cell><cell><![CDATA["+temp.getApellido()+"]]></cell><cell><![CDATA["+temp.getCrecio_en()+"]]></cell><cell><![CDATA[<button onclick='Modificar(\""+temp.getIdpaciente()+"\",\""+idcita+"\")' ><img width='24px' height='24px' src="+((temp.getEstado()==1)?"'../images/exclamation.png'":(temp.getEstado()==2)?"'../images/off.png'":(temp.getEstado()==3)?"'../images/on.png'":"'../images/close.png'")+" /></button>]]></cell><cell><![CDATA[<input type='text' value='"+temp.getDireccion()+"' size='15' id='boleta"+temp.getIdpaciente()+"' name='boleta"+temp.getIdpaciente()+"' /><button onclick='GuardarBoleta(\""+temp.getIdpaciente()+"\",\""+temp.getIdunidad_academica()+"\")'><img width='24px' height='24px' src='../images/guardar.png' /></button>]]></cell></row>";	 
							
									 }
									 info+=data+"</rows>";
									 out.println(info);
									 
									 

								
						 }
												 
						 
						 dbo.Close();
					
			}
		
	}

}
