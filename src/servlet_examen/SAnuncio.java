package servlet_examen;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import data.CAnuncio;
import data.CUsuarioPermiso;
import framework.Base64core;
import framework.CDataExam;
import framework.CValidation;

/**
 * Servlet implementation class SAnuncio
 */
@WebServlet("/SAnuncio")
public class SAnuncio extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SAnuncio() {
        super();
        // TODO Auto-generated constructor stub
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
				CDataExam dbo=new CDataExam();
				dbo.Connect();
				 String action=valid.ValidarRequest(request.getParameter("a"));
				 		 
				if(action.equalsIgnoreCase("show")&&  (user_permiso.getIdpermiso().indexOf(254)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
					 int idanuncio=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idanuncio")));
					 CAnuncio temp_area=dbo.getAnuncioEspecifico(idanuncio);
					 String result="";
					 if(temp_area!=null){
						 result= temp_area.getContenido();
					 }
					 response.setContentType("text/html;charset="+codificacion);
					 out.println(result);
				}else if(action.equalsIgnoreCase("guardaredit")&& (user_permiso.getIdpermiso().indexOf(254)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
					String result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";			
					int idanuncio=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idanuncio")));
					String contenido=(valid.ValidarRequest(request.getParameter("contenido")));		
					contenido=base64.decodificar(contenido);
					contenido=valid.Limpiarvalor(contenido,codificacion);
					String validacion=valid.ValidarSiesMayor(idanuncio, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar un item\"}");
					validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(contenido, 5990, "Contenido"):validacion;
					
					if(validacion.compareTo("")==0){
						CAnuncio temp=dbo.getAnuncioEspecifico(idanuncio);;
						temp.setContenido(contenido);
						boolean b=dbo.UpdateAnuncio(temp);
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
