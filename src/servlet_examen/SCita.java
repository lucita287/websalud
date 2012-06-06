package servlet_examen;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import data.CCita;
import data.CPaciente;

import framework.CDataExam;
import framework.CValidation;

/**
 * Servlet implementation class SCita
 */
@WebServlet("/SCita")
public class SCita extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SCita() {
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
    	String codificacion=request.getCharacterEncoding();
		codificacion=(codificacion==null)?"ISO-8859-1":codificacion;
    	CValidation valid=new CValidation();
    	CDataExam dbo=new CDataExam();
		 if(dbo.Connect()){
    	String action=valid.ValidarRequest(request.getParameter("a"));
		if(action.compareTo("guardar_rango")==0){
			String result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
			int lunes=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("lunes")));
			int martes=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("martes")));
			int miercoles=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("miercoles")));
			int jueves=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("jueves")));
			int viernes=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("viernes")));
			int sabado=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("sabado")));
			int domingo=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("domingo")));
			int cupo=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("cupo")));
			
			String fecha_inicio=(valid.ValidarRequest(request.getParameter("fecha_inicio")));		
			fecha_inicio=valid.Limpiarvalor(fecha_inicio,codificacion);
			String fecha_fin=(valid.ValidarRequest(request.getParameter("fecha_fin")));		
			fecha_fin=valid.Limpiarvalor(fecha_fin,codificacion);
			String hora_inicio=(valid.ValidarRequest(request.getParameter("hora_inicio")));
			String hora_fin=(valid.ValidarRequest(request.getParameter("hora_fin")));
			hora_inicio=valid.Limpiarvalor(hora_inicio,codificacion);
			hora_fin=valid.Limpiarvalor(hora_fin,codificacion);
			int tipo_examen=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("tipo_examen")));
			int estado=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("estado")));
			String validacion=valid.ValidarSiesMayor(cupo, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe ingresar una cupo\"}");
			validacion=(validacion.compareTo("")==0)?valid.isFechaValida(fecha_inicio,  "Fecha inicio"):validacion;
			validacion=(validacion.compareTo("")==0)?valid.ValidarSiesMayor(tipo_examen, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe seleccionar un examen\"}"):validacion;
			validacion=(validacion.compareTo("")==0)?valid.isFechaValida(fecha_fin,  "Fecha fin"):validacion;
			validacion=(validacion.compareTo("")==0)?valid.validarFechaMayoraOtra(fecha_inicio,fecha_fin,"Fecha de Inicio","Fecha de Fin"):validacion;
			validacion=(validacion.compareTo("")==0)?valid.ValidarFormatoHora2(hora_inicio,"Hora de Inicio"):validacion;
			validacion=(validacion.compareTo("")==0)?valid.ValidarFormatoHora2(hora_fin,"Hora de Fin"):validacion;
			
			validacion=(validacion.compareTo("")==0)?valid.validarHoraMayoraOtra(valid.CambiarFormatohhmm2(hora_inicio),valid.CambiarFormatohhmm2(hora_fin)):validacion;
			if(validacion.compareTo("")==0){
				
				
				if(lunes==1 || martes==1||miercoles==1||jueves==1||viernes==1||sabado==1||domingo==1){
					int r=dbo.SafeCitasDetalle(valid.CambiarFormatoddmmyy(fecha_inicio),valid.CambiarFormatoddmmyy(fecha_fin), valid.CambiarFormatohhmm2(hora_inicio), valid.CambiarFormatohhmm2(hora_fin), cupo, tipo_examen,estado ,lunes,martes,miercoles,jueves,viernes,sabado,domingo);
					if(r>=1)
					result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
					else result="{\"resultado\":\"ERROR\",\"mensaje\":\" Error al guardar o no existe ningun \n dia de la semana  en el rango de fechas \"}";
				}else{
					result="{\"resultado\":\"ERROR\",\"mensaje\":\"Debe seleccionar almenos un dia \"}";
				}	
			}else{
				result=validacion;
			}
			out.println(result);
			
			
		}else if(action.compareTo("guardarespecifico")==0){
			
int cupo=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("cupo")));
String result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
			String fecha=(valid.ValidarRequest(request.getParameter("fecha")));		
			fecha=valid.Limpiarvalor(fecha,codificacion);
			String hora_inicio=(valid.ValidarRequest(request.getParameter("hora_inicio")));
			String hora_fin=(valid.ValidarRequest(request.getParameter("hora_fin")));
			hora_inicio=valid.Limpiarvalor(hora_inicio,codificacion);
			hora_fin=valid.Limpiarvalor(hora_fin,codificacion);
			int tipo_examen=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("tipo_examen")));
			int estado=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("estado")));
			String validacion=valid.ValidarSiesMayor(cupo, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe ingresar una cupo\"}");
			validacion=(validacion.compareTo("")==0)?valid.isFechaValida(fecha,  "Fecha inicio"):validacion;
			validacion=(validacion.compareTo("")==0)?valid.ValidarFormatoHora2(hora_inicio,"Hora de Inicio"):validacion;
			validacion=(validacion.compareTo("")==0)?valid.ValidarFormatoHora2(hora_fin,"Hora de Fin"):validacion;
			validacion=(validacion.compareTo("")==0)?valid.validarHoraMayoraOtra(valid.CambiarFormatohhmm2(hora_inicio),valid.CambiarFormatohhmm2(hora_fin)):validacion;
			if(validacion.compareTo("")==0){
				
					int r=dbo.SafeCita(valid.CambiarFormatoddmmyy(fecha), valid.CambiarFormatohhmm2(hora_inicio), valid.CambiarFormatohhmm2(hora_fin), cupo, tipo_examen,estado);
					if(r>=1)
					result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
					else result="{\"resultado\":\"ERROR\",\"mensaje\":\" Error al guardar  \"}";
					
			}else{
				result=validacion;
			}
			out.println(result);
			
		}else if(action.compareTo("citas_calendar")==0) {
			response.setContentType("application/json;charset=UTF-8"); 
    		Long start=valid.ConvertLong(valid.ValidarRequest(request.getParameter("start")));
    		if(start<1000000000000L){
    			start=start*1000;
    		}
    		
    		Long end=valid.ConvertLong(valid.ValidarRequest(request.getParameter("end")));
    		if(end<1000000000000L){
    			end=end*1000;
    		}
    		Date fecha_inicio=new Date();
    		fecha_inicio.setTime(start);
    		Date fecha_fin=new Date();
    		fecha_fin.setTime(end);
    		//getListaDetalleActividad
    		 ArrayList<CCita> lista=dbo.getListaCita(fecha_inicio, fecha_fin);
			 String data="[";
			 String lista_data="";
			 for(int j=0; j<lista.size();j++){ 
				 CCita da=lista.get(j);
				 lista_data+=(lista_data.compareTo("")==0)?"":",";
				// lista_data+="{\"id\":"+da.getIddetalleactividad()+", \"start\":\""+da.getFormatoFechaCalendar(da.getFecha(), da.getHorainicio())+"\", \"end\":\""+da.getFormatoFechaCalendar(da.getFecha(), da.getHorafin())+"\", \"title\":\""+da.getActividadidactividad().getTitulo()+"\"}";
				 
				 lista_data+="{\"id\":"+da.getIdcita()+", \"estado\":"+da.getEstado()+", \"tipo\":"+da.getTipo_examen()+", \"start\":"+da.getFormatoFechaCalendar(da.getFecha(), da.getHora_inicio())+", \"end\":"+da.getFormatoFechaCalendar(da.getFecha(), da.getHora_fin())+", \"title\":\""+da.getTipo_examenD()+"<br> Cupo total "+(da.getCupo()-da.getCupo_disp())+"<br>Cupo Actual "+da.getCupo_disp()+"<br>"+da.getEstadoD()+"\"}";
			 }
			 data+=lista_data+"]";
			 out.print(data);
			
		}else if(action.equalsIgnoreCase("asignar_cita")){
			int idcita=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idcita")));
			String result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
			HttpSession sessiones=request.getSession(false); 
			if(sessiones!=null){
				CPaciente pac=(CPaciente)sessiones.getAttribute("paci_consulta");
				if(pac!=null && idcita>0){
					int respuesta=dbo.AsignarCita(idcita, pac.getIdpaciente(),request.getParameter("boleta"));
					if(respuesta>0){
						result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
					}else{
						result="{\"resultado\":\"ERROR\",\"mensaje\":\"Ya tiene asignado esa fecha, o ya no existe cupo. actualize la pagina\"}";
					}
				}else{
					result="{\"resultado\":\"ERROR\",\"mensaje\":\"Debe seleccionar un paciente o cita\"}";
				}
			}else result="{\"resultado\":\"ERROR\",\"mensaje\":\"Ha finalizado la sesion\"}";
			out.print(result);
		}else if(action.equalsIgnoreCase("estu_cita")){
			int idcita=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idcita")));
			String result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
			HttpSession sessiones=request.getSession(false); 
			if(sessiones!=null){
				CPaciente pac=(CPaciente)sessiones.getAttribute("paci_consulta");
				if(pac!=null && idcita>0){
					int respuesta=dbo.UpdatePacienteCita(idcita, pac.getIdpaciente());
					if(respuesta==1){
						result="{\"resultado\":\"OK\"}";
					}else{
						result="{\"resultado\":\"ERROR\"}";
					}
				}else{
					result="{\"resultado\":\"ERROR\"}";
				}
			}else result="{\"resultado\":\"ERROR\"}";
			out.print(result);
		}else if(action.equalsIgnoreCase("estu_cita_pac")){
			int idcita=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idcita")));
			int idpaciente=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idpaciente")));
			String result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
				if(idpaciente>0 && idcita>0){
					int respuesta=dbo.UpdatePacienteCita(idcita, idpaciente);
					if(respuesta==1){
						result="{\"resultado\":\"OK\"}";
					}else{
						result="{\"resultado\":\"ERROR\"}";
					}
				
			}else result="{\"resultado\":\"ERROR\"}";
			out.print(result);
		}else if(action.equalsIgnoreCase("deleteespecifico")){
			int idcita=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idcita")));
			boolean respuesta=dbo.deleteCita(idcita);
			String result="";
			if(respuesta){
				result="{\"resultado\":\"OK\",\"mensaje\":\"Eliminado\"}";
			}else{
				result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se puede borrar, tiene citas asignadas\"}";
			}
			out.print(result);
		}else if(action.equalsIgnoreCase("estadoespecifico")){
			int idcita=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idcita")));
			CCita cita=dbo.getCita(idcita);
			boolean respuesta=dbo.update_cita(cita);
			String result="";
			if(respuesta){
				result="{\"resultado\":\"OK\",\"mensaje\":\"Actualizado\"}";
			}else{
				result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se ha actualizado\"}";
			}
			out.print(result);
		}else if(action.compareTo("updateespecifico")==0){
			int idcita=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idcita")));
			int cupo=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("cupo")));
			String result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";	
			String hora_inicio=(valid.ValidarRequest(request.getParameter("hora_inicio")));
			String hora_fin=(valid.ValidarRequest(request.getParameter("hora_fin")));
			hora_inicio=valid.Limpiarvalor(hora_inicio,codificacion);
			hora_fin=valid.Limpiarvalor(hora_fin,codificacion);
			int tipo_examen=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("tipo_examen")));
			int estado=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("estado")));
			String validacion=valid.ValidarSiesMayor(cupo, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe ingresar una cupo\"}");
			validacion=(validacion.compareTo("")==0)?valid.ValidarSiesMayor(idcita, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe seleccionar una cita\"}"):validacion;
			validacion=(validacion.compareTo("")==0)?valid.ValidarFormatoHora2(hora_inicio,"Hora de Inicio"):validacion;
			validacion=(validacion.compareTo("")==0)?valid.ValidarFormatoHora2(hora_fin,"Hora de Fin"):validacion;
			validacion=(validacion.compareTo("")==0)?valid.validarHoraMayoraOtra(valid.CambiarFormatohhmm2(hora_inicio),valid.CambiarFormatohhmm2(hora_fin)):validacion;
			if(validacion.compareTo("")==0){
				
					boolean r=dbo.UpdateCita(idcita, valid.CambiarFormatohhmm2(hora_inicio), valid.CambiarFormatohhmm2(hora_fin), cupo, tipo_examen,estado);
					if(r) result="{\"resultado\":\"OK\",\"mensaje\":\"Actualizado\"}";
					else result="{\"resultado\":\"ERROR\",\"mensaje\":\" Error al guardar  \"}";
					
			}else{
				result=validacion;
			}
			out.println(result);
			
		}else if(action.compareTo("updatecita_paciente")==0){
			int idcita=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idcita")));
			int idpaciente=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idpaciente")));
			String result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
			String boleta=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("boleta")), codificacion);
				if(idpaciente>0 && idcita>0){
					boolean respuesta=dbo.UpdatePacienteCita(idcita, idpaciente,boleta);
					if(respuesta){
						result="{\"resultado\":\"OK\"}";
					}else{
						result="{\"resultado\":\"ERROR\"}";
					}
				
			}else result="{\"resultado\":\"ERROR\"}";
			out.print(result);
		}
		dbo.Close();
		 }
	}

}
