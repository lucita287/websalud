/**
 * VerificaDatosRyEPortType.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package gt.edu.usac.rye.nusoap;
//Service Endpoint Interface

import java.rmi.Remote;
import javax.jws.WebMethod;
import javax.jws.WebService;
import javax.jws.soap.SOAPBinding;

@WebService
@SOAPBinding(style = SOAPBinding.Style.RPC)
public interface VerificaDatosRyEPortType extends java.rmi.Remote {
    @WebMethod
    public java.lang.String verificaPIN(java.lang.String xml_verificaPIN) throws java.rmi.RemoteException;
    @WebMethod
    public java.lang.String verificaInscripcion(java.lang.String xml_verificaInscripcion) throws java.rmi.RemoteException;
    @WebMethod
    public java.lang.String verificaNuevos(java.lang.String xml_RegistraDatos) throws java.rmi.RemoteException;
}
