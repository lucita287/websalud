<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
    <%@ page import="framework.CValidation" %>
    <%@ page import="framework.CDataExam" %>
    <%@ page import="data.CTitulo_Respuesta" %>
    <%@ page import="java.util.Iterator"%>
    <%@ page import="java.util.ArrayList"%>
    <%
    CDataExam data=new CDataExam();
    data.Connect();
    ArrayList<CTitulo_Respuesta> lista=data.getListaTitulo_Respuesta();
    data.Close();
    
    CValidation valid=new CValidation();
		int t=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("cantidad")));
    %>
    <script>
	$(function() {
		var arraytext = [<%
				Iterator<CTitulo_Respuesta> it=lista.iterator();
				while(it.hasNext() ){
					CTitulo_Respuesta titulo=it.next();
					out.println("\""+titulo.getDescripcion()+"\""+((it.hasNext())?",":""));
				}
			%>];
		$( ".tags" ).autocomplete({
			source: arraytext
		});
	});
	function mensaje_cadena (){
		cadena = [ 	
		          'multiple='+$("input[name='multiple']:checked").val(),
		          <%for (int i=1;i<=t;i++) { %>
		          "ponderacion<%=i%>="+$("#ponderacion<%=i%>").val(),
		          "descrip_titu<%=i%>="+escape($("#descrip_titu<%=i%>").val()),
		          <%}%>
				].join('&');
		return cadena;
	}	
	</script>
    <%for (int i=1;i<=t;i++) { %>
    		<div class="fila">
    			<div class="col_titulo">*<%=i%>)</div>
    			<div class="col">
    					Ponderaci&oacute;n: <input type="text" size="6" id="ponderacion<%=i%>" name="ponderacion<%=i%>"/>
    					Descripci&oacute;n: <input type="text" size="40" id="descrip_titu<%=i%>" name="descrip_titu<%=i%>" class="tags" />
    		    </div>
    		</div>
    <% } %>	
    	