/**
 * VerificaDatosRyE.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package gt.edu.usac.rye.nusoap;

import javax.jws.WebService;
import javax.jws.soap.SOAPBinding;

@WebService
@SOAPBinding(style = SOAPBinding.Style.RPC)
public interface VerificaDatosRyE extends javax.xml.rpc.Service {
    public java.lang.String getVerificaDatosRyEPortAddress();

    public gt.edu.usac.rye.nusoap.VerificaDatosRyEPortType getVerificaDatosRyEPort() throws javax.xml.rpc.ServiceException;

    public gt.edu.usac.rye.nusoap.VerificaDatosRyEPortType getVerificaDatosRyEPort(java.net.URL portAddress) throws javax.xml.rpc.ServiceException;
}
