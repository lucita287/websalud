package servlet_examen;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import data.CCategoria;
import data.CCategoria_Interpretacion;
import data.CMenu_Categoria;
import data.CUsuarioPermiso;
import framework.Base64core;
import framework.CDataExam;
import framework.CValidation;

/**
 * Servlet implementation class SCategoria
 */
@WebServlet("/SCategoria")
public class SCategoria extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SCategoria() {
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
    	String codificacion=request.getCharacterEncoding();
		codificacion=(codificacion==null)?"ISO-8859-1":codificacion;
    	String action=valid.ValidarRequest(request.getParameter("a"));
    	HttpSession sessiones = request.getSession(false);
		 if(sessiones!=null &&  sessiones.getAttribute("user_permiso")!=null){
					 CUsuarioPermiso user_permiso=(CUsuarioPermiso)sessiones.getAttribute("user_permiso");
					 Base64core base64=new Base64core(); 
					CDataExam dbo=new CDataExam();
					dbo.Connect();
					
					
					if(action.equalsIgnoreCase("guardarcate")&& (user_permiso.getIdpermiso().indexOf(250)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
						String result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
						int idcate=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("id_cate")));
						String nombre=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("nombre")),codificacion);
						int auto=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("auto")));
						int multifa=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("multifa")));
						int orden=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("orden")));
						int estado=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("estado")));
						int menu=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("menu_cate")));
						
						String validacion=valid.ValidarSiesMayor(idcate, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar un item\"}");
						validacion=(validacion.compareTo("")==0)?valid.ValidarSiesMayor(menu, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar un Menu para la categoria\"}"):validacion;
						validacion=(validacion.compareTo("")==0)?valid.ValidarCampoVacio(nombre, "Descripcion"):validacion;
						validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(nombre, 100, "Descripcion"):validacion;
						
						
						if(validacion.compareTo("")==0){
							CCategoria cate=new CCategoria(idcate,nombre,orden,auto, multifa,estado,new CMenu_Categoria(menu,"","",0));
							boolean b=dbo.UpdateCategoria(cate);
							if(!b){
								result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se ha almacenado\"}";
							}else{
								result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
							}
						}else result=validacion;
						out.println(result);
						
					}else if(action.equalsIgnoreCase("newcate")&& (user_permiso.getIdpermiso().indexOf(250)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
						String result="";
						String nombre=valid.Limpiarvalor2(valid.ValidarRequest(request.getParameter("nombre")),codificacion);
						int auto=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("auto")));
						int multifa=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("multifa")));
						int orden=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("orden")));
						int estado=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("estado")));
						int menu=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("menu_cate")));
						
						String validacion=valid.ValidarCampoVacio(nombre, "Descripcion");
						validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(nombre, 100, "Descripcion"):validacion;
						validacion=(validacion.compareTo("")==0)?valid.ValidarSiesMayor(menu, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar un Menu para la categoria\"}"):validacion;
						
						if(validacion.compareTo("")==0){
							CCategoria cate=new CCategoria(0,nombre,orden,auto, multifa,estado,new CMenu_Categoria(menu,"","",0));
							boolean b=dbo.SafeCategoria(cate);
							if(!b){
								result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se ha almacenado\"}";
							}else{
								result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
							}
						}else result=validacion;
						out.println(result);
							
					}else if(action.equalsIgnoreCase("deletecate")&& (user_permiso.getIdpermiso().indexOf(250)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
						String result="";
						int idcate=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("id_cate")));
						String validacion=valid.ValidarSiesMayor(idcate, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar un item\"}");
						
						if(validacion.compareTo("")==0){
							boolean b=dbo.deleteCategoria(idcate);
							if(!b){
								result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se ha eliminado\"}";
							}else{
								result="{\"resultado\":\"OK\",\"mensaje\":\"Eliminado\"}";
							}
						}else result=validacion;
						out.println(result);
							
					}else if(action.equalsIgnoreCase("show_cate_pond")&& (user_permiso.getIdpermiso().indexOf(250)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
						String result=" ";
						int idcate_pond=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idcate_pond")));
						CCategoria_Interpretacion act=dbo.getCategoria_InterpretacionEspecifico(idcate_pond);
						 if(act!=null){							 
							 result= "{\"min\":\""+act.getPonderacion_min()+"\",\"max\":\""+act.getPonderacion_max()+"\",\"interpretacion\":\""+valid.Limpiarvalor3(act.getInterpretacion())+"\",\"titulo\":\""+act.getTitulo()+"\",\"size\":\""+act.getSize()+"\"}";
						 }
						 out.println(result);
						//MODIFICAR CATEGORIA 
					}else if(action.equalsIgnoreCase("safe_cate_pond")&& (user_permiso.getIdpermiso().indexOf(250)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
						String result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
						int idcate_pond=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idcate_pond")));
						String interpretacion=valid.Limpiarvalor2(valid.ValidarRequest(request.getParameter("interpretacion")),codificacion);
						String titulo=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("titulo")),codificacion);
						int size=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("size")));
						int min=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("min")));
						int max=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("max")));
						int idcategoria=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idcategoria")));
						
						String validacion=valid.ValidarSiesMayor(idcate_pond, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar un item\"}");
						validacion=(validacion.compareTo("")==0)?valid.ValidarCampoVacio(interpretacion, "Descripcion"):validacion;
						validacion=(validacion.compareTo("")==0)?valid.ValidarCampoVacio(titulo, "Titulo"):validacion;
						validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(titulo, 100, "Titulo"):validacion;
						validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(interpretacion, 5000, "Descripcion"):validacion;
						validacion=(validacion.compareTo("")==0)?valid.validarMinyMax(min, max, "Minimo","Maximo"):validacion;
						validacion=(validacion.compareTo("")==0)?valid.ValidarSiesMayor(idcategoria, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar una categoria\"}"):validacion;
						
						if(validacion.compareTo("")==0){
							CCategoria categoria=new CCategoria(idcategoria,"",0,0,0,0,null);
							CCategoria_Interpretacion cate=new CCategoria_Interpretacion(idcate_pond,max, min, interpretacion,categoria,titulo,size) ;
							boolean b=dbo.UpdateCategoria_Interpretacion(cate);
							if(!b){
								result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se ha almacenado\"}";
							}else{
								result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
							}
						}else result=validacion;
						out.println(result);
						
					}else if(action.equalsIgnoreCase("new_cate_pond")&& (user_permiso.getIdpermiso().indexOf(250)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
						String result="";
						String interpretacion=valid.Limpiarvalor2(valid.ValidarRequest(request.getParameter("interpretacion")),codificacion);
						int min=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("min")));
						int max=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("max")));
						int idcategoria=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idcategoria")));
						String titulo=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("titulo")),codificacion);
						int size=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("size")));
						
						String validacion=valid.ValidarSiesMayor(idcategoria, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar una categoria\"}");
						validacion=(validacion.compareTo("")==0)?valid.ValidarCampoVacio(interpretacion, "Descripcion"):validacion;
						validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(interpretacion, 4000, "Descripcion"):validacion;
						validacion=(validacion.compareTo("")==0)?valid.validarMinyMax(min, max, "Minimo","Maximo"):validacion;
						validacion=(validacion.compareTo("")==0)?valid.ValidarCampoVacio(titulo, "Titulo"):validacion;
						validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(titulo, 100, "Titulo"):validacion;
						if(validacion.compareTo("")==0){
							CCategoria categoria=new CCategoria(idcategoria,"",0,0,0,0,null);
							CCategoria_Interpretacion cate=new CCategoria_Interpretacion(0,max, min, interpretacion,categoria,titulo,size) ;
							boolean b=dbo.SafeCategoria_Interpretacion(cate);
							if(!b){
								result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se ha almacenado\"}";
							}else{
								result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
							}
						}else result=validacion;
						out.println(result);
							
					}else if(action.equalsIgnoreCase("deletecate_ponde")&& (user_permiso.getIdpermiso().indexOf(250)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
						String result="";
						int idcate=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idcate_pond")));
						String validacion=valid.ValidarSiesMayor(idcate, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar un item\"}");
						
						if(validacion.compareTo("")==0){
							boolean b=dbo.deleteCategoria_Interpretacion(idcate);
							if(!b){
								result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se ha eliminado\"}";
							}else{
								result="{\"resultado\":\"OK\",\"mensaje\":\"Eliminado\"}";
							}
						}else result=validacion;
						out.println(result);
							
					}else if(action.equalsIgnoreCase("guardarmenu_categoria")&& (user_permiso.getIdpermiso().indexOf(250)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
						String result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
						int idmenu_Categoria=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("id_menu_categoria")));
						String nombre=valid.Limpiarvalor(base64.decodificar(valid.ValidarRequest(request.getParameter("nombre"))),codificacion);
						int idarea=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idarea")));
						String contenido=(valid.ValidarRequest(request.getParameter("contenido")));		
						contenido=base64.decodificar(contenido);
						contenido=valid.Limpiarvalor(contenido,codificacion);
						String validacion=valid.ValidarSiesMayor(idmenu_Categoria, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar un item\"}");
						validacion=(validacion.compareTo("")==0)?valid.ValidarSiesMayor(idarea, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar un area\"}"):validacion;
						validacion=(validacion.compareTo("")==0)?valid.ValidarCampoVacio(nombre, "Descripcion"):validacion;
						validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(nombre, 80, "Descripcion"):validacion;
						validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(contenido, 4990, "Contenido"):validacion;
						
						if(validacion.compareTo("")==0){
							CMenu_Categoria car=new CMenu_Categoria(idmenu_Categoria,nombre,contenido,idarea);
							boolean b=dbo.UpdateMenu_Categoria(car);
							if(!b){
								result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se ha almacenado\"}";
							}else{
								result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
							}
						}else result=validacion;
						out.println(result);
						
					}else if(action.equalsIgnoreCase("newmenu_categoria")&& (user_permiso.getIdpermiso().indexOf(250)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
						String result="";
						String nombre=valid.Limpiarvalor(base64.decodificar(valid.ValidarRequest(request.getParameter("nombre"))),codificacion);
						int idarea=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idarea")));
						
						String contenido=(valid.ValidarRequest(request.getParameter("contenido")));		
						contenido=base64.decodificar(contenido);
						contenido=valid.Limpiarvalor(contenido,codificacion);
						
						String validacion=valid.ValidarCampoVacio(nombre, "Descripcion");
						validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(nombre, 80, "Descripcion"):validacion;
						validacion=(validacion.compareTo("")==0)?valid.ValidarSiesMayor(idarea, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar un area\"}"):validacion;
						validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(contenido, 4990, "Contenido"):validacion;
						if(validacion.compareTo("")==0){
							CMenu_Categoria car=new CMenu_Categoria(0,nombre,contenido,idarea);
							boolean b=dbo.SafeMenu_Categoria(car);
							if(!b){
								result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se ha almacenado\"}";
							}else{
								result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
							}
						}else result=validacion;
						out.println(result);
							
					}else if(action.equalsIgnoreCase("deletemenu_categoria")&& (user_permiso.getIdpermiso().indexOf(250)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
						String result="";
						int id_menu_categoria=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("id_menu_categoria")));
						String validacion=valid.ValidarSiesMayor(id_menu_categoria, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar un item\"}");
						
						if(validacion.compareTo("")==0){
							boolean b=dbo.deleteMenu_Categoria(id_menu_categoria);
							if(!b){
								result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se ha eliminado\"}";
							}else{
								result="{\"resultado\":\"OK\",\"mensaje\":\"Eliminado\"}";
							}
						}else result=validacion;
						out.println(result);
							
					}else if(action.equalsIgnoreCase("show_menu_cate")){
						ArrayList<CMenu_Categoria> list_respon=dbo.getListaMenu_Categoria();
						String result="{total:"+list_respon.size()+",rows:[";
						String data="";
						
						for(int j=0; j<list_respon.size();j++){ 
							CMenu_Categoria respon=list_respon.get(j);
							data+=(data.compareTo("")==0)?"":",";
							data+="{value:"+respon.getIdmenu_categoria()+",text:'"+respon.getNombre()+"'}";
						}
						result+=data+"]}";
						out.println(result);
					}else if(action.equalsIgnoreCase("show_menu_categoria")){
						int idmenu_Categoria=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idmenu_categoria")));
						 CMenu_Categoria temp_area=dbo.getMenuCategoriaEspecifico(idmenu_Categoria);
						 String result="";
						 if(temp_area!=null){
							 result= "{nombre:\""+temp_area.getNombre()+" \", contenido:\""+temp_area.getInstruccion()+" \", area:\""+temp_area.getArea_examen()+"\"}";
						 }
						 response.setContentType("text/html;charset="+codificacion);
						 out.println(base64.codificar(valid.Imprimirvalor(result,codificacion)));
					}
					dbo.Close();
		 }
		 
	}

}
