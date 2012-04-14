<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataExam" %>  
<%@ page import="data.CPaciente" %>
<%@ page import="data.CDependencia" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Iterator" %>    

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
    <div id="dato_personal" class="ui-widget-content ui-corner-all">
	<h3 class="ui-state-default ui-corner-all">Estatus del trabajador</h3>
		<div class="perfil">
					<div class="tabla">
						<div class="border">
							
									<div class="col_titulo">No de personal</div>
									<div class="col"><input type="text" size="40"/></div>
									
							<div style="clear: both;"></div>
						</div>
						<div class="border">
							
									<div class="col_titulo">Dependencia</div>
									<div class="col">
									
									<select id="dependencia" name="dependencia" class="mselect">
												<option value="0">SELECCIONE LA DEPENDENC&Iacute;A</option>	
												<%
													Iterator<CDependencia> it4=lista_dep.iterator();
													while (it4.hasNext()) {
														CDependencia car=it4.next();
															out.println("<option value=\""+car.getIddependencia()+"\">"+car.getNombre()+"</option>");
													    }
												%>
										</select>
									
									</div>
									
							<div style="clear: both;"></div>
						</div>
					</div>
		</div>				
	
	<div style="clear: both;"></div>
	</div>
<%	data.Close(); } %>	