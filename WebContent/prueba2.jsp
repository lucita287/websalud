
<html>
<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="AUTHOR" content="eCardMAX.com">
<meta name="keywords" content="WYSIWYG,Rich Text Editor,HTML2BBCode,BBCode2HTML,HTMLTOBBCODE,BBCODETOHTML,HTML to BBCode, BBCode to HTML,JavaScript, Java, Applet, Java Applet, Make Friend, Love, Liebe, Amour, Amore, Friendship, Cool, Music, Midi, Photos, HTML, XML, DHTML, Flash, cgi, perl script, ecard, e-card, ecards, e-cards, postcard, postcards, guestbook, search, tell-a-friend, feedback form, weeding, header footer, email, random, java, birthday, internet, congratulation, baby, computer, music, realplayer, audio, upload, download, banner, poem, animated, skin, voice recorder, greeting card, php, mysql, erotic, webmaster, customized scripts, paypal, 2checkout, bluemountain, egreetings, eletronic greeting card, Card History, software, free">
<META name="verify-v1" content="Qn0+YWD3aQIAUPGXxHS4L4N55/EfUPI0O4JW804AKOs=" />
<meta name="description" content=""> 
<title>HotEditor V4.4 - WYSIWYG to BBCode Converter (HTML to BBCode and BBCode to HTML) Support Safari</title>
</head>

<body>

<div align="center" >
	<table border="0" width="800" >
		<tr>
			<td>
			<p align="center"><b><font size="4" color="#008000">HotEditor V.4.4 works with <br>	IE, FireFox, NetScape, Opera 9x, Chrome and Safari 1.3.2 or higher</font></b><br>&nbsp;</td>
		</tr>
		<tr>
			<td><b><font face="Verdana">Preview Submit</font></b></td>
		</tr>
		<tr>
			<td><hr></td>
		</tr>
		<tr>
			<td><div id="preview_innerhtml" style="overflow:auto;height:100px;width:100%;border:2px solid #6593CF;background-color:#DBE6F3;font-family: Verdana, Tahoma, Arial;font-size:12px;"></div></td>
		</tr>
		<tr>
			<td><b><font face="Verdana">BBCode Output</font></b><br><textarea name="message" id="message" style="width:100%;height:100px;"></textarea></td>
		</tr>
	</table>
</div>

<div align="center">
	<table border="0" width="800">
		<tr>
			<td align=center>
				<style type='text/css'>@import url(styles/office2007/style.css);</style>			
				<script language="JavaScript" type="text/javascript" src="editor.js?version=4.4"></script>				
				<script language="JavaScript" type="text/javascript">
					var getdata ="[B]Test me[/B]";
					//Flag "min" will show Mini toolbar - "max" will show 2 toolbars - config inside editor.js
					Instantiate("min","editor", getdata , "600px", "200px");

					//For Vietnamese User. Edit file editor.js to enable vietnamese keyboard
					if(enable_vietnamese_keyboard==1){
						document.write("<script language=\"JavaScript\" type=\"text/javascript\" src=avim.js><\/script>");
						var hoteditor_avim_method = hot_readCookie("hoteditor_avim_method");var him_auto_checked="";var him_telex_checked="";var him_vni_checked="";var him_viqr_checked="";var him_viqr2_checked="";var him_off_checked="";if(hoteditor_avim_method=="0"){him_auto_checked="checked";}else if(hoteditor_avim_method=="1"){him_telex_checked="checked";}else if(hoteditor_avim_method=="2"){him_vni_checked="checked";}else if(hoteditor_avim_method=="3"){him_viqr_checked="checked";}else if(hoteditor_avim_method=="4"){him_viqr2_checked="checked";}else if(hoteditor_avim_method=="-1"){him_off_checked="checked";}
						document.write("<div style='width:100%;text-align:center;font-family:Verdana;font-size:11px;'><input "+him_auto_checked+" id=him_auto onclick=setMethod(0); type=radio name=viet_method> Auto :: <input "+him_telex_checked+" id=him_telex onclick=setMethod(1); type=radio name=viet_method> Telex :: <input "+him_vni_checked+" id=him_vni onclick=setMethod(2); type=radio name=viet_method> VNI :: <input "+him_viqr_checked+" id=him_viqr onclick=setMethod(3); type=radio name=viet_method> VIQR :: <input "+him_viqr2_checked+" id=him_viqr2 onclick=setMethod(4); type=radio name=viet_method> VIQR* :: <input "+him_off_checked+" id=him_off onclick=setMethod(-1); type=radio name=viet_method> Off<br><img src="+styles_folder_path+"/vietnamese_symbol.gif></div>");
					}
			
					function get_hoteditor_data(){
						setCodeOutput();
						var html_output = document.getElementById("hoteditor_html_ouput_editor").value;//Output to HTML code
						var bbcode_output=document.getElementById("hoteditor_bbcode_ouput_editor").value;//Output to BBCode
						document.getElementById("message").value = bbcode_output;
						document.getElementById("preview_innerhtml").innerHTML=html_output;
					}
					
				</script>							
			</td>
		</tr>
		<tr>
			<td align=center><font size="2"><b>DEMO </b>Insert HTML (or Text) to HotEditor - Click icons below</font><br>
				<img style="CURSOR:hand; CURSOR:Pointer" onmousedown="if(editor_type==1){WriteHTML('<img src=smileys/1.gif>','editor');}else{WriteTEXT('[IMG]smileys/1.gif[/IMG]','editor');}" src="smileys/1.gif">
				<img style="CURSOR:hand; CURSOR:Pointer" onmousedown="if(editor_type==1){WriteHTML('<img src=smileys/2.gif>','editor');}else{WriteTEXT('[IMG]smileys/2.gif[/IMG]','editor');}" src="smileys/2.gif">
				<img style="CURSOR:hand; CURSOR:Pointer" onmousedown="if(editor_type==1){WriteHTML('<img src=smileys/3.gif>','editor');}else{WriteTEXT('[IMG]smileys/3.gif[/IMG]','editor');}" src="smileys/3.gif">
			</td>
		</tr>
		<tr>
			<td align=center><a href=# onclick="get_hoteditor_data();"><b>[Submit / Preview]</b></a></td>
		</tr>
		<tr>
			<td align=center><b><font size="4">Tip:</font></b> Click icon <img src=styles/office2007/switch_richtext_on.gif> to convert BBCode to HTML or HTML to BBCode<br><br>
				<a href=index.html>Click here</a> to see 1 editor with all buttons<br>
				<a href=index_mini.html>Click here</a> to see mini editor (You can add/remove buttons by editting file editor.js)<br>
				<a href=index_2editors.html>Click here</a> to see 2 editors with all buttons on 1 page<br>
				<a href=index_rtl.html>Click here</a> to see text flow form Right To Left<br>
				<a href=phpdemo.php>Click here</a> to see PHP page Sample<br>
			</td>
		</tr>
	</table>
</div>

</body>

</html>