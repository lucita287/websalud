<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataExam" %>    
<%@ page import="data.CMenu_Categoria" %> 
<%@ page import="data.CPaciente" %> 
<%@ page import="java.util.ArrayList" %> 
<%@ page import="java.util.Iterator" %>    
<%@ page import="data.CAnuncio" %>
<%@ page import="data.CArea_Examen" %>
 <% 
    HttpSession sessiones=request.getSession(false); 
 	
    if(sessiones!=null && sessiones.getAttribute("paciente")!=null){
    	CPaciente pac=(CPaciente)sessiones.getAttribute("paciente");
    	if(pac.getExamen_linea()>=3 && pac.getEstado()==3){	
    %>

    

    
	
    
    <% 
    CDataExam dbo=new CDataExam();
    if(dbo.Connect()){
    CAnuncio anuncio=dbo.getAnuncioEspecifico(2);
    
    ArrayList<Integer> lista_menu=dbo.ListaMenu_Categoria_Multi(pac.getIdpaciente() );
    ArrayList<CArea_Examen> list_e=dbo.getListaArea_Examen(0,1);
    Iterator<CArea_Examen> it2=list_e.iterator();
   
    String html="";		
    int check=0;
    while(it2.hasNext()){ 
    	CArea_Examen area=it2.next();
    	html+="<div class='area_examen'>"+area.getNombre().toUpperCase()+"</div>";
    				
			   html+=" <table> \n";
				ArrayList<CMenu_Categoria> lista=dbo.getListaMenu_Categoria(0,1,area.getIdarea_examen());						    
				Iterator<CMenu_Categoria> it=lista.iterator();
					    while(it.hasNext()){
							    	
			   	 html+="			    	<tr>\n";
							   for(int i=0; i<3; i++){ 
				 html+="			    	<td>\n";				   
							       		
								    			if(it.hasNext()){
										    		CMenu_Categoria menu=null;
										    		menu=it.next();
										    		String etiqueta="";
										    			if((lista_menu.indexOf(menu.getIdmenu_categoria())>-1)){
										    					etiqueta="../images/check1.png";
										    			}else{
										    				check++;
										    				etiqueta="../images/uncheck1.png";
										    			}
										    		
				
				html+="				    				<a class=\"menu\" style=\"width:220px; text-align: left;\" href=\"index.jsp?portal=10&idmenu="+menu.getIdmenu_categoria()+"&auto=0&multi=1\">\n";
				html+="							    			<img src=\""+ etiqueta+"\" />"+menu.getNombre()+"</a>\n";
											    			
											    } 
									    	
									    	
				html+="				    	</td>\n";
								    } 	
				html+="				</tr>\n";   
							    }
				html+="</table>\n";
	 } 
	 %>
	<div style="float:right;">
	<% if(check==0){ %>
	
	<form id="MainForm" name="MainForm" action="../SSiguiente" method="post">
		<input type="hidden" name="a" value="multi" />
		<input type="submit" name="siguiente" class="large button red" value="siguiente" />
	</form>
	
	<% } %>
	</div>		    
	<h2>PASO 2 / EXAMEN MULTIFASICO</h2>
	
    <% 
    	out.println("<div class='instruccion'>"+anuncio.getContenido()+"</div>");
    	out.println(html); 
    %>
    <script>
	$(function() {
		$( "a.menu").button();
		$(".siguiente").button();		
	});
	</script>
	<% 
	dbo.Close();
    	}
	
	}else{
		
		%>
			<h2>DEBE COMPLETAR EL PASO 1, PARA CONTINUAR <%= pac.getExamen_linea() %></h2>
		<%
	}	
    	
    } %>