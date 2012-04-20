package servlet_estudiantes;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.File;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import framework.CDataBase;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRExporterParameter;
import net.sf.jasperreports.engine.JRParameter;
import net.sf.jasperreports.engine.JRRuntimeException;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.export.JRHtmlExporter;
import net.sf.jasperreports.engine.export.JRHtmlExporterParameter;
import net.sf.jasperreports.engine.util.JRLoader;
import net.sf.jasperreports.engine.util.SimpleFileResolver;
import net.sf.jasperreports.j2ee.servlets.ImageServlet;


/**
 * Servlet implementation class SGenerateReport
 */
@WebServlet("/SGenerateReport")
public class SGenerateReport extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SGenerateReport() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		
		
		
		
		
		
		HttpSession session=request.getSession(false);
			response.setHeader( "Content-disposition","inline; filename=\"" + request.getParameter("report_name")+".html" + "\"" );
			response.setContentType("text/html");
			response.setCharacterEncoding("utf-8");
			PrintWriter out = response.getWriter();
			try{
				String realpath=getServletContext().getRealPath("/");
				File reportFile = new File(realpath+"/estudiante/report_view/"+request.getParameter("report")+".jasper");
				if (!reportFile.exists())
					throw new JRRuntimeException("El archivo "+request.getParameter("report")+".jasper no se encontro.");

				JasperReport jasperReport = (JasperReport)JRLoader.loadObject(reportFile.getPath());
			
				Map parameters = new HashMap();
				String[] params;
				params=(request.getParameter("parameters")!="") ? request.getParameter("parameters").toString().split(",") :  null;
				if(params!=null){
					String[] values=request.getParameter("values").toString().split("\\|");
					//for(int i=0; i<params.length;i++){
					//	String param=params[i];
						parameters.put("idpaciente", 1);
						parameters.put("SUBREPORT_DIR","./");
					//}
				}
				parameters.put(JRParameter.REPORT_FILE_RESOLVER, new SimpleFileResolver(new File(realpath+"estudiante/report_view/")));
				
				CDataBase db=new CDataBase();
				if(db.Connect()){
					JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport,parameters,db.getconnection());
								
					JRHtmlExporter exporter = new JRHtmlExporter();
				
					request.getSession().setAttribute(ImageServlet.DEFAULT_JASPER_PRINT_SESSION_ATTRIBUTE, jasperPrint);
					
					exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
					exporter.setParameter(JRExporterParameter.OUTPUT_WRITER, out);
					exporter.setParameter(JRHtmlExporterParameter.IMAGES_URI, "./SRimage?image=");
					exporter.setParameter(JRHtmlExporterParameter.HTML_HEADER, "<html>" +
							"<head>" +
							" 	<link rel=\"shortcut icon\" href=\"./favi.ico\" >"+
							"	<title>Unidad de Salud</title>" +
							"	<script type=\"text/javascript\">" +
							"		function ExportPDF(){ " +
							"			document.getElementById('form_report').submit();" +
							"		}	" +
							"	</script>" +
							"</head>" +
							"<body>" +
							"<div style=\"width: 100%; text-align: right; font-family: 'DejaVu Sans', Arial, Helvetica, sans-serif; font-size: 14px;\"><a href=\"#\" onclick=\"ExportPDF()\">Exportar a PDF </a></div>" +
							"<table width=\"100%\"><tr><td align=\"center\">");
					if(jasperPrint.getPages().size()>0){
						exporter.setParameter(JRHtmlExporterParameter.HTML_FOOTER,"</td></tr></table>" +
								"<form id=\"form_report\" name=\"form_report\" action=\"./SGenerateReportPDF\" method=\"post\" target=\"_blank\">"+
								  	"<input type=\"hidden\" name=\"report\" id=\"report\" value=\""+request.getParameter("report")+"\" />"+
								  	"<input type=\"hidden\" name=\"report_name\" id=\"report_name\" value=\""+request.getParameter("report_name")+"\" />"+
								  	"<input type=\"hidden\" name=\"parameters\" id=\"parameters\" value=\""+request.getParameter("parameters")+"\" />"+
								  	"<input type=\"hidden\" name=\"values\" id=\"values\" value=\""+request.getParameter("values")+"\" />"+
								  	"</form>" +
								"</body></html>");
					}
					else{
						exporter.setParameter(JRHtmlExporterParameter.HTML_FOOTER,"</td></tr></table><table width=\"100%\"><tr><td height=\"200px\" align=\"center\" valign=\"middle\" style=\"font-size: 14px; font-weight: bold; font-family: 'DejaVu Sans', Arial, Helvetica, sans-serif;\">No existe informaci&oacute;n con lo par&aacute;metros seleccionados.</td></tr></table>" +
								"<form id=\"form_report\" name=\"form_report\" action=\"#\" method=\"post\" >"+
								  	"<input type=\"hidden\" name=\"report\" id=\"report\" value=\""+request.getParameter("report")+"\" />"+
								  	"<input type=\"hidden\" name=\"report_name\" id=\"report_name\" value=\""+request.getParameter("report_name")+"\" />"+
								  	"<input type=\"hidden\" name=\"parameters\" id=\"parameters\" value=\""+request.getParameter("parameters")+"\" />"+
								  	"<input type=\"hidden\" name=\"values\" id=\"values\" value=\""+request.getParameter("values")+"\" />"+
								  	"</form>" +
								"</body></html>");
					}
					exporter.exportReport();
					db.Close();
				}
			}
			catch (JRException e)
			{
				out.println("<html>");
				out.println("<head>");
				out.println("<title>MuniVirtual - Reportes</title>");
				out.println("</head>");
				
				out.println("<body bgcolor=\"white\">");
				out.println("<span class=\"bnew\">Se ha encontrado un error en el reporte:</span>");
				out.println("<pre>");
				e.printStackTrace(out);
				out.println("</pre>");
				out.println("</body>");
				out.println("</html>");
				
			}
		
		
		
		
		
		
		
		
		
		
		
		
	}
}