package servlet_estudiantes;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import data.CPaciente;
import data.CPaciente_Menu_Categoria;
import data.CPregunta;
import data.CPregunta_Paciente;
import framework.CDataExam;
import framework.CValidationMensaje;

/**
 * Servlet implementation class SRespuesta
 */
@WebServlet("/SRespuesta")
public class SRespuesta extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SRespuesta() {
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
		HttpSession sessiones=request.getSession(false); 
		//PrintWriter out = response.getWriter(); 
		String codificacion=request.getCharacterEncoding();
		codificacion=(codificacion==null)?"ISO-8859-1":codificacion;
		CValidationMensaje valid=new CValidationMensaje();
		
		if(sessiones!=null && sessiones.getAttribute("paciente")!=null){
			CPaciente pac=(CPaciente)sessiones.getAttribute("paciente");
			CDataExam	data=new CDataExam();
			if(data.Connect()){
				
				int action=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("a")));
				int auto=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("auto")));
				int multi=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("multi")));
				int area =valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idarea")));
				String submit=valid.ValidarRequest(request.getParameter("sig"));
				if(action>0 &&(auto==1 || multi==1)){
					ArrayList<CPregunta> preg=data.getListaPreguntas(action ,auto, multi);
					Iterator<CPregunta> it2=preg.iterator();
					String validaciones="";
					//REVISAR RESPUESTAS
					while(it2.hasNext()){
						CPregunta pregunta=it2.next();
						if(pregunta.getGenero()==0 || pregunta.getGenero()==pac.getSexo()){
							String validaciones2="";
						if(pregunta.getRequerida()==1){
							String resp=request.getParameter("pregunta_"+pregunta.getIdpregunta());
							
							if(resp==null){
								validaciones2="Debe responder todas las preguntas obligatorias";
								
							}else if(pregunta.getIdtipo_pregunta().getIdtipo_pregunta()==2 && resp.isEmpty()){
								validaciones2="Debe responder todas las preguntas obligatorias";
								
							}
							validaciones=validaciones2;
						}	
							if(validaciones2.compareTo("")==0){
								ArrayList<Integer> lista=new ArrayList<Integer>();
								if(pregunta.getIdtipo_pregunta().getIdtipo_pregunta()==1){
									int num=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("pregunta_"+pregunta.getIdpregunta())));
									CPregunta_Paciente preg_pac=new CPregunta_Paciente(pregunta.getIdpregunta(),pac.getIdpaciente(),num,null,lista, pregunta.getIdtipo_pregunta().getIdtipo_pregunta());
									data.SafeRespuesta(preg_pac);
								}else if(pregunta.getIdtipo_pregunta().getIdtipo_pregunta()==2){
									String respuesta=valid.Limpiarvalor( valid.ValidarRequest(request.getParameter("pregunta_"+pregunta.getIdpregunta())),codificacion);
									if(respuesta.length()>150) respuesta=respuesta.substring(0,150);
									CPregunta_Paciente preg_pac=new CPregunta_Paciente(pregunta.getIdpregunta(),pac.getIdpaciente(),null,respuesta,lista, pregunta.getIdtipo_pregunta().getIdtipo_pregunta());
									data.SafeRespuesta(preg_pac);
								}else if(pregunta.getIdtipo_pregunta().getIdtipo_pregunta()>=3){
									if(request.getParameter("pregunta_"+pregunta.getIdpregunta())!=null){
										if(pregunta.getMultiple()==1){
											String[] param = request.getParameterValues("pregunta_"+pregunta.getIdpregunta());
											 for(int i=0; i<param.length; i++){
												 int num=valid.ConvertEntero(param[i]);
												 if(num>0) lista.add(num);			 
											 }
										}else{
											int num=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("pregunta_"+pregunta.getIdpregunta())));
											if(num>0) lista.add(num);
										}
										
										CPregunta_Paciente preg_pac=new CPregunta_Paciente(pregunta.getIdpregunta(),pac.getIdpaciente(),null,null,lista, pregunta.getIdtipo_pregunta().getIdtipo_pregunta());
										data.SafeRespuesta(preg_pac);
									}
								}
							}
						
						}
					}
					if(validaciones.compareTo("")==0){
						
						data.SafeMenu_Paciente(new CPaciente_Menu_Categoria(pac.getIdpaciente(),action,
								auto, multi));
						
						
						if(submit.compareTo("Continuar")==0){
						int next=data.getProximo(area,auto,multi,action);
							if(next==0){	
								if(auto==1){ 
									response.sendRedirect("estudiante/index.jsp?portal=6");
								}else{ 
									response.sendRedirect("estudiante/index.jsp?portal=5");
								}
							}else{
								response.sendRedirect("estudiante/index.jsp?portal=10&idmenu="+next+"&auto="+auto+"&multi="+multi);
							}
						}else{
							if(auto==1){ 
								response.sendRedirect("estudiante/index.jsp?portal=6");
							}else{ 
								response.sendRedirect("estudiante/index.jsp?portal=5");
							}
						}	
					}else{
						response.sendRedirect("estudiante/index.jsp?portal=10&idmenu="+action+"&auto="+auto+"&multi="+multi+"&e="+validaciones);
					}
				}else response.sendRedirect("index.jsp");
				
				
				data.Close();
			}else response.sendRedirect("index.jsp");
		}else response.sendRedirect("index.jsp");	
	}

}
