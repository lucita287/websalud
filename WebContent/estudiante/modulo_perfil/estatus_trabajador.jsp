<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataExam" %>  
<%@ page import="data.CPaciente" %>
<%@ page import="data.CDependencia" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Iterator" %>   
<%@ page import="framework.CValidation" %> 
<%
	CValidation valid=new CValidation();
	Integer portal=valid.ConvertEntero(request.getParameter("portal"));
%>
<script>
var addressFormatting = function(text){
	var newText = text;
	//array of find replaces
	var findreps = [
		{find:/^([^\-]+) \- /g, rep: '<span class="ui-selectmenu-item-header">$1</span>'},
		{find:/([^\|><]+) \| /g, rep: '<span class="ui-selectmenu-item-content">$1</span>'},
		{find:/([^\|><\(\)]+) (\()/g, rep: '<span class="ui-selectmenu-item-content">$1</span>$2'},
		{find:/([^\|><\(\)]+)$/g, rep: '<span class="ui-selectmenu-item-content">$1</span>'},
		{find:/(\([^\|><]+\))$/g, rep: '<span class="ui-selectmenu-item-footer">$1</span>'}
	];
	
	for(var i in findreps){
		newText = newText.replace(findreps[i].find, findreps[i].rep);
	}
	return newText;
}
$(function(){
		$('.mselect').selectmenu({
			style:'dropdown', 
			menuWidth: 400,
			maxHeight: 150,
			format: addressFormatting
		});
});	
</script>
 <% 
HttpSession sessiones=request.getSession(false); 
if(sessiones!=null && sessiones.getAttribute("paciente")!=null){
	CPaciente pac=(CPaciente)sessiones.getAttribute("paciente");
		
	CDataExam	data=new CDataExam();
	data.Connect();
	ArrayList<CDependencia> lista_dep=data.getListaDependencia();
%>	

	<form id="MainForm" name="MainForm" action="../SDatoPersonal" method="post">

	<div style="float:left;">
	<h2>PASO 1 / OPCIONAL, SOLO PARA TRABAJADORES</h2>
	</div>
	<div class="button-sig">
	<input type="submit" id="button_sig" class="ui-state-default ui-corner-all button" value="Guardar"/> 
	</div>
	<div style="clear: both;"></div>
	<input type="hidden" id="idestatus" name="idestatus" value="<%=portal%>">
    <div id="dato_personal" class="ui-widget-content ui-corner-all">
	<h3 class="ui-state-default ui-corner-all">Estatus del trabajador</h3>
		<div class="perfil">
					<div class="tabla">
						<div class="border">
							
									<div class="col_titulo">No de personal</div>
									<div class="col"><input type="text" value="<%=pac.getNo_personal()>0? pac.getNo_personal():"" %>" size="40"/></div>
									
							<div style="clear: both;"></div>
						</div>
						<div class="border">
							
									<div class="col_titulo">Dependencia</div>
									<div class="col">
									
									<select id="depend_estudiante" name="depend_estudiante" class="mselect">
												<option value="0">SELECCIONE LA DEPENDENC&Iacute;A</option>	
												<%
													Iterator<CDependencia> it4=lista_dep.iterator();
													while (it4.hasNext()) {
														CDependencia car=it4.next();%>
															<option value="<%=car.getIddependencia()%>" <%= (car.getIddependencia()==pac.getIddependencia() ?"SELECTED":"")%> ><%=car.getNombre()%></option> 
												<%	}	%>
										</select>
									
									</div>
									
							<div style="clear: both;"></div>
						</div>
					</div>
		</div>				
	
	<div style="clear: both;"></div>
	</div>
	
	</form>
	
	
<%	data.Close(); } %>	