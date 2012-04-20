<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>

<body>
<form id="form_report" name="form_report" action="../SGenerateReportPDF" method="post" target="_blank">
  	<input type="submit" value="enviar" />
  	<input type="hidden" name="report" id="report" value="Primera_parte" />
  	<input type="hidden" name="report_name" id="report_name" value="Primera_parte" />
  	<input type="hidden" name="parameters" id="parameters" value="idpaciente" />
  	<input type="hidden" name="values" id="values" value="1" />
  </form>
</body>
</html>