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

import data.CAnuncio;
import data.CUsuarioPermiso;
import framework.CDataExam;

/**
 * Servlet implementation class SAnuncio_Table
 */
@WebServlet("/SAnuncioTable")
public class SAnuncioTable extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SAnuncioTable() {
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
		 
		 
		 HttpSession sessiones = request.getSession(false);
		 if(sessiones!=null &&  sessiones.getAttribute("user_permiso")!=null){
				CUsuarioPermiso user_permiso=(CUsuarioPermiso)sessiones.getAttribute("user_permiso");
				if( (user_permiso.getIdpermiso().indexOf(254)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
					CDataExam dbo=new CDataExam();
					 dbo.Connect(); 
					 
					 ArrayList<CAnuncio> lista=dbo.getAnuncioLista();
					 String info="<?xml version=\"1.0\" encoding=\"utf-8\"?>";
					 info+="<rows><page>1</page><total>"+lista.size()+"</total>";
					 
					 String data="";
					 for(int i=0; i<lista.size();i++){
						 CAnuncio temp=lista.get(i);
						 data+="<row id='"+temp.getIdanuncio()+"'><cell><![CDATA[<input type='radio' class='anuncio_radio' onclick='editaranuncio("+temp.getIdanuncio()+")' name='idmenu_radio' value='"+temp.getIdanuncio()+"' />]]></cell><cell><![CDATA["+temp.getIdanuncio()+"]]></cell><cell><![CDATA["+temp.getNombre()+"]]></cell><cell><![CDATA["+temp.getDescripcion()+"]]></cell></row>";	 
			
					 }
					 info+=data+"</rows>";
					 out.println(info);
					 dbo.Close();
				}
		}
	}

}
