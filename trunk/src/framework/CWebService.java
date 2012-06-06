package framework;
import gt.edu.usac.rye.nusoap.VerificaDatosRyEPortType;
import javax.xml.rpc.Service;
import javax.xml.rpc.ServiceException;
import javax.xml.rpc.ServiceFactory;

import javax.xml.namespace.QName;

import data.CPaciente;
import data.CPacienteWebService;

import java.net.MalformedURLException;
import java.net.URL;
import java.rmi.RemoteException;

public class CWebService {
	private String usuario="200614790";
	private String password="Estud14nt3";
	private String dependencia="usalud";
	private String wsdl="http://www.registro.usac.edu.gt/WS/verificadatosRyEWebService2.php?wsdl";
	private String wsdl2="http://www.registro.usac.edu.gt/WS/consultaEstudianteRyEv2.0.php?wsdl";
	
	private String qname="http://rye.usac.edu.gt/nusoap";
	private int ciclo=2012;
	public CWebService(int year){
		this.ciclo=year;
	}
	
	private String generateDatosGenerales(String carne){
		String xml="<SOLICITUD_DATOS_RYE>"
                +" <DEPENDENCIA>"+this.dependencia+"</DEPENDENCIA> "
                +" <LOGIN>"+this.usuario+"</LOGIN> "
                +" <PWD>"+this.password+"</PWD>"
                +" <CARNET>"+carne+"</CARNET>"
                + "</SOLICITUD_DATOS_RYE>";
		return xml;
	}
	private String generateValidPin(String user, String pin){
		String xml="<VERIFICAR_PIN>"
                +" <DEPENDENCIA>"+this.dependencia+"</DEPENDENCIA> "
                +" <LOGIN>"+this.usuario+"</LOGIN> "
                +" <PWD>"+this.password+"</PWD>"
                +" <CARNET>"+user+"</CARNET> "
                +" <PIN>"+pin+"</PIN> "
                + "</VERIFICAR_PIN>";
		return xml;
	}
	private String generateValidInscripcion(CPacienteWebService pac){
		String xml="<VERIFICAR_INSCRITO>"
                +" <DEPENDENCIA>"+this.dependencia+"</DEPENDENCIA> "
                +" <LOGIN>"+this.usuario+"</LOGIN> "
                +" <PWD>"+this.password+"</PWD>"
                +" <CARNET>"+pac.getCarne()+"</CARNET>"
                +" <UNIDAD_ACADEMICA>"+pac.getCodigo_unidad()+"</UNIDAD_ACADEMICA>"
                +" <EXTENSION>"+pac.getExtension()+"</EXTENSION>"
                +" <CARRERA>"+pac.getCodigo_carrera()+"</CARRERA>"
                +" <CICLO>"+this.ciclo+"</CICLO>"
                + "</VERIFICAR_INSCRITO>";;
		return xml;
	}
	
	
	public CPaciente DatosGenerales(String carne,CDataExam dbo){
		try {
			URL url = new URL(this.wsdl2);
			QName qname = new QName(this.qname, "VerificaDatosRyE");
			ServiceFactory factory = ServiceFactory.newInstance();
	        Service        service = (Service) factory.createService(url, qname);
	        gt1.edu.usac.rye.nusoap.VerificaDatosRyEPortType servicio = (gt1.edu.usac.rye.nusoap.VerificaDatosRyEPortType) service.getPort(gt1.edu.usac.rye.nusoap.VerificaDatosRyEPortType.class);
	        String xml=servicio.datosGenerales(this.generateDatosGenerales(carne));
	        CReadXML read=new CReadXML();
	        CPacienteWebService pac=read.ReadDatosGenerales(xml,carne);
	        CPaciente paciente=this.VerificarEstudiante(pac, dbo);
	        return paciente;
	        
		} catch (MalformedURLException | ServiceException | RemoteException e) {
			//e.printStackTrace();
		}
           
		return null;
	}
	
	
	public static void main (String args[]) {
        CWebService service=new CWebService(2012);
        CPaciente pac=service.DatosGenerales(200711433+"",null);
        CDataExam exam=new CDataExam();
        exam.Connect();
        System.out.println(pac.getDireccion()+" *"+pac.getIdunidad_academica()+" ");
    }
	
	public int VerificarPin(String user, String pin){
		try {
			URL url = new URL(this.wsdl);
			QName qname = new QName(this.qname, "VerificaDatosRyE");
			ServiceFactory factory = ServiceFactory.newInstance();
	        Service        service = (Service) factory.createService(url, qname);
	        VerificaDatosRyEPortType webservice = (VerificaDatosRyEPortType) service.getPort(VerificaDatosRyEPortType.class);
	        String xml=webservice.verificaPIN(this.generateValidPin(user, pin));
	        CReadXML rxml= new CReadXML();
	        int result=rxml.status_verificar_pin(xml);
	        return result;
		} catch (MalformedURLException | ServiceException | RemoteException e) {
			//e.printStackTrace();
		}
           
		return 0;
	}
	public CPaciente VerificarEstudiante(CPacienteWebService carne,CDataExam dbo){
		try {
			if(carne!=null){
					URL url = new URL(this.wsdl);
					QName qname = new QName(this.qname, "VerificaDatosRyE");
					ServiceFactory factory = ServiceFactory.newInstance();
			        Service        service = (Service) factory.createService(url, qname);
			        VerificaDatosRyEPortType webservice = (VerificaDatosRyEPortType) service.getPort(VerificaDatosRyEPortType.class);
			        String xml=webservice.verificaNuevos( generateValidInscripcion(carne));
			        CReadXML rxml= new CReadXML();
			        CPaciente result=rxml.verificar_Inscrito(xml,dbo,carne);
			        return result;
			}      
		} catch (MalformedURLException | ServiceException | RemoteException e) {
			//e.printStackTrace();
		}
           
		return null;
	}
	
}
