package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import data.CArea;
import data.CUsuarioPermiso;
import framework.CDataBase;

/**
 * Servlet implementation class SAreaTable
 */
@WebServlet("/SAreaTable")
public class SAreaTable extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SAreaTable() {
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
				if( (user_permiso.getIdpermiso().indexOf(231)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
					 CDataBase dbo=new CDataBase();
					 dbo.Connect(); 
					 
					 ArrayList<CArea> lista=dbo.getAreaLista(user_permiso.getIdarea());
					 String info="<?xml version=\"1.0\" encoding=\"utf-8\"?>";
					 info+="<rows><page>1</page><total>"+lista.size()+"</total>";
					 
					 String data="";
					 for(int i=0; i<lista.size();i++){
						 CArea temp=lista.get(i);
					data+="<row id='"+temp.getidarea()+"'><cell><![CDATA[<input type='radio' class='area_radio' onclick='editararea("+temp.getidarea()+")' name='idmenu_radio' value='"+temp.getidarea()+"' />]]></cell><cell><![CDATA["+temp.getidarea()+"]]></cell><cell><![CDATA["+temp.getnombre()+"]]></cell><cell><![CDATA["+((temp.getareaidarea()!=null)?temp.getareaidarea().getnombre():"")+"]]></cell></row>";	 
			
					 }
					 info+=data+"</rows>";
					 out.println(info);
					 dbo.Close();
				}
		}
				
	}

}
