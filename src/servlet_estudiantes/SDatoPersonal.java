package servlet_estudiantes;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import data.CGrupo_Familiar;
import data.CPaciente;
import data.CPaciente_Menu_Categoria;
import framework.CDataExam;
import framework.CValidationMensaje;

/**
 * Servlet implementation class SDatoPersonal
 */
@WebServlet("/SDatoPersonal")
public class SDatoPersonal extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SDatoPersonal() {
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
			data.Connect();
			CValidationMensaje valid=new CValidationMensaje();
			Integer idestatus=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idestatus")));
			String action=valid.ValidarRequest(request.getParameter("a"));
			String codificacion=request.getCharacterEncoding();
			codificacion=(codificacion==null)?"ISO-8859-1":codificacion;
			
			if(idestatus==1){
					int civil_personal=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("civil_personal")));
					String crecio_en=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("crecio_en_personal")), codificacion);
					String nombre_emer=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("emer_nombre_personal")), codificacion);		
					int emer_idpar=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("emer_par_personal")));
					String emer_movil=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("movil_personal")), codificacion);
					String emer_tel=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("tel_personal")), codificacion);
					String tit_secun=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("tit_secun_personal")), codificacion);
					int tsange=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("tsangre_personal")));
					String mensaje="";
					
					String mensaje2=valid.ValidarECombo(civil_personal,"Estado Civil");
					if(mensaje2.compareTo("")==0) pac.setEstado_civilidestado_civil(civil_personal);
					mensaje+=mensaje2;
					
					mensaje2=valid.ValidarECombo(emer_idpar,"parentesco en caso de emergencia");
					if(mensaje2.compareTo("")==0) pac.setIdemer_parentesco(emer_idpar);
					mensaje+=mensaje2;
					
					mensaje2=valid.ValidarECombo(tsange,"tipo de sangre");
					if(mensaje2.compareTo("")==0) pac.setIdtipo_sangre(tsange);
					mensaje+=mensaje2;
					
					mensaje2=valid.ValidarENombre(crecio_en, 100, "Crecio en");
					if(mensaje2.compareTo("")==0) pac.setCrecio_en(crecio_en);
					mensaje+=mensaje2;
					
					mensaje2=valid.ValidarENombreV2(tit_secun, 150, "Titulo de Secundaria");
					if(mensaje2.compareTo("")==0) pac.setTitulo_secundaria(tit_secun);
					mensaje+=mensaje2;
					
					mensaje2=valid.ValidarENombre(emer_tel, 50, "Telefono de emergencia");
					if(mensaje2.compareTo("")==0) pac.setEmer_telefono(emer_tel);
					mensaje+=mensaje2;
					
					mensaje2=valid.ValidarENombre(emer_movil, 50, "Telefono movil");
					if(mensaje2.compareTo("")==0) pac.setEmer_movil(emer_movil);
					mensaje+=mensaje2;
					
					mensaje2=valid.ValidarENombre(nombre_emer, 50, "Nombre de emergencia");
					if(mensaje2.compareTo("")==0) pac.setEmer_nombre(nombre_emer);
					mensaje+=mensaje2;
					
					if(mensaje.isEmpty()){
						boolean b=data.UpdatePaciente1(pac);	
						if(b){
							response.sendRedirect("estudiante/index.jsp?portal=5");
						}else{
							response.sendRedirect("estudiante/index.jsp?e=Error al guardar&portal=1");
						}
					}else{
						response.sendRedirect("estudiante/index.jsp?e="+mensaje+"&portal=1");
					}
			}else if(action.equalsIgnoreCase("siguiente")){
				
				int area =valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idarea")));
				String descripcion=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("descripcion")), codificacion);
				if(descripcion.length()>=300)
				descripcion=descripcion.substring(0,300);
				data.SafeAmbienteFamiliar(pac.getIdpaciente(), descripcion);
				data.SafeMenu_Paciente(new CPaciente_Menu_Categoria(pac.getIdpaciente(),1,
						0, 1));
				int next=data.getProximo(area,0,1,1);
				response.sendRedirect("estudiante/index.jsp?portal=10&idmenu="+next+"&auto=0&multi=1");
				
				
			}else if(action.equalsIgnoreCase("Guardar")){
				
				String descripcion=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("descripcion")), codificacion);
				if(descripcion.length()>=300)
				descripcion=descripcion.substring(0,300);
				data.SafeAmbienteFamiliar(pac.getIdpaciente(), descripcion);
				
				int idparen=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("par_personal")));
				int edad=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("edad")));
				int genero=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("genero")));
				int salud=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("salud")));
				String trabajo=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("trabajo")), codificacion);
				Double mensual=valid.ConvertDouble(valid.ValidarRequest(request.getParameter("mensual")));
				String lugar=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("lugar")), codificacion);
				String error="";
				if(idparen==0) error+="Debe seleccionar parentesco<br/>";
				if(edad==0) error+="Debe ingresar una edad valida<br/>";
				if(salud==0) error+="Debe ingresar su estado de salud<br/>";
				if(trabajo.length()>30) error+="La longitud maxima del trabajo es 30<br/>";
				if(lugar.length()>50) error+="La longitud maxima del lugar es 50<br/>";
				
				if(error.compareTo("")==0){
					CGrupo_Familiar grupo=new CGrupo_Familiar(pac.getIdpaciente(),0,
							idparen, genero,trabajo, mensual,
							lugar,salud,edad);
					boolean b=data.SafeGrupoFamiliar(grupo);
					if(b){
						response.sendRedirect("estudiante/index.jsp?portal=11");
					}else{
						response.sendRedirect("estudiante/index.jsp?e=Error al guardar&portal=11");
					}
				}else{
					String param="&e="+error+"&idparen="+idparen+"&edad="+edad+"&genero="+genero+"&salud="+salud+"&trabajo="+trabajo+"&mensual="+mensual+"&lugar="+lugar;
					response.sendRedirect("estudiante/index.jsp?portal=11"+param);
				}
			}else if(idestatus==4){
				int id=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("id")));
				boolean b=data.deleteGrupoFamiliar(id,pac.getIdpaciente());
				if(b){
					response.sendRedirect("estudiante/index.jsp?portal=11");
				}else{
					response.sendRedirect("estudiante/index.jsp?e=Error al eliminar&portal=11");
				}
			}else if(action.equalsIgnoreCase("Regresar al menu")){
				String descripcion=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("descripcion")), codificacion);
				if(descripcion.length()>=300)
				descripcion=descripcion.substring(0,300);
				data.SafeAmbienteFamiliar(pac.getIdpaciente(), descripcion);
				data.SafeMenu_Paciente(new CPaciente_Menu_Categoria(pac.getIdpaciente(),1,
						0, 1));
				response.sendRedirect("estudiante/index.jsp?portal=5");
				
			}else{
				response.sendRedirect("index.jsp");
			}
			
			data.Close();
		}else{
			response.sendRedirect("index.jsp");
		}
	}

}
