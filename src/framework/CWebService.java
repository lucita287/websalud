package framework;
import gt.edu.usac.rye.nusoap.VerificaDatosRyEPortType;
import javax.xml.rpc.Service;
import javax.xml.rpc.ServiceException;
import javax.xml.rpc.ServiceFactory;

import javax.xml.namespace.QName;

import data.CPaciente;

import java.net.MalformedURLException;
import java.net.URL;
import java.rmi.RemoteException;

public class CWebService {
	private String usuario="200614790";
	private String password="Estud14nt3";
	private String dependencia="usalud";
	private String wsdl="http://www.registro.usac.edu.gt/WS/verificadatosRyEWebService2.php?wsdl";
	private String qname="http://rye.usac.edu.gt/nusoap";
	private int ciclo=2012;
	public CWebService(int year){
		this.ciclo=year;
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
	private String generateValidInscripcion(String carne){
		String xml="<VERIFICAR_INSCRITO>"
                +" <DEPENDENCIA>"+this.dependencia+"</DEPENDENCIA> "
                +" <LOGIN>"+this.usuario+"</LOGIN> "
                +" <PWD>"+this.password+"</PWD>"
                +" <CARNET>"+carne+"</CARNET>"
                +" <UNIDAD_ACADEMICA>08</UNIDAD_ACADEMICA>"
                +" <EXTENSION>00</EXTENSION>"
                +" <CARRERA>09</CARRERA>"
                +" <CICLO>"+this.ciclo+"</CICLO>"
                + "</VERIFICAR_INSCRITO>";;
		return xml;
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
			e.printStackTrace();
		}
           
		return 0;
	}
	public CPaciente VerificarEstudiante(String carne,CDataExam dbo){
		try {
			URL url = new URL(this.wsdl);
			QName qname = new QName(this.qname, "VerificaDatosRyE");
			ServiceFactory factory = ServiceFactory.newInstance();
	        Service        service = (Service) factory.createService(url, qname);
	        VerificaDatosRyEPortType webservice = (VerificaDatosRyEPortType) service.getPort(VerificaDatosRyEPortType.class);
	        String xml=webservice.verificaNuevos( generateValidInscripcion(carne));
	        CReadXML rxml= new CReadXML();
	        CPaciente result=rxml.verificar_Inscrito(xml,dbo);
	        
	        return result;
		} catch (MalformedURLException | ServiceException | RemoteException e) {
			e.printStackTrace();
		}
           
		return null;
	}
	
}
