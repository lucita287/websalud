package data;

public class CEdificio {
private int idedificio;
private String nombre;
private String direccion;
private String telefono;

/**
 * @param idedificio
 * @param nombre
 * @param direccion
 * @param telefono
 */
public CEdificio(int idedificio, String nombre, String direccion,
		String telefono) {
	this.idedificio = idedificio;
	this.nombre = nombre;
	this.direccion = direccion;
	this.telefono = telefono;
}
/**
 * @return the idedificio
 */
public int getIdedificio() {
	return idedificio;
}
/**
 * @param idedificio the idedificio to set
 */
public void setIdedificio(int idedificio) {
	this.idedificio = idedificio;
}

/**
 * @return the nombre
 */
public String getNombre() {
	return nombre;
}
/**
 * @param nombre the nombre to set
 */
public void setNombre(String nombre) {
	this.nombre = nombre;
}
/**
 * @return the direccion
 */
public String getDireccion() {
	return direccion;
}
/**
 * @param direccion the direccion to set
 */
public void setDireccion(String direccion) {
	this.direccion = direccion;
}
/**
 * @return the telefono
 */
public String getTelefono() {
	return telefono;
}
/**
 * @param telefono the telefono to set
 */
public void setTelefono(String telefono) {
	this.telefono = telefono;
}

}
