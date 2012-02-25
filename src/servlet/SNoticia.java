package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import data.CArea;
import data.CMultimedia;
import data.CNoticia;

import framework.Base64core;
import framework.CDataBase;
import framework.CValidation;

/**
 * Servlet implementation class SNoticia
 */
@WebServlet("/SNoticia")
public class SNoticia extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SNoticia() {
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
		CValidation valid=new CValidation();
		CDataBase dbo=new CDataBase();
		 dbo.Connect();
		if(action.equalsIgnoreCase("new_noticia")){
			String result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
			int idmultimedia=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idimagen")));
			int idarea=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idarea")));
			int prioridad=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("prioridad")));
			String titulo=valid.ValidarRequest(request.getParameter("titulo"));
			titulo=base64.decodificar(titulo);
			titulo=valid.Limpiarvalor(titulo);
			String contenido=(valid.ValidarRequest(request.getParameter("contenido")));		
			contenido=base64.decodificar(contenido);
			contenido=valid.Limpiarvalor(contenido);
			String descripcion=(valid.ValidarRequest(request.getParameter("descripcion")));		
			descripcion=base64.decodificar(descripcion);
			descripcion=valid.Limpiarvalor(descripcion);
			
			String fecha_inicio=(valid.ValidarRequest(request.getParameter("fecha_inicio")));		
			fecha_inicio=base64.decodificar(fecha_inicio);
			String fecha_fin=(valid.ValidarRequest(request.getParameter("fecha_fin")));		
			fecha_fin=base64.decodificar(fecha_fin);
			String validacion=valid.ValidarCampoVacio(titulo, "titulo");
			validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(titulo, 48, "Titulo"):validacion;
			validacion=(validacion.compareTo("")==0)?valid.ValidarCampoVacio(contenido, "Descripcion"):validacion;
			validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(contenido, 3990, "Descripcion"):validacion;
			validacion=(validacion.compareTo("")==0)?valid.ValidarCampoVacio(descripcion, "Descripcion corta"):validacion;
			validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(descripcion, 100, "Descripcion corta"):validacion;
			validacion=(validacion.compareTo("")==0)?valid.isFechaValida(fecha_inicio,  "Fecha inicio"):validacion;
			validacion=(validacion.compareTo("")==0)?valid.isFechaValida(fecha_fin,  "Fecha fin"):validacion;
			validacion=(validacion.compareTo("")==0)?valid.validarFechaMayoraOtra(fecha_inicio,fecha_fin,"Fecha de Inicio","Fecha de Fin"):validacion;
			if(validacion.compareTo("")==0){
				Date ffecha_inicio=valid.CambiarFormatoddmmyy(fecha_inicio);
				Date ffecha_fin=valid.CambiarFormatoddmmyy(fecha_fin);
				CArea area=dbo.getCAreaEspecifico(idarea);
				CMultimedia multi=dbo.getMultimediaEspecifica(idmultimedia);
				CNoticia noti=new CNoticia(titulo,contenido,descripcion,multi, ffecha_inicio, ffecha_fin,  prioridad, 0, area);
				boolean b=dbo.SafeNoticia(noti);
				if(b) result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
				else result="{\"resultado\":\"ERROR\",\"mensaje\":\"Error al guardar\"}";
			}else{
				result=validacion;
			}
			
			out.println(result);
		}else if(action.equalsIgnoreCase("show_news")){
			String result=" ";
			int idnoticia=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idnoticia")));
			CNoticia noti=dbo.getNoticiaEspecifica(idnoticia);
			 if(noti!=null){
				 result= "{descripcion:\""+noti.getDescripcion()+"\",idarea:\""+noti.getAreaidarea().getidarea()+"\",areanombre:\""+
						 noti.getAreaidarea().getnombre()+"\",idimagen:"+noti.getMultimediaidmultimedia().getidimagen()+",idimagendir:\""+noti.getMultimediaidmultimedia().getdireccion_relativa()+"\","
					 +"prioridad:\""+noti.getPrioridad()+"\",titulo:\""+noti.getTitulo()+"\",fecha_inicio:\""+noti.getFormatoFechaddmmyy(noti.getFecha_inicio())+"\",fecha_fin:\""+noti.getFormatoFechaddmmyy(noti.getFecha_fin())+"\",descripcion_corta:\""+noti.getDescripcion_corta()+"\"}";
			 }
			 out.println(base64.codificar(result));
		}else if(action.equalsIgnoreCase("safe_noticia")){
			String result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
			int idnoticia=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idnoticia")));
			int idmultimedia=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idimagen")));
			int idarea=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idarea")));
			int prioridad=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("prioridad")));
			String titulo=valid.ValidarRequest(request.getParameter("titulo"));
			titulo=base64.decodificar(titulo);
			titulo=valid.Limpiarvalor(titulo);
			String contenido=(valid.ValidarRequest(request.getParameter("contenido")));		
			contenido=base64.decodificar(contenido);
			contenido=valid.Limpiarvalor(contenido);
			String fecha_inicio=(valid.ValidarRequest(request.getParameter("fecha_inicio")));		
			fecha_inicio=base64.decodificar(fecha_inicio);
			String fecha_fin=(valid.ValidarRequest(request.getParameter("fecha_fin")));		
			fecha_fin=base64.decodificar(fecha_fin);
			String descripcion=(valid.ValidarRequest(request.getParameter("descripcion")));		
			descripcion=base64.decodificar(descripcion);
			descripcion=valid.Limpiarvalor(descripcion);
			String validacion=valid.ValidarSiesMayor(idnoticia, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar un item\"}");
			validacion=(validacion.compareTo("")==0)?valid.ValidarCampoVacio(titulo, "Titulo"):validacion;
			validacion=(validacion.compareTo("")==0)?valid.ValidarCampoVacio(contenido, "Contenido"):validacion;
			validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(titulo, 48, "Titulo"):validacion;
			validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(contenido, 3990, "Contenido"):validacion;
			validacion=(validacion.compareTo("")==0)?valid.ValidarCampoVacio(descripcion, "Descripcion corta"):validacion;
			validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(descripcion, 100, "Descripcion corta"):validacion;
			validacion=(validacion.compareTo("")==0)?valid.isFechaValida(fecha_inicio,  "Fecha inicio"):validacion;
			validacion=(validacion.compareTo("")==0)?valid.isFechaValida(fecha_fin,  "Fecha fin"):validacion;
			validacion=(validacion.compareTo("")==0)?valid.validarFechaMayoraOtra(fecha_inicio,fecha_fin,"Fecha de Inicio","Fecha de Fin"):validacion;
			
			if(validacion.compareTo("")==0){
				Date ffecha_inicio=valid.CambiarFormatoddmmyy(fecha_inicio);
				Date ffecha_fin=valid.CambiarFormatoddmmyy(fecha_fin);
				CArea area=dbo.getCAreaEspecifico(idarea);
				CMultimedia multi=dbo.getMultimediaEspecifica(idmultimedia);
				CNoticia noti=dbo.getNoticiaEspecifica(idnoticia);
				noti.setAreaidarea(area);
				noti.setMultimediaidmultimedia(multi);
				noti.setDescripcion(contenido);
				noti.setFecha_inicio(ffecha_inicio);
				noti.setFecha_fin(ffecha_fin);
				noti.setDescripcion_corta(descripcion);
				noti.setTitulo(titulo);
				noti.setPrioridad(prioridad);
				
				boolean b=dbo.UpdateNoticia(noti);
				if(b) result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
				else result="{\"resultado\":\"ERROR\",\"mensaje\":\"Error al guardar\"}";
			}else{
				result=validacion;
			}
			
			out.println(result);
		}
		dbo.Close();
	}
	
	

}
