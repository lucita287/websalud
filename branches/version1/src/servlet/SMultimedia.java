package servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import data.CMultimedia;
import data.CUsuarioPermiso;
import framework.CDataBase;
import framework.CValidation;

/**
 * Servlet implementation class SMultimedia
 */
@WebServlet("/SMultimedia")
public class SMultimedia extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SMultimedia() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request,response);
	}

	public String eliminar(CDataBase dbo,ArrayList<CMultimedia> lista_imag){
		String resultados="<div class=\"multi\"><div class=\"tabla\">";
		 for(int i=0; i<lista_imag.size();i++){
           	CMultimedia multi=lista_imag.get(i);
           	File f=new File(multi.getdireccion());
           	resultados+="<div class=\"fila\">";
           	resultados+="<div class=\"col_titulo\">"+multi.getidimagen()+". "+f.getName()+"</div>";
           	if(!f.exists()){
           		
           		boolean b=dbo.deleteMultimedia(multi.getidimagen());
           		if(b) resultados+="<div class=\"col\">NO SE ENCONTRO,ELIMINADO</div>";		
           		else resultados+="<div class=\"col\">NO SE ENCONTRO,ERROR AL ELIMINADO</div>";
           			
           		
           	}else{
           		if(f.delete()){
           			boolean b=dbo.deleteMultimedia(multi.getidimagen());
               		if(b) resultados+="<div class=\"col\">ELIMINADO</div>";		
               		else resultados+="<div class=\"col\">ERROR AL ELIMINADO</div>";
           		}else{
           			resultados+="<div class=\"col\">NO SE PUEDE ELIMINAR </div>";
           		
           		}
           	}
           	resultados+="</div>";
           }
		 resultados+="</div></div>";
		return resultados;
	}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8"); 
    	PrintWriter out = response.getWriter(); 
    	CValidation valid=new CValidation();
    	String action=valid.ValidarRequest(request.getParameter("a"));
		
		
		HttpSession sessiones = request.getSession(false);
		 if(sessiones!=null &&  sessiones.getAttribute("user_permiso")!=null){
					 CUsuarioPermiso user_permiso=(CUsuarioPermiso)sessiones.getAttribute("user_permiso");
					 
								CDataBase dbo=new CDataBase();
								 dbo.Connect();
								
								 //ELIMINAR IMAGENES
								 if(action.equalsIgnoreCase("eliminar_especifico")&& (user_permiso.getIdpermiso().indexOf(248)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
									 String resultados="";
									 ArrayList<Integer> lista=valid.ValidarListaNumeros(valid.ValidarRequest(request.getParameter("check_det_multimedia")));
									 ArrayList<CMultimedia> lista_imag=dbo.getMultimediaEliminarLista(lista);
									 resultados=this.eliminar(dbo, lista_imag);
									 out.print(resultados);
								 }else if(action.equalsIgnoreCase("eliminar_todos")&& (user_permiso.getIdpermiso().indexOf(248)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
									 
									 ArrayList<CMultimedia> lista_imag=dbo.getMultimediaEliminarLista();
									 String resultados=this.eliminar(dbo, lista_imag);
									 out.print(resultados);
								 }
								 
								 
								 dbo.Close();
		 }
		
		
	}

}
