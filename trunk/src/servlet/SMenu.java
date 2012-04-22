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
import data.CMenu;
import data.CUsuarioPermiso;

import framework.Base64core;
import framework.CDataBase;
import framework.CValidation;

/**
 * Servlet implementation class SMenu
 */
@WebServlet("/SMenu")
public class SMenu extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SMenu() {
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
		String codificacion=request.getCharacterEncoding();
		codificacion=(codificacion==null)?"ISO-8859-1":codificacion;
		response.setContentType("text/html;charset=UTF-8"); 
		PrintWriter out = response.getWriter(); 
		CValidation valid=new CValidation();
		String action=valid.ValidarRequest(request.getParameter("a"));
		Base64core base64=new Base64core();
		
		CDataBase dbo=new CDataBase();
		 dbo.Connect();
		 HttpSession sessiones = request.getSession(false);
		 if(sessiones!=null &&  sessiones.getAttribute("user_permiso")!=null){
					 CUsuarioPermiso user_permiso=(CUsuarioPermiso)sessiones.getAttribute("user_permiso");
					//PERMISO PARA MOSTRAR CONTENIDO
					 if(action.equalsIgnoreCase("show")&& (user_permiso.getIdpermiso().indexOf(221)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
								 int idmenu=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idmenu")));
								 CMenu temp_menu=dbo.getMenuEspecifico(idmenu);
								 String result="";
								 if(temp_menu!=null){
									 result= "{descripcion:\""+temp_menu.getdescripcion()+" \",area:\""+temp_menu.getareaidarea().getidarea()+"\",idarea:\""+temp_menu.getareaidarea().getidarea()+"\",areanombre:\""+
										 temp_menu.getareaidarea().getnombre()+"\",\"submenu\":\""+((temp_menu.getidmenu_rec()==null)?"":temp_menu.getidmenu_rec().getdescripcion())+"\","
										 +"size:\""+temp_menu.getsize()+"\",contenido:\""+temp_menu.getcontenido()+" \"}";
								 }
								 response.setContentType("text/html;charset="+codificacion);
									out.println(base64.codificar(valid.Imprimirvalor(result,codificacion)));
								 
					//MENU DEL PORTAL
					 }else if(action.equalsIgnoreCase("admin")){
								int idmenu=valid.ConvertEntero(request.getParameter("idmenu")==null?"1":request.getParameter("idmenu"));
								HttpSession session = request.getSession();
								session.setAttribute("portal", new Integer(idmenu));
					//GUARDAR CONTENIDO			
					}else if(action.equalsIgnoreCase("guardaredit")&& (user_permiso.getIdpermiso().indexOf(222)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
								String result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";			
								int idmenu=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idmenu")));
								
								int size=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("size")));
								String titulo=valid.ValidarRequest(request.getParameter("titulo"));
								titulo=base64.decodificar(titulo);
								titulo=valid.Limpiarvalor(titulo,codificacion);
								String contenido=(valid.ValidarRequest(request.getParameter("contenido")));		
								contenido=base64.decodificar(contenido);
								contenido=valid.Limpiarvalor(contenido,codificacion);
								String validacion=valid.ValidarSiesMayor(idmenu, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar un item\"}");
								validacion=(validacion.compareTo("")==0)?valid.ValidarCampoVacio(titulo, "titulo"):validacion;
								validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(titulo, 48, "Titulo"):validacion;
								validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(contenido, 4990, "Contenido"):validacion;
								validacion=(validacion.compareTo("")==0)?valid.ValidarRango(size, 0, 3, "{\"resultado\":\"ERROR\",\"mensaje\":\"No ha seleccionado un tama&ntilde;o\"}"):validacion;
									if(validacion.compareTo("")==0){
											CMenu temp_menu=dbo.getMenuEspecifico(idmenu);
												if((temp_menu.getidmenu_rec()==null && temp_menu.getdescripcion().trim().equalsIgnoreCase(titulo))||temp_menu.getidmenu_rec()!=null){
													temp_menu.setcontenido(contenido);
													temp_menu.setdescripcion(titulo);
													temp_menu.setsize(size);
													boolean b=dbo.UpdateMenu(temp_menu);
													if(b)result="{\"resultado\":\"OK\",\"mensaje\":\"ACTUALIZACI&Oacute;N\"}";
													else result="{\"resultado\":\"ERROR\",\"mensaje\":\"PROBLEMA AL GUARDAR\"}";
												}else{
													result="{\"resultado\":\"ERROR\",\"mensaje\":\"El titulo no puede cambiarse en el menu principal -"+temp_menu.getdescripcion()+"-"+titulo+"#\"}";
												}
									}else result=validacion;
									out.println(result);
					//MOSTRAR LOS MENUS DE UN AREA
					}else if(action.equalsIgnoreCase("showsubmenu")){
									int idarea=valid.ConvertEntero((request.getParameter("idarea")==null)?"1":request.getParameter("idarea"));
									ArrayList<CMenu> list_menu=dbo.getMenu(idarea);
									String data="";
									for(int i=0; i<list_menu.size(); i++){
										CMenu menu=list_menu.get(i);
										data+=(data.equalsIgnoreCase("")?"":",");
										data+="{\"idmenu\":\""+menu.getidmenu()+"\",\"descripcion\": \""+menu.getdescripcion()+"\"}";
									}
									
										String result=	" {\"menus\": [  "+data+" ] }";
										 response.setContentType("text/html;charset="+codificacion);
										out.println(valid.Imprimirvalor(result,codificacion));
					//NUEVO CONTENIDO
					}else if(action.equalsIgnoreCase("guardarnew")&& (user_permiso.getIdpermiso().indexOf(224)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
									String result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
									String titulo=valid.ValidarRequest(request.getParameter("titulo"));
									titulo=base64.decodificar(titulo);
									titulo=valid.Limpiarvalor(titulo,codificacion);
									String contenido=valid.ValidarRequest(request.getParameter("contenido"));
									contenido=base64.decodificar(contenido);
									contenido=valid.Limpiarvalor(contenido,codificacion);
									int size=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("size")));
									int idarea=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("area")));
									int idsubmenu=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("submenu")));
									String validacion=valid.ValidarCampoVacio(titulo, "titulo");
									validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(titulo, 48, "Titulo"):validacion;
									validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(contenido, 4990, "Contenido"):validacion;
									validacion=(validacion.compareTo("")==0)?valid.ValidarRango(size, 0, 3, "{\"resultado\":\"ERROR\",\"mensaje\":\"No ha seleccionado un tama&ntilde;o\"}"):validacion;
									validacion=(validacion.compareTo("")==0)?valid.ValidarSiesMayor(idarea, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe seleccionar el area\"}"):validacion;
									validacion=(validacion.compareTo("")==0)?valid.ValidarSiesMayor(idsubmenu, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe seleccionar un submenu\"}"):validacion;
														
										if(validacion.compareTo("")==0){
											
											CMenu menu=dbo.getMenuEspecifico(idsubmenu);
											CArea area=dbo.getCAreaEspecifico(idarea);
											CMenu newmenu=new CMenu(0,titulo,area,contenido,size,menu);
											boolean b=dbo.SafeMenu(newmenu);
											if(b)result="{\"resultado\":\"OK\",\"mensaje\":\"ACTUALIZACI&Oacute;N\"}";
											else result="{\"resultado\":\"ERROR\",\"mensaje\":\"PROBLEMA AL GUARDAR\"}";
										}else{
											result=validacion;
										}
									out.println(result);
					//ELIMINAR CONTENIDO				
					}else if(action.equalsIgnoreCase("deletemenu")&& (user_permiso.getIdpermiso().indexOf(223)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
										String result="{\"resultado\":\"OK\",\"mensaje\":\"Borrado\"}";
										int idmenu=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idmenu")));
										String validacion=valid.ValidarSiesMayor(idmenu, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar un item\"}");
										if(validacion.compareTo("")==0){
											int res=dbo.deleteMenu(idmenu);
											if(res==0){
												result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se puede eliminar el elemento seleccionado\"}";
											} else result="{\"resultado\":\"OK\",\"mensaje\":\"Eliminado\"}";
										}else result=validacion;
										out.println(result);
					}
		 }
		dbo.Close();
	}

}
