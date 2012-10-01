package servlet_estudiantes;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import data.CConfiguracion;
import data.CPaciente;
import framework.CDataExam;
import framework.CValidation;

/**
 * Servlet implementation class SSiguiente
 */
@WebServlet("/SSiguiente")
public class SSiguiente extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SSiguiente() {
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
		HttpSession sessiones=request.getSession(false); 
		if(sessiones!=null && sessiones.getAttribute("paciente")!=null){
			CPaciente pac=(CPaciente)sessiones.getAttribute("paciente");
			CDataExam	data=new CDataExam();
			CValidation valid=new CValidation();
			data.Connect();
			String action=valid.ValidarRequest(request.getParameter("a"));
			String codificacion=request.getCharacterEncoding();
			codificacion=(codificacion==null)?"ISO-8859-1":codificacion;
			if(action.equalsIgnoreCase("instru")){
					if(pac.getExamen_linea()<1){
						pac.setExamen_linea(1);
						data.UpdatePacienteExamen(pac);
						
					}
					response.sendRedirect("estudiante/index.jsp?portal="+pac.getExamen_linea());
			}else if(action.equalsIgnoreCase("auto")){
				if(pac.getExamen_linea()<6){
					pac.setExamen_linea(6);
					data.UpdatePacienteExamen2(pac);
					
				}
				response.sendRedirect("estudiante/index.jsp?portal="+pac.getExamen_linea());
			}else if(action.equalsIgnoreCase("multi")){
				if(pac.getExamen_linea()<5){
					pac.setExamen_linea(5);
					data.UpdatePacienteExamen2(pac);
					
				}
				response.sendRedirect("estudiante/index.jsp?portal="+pac.getExamen_linea());
			}else if(action.equalsIgnoreCase("reportauto")){
				if(pac.getExamen_linea()<8){
					pac.setExamen_linea(8);
					data.UpdatePacienteExamen(pac);
					
				}
				response.sendRedirect("estudiante/index.jsp?portal="+pac.getExamen_linea());
			}else if(action.equalsIgnoreCase("reportmulti")){
				if(pac.getExamen_linea()<7){
					pac.setExamen_linea(7);
					data.UpdatePacienteExamen(pac);
					
				}
				response.sendRedirect("estudiante/index.jsp?portal="+pac.getExamen_linea());
			}else if(action.equalsIgnoreCase("cita_multi")||action.equalsIgnoreCase("cita_auto")){
				CConfiguracion config2=data.getConfiguracion();
				int cita=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("fecha_examen") )); 
				String param="";
				if(cita<=0){
					param+="Debe ingresar una cita";
				}
				if( config2.getFecha_examen().compareTo(new java.util.Date()) <=0 ){ 
								
								String noboleta=valid.ValidarRequest(request.getParameter("boleta") );
									if(noboleta.trim().equalsIgnoreCase("")){
										param+="<br>Debe ingresar una boleta valida";
									}
														
								if(param.compareTo("")==0){
									int result=data.AsignarCita(cita, pac.getIdpaciente(), noboleta+"");
									if(result==1){
									response.sendRedirect("estudiante/index.jsp?portal="+pac.getExamen_linea());
									}else{
										String e="&e=YA NO EXISTE CUPO PARA ESA CITA&noboleta="+noboleta;
										response.sendRedirect("estudiante/index.jsp?portal="+pac.getExamen_linea()+e);
									}
								}else{
									String e="&e="+param+"&noboleta="+noboleta+"&cita="+cita;
									response.sendRedirect("estudiante/index.jsp?portal="+pac.getExamen_linea()+e);
								}
				 }else{
							 	if(param.compareTo("")==0){
									data.AsignarCita(cita, pac.getIdpaciente(),"");
									response.sendRedirect("estudiante/index.jsp?portal="+pac.getExamen_linea());
								}else{
									String e="&e="+param+"&cita="+cita;
									response.sendRedirect("estudiante/index.jsp?portal="+pac.getExamen_linea()+e);
								}
				 }
			}else{
				response.sendRedirect("estudiante/index.jsp");
			}
			data.Close();
		}
	}

}
