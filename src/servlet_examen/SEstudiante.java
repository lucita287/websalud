package servlet_examen;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;

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
import framework.CWebService;

/**
 * Servlet implementation class SEstudiante
 */
@WebServlet("/SEstudiante")
public class SEstudiante extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SEstudiante() {
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
		CDataExam dbo=new CDataExam();
		String codificacion=request.getCharacterEncoding();
		codificacion=(codificacion==null)?"ISO-8859-1":codificacion;
		dbo.Connect();
		String user=valid.ValidarRequest(request.getParameter("user")).trim().toLowerCase(); 
		String action=valid.ValidarRequest(request.getParameter("a"));
		HttpSession session = request.getSession(true);
		CConfiguracion config=dbo.getConfiguracion();
		if(action.equalsIgnoreCase("estudiante_ver")){
				
			
			if(request.getParameter("enviar").toString().compareTo("Buscar")==0){
				if(!user.isEmpty()){	 
					CPaciente pac= dbo.getEstudianteEspecifica(user);
					int idpaciente=0;
					if(pac==null){
					 CWebService servicio=new CWebService(config.getCiclo(),config.getDependencia(),config.getNo_personal(),config.getPassword());
					 pac=servicio.DatosGenerales(user, dbo);//.VerificarEstudiante(user, dbo);
							 if(pac!=null){
								 dbo.SafePaciente(pac);
								 idpaciente=dbo.getIdPaciente(pac.getUsuario());
								 pac.setIdpaciente(idpaciente);
								 session.setAttribute("resultado","1");
								 session.setAttribute("paci_consulta",pac);
								 
							 }else{
								 session.setAttribute("resultado","0");
								 session.setAttribute("paci_consulta",null);
								 
							 }
							 
					}else{
						idpaciente=pac.getIdpaciente();
						session.setAttribute("paci_consulta",pac);
						session.setAttribute("resultado","1");
					
					}
				 }else {
					 session.setAttribute("resultado","0");
					 session.setAttribute("paci_consulta",null);
					 
				 }
				response.sendRedirect("secretaria/index.jsp?portal=3");
			}else{
				CPaciente pac=(CPaciente)session.getAttribute("paci_consulta");
				if(pac!=null){
					String apellido=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("apellido")), codificacion);
					String nombre=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("nombre")), codificacion);
					String celular=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("celular")), codificacion);
					String correo=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("correo")), codificacion);
					String fecha=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("fecha")), codificacion);
					String direccion=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("direccion")), codificacion);
					int sexo=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("sexo")));
					String telefono=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("telefono")), codificacion);
					int unidad=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("unidad")));
					
					String error="";
					if(apellido.compareTo("")==0){
						error+="<br>El apellido no puede ir vacio";
					}else{
						pac.setApellido(apellido);
					}
					
					if(nombre.compareTo("")==0){
						error+="<br>El nombre no puede ir vacio";
					}else{
						pac.setNombre(nombre);
					}
					if(valid.isFechaValida(fecha,  "Fecha Nacimiento").compareTo("")!=0){
						error+="<br>No es fecha valida de nacimiento";
					}else{
						pac.setFecha_nacimiento(valid.CambiarFormatoddmmyy(fecha));
					}
					
					celular=(celular.length()>=50)?celular.substring(0,50):celular;
					pac.setMovil(celular);
					correo=(correo.length()>=80)?correo.substring(0,80):correo;
					direccion=(direccion.length()>=300)?direccion.substring(0,300):direccion;
					pac.setDireccion(direccion);
					pac.setEmail(correo);
					
					pac.setSexo(sexo);
					telefono=(telefono.length()>=80)?telefono.substring(0,50):telefono;
					pac.setTelefono(telefono);
					pac.setIdunidad_academica(unidad);
					
					if(error.compareTo("")==0){
						boolean b=dbo.UpdatePaciente2(pac);
						if(b) response.sendRedirect("secretaria/index.jsp?portal=3&e=Almacenado con Exito");
						else response.sendRedirect("secretaria/index.jsp?portal=3&e=Error al guardar");
					}else{
						response.sendRedirect("secretaria/index.jsp?portal=3&e="+error);
					}
					
				}else response.sendRedirect("secretaria/index.jsp?portal=3");
			}
		}else if(action.equalsIgnoreCase("estudiante_consulta")){
			String carne=valid.ValidarRequest(request.getParameter("carne"));
			String result="ERROR<br/>Debe ingrese el carne";
			CPaciente pac=null;
			if(!carne.isEmpty()){
				
				pac= dbo.getEstudianteEspecifica(carne);
				if(pac==null){
					CWebService servicio=new CWebService(config.getCiclo(),config.getDependencia(),config.getNo_personal(),config.getPassword());
					 pac=servicio.DatosGenerales(carne, dbo);//VerificarEstudiante(carne, dbo);
							 if(pac!=null){
								 dbo.SafePaciente(pac);
								 int idpaciente=dbo.getIdPaciente(pac.getUsuario());
								 pac.setIdpaciente(idpaciente);
								 
							 }
				}
				
					
			}
			if(pac!=null){
				session.setAttribute("paci_consulta",pac);
				result="<div  style='border: 1px solid blue'><table>";
				result+="<tr><td><b>Nombre</b></td><td>"+pac.getNombre()+"</td><td><b>Apellido</b></td><td>"+pac.getApellido()+"</td></tr>";
				result+="<tr><td><b>Telefono</b></td><td>"+pac.getTelefono()+"</td><td><b>Movil</b></td><td>"+pac.getMovil()+"</td></tr>";
				result+="<tr><td><b>Email</b></td><td>"+pac.getEmail()+"</td><td><b>Facultad</b></td><td>"+dbo.getUnidadAcademica(pac.getIdunidad_academica())+"</td></tr>";
				result+="</table></div>";
			}else{
				result="ERROR CARNE NO ENCONTRADO";
				session.setAttribute("paci_consulta",null);
			}
			
			out.println(result);
			
		}else if(action.equalsIgnoreCase("buscar_nombre")){
			String nombre=valid.ValidarRequest(request.getParameter("nombre"));
			String apellido=valid.ValidarRequest(request.getParameter("apellido"));
			ArrayList<CPaciente> listpaciente=dbo.getListaPacientes(nombre, apellido);
			String result="";
			Iterator<CPaciente> it=listpaciente.iterator();
			while(it.hasNext()){
				CPaciente pac=it.next();
				result+="<div  style='border: 1px solid blue'>";
				result+="<table  >";
				result+="<tr   ><td rowspan='4'><a onclick='Seleccionar("+pac.getIdpaciente()+")'><img src='../images/on.png' /></a></td></tr>";
				result+="<tr><td><b>Carne</b></td><td>"+pac.getCarne()+"</td><td><b>Apellido</b></td><td>"+pac.getNombre()+" "+pac.getApellido()+"</td></tr>";
				result+="<tr><td><b>Telefono</b></td><td>"+pac.getTelefono()+"</td><td><b>Movil</b></td><td>"+pac.getMovil()+"</td></tr>";
				result+="<tr><td><b>Email</b></td><td>"+pac.getEmail()+"</td><td><b>Facultad</b></td><td>"+dbo.getUnidadAcademica(pac.getIdunidad_academica())+"</td></tr>";
				result+="</table>";
				result+="</div>";
			}
			out.println(result);
		}else if(action.equalsIgnoreCase("seleccionar_estudiante")){
			int idpaciente=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idpaciente")));
			String result="";
			if(idpaciente>0){
				CPaciente pac=dbo.getPacienteEspecifica(idpaciente);
				if(pac!=null){
					idpaciente=pac.getIdpaciente();
					session.setAttribute("paci_consulta",pac);
					session.setAttribute("resultado","1");
					result="<div  style='border: 1px solid blue'><table>";
					result+="<tr><td><b>Nombre</b></td><td>"+pac.getNombre()+"</td><td><b>Apellido</b></td><td>"+pac.getApellido()+"</td></tr>";
					result+="<tr><td><b>Telefono</b></td><td>"+pac.getTelefono()+"</td><td><b>Movil</b></td><td>"+pac.getMovil()+"</td></tr>";
					result+="<tr><td><b>Email</b></td><td>"+pac.getEmail()+"</td><td><b>Facultad</b></td><td>"+dbo.getUnidadAcademica(pac.getIdunidad_academica())+"</td></tr>";
					result+="</table></div>";
					
				}else{
					session.setAttribute("paci_consulta",null);
				}
				
			}else{
				session.setAttribute("paci_consulta",null);
			}
			out.println(result);
		}else if(action.equalsIgnoreCase("crear_estudiante")){
			int carne=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("carne")));
			String nombre=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("nombre")),codificacion).toUpperCase();
			String apellido=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("apellido")),codificacion).toUpperCase();
			String fecha=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("fecha")),codificacion);
			int unidad_academica=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("unidad")));
			int sexo=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("sexo")));
			String validacion=valid.isFechaValida(fecha,  "Fecha Nacimiento");
			validacion=(validacion.compareTo("")==0)?valid.ValidarCampoVacio(nombre, "Nombre"):validacion;
			validacion=(validacion.compareTo("")==0)?valid.ValidarCampoVacio(apellido, "Apellido"):validacion;
			String result="{\"resultado\":\"OK\",\"mensaje\":\"ALMACENADO\"}";
			if(validacion.compareTo("")==0){
				if(carne>0&&unidad_academica>0){
					CPaciente pac=new CPaciente(0,nombre, valid.CambiarFormatoddmmyy(fecha),
							carne, "", "", "",sexo, "",carne+"",apellido,0,0,
							0, 0, unidad_academica);
					Boolean b=dbo.SafePaciente(pac);
						if(b){
							int idpaciente=dbo.getIdPaciente(pac.getUsuario());
							pac.setIdpaciente(idpaciente);
							result="{\"resultado\":\"OK\",\"mensaje\":\"ALMACENADO\"}";
							session.setAttribute("paci_consulta",pac);
							session.setAttribute("resultado","1");
						}else {
							result="{\"resultado\":\"ERROR\",\"mensaje\":\"Estudiante ya existe\"}";
						}
				}else {
					java.util.GregorianCalendar gre=new java.util.GregorianCalendar();
					CPaciente pac=new CPaciente(0,nombre, valid.CambiarFormatoddmmyy(fecha),
							0, "", "", "",sexo, "","e"+gre.getTimeInMillis(),apellido,0,0,
							0, 0, 0);
					Boolean b=dbo.SafePaciente(pac);
						if(b){
							int idpaciente=dbo.getIdPaciente(pac.getUsuario());
							pac.setIdpaciente(idpaciente);
							result="{\"resultado\":\"OK\",\"mensaje\":\"ALMACENADO\"}";
							session.setAttribute("paci_consulta",pac);
							session.setAttribute("resultado","1");
						}else {
							result="{\"resultado\":\"ERROR\",\"mensaje\":\"Estudiante ya existe\"}";
						}
				}
			}else{
				result=validacion;
			}
			out.print(result);
		}else if(action.equalsIgnoreCase("limpiar")){
			session.setAttribute("paci_consulta",null);
			session.setAttribute("resultado","1");
		}else if(action.equalsIgnoreCase("estudiante_info")){
			
			if(!user.isEmpty()){	 
				CPaciente pac= dbo.getEstudianteEspecifica(user);
				int idpaciente=0;
				if(pac==null){
				 CWebService servicio=new CWebService(config.getCiclo(),config.getDependencia(),config.getNo_personal(),config.getPassword());
				 pac=servicio.DatosGenerales(user, dbo);
						 if(pac!=null){
							 dbo.SafePaciente(pac);
							 idpaciente=dbo.getIdPaciente(pac.getUsuario());
							 pac.setIdpaciente(idpaciente);
							 session.setAttribute("resultado","1");
							 session.setAttribute("paci_consulta",pac);
							 
						 }else{
							 session.setAttribute("resultado","0");
							 session.setAttribute("paci_consulta",null);
							 
						 }
						 
				}else{
					idpaciente=pac.getIdpaciente();
					session.setAttribute("paci_consulta",pac);
					session.setAttribute("resultado","1");
				
				}
			 }else {
				 session.setAttribute("resultado","0");
				 session.setAttribute("paci_consulta",null);
				 
			 }
			response.sendRedirect("admin/index.jsp?portal=20");
			
		}
		dbo.Close();
	}

}
