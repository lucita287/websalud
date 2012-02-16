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
		String action=request.getParameter("a");
		Base64core base64=new Base64core();
		CDataBase dbo=new CDataBase();
		dbo.Connect();
		if(action.equalsIgnoreCase("guardaredit")){
			String titulo=base64.decodificar(request.getParameter("titulo"));
			String contenido=base64.decodificar(request.getParameter("contenido"));
			String result="{\"resultado\":\"ERROR\",\"mensaje\":\"Debe llenar todos los campos\"}";
			int idmultimedia=Integer.parseInt(request.getParameter("idimagen"));
			int idmenu=Integer.parseInt(request.getParameter("idmenu"));
			CMenu men=dbo.getMenuEspecifico(idmenu);
			if(!titulo.trim().equalsIgnoreCase("")&&!contenido.trim().equalsIgnoreCase("")){
				if(idmultimedia>0){
					CMultimedia multi=dbo.getMultimediaEspecifica(idmultimedia);
					CContenido conte=new CContenido(0,contenido, titulo,multi, men);
					boolean b=dbo.SafeContenido(conte);
					if(!b){
						result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se ha almacenado\"}";
					}else{
						result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
					}
				}else{
					 result="{\"resultado\":\"ERROR\",\"mensaje\":\"Debe seleccionar un archivo\"}";
				}
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
			String result="{\"resultado\":\"ERROR\",\"mensaje\":\"Debe llenar todos los campos\"}";
			int idmultimedia=Integer.parseInt(request.getParameter("idimagen"));
			int idcontenido=Integer.parseInt(request.getParameter("idconte"));
			if(idcontenido>0&&!titulo.trim().equalsIgnoreCase("")&&!contenido.trim().equalsIgnoreCase("")){
				if(idmultimedia>0){
					CMultimedia multi=dbo.getMultimediaEspecifica(idmultimedia);
					CContenido conte=dbo.getContenido(idcontenido);
					conte.setdescripcion(contenido);
					conte.settitulo(titulo);
					conte.setmultimedia(multi);
					boolean b=dbo.UpdateContenido(conte);
					if(b) result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
					else result="{\"resultado\":\"ERROR\",\"mensaje\":\"Error al guardar\"}";
				}else{
					 result="{\"resultado\":\"ERROR\",\"mensaje\":\"Debe seleccionar un archivo\"}";
				}
			}
			out.println(result);
		}
	}

}
