<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataBase" %>
<%@ page import="data.CNoticia" %>
<%@ page import="java.util.ArrayList" %>
<%  
CDataBase dbo=new CDataBase();
dbo.Connect();
ArrayList<CNoticia> list_news=dbo.getNoticias();


dbo.Close();
%>

<script>

	
	$(function() {
		$(".jCarouselLite2").jCarouselLite({
		vertical: true,
		btnNext: "#next_info",
		btnPrev: "#prev_info",
		visible: 3
	});
	});
	$(function() {	
	$(".news-inicio").click(function() {

		$("#widget-info").html($(this).attr("name"));
	});
	});
	
    </script>
	<style type="text/css">
		#noticias {width:75%; float:left; }
		#news_descripcion {width:75%; float:left; }
		#news_imagen { width:35%; float:left;  }
		#feedback { font-size: 1.4em; }
		#Panel-inicio { width:90%;  padding: 0.4em; background: #fff; }
		#header-inicio {float:left; }
		#tabs1-inicio h3 { margin: 0; padding: 0.4em; text-align: center; }
		#Panel-inicio-info { width:90%;  padding: 0.4em; background: #fff; }
		#tabs1-inicio-info { width:35%; float:left; }
		#widget-info { width:50%; float:left; }
		#tabs1-inicio-info h3 { margin: 0; padding: 0.4em; text-align: center; }
		#Panel-texto { width:90%;  padding: 0.4em; background: #fff; }
		#Panel-texto h3 { margin: 0; padding: 0.4em; text-align: center; }
		.news-inicio{	width:95%; height:80px; border-style:solid; border-width:1px;	}
     </style>
     

<div id="Panel-inicio" class="ui-widget-content ui-corner-all">
						<h3 class="ui-widget-header ui-corner-all">Noticias</h3>				


			<div id="tabs1-inicio-info">
				<div class="toggler">
							
							<div class="info-noticias">
							
								<div id="prev_info">
								<h3 class="ui-state-default ui-corner-all"><img src="images/up.png" /></h3>
								</div>
								
								<div class="jCarouselLite2">
								
									<ul>

		<% 
		for(int i=0; i<list_news.size();i++){
				CNoticia temp_news=list_news.get(i);
				String sub_descrip=(temp_news.getdescripcion().length()>100)?temp_news.getdescripcion().substring(0,100):temp_news.getdescripcion();
				sub_descrip=sub_descrip+" [...]";
		%>
										<li>
										<div class="news-inicio" name="<%=temp_news.getidnoticia()%>">
												
												<div class="news-text"  >
												<b><%=temp_news.gettitulo() %></b> 
												<br/><%= sub_descrip %>
												</div>
										</div>
										<div style="clear: both;"></div>
										</li>										
		<% 
			}
		%>	
									</ul>

								</div>
								<div id="next_info">
									<h3 class="ui-state-default ui-corner-all"><img src="images/down.png" /></h3>
								</div>
								<div style="clear: both;"></div>
							</div>
							
							
					</div>
				</div>
			<% if(list_news.size()>0){ 
				CNoticia info_new=list_news.get(1);
			%>
			<div id="widget-info"> 
					<h3><%=info_new.gettitulo()%></h3>
					<div style="border-top: 1px dotted #6699CC; height: 20px; margin-top: 20px;"></div>
					<div>
					<div id="news_imagen">
					<img src="images/info.png" width="150px" height="180px">
					</div>
					<div id="news_descripcion">
						<%=info_new.getdescripcion()%>
					</div>
					</div>
			</div>
			<%} %>







<div style="clear: both;"></div>

</div>
<div style="clear: both;"></div>