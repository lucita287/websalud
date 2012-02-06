package servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSON;
import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;

import data.CMenu;

import framework.CDataBase;

/**
 * Servlet implementation class SMenu
 */
@WebServlet("/SMenu")
public class SMenu extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SMenu() {
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
		
		CDataBase dbo=new CDataBase();
		 dbo.Connect();
		if(action.equalsIgnoreCase("show")){
		 int idmenu=Integer.parseInt(request.getParameter("idmenu"));
		 CMenu temp_menu=dbo.getMenuEspecifico(idmenu);
		 String result=(temp_menu!=null)?
				 "{\"descripcion\":\""+temp_menu.getdescripcion()+"\",\"area\":\""+temp_menu.getareaidarea().getidarea()+"\"," +
				 		"\"contenido\":\""+temp_menu.getcontenido()+"\",\"areanombre\":\""+
				 temp_menu.getareaidarea().getdescripcion()+"\",\"submenu\":\""+((temp_menu.getidmenu_rec()==null)?"":temp_menu.getidmenu_rec().getdescripcion())+"\"}"
				 		
				 :"";
		 out.println(result);
		}else if(action.equalsIgnoreCase("admin")){
			int idmenu=Integer.parseInt(request.getParameter("idmenu")==null?"1":request.getParameter("idmenu"));
			 HttpSession session = request.getSession();
			 session.setAttribute("portal", new Integer(idmenu));
		}else if(action.equalsIgnoreCase("editmenu")){
			ArrayList<CMenu> list=dbo.getMenuLista();	
			 
			 String info="{";
			 info+="total: "+dbo.getCMenuTotal();
			 info+=", page: 1,";
			 info+="rows: [";
			 String data="";
			 for(int i=0; i<list.size();i++){
					CMenu temp=list.get(i);
					data+=(data=="")?"":",";
					data+="{ cell: [\"<input type='radio' onclick='editar("+temp.getidmenu()+")' name='idmenu_radio' value='"+temp.getidmenu()+"' />\",\""+temp.getidmenu()+"\", \""+temp.getdescripcion()+"\" , \""+temp.getareaidarea().getdescripcion()+"\" , \""+temp.getcontenido()+"\" , \""+((temp.getidmenu_rec()!=null)?temp.getidmenu_rec().getdescripcion():"")+"\" ] }";
			 }
			 info+=data+"] }";
			 out.println(info);
		}else if(action.equalsIgnoreCase("guardaredit")){
			String result="{\"resultado\":\""+"\"OK\",\"mensaje\":\"Almacenado\"}";
			
			int idmenu=Integer.parseInt(((request.getParameter("idmenu")==null)?"0":request.getParameter("idmenu")));
				if(idmenu>0){
					String titulo=request.getParameter("titulo");
					
					String string = titulo;
				    byte[] utf8 = string.getBytes("UTF-8");

				    // Convert from UTF-8 to Unicode
				    titulo = new String(utf8, "UTF-8");
					
					if(titulo.trim()!=""){
						CMenu temp_menu=dbo.getMenuEspecifico(idmenu);
							if((temp_menu.getidmenu_rec()==null && temp_menu.getdescripcion().equalsIgnoreCase(titulo))||temp_menu.getidmenu_rec()!=null){
								String contenido=request.getParameter("contenido");
								temp_menu.setcontenido(contenido);
								temp_menu.setdescripcion(titulo);
								result="{\"resultado\":\"ERROR\",\"mensaje\":\"OK -"+temp_menu.getdescripcion()+"."+titulo+"\"}";
							}else{
								result="{\"resultado\":\"ERROR\",\"mensaje\":\"El titulo no puede cambiarse en el menu principal -"+temp_menu.getdescripcion()+"-"+titulo+"-\"}";
							}
					}else{
						result="{\"resultado\":\"ERROR\",\"mensaje\":\"El titulo no puede estar vacio\"}";
					}
				}else{
					result="{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar un item\"}";
				}
				out.println(result);
		}
		dbo.Close();
	}

}
