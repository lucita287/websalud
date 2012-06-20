package servlet_estudiantes;

import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRExporterParameter;
import net.sf.jasperreports.engine.JRParameter;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.engine.util.JRLoader;
import net.sf.jasperreports.engine.util.SimpleFileResolver;
import data.CCita;
import data.CPaciente;
import framework.CDataExam;
import framework.CValidation;

/**
 * Servlet implementation class SGenerateCita
 */
@WebServlet("/SGenerateCita")
public class SGenerateCita extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SGenerateCita() {
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
		HttpSession sessiones=request.getSession(false); 
		if(sessiones!=null && sessiones.getAttribute("paciente")!=null){
			CPaciente pac=(CPaciente)sessiones.getAttribute("paciente");		
			response.setHeader( "Content-Disposition", "attachment; filename=\"CitaExamenSalud.pdf" + "\"" );
			response.setContentType("application/pdf");
			CValidation valid=new CValidation();
			try{
				String realpath=getServletContext().getRealPath("/");
				File reportFile =null;
				CDataExam db=new CDataExam();
				if(db.Connect()){
				CCita cita=db.getCita(valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idcita"))));
				
				if(cita.getTipo_examen()==2)
				reportFile = new File(realpath+"/estudiante/report_view/multi_cita.jasper");
				else reportFile = new File(realpath+"/estudiante/report_view/auto_cita.jasper");
				
				@SuppressWarnings("deprecation")
				JasperReport jasperReport = (JasperReport)JRLoader.loadObject(reportFile.getPath());
				
				Map<String,Object> parameters = new HashMap<String,Object>();
					parameters.put("idpaciente",pac.getIdpaciente() );
					parameters.put("idcita",cita.getIdcita());
					parameters.put("SUBREPORT_DIR","./");
				
				parameters.put(JRParameter.REPORT_FILE_RESOLVER, new SimpleFileResolver(new File(realpath+"/estudiante/report_view/")));
				
				
					JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport,parameters,db.getconnection());
					response.setContentType("application/pdf");

					JRPdfExporter exporter = new JRPdfExporter();
					exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
					
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
		}else{
			response.sendRedirect("index.jsp");
		}
	}

}
