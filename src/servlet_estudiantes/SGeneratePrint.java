package servlet_estudiantes;

import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRExporterParameter;
import net.sf.jasperreports.engine.JRParameter;
import net.sf.jasperreports.engine.JRPrintPage;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.engine.util.JRLoader;
import net.sf.jasperreports.engine.util.JRSaver;
import net.sf.jasperreports.engine.util.SimpleFileResolver;
import framework.CDataBase;

/**
 * Servlet implementation class SGeneratePrint
 */
@WebServlet("/SGeneratePrint")
public class SGeneratePrint extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SGeneratePrint() {
        super();
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
		response.setHeader( "Content-Disposition", "attachment; filename=\"RTitulo.pdf" + "\"" );
		response.setContentType("application/pdf");
		try{
			String realpath=getServletContext().getRealPath("/");
			File r2 = new File(realpath+"/estudiante/report_view/Rexamen_fisico.jrprint");
			File r3 = new File(realpath+"/estudiante/report_view/Rmedicina.jrprint");
			File r4 = new File(realpath+"/estudiante/report_view/Rodonto.jrprint");
			File r5 = new File(realpath+"/estudiante/report_view/Rexamen.jrprint");
			File r6 = new File(realpath+"/estudiante/report_view/rproblem.jrprint");
			
			
			
			Map<String,Object> parameters = new HashMap<String,Object>();
			//String[] params=(request.getParameter("parameters")!="") ? request.getParameter("parameters").toString().split(",") :  null;
				//String[] values=request.getParameter("values").toString().split("\\|");
			//	parameters.put("idpaciente", 1);
				//parameters.put("SUBREPORT_DIR","./");
			
			parameters.put(JRParameter.REPORT_FILE_RESOLVER, new SimpleFileResolver(new File(realpath+"/estudiante/report_view/")));
			
			CDataBase db=new CDataBase();
			if(db.Connect()){
				JasperPrint jp2 =(JasperPrint) JRLoader.loadObject(r2);
				JasperPrint jp3 =(JasperPrint) JRLoader.loadObject(r3);
				JasperPrint jp4 =(JasperPrint) JRLoader.loadObject(r4);
				JasperPrint jp5 =(JasperPrint) JRLoader.loadObject(r5);
				JasperPrint jp6 =(JasperPrint) JRLoader.loadObject(r6);
				//=JasperFillManager.fillReport(r2.getPath(), null, db.getconnection());
				List<JRPrintPage> pages = jp3 .getPages();
				for (int j = 0; j < pages.size(); j++) {
		            JRPrintPage object = (JRPrintPage)pages.get(j);
		            jp2.addPage(object);

				}
				pages = jp4 .getPages();
				for (int j = 0; j < pages.size(); j++) {
		            JRPrintPage object = (JRPrintPage)pages.get(j);
		            jp2.addPage(object);

				}
				pages = jp5 .getPages();
				for (int j = 0; j < pages.size(); j++) {
		            JRPrintPage object = (JRPrintPage)pages.get(j);
		            jp2.addPage(object);

				}
				pages = jp6 .getPages();
				for (int j = 0; j < pages.size(); j++) {
		            JRPrintPage object = (JRPrintPage)pages.get(j);
		            jp2.addPage(object);

				}

				
			
				
				
				
				JRPdfExporter exporter = new JRPdfExporter();
				exporter.setParameter(JRExporterParameter.JASPER_PRINT, jp2);
				JRSaver.saveObject(jp2, realpath+"/estudiante/report_view/PrintServiceReport.jrprint");
				System.out.println(realpath+"/estudiante/report_view/PrintServiceReport.jrprint");
				OutputStream ouputStream = response.getOutputStream();
				exporter.setParameter(JRExporterParameter.OUTPUT_STREAM, ouputStream);
				
				
				try {
					exporter.exportReport();
					
				} 
				catch (JRException e) {
					e.printStackTrace();
				}
				finally
				{
					if (ouputStream != null)
					{
						try
						{
							ouputStream.close();
						}
						catch (IOException ex)
						{
							ex.printStackTrace();
						}
					}
				}
				db.Close();
			}
		}
		catch (Throwable e)
		{
			e.printStackTrace();
		}
	}

}
