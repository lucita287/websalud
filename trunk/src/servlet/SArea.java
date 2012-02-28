package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import data.CArea;
import data.CMultimedia;
import framework.Base64core;
import framework.CDataBase;
import framework.CValidation;

/**
 * Servlet implementation class SArea
 */
@WebServlet("/SArea")
public class SArea extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SArea() {
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
		if(action.equalsIgnoreCase("show")){
		 int idarea=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idarea")));
		 CArea temp_area=dbo.getCAreaEspecifico(idarea);
		 String result="";
		 if(temp_area!=null){
			 result= "{nombre:\""+temp_area.getnombre()+" \",size:\""+temp_area.getsize()+"\",idimagen:"+temp_area.getidmultimedia().getidimagen()+",direccion_relativa:\""+
				 temp_area.getidmultimedia().getdireccion_relativa()+"\", contenido:\""+temp_area.getdescripcion()+"\"}";
		 }
		 out.println(base64.codificar(result));
		}else if(action.equalsIgnoreCase("guardaredit")){
			String result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";			
			int idarea=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idarea")));
			String contenido=(valid.ValidarRequest(request.getParameter("contenido")));		
			contenido=base64.decodificar(contenido);
			contenido=valid.Limpiarvalor(contenido);
			int idmultimedia=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idmultimedia")));
			int size=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("size")));
			String validacion=valid.ValidarSiesMayor(idarea, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar un item\"}");
			validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(contenido, 4990, "Contenido"):validacion;
			validacion=(validacion.compareTo("")==0)?valid.ValidarRango(size, 0, 3, "{\"resultado\":\"ERROR\",\"mensaje\":\"No ha seleccionado un tama&ntilde;o\"}"):validacion;
			
			if(validacion.compareTo("")==0){
				CMultimedia multi=dbo.getMultimediaEspecifica(idmultimedia);
				CArea area=dbo.getCAreaEspecifico(idarea);
				area.setdescripcion(contenido);
				area.setidmultimedia(multi);
				area.setsize(size);
				boolean b=dbo.UpdateArea(area);
				if(!b){
					result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se ha almacenado\"}";
				}else{
					result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
				}
			}else result=validacion;
			out.println(result);
			
		}
		dbo.Close();
	}

}
