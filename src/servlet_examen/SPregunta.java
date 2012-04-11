package servlet_examen;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import data.CCategoria;
import data.CPregunta;
import data.CPregunta_Titulo_Respuesta;
import data.CTipo_Pregunta;
import data.CTitulo_Respuesta;
import data.CUsuarioPermiso;
import framework.CDataExam;
import framework.CValidation;

/**
 * Servlet implementation class SPregunta
 */
@WebServlet("/SPregunta")
public class SPregunta extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SPregunta() {
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
    	String action=valid.ValidarRequest(request.getParameter("a"));
    	HttpSession sessiones = request.getSession(false);
		 if(sessiones!=null &&  sessiones.getAttribute("user_permiso")!=null){
					CUsuarioPermiso user_permiso=(CUsuarioPermiso)sessiones.getAttribute("user_permiso");
					 
					CDataExam dbo=new CDataExam();
					dbo.Connect();
					
					if(action.equalsIgnoreCase("NewPregunta")){
						String result="";
						String pregunta=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("pregunta")));
						int categoria=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("categoria")));
						int tipo=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("tipo")));
						int requerida=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("requerida")));
						int auto=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("auto")));
						int multifa=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("multifa")));
						int orden=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("orden")));
						int estado=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("estado")));
						
						String descrip=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("descrip")));
						
						String validacion=valid.ValidarCampoVacio(pregunta, "Pregunta");
						validacion=(validacion.compareTo("")==0)?valid.ValidarSiesMayor(categoria, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar una categoria\"}"):validacion;
						validacion=(validacion.compareTo("")==0)?valid.ValidarSiesMayor(tipo, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar una tipo de pregunta\"}"):validacion;
						if((auto==0 && multifa==0) && validacion.compareTo("")==0){
							validacion="{\"resultado\":\"ERROR\",\"mensaje\":\"Debe seleccionar almenos un examen, Autoevaluaci&oacute;n ó Multif&aacute;sico\"}";
						}
						

						if(tipo==1 && validacion.compareTo("")==0){
							CTipo_Pregunta ctipo=dbo.getTipo_PreguntaEspecifica(tipo);
							CCategoria cate=new CCategoria(categoria,"",0,0,0,0);
							CPregunta pregun=new CPregunta(0,orden,requerida, pregunta,cate, descrip,ctipo,auto,multifa, 0,0,estado);
							boolean b=dbo.SafePregunta(pregun);
							if(!b){
								result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se ha almacenado\"}";
							}else{
								result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
							}
						}else if(tipo==2  && validacion.compareTo("")==0){
							CTipo_Pregunta ctipo=dbo.getTipo_PreguntaEspecifica(tipo);
							int size_pregunta=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("size_pregunta")));
							validacion=(validacion.compareTo("")==0)?valid.ValidarSiesMayor(size_pregunta, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar el tama&ntilde;o del texto de la pregunta\"}"):validacion;
							if(validacion.compareTo("")==0){
								CCategoria cate=new CCategoria(categoria,"",0,0,0,0);
								CPregunta pregun=new CPregunta(0,orden,requerida, pregunta,cate, descrip,ctipo,auto,multifa,size_pregunta,0,estado);
								boolean b=dbo.SafePregunta(pregun);
								if(!b){
									result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se ha almacenado\"}";
								}else{
									result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
								}
							}else result=validacion;
						}else if(tipo==3 &&  validacion.compareTo("")==0){
							int multiple=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("multiple")));
							int cantidad_opc=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("cantidad_opc")));
							ArrayList<CPregunta_Titulo_Respuesta> lista=new ArrayList<CPregunta_Titulo_Respuesta>();
							validacion=(validacion.compareTo("")==0)?valid.ValidarSiesMayor(cantidad_opc, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar la cantidad de opciones\"}"):validacion;
							for (int i=1;i<=cantidad_opc;i++) {
								int num=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("ponderacion"+i)));
								String val=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("descrip_titu"+i)));
								CTitulo_Respuesta titulo_Respuesta=dbo.getTitulo_RespuestaEspecifica(val);
								if(titulo_Respuesta==null) titulo_Respuesta=new CTitulo_Respuesta(0,val);
								validacion=(validacion.compareTo("")==0)?valid.ValidarCampoVacio(val,i+") Descripci&oacute;n "):validacion;
								lista.add(new CPregunta_Titulo_Respuesta(null,titulo_Respuesta,num));
								
							}
							
							if(validacion.compareTo("")==0){
								CTipo_Pregunta ctipo=dbo.getTipo_PreguntaEspecifica(tipo);
								CCategoria cate=new CCategoria(categoria,"",0,0,0,0);
								CPregunta pregun=new CPregunta(0,orden,requerida, pregunta,cate, descrip,ctipo,auto,multifa, 0,multiple,estado);
								boolean b=dbo.SafePregunta(pregun);
								if(!b){
									result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se ha almacenado\"}";
								}else{
									int idpregunta=dbo.getPreguntaEspecifica(pregun);
									if(idpregunta>0){
										pregun.setIdpregunta(idpregunta);
										
										boolean b1 =dbo.SafePregunta_Titulo_Respuesta(pregun,lista);
										if(!b1){
											result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se ha almacenado\"}";
										}else{
											result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
										}
									}else{
										result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
									}
									result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
								}
							}else result=validacion;
							
						}else if(tipo>=4 && validacion.compareTo("")==0){
							int multiple=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("multiple")));
							CTipo_Pregunta tipo_preg= dbo.getTipo_PreguntaEspecifica(tipo);
							Iterator<CTitulo_Respuesta> it2=tipo_preg.getIdgrupo_titulo_respuesta().iterator();	
							ArrayList<CPregunta_Titulo_Respuesta> lista=new ArrayList<CPregunta_Titulo_Respuesta>();
							
							while(it2.hasNext()){
								CTitulo_Respuesta titulo=it2.next();	
								 String label="ponderacion"+titulo.getIdtitulo_respuesta();  
								 int num=valid.ConvertEntero(valid.ValidarRequest(request.getParameter(label)));
								 lista.add(new CPregunta_Titulo_Respuesta(null,titulo,num));
							}
							CTipo_Pregunta ctipo=dbo.getTipo_PreguntaEspecifica(tipo);
							CCategoria cate=new CCategoria(categoria,"",0,0,0,0);
							CPregunta pregun=new CPregunta(0,orden,requerida, pregunta,cate, descrip,ctipo,auto,multifa, 0,multiple,estado);
							boolean b=dbo.SafePregunta(pregun);
							if(!b){
								result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se ha almacenado\"}";
							}else{
								int idpregunta=dbo.getPreguntaEspecifica(pregun);
								if(idpregunta>0){
									pregun.setIdpregunta(idpregunta);
									
									boolean b1 =dbo.SafePregunta_Titulo_Respuesta(pregun,lista);
									if(!b1){
										result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se ha almacenado\"}";
									}else{
										result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
									}
								}else{
									result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
								}
								result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
							}
						}else result=validacion;
						out.println(result);
						
					}
		 }
		
	}

}
