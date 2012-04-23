package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import data.CArea;
import data.CMultimedia;
import data.CUsuarioPermiso;
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
		String codificacion=request.getCharacterEncoding();
		codificacion=(codificacion==null)?"ISO-8859-1":codificacion;
		PrintWriter out = response.getWriter(); 		
		Base64core base64=new Base64core();
		CValidation valid=new CValidation();
		HttpSession sessiones = request.getSession(false);
		 if(sessiones!=null &&  sessiones.getAttribute("user_permiso")!=null){
		CUsuarioPermiso user_permiso=(CUsuarioPermiso)sessiones.getAttribute("user_permiso");
		
		CDataBase dbo=new CDataBase();
		 dbo.Connect();
		 String action=valid.ValidarRequest(request.getParameter("a"));
		 
		 if(action.equalsIgnoreCase("show")&&  (user_permiso.getIdpermiso().indexOf(231)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
		 int idarea=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idarea")));
		 CArea temp_area=dbo.getCAreaEspecifico(idarea);
		 String result="";
		 if(temp_area!=null){
			 result= "{nombre:\""+temp_area.getnombre()+" \",size:\""+temp_area.getsize()+"\",idimagen:"+temp_area.getidmultimedia().getidimagen()+",direccion_relativa:\""+
				 temp_area.getidmultimedia().getdireccion_relativa()+"\", contenido:\""+temp_area.getdescripcion()+"\"}";
		 }
		 response.setContentType("text/html;charset="+codificacion);
		 out.println(base64.codificar(valid.Imprimirvalor(result,codificacion)));
		}else if(action.equalsIgnoreCase("guardaredit")&& (user_permiso.getIdpermiso().indexOf(232)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
			String result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";			
			int idarea=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idarea")));
			String contenido=(valid.ValidarRequest(request.getParameter("contenido")));		
			contenido=base64.decodificar(contenido);
			contenido=valid.Limpiarvalor(contenido,codificacion);
			int idmultimedia=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idmultimedia")));
			int size=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("size")));
			String validacion=valid.ValidarSiesMayor(idarea, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar un item\"}");
			validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(contenido, 4990, "Contenido"):validacion;
			validacion=(validacion.compareTo("")==0)?valid.ValidarRango(size, 0, 4, "{\"resultado\":\"ERROR\",\"mensaje\":\"No ha seleccionado un tama&ntilde;o\"}"):validacion;
			
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

}
