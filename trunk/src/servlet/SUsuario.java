package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import data.CArea;
import data.CPermiso;
import data.CUsuario;

import framework.CDataBase;
import framework.CValidation;

/**
 * Servlet implementation class SUsuario
 */
@WebServlet("/SUsuario")
public class SUsuario extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SUsuario() {
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
		String action=request.getParameter("a");
		CValidation valid=new CValidation();
		CDataBase dbo=new CDataBase();
		dbo.Connect();
		HttpSession session = request.getSession(false);
		if(session!=null && session.getAttribute("user")!=null){
		if(action.equalsIgnoreCase("show")){
			 int iduser=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("iduser")));
			 CUsuario temp_user=dbo.getUsuarioEspecifico( iduser);
			 String result="";
			 if(temp_user!=null){
				 
				 String data="";
				 ArrayList<CPermiso> list=dbo.getListaPermiso(iduser);
				 for(int j=0; j<list.size();j++){ 
					 CPermiso perm=list.get(j);
					 data+=(data.equalsIgnoreCase(""))?"":",";	
					data+="{idpermiso:"+perm.getIdpermiso()+"}";
				 }
				 data="permisos:["+data+"]";
				 result= "{nombre:\""+temp_user.getnombre()+" \",apellido:\""+temp_user.getapellido()+"\",nick:\""+temp_user.getnick()+"\",telefono:\""+
						 temp_user.gettelefono()+"\",email:\""+temp_user.getemail()+"\","
					 +"telefono:\""+temp_user.gettelefono()+"\",idarea:\""+temp_user.getAreaidarea().getidarea()+"\",estado:\""+temp_user.getEstado()+"\","+data+"}";
				 
			 }
			 out.println(result);
		}else if(action.equalsIgnoreCase("guardaredit")){
			
			String result="";
			int iduser=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idusuario")));
			int estado=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("estado")));
			String nombre=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("name")));
			String apellido=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("apellido")));
			String nick=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("nick")));
			nick=nick.toLowerCase();
			String phone=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("phone")));
			String email=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("email")));
			int idarea=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idarea")));
			String pass=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("password")));
			String pass2=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("password2")));
			String validacion=valid.ValidarCampoVacio(nombre, "Nombre");
			CUsuario usuario=dbo.getUsuario(session.getAttribute("user").toString()); 
			validacion=(validacion.compareTo("")==0)?valid.ValidarSiesMayor(iduser, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar un item\"}"):validacion;
			validacion=(validacion.compareTo("")==0)?valid.ValidarSiesMayor(usuario.getidusuario(), 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe iniciar Session\"}"):validacion;
			validacion=(validacion.compareTo("")==0)?valid.ValidarCampoVacio(apellido, "Apellido"):validacion;
			validacion=(validacion.compareTo("")==0)?valid.ValidarCampoVacio(nick, "Nick"):validacion;
			validacion=(validacion.compareTo("")==0)?valid.ValidarNoLongintud(nick,4 ,"Nick"):validacion;
			
			if(email.compareTo("")!=0)
				validacion=(validacion.compareTo("")==0)?valid.ValidarEmail(email):validacion;
			if(!pass.isEmpty())
				validacion=	(validacion.compareTo("")==0)?valid.ValidarPassword(pass, pass2):validacion;
				validacion=(validacion.compareTo("")==0)?valid.ValidarNick(nick, iduser):validacion;
			if(validacion.compareTo("")==0){
				CUsuario user=dbo.getUsuarioEspecifico(iduser);
				CArea area=dbo.getCAreaEspecifico(idarea);
				user.setAreaidarea(area);
				user.setNombre(nombre);
				user.setApellido(apellido);
				user.setEstado(estado);
				user.setEmail(email);
				user.setPassword(pass);
				user.setNick(nick);
				user.setTelefono(phone);
				boolean b=dbo.UpdateUsuario(user, usuario.getidusuario());
				if(b) result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
				else result="{\"resultado\":\"ERROR\",\"mensaje\":\"Error al guardar\"}";
			}else{
				result=validacion;
			}
			out.println(result);
		}else if(action.equalsIgnoreCase("newedit")){
			String result="";
			int estado=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("estado")));
			String nombre=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("name")));
			String apellido=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("apellido")));
			String nick=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("nick")));
			nick=nick.toLowerCase();
			String phone=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("phone")));
			String email=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("email")));
			int idarea=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idarea")));
			String pass=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("password")));
			String pass2=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("password2")));
			String validacion=valid.ValidarCampoVacio(nombre, "Nombre");
			CUsuario usuario=dbo.getUsuario(session.getAttribute("user").toString()); 
			validacion=(validacion.compareTo("")==0)?valid.ValidarSiesMayor(usuario.getidusuario(), 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe iniciar Session\"}"):validacion;
			validacion=(validacion.compareTo("")==0)?valid.ValidarCampoVacio(apellido, "Apellido"):validacion;
			validacion=(validacion.compareTo("")==0)?valid.ValidarCampoVacio(nick, "Nick"):validacion;
			validacion=(validacion.compareTo("")==0)?valid.ValidarNoLongintud(nick,4 ,"Nick"):validacion;
			
			if(email.compareTo("")!=0)
				validacion=(validacion.compareTo("")==0)?valid.ValidarEmail(email):validacion;
				validacion=	(validacion.compareTo("")==0)?valid.ValidarPassword(pass, pass2):validacion;
				validacion=(validacion.compareTo("")==0)?valid.ValidarNick(nick):validacion;
				if(validacion.compareTo("")==0){
					CArea area=dbo.getCAreaEspecifico(idarea);
					CUsuario user=new CUsuario(0,nombre,apellido,nick,pass,phone,email,estado,area);
					boolean b=dbo.SafeUser(user, usuario.getidusuario());
					if(b) result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
					else result="{\"resultado\":\"ERROR\",\"mensaje\":\"Error al guardar\"}";
					
				}else{
					result=validacion;
				}
			out.println(result);	
		}else if(action.equalsIgnoreCase("privileges")){
			String result="";
			int iduser=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("iduser")));
			String validacion=valid.ValidarSiesMayor(iduser, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe seleccionar un usuario\"}");
			ArrayList<Integer> lista=valid.ValidarListaNumeros(valid.ValidarRequest(request.getParameter("permisos")));
			if(validacion.compareTo("")==0){
				 boolean b=dbo.safePermisoUsuario(iduser,lista);
				 if(b) result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
					else result="{\"resultado\":\"ERROR\",\"mensaje\":\"Error al guardar\"}";
			}else{
				result=validacion;
			}
			out.println(result);
		}
		
		}
		
		dbo.Close();
	}

}
