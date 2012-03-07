package data;

public class CUsuario {
	private int idusuario;
	private String nombre;
	private String apellido;
	private String nick;
	private String password;
	private String telefono;
	private String email;
	private CArea areaidarea;
	private int estado;
	/**
	 * @return the estado
	 */
	public int getEstado() {
		return estado;
	}
	/**
	 * @param estado the estado to set
	 */
	public void setEstado(int estado) {
		this.estado = estado;
	}
	/**
	 * @return the areaidarea
	 */
	public CArea getAreaidarea() {
		return areaidarea;
	}
	/**
	 * @param areaidarea the areaidarea to set
	 */
	public void setAreaidarea(CArea areaidarea) {
		this.areaidarea = areaidarea;
	}
	public CUsuario(int idusuario, String nombre, String apellido,String nick, String password, String telefono, String email,int estado ,CArea areaidarea){
		this.idusuario=idusuario;
		this.nombre=nombre;
		this.apellido=apellido;
		this.nick=nick;
		this.password=password;
		this.telefono=telefono;
		this.email=email;
		this.areaidarea=areaidarea;
		this.estado=estado;
	}
	public int getidusuario(){
		return this.idusuario;
	}
	public String getnombre(){
		return this.nombre;
	}
	public String getapellido(){
		return this.apellido;
	}
	public String getnick(){
		return this.nick;
	}
	public String getpassword(){
		return this.password;
	}
	public String gettelefono(){
		return this.telefono;
	}
	public String getemail(){
		return this.email;
	}
	public CArea areaidarea(){
		return this.areaidarea;
	}
	/**
	 * @param idusuario the idusuario to set
	 */
	public void setIdusuario(int idusuario) {
		this.idusuario = idusuario;
	}
	/**
	 * @param nombre the nombre to set
	 */
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	/**
	 * @param apellido the apellido to set
	 */
	public void setApellido(String apellido) {
		this.apellido = apellido;
	}
	/**
	 * @param nick the nick to set
	 */
	public void setNick(String nick) {
		this.nick = nick;
	}
	/**
	 * @param password the password to set
	 */
	public void setPassword(String password) {
		this.password = password;
	}
	/**
	 * @param telefono the telefono to set
	 */
	public void setTelefono(String telefono) {
		this.telefono = telefono;
	}
	/**
	 * @param email the email to set
	 */
	public void setEmail(String email) {
		this.email = email;
	}
}

