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

import data.CEstado_Civil;
import data.CTipo_Sangre;
import data.CUsuarioPermiso;
import framework.CDataExam;
import framework.CValidation;

/**
 * Servlet implementation class SPropiedadTable
 */
@WebServlet("/SPropiedadTable")
public class SPropiedadTable extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SPropiedadTable() {
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
		
		HttpSession sessiones = request.getSession(false);
		 if(sessiones!=null &&  sessiones.getAttribute("user_permiso")!=null){
				CUsuarioPermiso user_permiso=(CUsuarioPermiso)sessiones.getAttribute("user_permiso");
				String action=valid.ValidarRequest(request.getParameter("a"));
				
				if(action.equalsIgnoreCase("civil") &&(user_permiso.getIdpermiso().indexOf(239)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
					CDataExam dbo=new CDataExam();
					 dbo.Connect();
					 		ArrayList<CEstado_Civil> lista=dbo.getListaEstadoCivil();
					 		String info="<?xml version=\"1.0\" encoding=\"utf-8\"?>";
							 info+="<rows><page>1</page><total>"+lista.size()+"</total>";
							 
							 String data="";
							 for(int i=0; i<lista.size();i++){
								 CEstado_Civil temp=lista.get(i);
								 	data+="<row id='"+temp.getIdestado_civil()+"'><cell><![CDATA[<input type='radio' class='menu_radio' onclick='EditarEstadoCivil("+temp.getIdestado_civil()+",\""+temp.getNombre()+"\")' name='idcivil_radio' value='"+temp.getIdestado_civil()+"' />]]></cell><cell><![CDATA["+temp.getIdestado_civil()+"]]></cell><cell><![CDATA["+temp.getNombre()+"]]></cell></row>";	 
							 }
							 info+=data+"</rows>";
							 out.println(info);
					 dbo.Close();
				
				}else if(action.equalsIgnoreCase("tsangre") &&(user_permiso.getIdpermiso().indexOf(240)>-1  || user_permiso.getIdusuario().getidusuario()==1)){
					CDataExam dbo=new CDataExam();
					 dbo.Connect();
					 		ArrayList<CTipo_Sangre> lista=dbo.getListaTipo_Sangre();
					 		String info="<?xml version=\"1.0\" encoding=\"utf-8\"?>";
							 info+="<rows><page>1</page><total>"+lista.size()+"</total>";
							 
							 String data="";
							 for(int i=0; i<lista.size();i++){
								 CTipo_Sangre temp=lista.get(i);
								 	data+="<row id='"+temp.getIdtipo_sangre()+"'><cell><![CDATA[<input type='radio' class='menu_radio' onclick='Editartsangre("+temp.getIdtipo_sangre()+",\""+temp.getNombre()+"\")' name='idtsangre_radio' value='"+temp.getIdtipo_sangre()+"' />]]></cell><cell><![CDATA["+temp.getIdtipo_sangre()+"]]></cell><cell><![CDATA["+temp.getNombre()+"]]></cell></row>";	 
							 }
							 info+=data+"</rows>";
							 out.println(info);
					 dbo.Close();
				
				} 
		 }
	}

}
