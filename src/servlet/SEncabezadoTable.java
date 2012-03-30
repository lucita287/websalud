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


import data.CEncabezado;
import data.CUsuarioPermiso;
import framework.CDataBase;
import framework.CValidation;

/**
 * Servlet implementation class SEncabezadoTable
 */
@WebServlet("/SEncabezadoTable")
public class SEncabezadoTable extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SEncabezadoTable() {
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
						 CValidation valid=new CValidation();
						 int idarea=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("pidarea")));
						 ArrayList<CEncabezado> list=dbo.getEncabezadoLista(idarea);
						String info="{";
				        info+="total: "+list.size();
				        info+=", page: 1,";
				        info+="rows: [";
				        String data="";
				        
				        
				        for(int i=0; i<list.size();i++){
				        	CEncabezado temp=list.get(i);
				                       data+=(data=="")?"":",";
				                                         data+="{ cell: [\"<input type='radio' onclick='editar_encabe("+temp.getMultimediaidmultimedia().getidimagen()+")' name='idencabe' value='"+temp.getMultimediaidmultimedia().getidimagen()+"' />\",\""+temp.getMultimediaidmultimedia().getidimagen()+"\", \""+temp.getAreaidarea().getnombre()+"\" , \""+temp.getMultimediaidmultimedia().getdireccion_relativa()+"\"  ] }";
				        }
				        info+=data+"] }";
				        dbo.Close();
				        out.print(info);
				}     
		 }
        
        
	}

}
