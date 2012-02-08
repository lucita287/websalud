<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.io.File" %>
<%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.util.*" import="java.io.*" import="org.apache.commons.fileupload.*" import="org.apache.commons.fileupload.disk.*" import="org.apache.commons.fileupload.servlet.*" import="org.apache.commons.io.*"%>
<%

boolean isMultipart = ServletFileUpload.isMultipartContent(request);
if (!isMultipart) {

} else {

FileItemFactory factory = new DiskFileItemFactory();

ServletFileUpload upload = new ServletFileUpload(factory);

List items = null;
try {
items = upload.parseRequest(request);
} catch (FileUploadException e) {
e.printStackTrace();
}

Iterator itr = items.iterator();
String CampoAutor="";
String CampoFecha="";
String CampoNotacion="";
String CampoNombre="";
while (itr.hasNext()) 
{
FileItem item = (FileItem) itr.next();

if(item.isFormField())
{
String nombrecampo=item.getFieldName();
String valorcampo=item.getString();
if(nombrecampo.equals("autor"))
{
CampoAutor=valorcampo;
}
else
if(nombrecampo.equals("fecha"))
{
CampoFecha=valorcampo;
}
else
if(nombrecampo.equals("notacion"))
{
CampoNotacion=valorcampo; 
}
else
if(nombrecampo.equals("nombre"))
{
CampoNombre=valorcampo;
}

}
else
{
try {

String itemName = item.getName();
File savedFile = new File(config.getServletContext().getRealPath("/")+"/imagenes/"+itemName);
item.write(savedFile);


} catch (Exception e) {
e.printStackTrace();
}
} 
}

}
%>