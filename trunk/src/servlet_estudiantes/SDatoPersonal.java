package servlet_estudiantes;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import data.CPaciente;
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
					String mensaje=valid.ValidarECombo(civil_personal,"Estado Civil");
					mensaje+=valid.ValidarECombo(emer_idpar,"parentesco en caso de emergencia");
					mensaje+=valid.ValidarECombo(tsange,"tipo de sangre");
					mensaje+=valid.ValidarENombre(crecio_en, 100, "Crecio en");
					mensaje+=valid.ValidarENombreV(tit_secun, 150, "Titulo de Secundaria");
					mensaje+=valid.ValidarENombre(emer_tel, 50, "Telefono de emergencia");
					mensaje+=valid.ValidarENombre(emer_movil, 50, "Telefono movil");
					mensaje+=valid.ValidarENombre(nombre_emer, 50, "Nombre de emergencia");
					if(mensaje.isEmpty()){
						pac.setEstado_civilidestado_civil(civil_personal);
						pac.setCrecio_en(crecio_en);
						pac.setEmer_nombre(nombre_emer);
						pac.setEmer_movil(emer_movil);
						pac.setEmer_telefono(emer_tel);
						pac.setTitulo_secundaria(tit_secun);
						pac.setIdtipo_sangre(tsange);
						pac.setIdemer_parentesco(emer_idpar);
						boolean b=data.UpdatePaciente1(pac);
						if(b){
							response.sendRedirect("estudiante/index.jsp?portal=5");
						}else{
							response.sendRedirect("estudiante/index.jsp?e=Error al guardar&portal=1");
						}
					}else{
						response.sendRedirect("estudiante/index.jsp?e="+mensaje+"&portal=1");
					}
			}
			
			data.Close();
		}
	}

}
