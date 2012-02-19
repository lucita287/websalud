package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import data.CContenido;
import data.CMenu;
import data.CMultimedia;

import framework.Base64core;
import framework.CDataBase;
import framework.CValidation;

/**
 * Servlet implementation class SContenido
 */
@WebServlet("/SContenido")
public class SContenido extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SContenido() {
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
		
		Base64core base64=new Base64core();
		CDataBase dbo=new CDataBase();
		dbo.Connect();
		if(action.equalsIgnoreCase("guardaredit")){
			String titulo=base64.decodificar(valid.ValidarRequest(request.getParameter("titulo")));
			titulo=valid.Limpiarvalor(titulo);
			String contenido=base64.decodificar(valid.ValidarRequest(request.getParameter("contenido")));
			contenido=valid.Limpiarvalor(contenido);
			int idmultimedia=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idimagen")));
			int idmenu=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idmenu")));
			String result="{\"resultado\":\"ERROR\",\"mensaje\":\"Debe llenar todos los campos\"}";
			
			String validacion=valid.ValidarSiesMayor(idmenu, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar un item\"}");
			validacion=(validacion.compareTo("")==0)?valid.ValidarSiesMayor(idmultimedia, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe seleccionar un archivo\"}"):validacion;
			validacion=(validacion.compareTo("")==0)?valid.ValidarCampoVacio(titulo, "titulo"):validacion;
			validacion=(validacion.compareTo("")==0)?valid.ValidarCampoVacio(contenido, "titulo"):validacion;
			validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(titulo, 48, "Titulo"):validacion;
			validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(contenido, 100, "Contenido"):validacion;
			
				if(validacion.compareTo("")==0){
					CMenu temp_menu=dbo.getMenuEspecifico(idmenu);
					CMultimedia multi=dbo.getMultimediaEspecifica(idmultimedia);
					CContenido conte=new CContenido(0,contenido, titulo,multi, temp_menu);
					boolean b=dbo.SafeContenido(conte);
					if(!b){
						result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se ha almacenado\"}";
					}else{
						result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
					}
				}else{
					 result=validacion;
				}
			
			out.println(result);
		}else if(action.equalsIgnoreCase("editconte")){
			int idcontenido=Integer.parseInt(request.getParameter("idcontenido"));
			CContenido contenido=dbo.getContenido(idcontenido);
			String  result="{\"titulo\":\""+base64.codificar(contenido.gettitulo())+"\",\"descripcion\":\""+base64.codificar(contenido.getdescripcion())+"\",\"idimagen\":\""+contenido.getmultimedia().getidimagen()+"\",\"direccion\":\""+contenido.getmultimedia().getdireccion_relativa()+"\"}";
			out.println(result);
		}else if(action.equalsIgnoreCase("updateedit")){
			String titulo=base64.decodificar(request.getParameter("titulo"));
			String contenido=base64.decodificar(request.getParameter("contenido"));
			int idmultimedia=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idimagen")));
			int idcontenido=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idconte")));
			
			String validacion=valid.ValidarSiesMayor(idcontenido, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar un archivo de la tabla\"}");
			validacion=(validacion.compareTo("")==0)?valid.ValidarSiesMayor(idmultimedia, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe seleccionar un archivo\"}"):validacion;
			validacion=(validacion.compareTo("")==0)?valid.ValidarCampoVacio(titulo, "titulo"):validacion;
			validacion=(validacion.compareTo("")==0)?valid.ValidarCampoVacio(contenido, "titulo"):validacion;
			validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(titulo, 48, "Titulo"):validacion;
			validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(contenido, 100, "Contenido"):validacion;			
			String result="{\"resultado\":\"ERROR\",\"mensaje\":\"Debe llenar todos los campos\"}";
			
			if(validacion.compareTo("")==0){
					CMultimedia multi=dbo.getMultimediaEspecifica(idmultimedia);
					CContenido conte=dbo.getContenido(idcontenido);
					conte.setdescripcion(contenido);
					conte.settitulo(titulo);
					conte.setmultimedia(multi);
					boolean b=dbo.UpdateContenido(conte);
					if(b) result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
					else result="{\"resultado\":\"ERROR\",\"mensaje\":\"Error al guardar\"}";
				}else result=validacion;
				
			
			out.println(result);
		}else if(action.equalsIgnoreCase("deleteconte")){
			String result="{\"resultado\":\"OK\",\"mensaje\":\"Borrado\"}";
			int idcontenido=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idcontenido")));
			String validacion=valid.ValidarSiesMayor(idcontenido, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar un archivo de la tabla\"}");
			if(validacion.compareTo("")==0){
				int res=dbo.deleteContenido(idcontenido);
				if(res==0){
					result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se puede eliminar el elemento seleccionado\"}";
				} else result="{\"resultado\":\"OK\",\"mensaje\":\"Eliminado\"}";
			}else result=validacion;
			out.println(result);
		}
		dbo.Close();
	}

}
