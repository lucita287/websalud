<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
    <%@ page import="framework.CDataExam" %>
    <%@ page import="data.CUsuarioPermiso" %>
    <%@ page import="data.CConfiguracion_Examen" %>
    <%@ page import="data.CConfiguracion" %>
    <%@ page import="java.util.ArrayList" %>
<%

HttpSession sessiones = request.getSession(false);
if(sessiones!=null &&  sessiones.getAttribute("user_permiso")!=null){
	CUsuarioPermiso user_permiso=(CUsuarioPermiso)sessiones.getAttribute("user_permiso");
	
		if (user_permiso.getIdpermiso().indexOf(255)>-1  || user_permiso.getIdusuario().getidusuario()==1){
			CDataExam dbo=new CDataExam();
			if(dbo.Connect()){
				CConfiguracion config2=dbo.getConfiguracion();
			ArrayList<CConfiguracion_Examen> lista=dbo.getListaConfiguracion_Examen();		
%>
    <div id="dialog-message" title="Mensaje de Informaci&oacute;n"></div>
    
			<h2>CATEGORIZACI&Oacute;N SEG&Uacute;N <%= config2.getRandom_carne()==0?"RANDOM":"CARNE" %></h2>
			<h2>PARA EL CICLO <%= config2.getCiclo() %> </h2>
			<style>
				.titulo { text-transform:uppercase; font-size:15px; }
			</style>
			<table>
				<tr>
					<% CConfiguracion_Examen config1=lista.get(0); %>
					<td><div class="titulo">Finalizan con 0</div></td>
						<td>
								<select id="carne0" name="carne0" >
										<option value="1"  <%= config1.getTipo_examen()==1?"selected":"" %> >AutoEvaluacion</option>
										<option value="2"  <%= config1.getTipo_examen()==1?"":"selected" %> >Multif&aacute;sico</option>
								</select>
						</td>
				</tr>
				<tr>	
					<td><div class="titulo">Finalizan con 1</div></td>
						<td>
						<% config1=lista.get(1); %>
							<select id="carne1" name="carne1" >
										<option value="1"  <%= config1.getTipo_examen()==1?"selected":"" %> >AutoEvaluacion</option>
										<option value="2"  <%= config1.getTipo_examen()==1?"":"selected" %> >Multif&aacute;sico</option>
								
								</select>
						</td>
				</tr>
				<tr>	
					<td><div class="titulo">Finalizan con 2</div></td>
						<td>
						<% config1=lista.get(2); %>
							<select id="carne2" name="carne2" >
										<option value="1"  <%= config1.getTipo_examen()==1?"selected":"" %> >AutoEvaluacion</option>
										<option value="2"  <%= config1.getTipo_examen()==1?"":"selected" %> >Multif&aacute;sico</option>
								</select>
						</td>
				</tr>
				<tr>	
					<td><div class="titulo">Finalizan con 3</div></td>
						<td>
						<% config1=lista.get(3); %>
							<select id="carne3" name="carne3" >
										<option value="1"  <%= config1.getTipo_examen()==1?"selected":"" %> >AutoEvaluacion</option>
										<option value="2"  <%= config1.getTipo_examen()==1?"":"selected" %> >Multif&aacute;sico</option>
								</select>
						</td>
				</tr>
				<tr>	
					<td><div class="titulo">Finalizan con 4</div></td>
						<td>
							<% config1=lista.get(4); %>
							<select id="carne4" name="carne4" >
										<option value="1"  <%= config1.getTipo_examen()==1?"selected":"" %> >AutoEvaluacion</option>
										<option value="2"  <%= config1.getTipo_examen()==1?"":"selected" %> >Multif&aacute;sico</option>
								</select>
						</td>
				</tr>
				<tr>	
					<td><div class="titulo">Finalizan con 5</div></td>
						<td>
							<% config1=lista.get(5); %>
							<select id="carne5" name="carne5" >
										<option value="1"  <%= config1.getTipo_examen()==1?"selected":"" %> >AutoEvaluacion</option>
										<option value="2"  <%= config1.getTipo_examen()==1?"":"selected" %> >Multif&aacute;sico</option>
								</select>
						</td>
				</tr>
				<tr>	
					<td><div class="titulo">Finalizan con 6</div></td>
						<td>
							<% config1=lista.get(6); %>
							<select id="carne6" name="carne6" >
										<option value="1"  <%= config1.getTipo_examen()==1?"selected":"" %> >AutoEvaluacion</option>
										<option value="2"  <%= config1.getTipo_examen()==1?"":"selected" %> >Multif&aacute;sico</option>
								</select>
						</td>
				</tr>
				<tr>	
					<td><div class="titulo">Finalizan con 7</div></td>
						<td>
							<% config1=lista.get(7); %>
							<select id="carne7" name="carne7" >
										<option value="1"  <%= config1.getTipo_examen()==1?"selected":"" %> >AutoEvaluacion</option>
										<option value="2"  <%= config1.getTipo_examen()==1?"":"selected" %> >Multif&aacute;sico</option>
								</select>
						</td>
				</tr>
				<tr>	
					<td><div class="titulo">Finalizan con 8</div></td>
						<td>
							<% config1=lista.get(8); %>
							<select id="carne8" name="carne8" >
										<option value="1"  <%= config1.getTipo_examen()==1?"selected":"" %> >AutoEvaluacion</option>
										<option value="2"  <%= config1.getTipo_examen()==1?"":"selected" %> >Multif&aacute;sico</option>
								</select>
						</td>
				</tr>
				<tr>	
					<td><div class="titulo">Finalizan con 9</div></td>
						<td>
							<% config1=lista.get(9); %>
							<select id="carne9" name="carne9" >
										<option value="1"  <%= config1.getTipo_examen()==1?"selected":"" %> >AutoEvaluacion</option>
										<option value="2"  <%= config1.getTipo_examen()==1?"":"selected" %> >Multif&aacute;sico</option>
								</select>
						</td>
				</tr>
			</table>
								<div class="center_button">
													<a href="#" onclick="Guardar()" class="ui-state-default ui-corner-all buttonsave" > <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>
													
								</div>
			
			<script>
					  function Guardar(){
						  cadena = 'carne0='   +$("#carne0").val()+"&";
						  cadena = cadena +'carne1='   + $("#carne1").val()+"&";
						  cadena = cadena +'carne2='   + $("#carne2").val()+"&";
						  cadena = cadena +'carne3='   + $("#carne3").val()+"&";
						  cadena = cadena +'carne4='   + $("#carne4").val()+"&";
						  cadena = cadena +'carne5='   + $("#carne5").val()+"&";
						  cadena = cadena +'carne6='   + $("#carne6").val()+"&";
						  cadena = cadena +'carne7='   + $("#carne7").val()+"&";
						  cadena = cadena +'carne8='   + $("#carne8").val()+"&";
						  cadena = cadena +'carne9='   + $("#carne9").val()+"&";
						  cadena = cadena + "a=GuardarCarne";
							 
							$.ajax({
						        url: "../SConfiguracion",
						        data: cadena,
						  	    type: 'post',
						        dataType: 'json',
						        success: function(data){
						        	mensaje(data.mensaje);
						        }
						    });
						 
					 }
					  $(function() {
							$( ".buttonsave" ).button();
						});
			</script>	
<%		 dbo.Close(); }	} } %>	