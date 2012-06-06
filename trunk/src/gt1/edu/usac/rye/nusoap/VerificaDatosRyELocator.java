/**
 * VerificaDatosRyELocator.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package gt1.edu.usac.rye.nusoap;

public class VerificaDatosRyELocator extends org.apache.axis.client.Service implements gt1.edu.usac.rye.nusoap.VerificaDatosRyE {

    public VerificaDatosRyELocator() {
    }


    public VerificaDatosRyELocator(org.apache.axis.EngineConfiguration config) {
        super(config);
    }

    public VerificaDatosRyELocator(java.lang.String wsdlLoc, javax.xml.namespace.QName sName) throws javax.xml.rpc.ServiceException {
        super(wsdlLoc, sName);
    }

    // Use to get a proxy class for VerificaDatosRyEPort
    private java.lang.String VerificaDatosRyEPort_address = "http://www.registro.usac.edu.gt/WS/consultaEstudianteRyEv2.0.php";

    public java.lang.String getVerificaDatosRyEPortAddress() {
        return VerificaDatosRyEPort_address;
    }

    // The WSDD service name defaults to the port name.
    private java.lang.String VerificaDatosRyEPortWSDDServiceName = "VerificaDatosRyEPort";

    public java.lang.String getVerificaDatosRyEPortWSDDServiceName() {
        return VerificaDatosRyEPortWSDDServiceName;
    }

    public void setVerificaDatosRyEPortWSDDServiceName(java.lang.String name) {
        VerificaDatosRyEPortWSDDServiceName = name;
    }

    public gt1.edu.usac.rye.nusoap.VerificaDatosRyEPortType getVerificaDatosRyEPort() throws javax.xml.rpc.ServiceException {
       java.net.URL endpoint;
        try {
            endpoint = new java.net.URL(VerificaDatosRyEPort_address);
        }
        catch (java.net.MalformedURLException e) {
            throw new javax.xml.rpc.ServiceException(e);
        }
        return getVerificaDatosRyEPort(endpoint);
    }

    public gt1.edu.usac.rye.nusoap.VerificaDatosRyEPortType getVerificaDatosRyEPort(java.net.URL portAddress) throws javax.xml.rpc.ServiceException {
        try {
            gt1.edu.usac.rye.nusoap.VerificaDatosRyEBindingStub _stub = new gt1.edu.usac.rye.nusoap.VerificaDatosRyEBindingStub(portAddress, this);
            _stub.setPortName(getVerificaDatosRyEPortWSDDServiceName());
            return _stub;
        }
        catch (org.apache.axis.AxisFault e) {
            return null;
        }
    }

    public void setVerificaDatosRyEPortEndpointAddress(java.lang.String address) {
        VerificaDatosRyEPort_address = address;
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        try {
            if (gt1.edu.usac.rye.nusoap.VerificaDatosRyEPortType.class.isAssignableFrom(serviceEndpointInterface)) {
                gt1.edu.usac.rye.nusoap.VerificaDatosRyEBindingStub _stub = new gt1.edu.usac.rye.nusoap.VerificaDatosRyEBindingStub(new java.net.URL(VerificaDatosRyEPort_address), this);
                _stub.setPortName(getVerificaDatosRyEPortWSDDServiceName());
                return _stub;
            }
        }
        catch (java.lang.Throwable t) {
            throw new javax.xml.rpc.ServiceException(t);
        }
        throw new javax.xml.rpc.ServiceException("There is no stub implementation for the interface:  " + (serviceEndpointInterface == null ? "null" : serviceEndpointInterface.getName()));
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(javax.xml.namespace.QName portName, Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        if (portName == null) {
            return getPort(serviceEndpointInterface);
        }
        java.lang.String inputPortName = portName.getLocalPart();
        if ("VerificaDatosRyEPort".equals(inputPortName)) {
            return getVerificaDatosRyEPort();
        }
        else  {
            java.rmi.Remote _stub = getPort(serviceEndpointInterface);
            ((org.apache.axis.client.Stub) _stub).setPortName(portName);
            return _stub;
        }
    }

    public javax.xml.namespace.QName getServiceName() {
        return new javax.xml.namespace.QName("http://rye.usac.edu.gt/nusoap", "VerificaDatosRyE");
    }

    private java.util.HashSet ports = null;

    public java.util.Iterator getPorts() {
        if (ports == null) {
            ports = new java.util.HashSet();
            ports.add(new javax.xml.namespace.QName("http://rye.usac.edu.gt/nusoap", "VerificaDatosRyEPort"));
        }
        return ports.iterator();
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(java.lang.String portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        
if ("VerificaDatosRyEPort".equals(portName)) {
            setVerificaDatosRyEPortEndpointAddress(address);
        }
        else 
{ // Unknown Port Name
            throw new javax.xml.rpc.ServiceException(" Cannot set Endpoint Address for Unknown Port" + portName);
        }
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(javax.xml.namespace.QName portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        setEndpointAddress(portName.getLocalPart(), address);
    }

}
