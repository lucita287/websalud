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
		String resultados="";
		 for(int i=0; i<lista_imag.size();i++){
           	CMultimedia multi=lista_imag.get(i);
           	File f=new File(multi.getdireccion());
           	if(!f.exists()){
           		
           		boolean b=dbo.deleteMultimedia(multi.getidimagen());
           		if(b){
           			resultados+=f.getName()+" NO SE ENCONTRO,ELIMINADO <BR/>";
           		}else{
           			resultados+=f.getName()+" NO SE ENCONTRO,ERROR AL ELIMINADO <BR/>";
           		}
           	}else{
           		if(f.delete()){
           			boolean b=dbo.deleteMultimedia(multi.getidimagen());
               		if(b){
               			resultados+=f.getName()+" ELIMINADO <BR/>";
               		}else{
               			resultados+=f.getName()+" ERROR AL ELIMINADO <BR/>";
               		}
           		}else{
           		resultados+=f.getName()+" NO SE PUEDE ELIMINAR <BR/>";
           		}
           	}
           }
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
