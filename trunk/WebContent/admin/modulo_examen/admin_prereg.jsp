<style >
	.link_page {
		font-size:85%
	}
	
</style>
<div id="tabs">
			<ul>
				<li><a class="link_page" href="#tabs-1">Encabezado de condicion</a></li>
				<li><a class="link_page" href="#tabs-2">Condicion</a></li>
				<li><a class="link_page" href="#tabs-3">And / Or</a></li>
				<li><a class="link_page" href="#tabs-4">Parentesis / Not</a></li>
				<li><a class="link_page" href="#tabs-5">Resultados</a></li>
				<li><a class="link_page" href="#tabs-6">Inicio</a></li>
			</ul>
			
			<div id="tabs-1" style="width:650px; ">
				<jsp:include page="tabla_condi.jsp" />			
				<div style="clear: both;"></div>
			</div>
			<div id="tabs-2" style="width:650px; ">
				<jsp:include page="condicion.jsp" />
				<div style="clear: both;"></div>
			</div>
			<div id="tabs-3" style="width:650px; ">
				<jsp:include page="and_or.jsp" />
				<div style="clear: both;"></div>
			</div>
			<div id="tabs-4" style="width:650px; ">
				<jsp:include page="paren.jsp" />
				<div style="clear: both;"></div>
			</div>
			<div id="tabs-5" style="width:650px; ">
				<jsp:include page="result_condicion.jsp" />
				<div style="clear: both;"></div>
			</div>
			<div id="tabs-6" style="width:650px; ">
				<jsp:include page="Inicio_condicion.jsp" />
				<div style="clear: both;"></div>
			</div>
</div>