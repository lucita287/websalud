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
import data.CUsuarioPermiso;

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
		CValidation valid=new CValidation();
		String action=valid.ValidarRequest(request.getParameter("a"));
		
		CDataBase dbo=new CDataBase();
		dbo.Connect();
		if(action.equalsIgnoreCase("user_disponibilidad")){
			String result="{\"mensaje\":\"Disponible\"}";
			out.println(result);
		}
		HttpSession session = request.getSession(false);
		if(session!=null &&  session.getAttribute("user_permiso")!=null){
			CUsuarioPermiso user_permiso=(CUsuarioPermiso)session.getAttribute("user_permiso");
			
							if(action.equalsIgnoreCase("guardar_perfil")){
								String result="";
								CUsuario usuario_login=user_permiso.getIdusuario();
								String nombre=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("nombre")));
								String apellido=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("apellido")));
								String telefono=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("telefono")));
								String email=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("email")));
								String no_personal=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("no_personal")));
								String ant_pass=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("ant_pass")));
								String new_pass=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("new_pass")));
								String conf_pass=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("conf_pass")));
								String validacion=valid.ValidarCampoVacio(nombre, "Nombre");
								validacion=(validacion.compareTo("")==0)?valid.ValidarCampoVacio(apellido, "Apellido"):validacion;
								validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(nombre, 150, "Nombre"):validacion;
								validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(apellido, 150, "Apellido"):validacion;
								validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(email, 100, "Correo Electronico"):validacion;
								validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(new_pass, 100, "Password"):validacion;
								validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(no_personal, 20, "No de Personal"):validacion;
								validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(telefono, 50, "Telefono"):validacion;
								if(email.compareTo("")!=0) validacion=(validacion.compareTo("")==0)?valid.ValidarEmail(email):validacion;
								if(!new_pass.isEmpty()||!ant_pass.isEmpty() ||!conf_pass.isEmpty()){
									CUsuario user=dbo.getUsuario(usuario_login.getnick());
									validacion=	(validacion.compareTo("")==0)?valid.ValidarPasswordAnt(ant_pass,user.getpassword()):validacion;
									validacion=	(validacion.compareTo("")==0)?valid.ValidarPassword(new_pass,conf_pass):validacion;	
								}
								if(validacion.compareTo("")==0){
									usuario_login.setNombre(nombre);
									usuario_login.setApellido(apellido);
									usuario_login.setEmail(email);
									usuario_login.setNo_personal(no_personal);
									usuario_login.setPassword(new_pass);
									usuario_login.setTelefono(telefono);
									boolean b=dbo.UpdateUsuario(usuario_login);
									if(b) result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
									else result="{\"resultado\":\"ERROR\",\"mensaje\":\"Error al guardar\"}";
								}else{
									result=validacion;
								}
								out.println(result);
							}else
							//MOSTRAR USUARIO O PERMISO
							if(action.equalsIgnoreCase("show")&& (user_permiso.getIdpermiso().indexOf(233)>-1  || user_permiso.getIdpermiso().indexOf(235)>-1 || user_permiso.getIdusuario().getidusuario()==1)){
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
									 String area="";
									 ArrayList<Integer> list_area=dbo.getAreaListaInt(iduser);
									 for(int j=0; j<list_area.size();j++){ 
										 int idarea=list_area.get(j);
										 area+=(area.equalsIgnoreCase(""))?"":",";	
										 area+="{idarea:"+idarea+"}";
									 }
									 area="areas:["+area+"]";
									 
									 result= "{nombre:\""+temp_user.getnombre()+" \",apellido:\""+temp_user.getapellido()+"\",nick:\""+temp_user.getnick()+"\",telefono:\""+
											 temp_user.gettelefono()+"\",email:\""+temp_user.getemail()+"\","
										 +"telefono:\""+temp_user.gettelefono()+"\",no_personal:\""+temp_user.getNo_personal()+"\",estado:\""+temp_user.getEstado()+"\","+data+","+area+"}";
									 
								 }
								 out.println(result);
							//CREAR USUARIO	 
							}else if(action.equalsIgnoreCase("guardaredit") && (user_permiso.getIdpermiso().indexOf(234)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
								
								String result="";
								int iduser=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idusuario")));
								int estado=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("estado")));
								String nombre=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("name")));
								String apellido=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("apellido")));
								String nick=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("nick")));
								nick=nick.toLowerCase();
								String phone=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("phone")));
								String email=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("email")));
								String pass=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("password")));
								String pass2=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("password2")));
								String no_personal=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("no_personal")));
								
								String validacion=valid.ValidarCampoVacio(nombre, "Nombre");
								validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(nombre, 150, "Nombre"):validacion;
								validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(apellido, 150, "Apellido"):validacion;
								CUsuario usuario=dbo.getUsuario(session.getAttribute("user").toString()); 
								validacion=(validacion.compareTo("")==0)?valid.ValidarSiesMayor(iduser, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar un item\"}"):validacion;
								validacion=(validacion.compareTo("")==0)?valid.ValidarSiesMayor(usuario.getidusuario(), 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe iniciar Session\"}"):validacion;
								validacion=(validacion.compareTo("")==0)?valid.ValidarCampoVacio(apellido, "Apellido"):validacion;
								validacion=(validacion.compareTo("")==0)?valid.ValidarCampoVacio(nick, "Usuario"):validacion;
								validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(nick, 20, "Usuario"):validacion;
								validacion=(validacion.compareTo("")==0)?valid.ValidarNoLongintud(nick,4 ,"Usuario"):validacion;
								validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(no_personal, 20, "No de Personal"):validacion;
								validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(email, 100, "Correo Electronico"):validacion;
								validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(pass, 100, "Password"):validacion;
								validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(phone, 50, "Telefono"):validacion;
								if(email.compareTo("")!=0)
									validacion=(validacion.compareTo("")==0)?valid.ValidarEmail(email):validacion;
								if(!pass.isEmpty())
									validacion=	(validacion.compareTo("")==0)?valid.ValidarPassword(pass, pass2):validacion;
									validacion=(validacion.compareTo("")==0)?valid.ValidarNick(nick, iduser):validacion;
									
								if(validacion.compareTo("")==0){
									CUsuario user=dbo.getUsuarioEspecifico(iduser);
									user.setNo_personal(no_personal);
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
							//CREAR USUARIO	
							}else if(action.equalsIgnoreCase("newedit")&& (user_permiso.getIdpermiso().indexOf(234)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
								String result="";
								int estado=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("estado")));
								String nombre=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("name")));
								String apellido=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("apellido")));
								String nick=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("nick")));
								nick=nick.toLowerCase();
								String phone=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("phone")));
								String email=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("email")));
								String pass=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("password")));
								String pass2=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("password2")));
								String no_personal=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("no_personal")));
								
								String validacion=valid.ValidarCampoVacio(nombre, "Nombre");
								CUsuario usuario=dbo.getUsuario(session.getAttribute("user").toString()); 
								validacion=(validacion.compareTo("")==0)?valid.ValidarSiesMayor(usuario.getidusuario(), 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe iniciar Session\"}"):validacion;
								validacion=(validacion.compareTo("")==0)?valid.ValidarCampoVacio(apellido, "Apellido"):validacion;
								validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(nombre, 150, "Nombre"):validacion;
								validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(apellido, 150, "Apellido"):validacion;
								validacion=(validacion.compareTo("")==0)?valid.ValidarCampoVacio(nick, "Usuario"):validacion;
								validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(nick, 20, "Usuario"):validacion;
								validacion=(validacion.compareTo("")==0)?valid.ValidarNoLongintud(nick,4 ,"Usuario"):validacion;
								validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(no_personal, 20, "No de Personal"):validacion;
								validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(email, 100, "Correo Electronico"):validacion;
								validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(pass, 100, "Password"):validacion;
								
								if(email.compareTo("")!=0)
									validacion=(validacion.compareTo("")==0)?valid.ValidarEmail(email):validacion;
									validacion=	(validacion.compareTo("")==0)?valid.ValidarPassword(pass, pass2):validacion;
									validacion=(validacion.compareTo("")==0)?valid.ValidarNick(nick):validacion;
									if(validacion.compareTo("")==0){
										CUsuario user=new CUsuario(0,nombre,apellido,nick,pass,phone,email,estado,no_personal);
										boolean b=dbo.SafeUser(user, usuario.getidusuario());
										if(b) result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
										else result="{\"resultado\":\"ERROR\",\"mensaje\":\"Error al guardar\"}";
										
									}else{
										result=validacion;
									}
								out.println(result);	
							}else if(action.equalsIgnoreCase("privileges")&& (user_permiso.getIdpermiso().indexOf(236)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
								String result="";
								int iduser=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("iduser")));
								String validacion=valid.ValidarSiesMayor(iduser, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe seleccionar un usuario\"}");
								ArrayList<CPermiso> list_permisos=dbo.getListaPermiso();
								ArrayList<Integer> lista=new ArrayList<Integer>();
								for(int i=0; i<list_permisos.size();i++){ 
									CPermiso per=list_permisos.get(i);
									int permiso=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("id_permiso_"+per.getIdpermiso())));
									if(permiso==1) lista.add(per.getIdpermiso());
								}
								ArrayList<CArea> list_area=dbo.getAreaLista();
								ArrayList<Integer> areas=new ArrayList<Integer>();
								for(int i=0; i<list_area.size();i++){ 
									CArea idarea=list_area.get(i);
									int intarea=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("id_area"+idarea.getidarea())));
									if(intarea==1) areas.add(idarea.getidarea());
								}
								
								if(validacion.compareTo("")==0){
									 boolean b=dbo.safePermisoUsuario(iduser,lista,areas);
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
