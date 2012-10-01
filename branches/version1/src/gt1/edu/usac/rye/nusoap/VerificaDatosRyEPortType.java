/**
 * VerificaDatosRyEPortType.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package gt1.edu.usac.rye.nusoap;

public interface VerificaDatosRyEPortType extends java.rmi.Remote {
    public java.lang.String datosGenerales(java.lang.String xmlDatos) throws java.rmi.RemoteException;
    public java.lang.String seguimiento(java.lang.String xmlDatos) throws java.rmi.RemoteException;
    public java.lang.String unidadesAcademicas(java.lang.String xmlDatos) throws java.rmi.RemoteException;
    public java.lang.String carrerasPorUnidad(java.lang.String xmlDatos) throws java.rmi.RemoteException;
    public java.lang.String expediente(java.lang.String xmlDatos) throws java.rmi.RemoteException;
}
