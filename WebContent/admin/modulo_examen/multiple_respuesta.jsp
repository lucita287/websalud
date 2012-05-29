<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
    <%@ page import="framework.CValidation" %>
    <%@ page import="framework.CDataExam" %>
    <%@ page import="data.CTitulo_Respuesta" %>
    <%@ page import="java.util.Iterator"%>
    <%@ page import="java.util.ArrayList"%>
    <%@ page import="data.CUsuarioPermiso" %>
<%
HttpSession sessiones = request.getSession(false);
if(sessiones!=null &&  sessiones.getAttribute("user_permiso")!=null){
	CUsuarioPermiso user_permiso=(CUsuarioPermiso)sessiones.getAttribute("user_permiso");

		if (user_permiso.getIdpermiso().indexOf(259)>-1  || user_permiso.getIdusuario().getidusuario()==1){
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
		          'cantidad_opc='+$("#cantidad_opc_pregunta").val(),
		          <%for (int i=1;i<=t;i++) { %>
		          "ponderacion<%=i%>="+$("#ponderacion<%=i%>").val(),
		          "descrip_titu<%=i%>="+$("#descrip_titu<%=i%>").val(),
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
    					Descripci&oacute;n: <input type="text" size="30" id="descrip_titu<%=i%>" name="descrip_titu<%=i%>" class="tags" />
    		    </div>
    		</div>
    <% }	}	} %>	
    	