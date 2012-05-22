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
    		
    %>

    <div style="float:right;">
	<a href="index.jsp?portal=9" class="siguiente">SIGUIENTE</a>
	</div>
<h2>PASO 2 / EXAMEN MULTIF&Aacute;SICO</h2>
    
	
    
    <% 
    CDataExam dbo=new CDataExam();
    if(dbo.Connect()){
    CAnuncio anuncio=dbo.getAnuncioEspecifico(3);
    
    ArrayList<Integer> lista_menu=dbo.ListaMenu_Categoria_Multi(pac.getIdpaciente() );
    ArrayList<CArea_Examen> list_e=dbo.getListaArea_Examen();
    Iterator<CArea_Examen> it2=list_e.iterator();
    out.println("<div class='instruccion'>"+anuncio.getContenido()+"</div>");
    %>
    				
    <% while(it2.hasNext()){ 
    	CArea_Examen area=it2.next();
    		out.println("<div class='area_examen'>"+area.getNombre().toUpperCase()+"</div>");
    	%>				
    				
			    <table>
							    <%
							    ArrayList<CMenu_Categoria> lista=dbo.getListaMenu_Categoria(0,1,area.getIdarea_examen());						    
							    Iterator<CMenu_Categoria> it=lista.iterator();
							    while(it.hasNext()){
							    	
							    %>
							    	<tr>
							    	
							    	<%for(int i=0; i<3; i++){ %>
								    	<td>
								    		<%
								    		
								    			if(it.hasNext()){
										    		CMenu_Categoria menu=null;
										    		menu=it.next();
										    		if(menu.getIdmenu_categoria()==1){								    		%>
										    				<a href="index.jsp?portal=11"  style="width:220px; text-align: left;" class="siguiente">
											    	<% }else{ %>
											    			<a class="menu" style="width:220px; text-align: left;" href="index.jsp?portal=10&idmenu=<%=menu.getIdmenu_categoria()%>&auto=0&multi=1">
											    	<% } %>		
											    	
											    			<img src="<%= (lista_menu.indexOf(menu.getIdmenu_categoria())>-1)?"../images/check.png":"../images/uncheck.png" %>" />
											    			<%= menu.getNombre() %>
											    			</a>
											   <% } %> 	
									    	
									    	
								    	</td>
								    <%} %>	
							    	</tr>   
							    <%} %>
			    </table>
	<% } %>		    
    <script>
	$(function() {
		$( "a.menu").button();
		$(".siguiente").button();		
	});
	</script>
	<% 
	dbo.Close();
}	} %>