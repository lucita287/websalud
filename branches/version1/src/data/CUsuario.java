package data;

public class CUsuario {
	private int idusuario;
	private String nombre;
	private String apellido;
	private String nick;
	private String password;
	private String telefono;
	private String email;
	private String no_personal;

	/**
	 * @return the no_personal
	 */
	public String getNo_personal() {
		return no_personal;
	}
	/**
	 * @param no_personal the no_personal to set
	 */
	public void setNo_personal(String no_personal) {
		this.no_personal = no_personal;
	}
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
	
	
	public CUsuario(int idusuario, String nombre, String apellido,String nick, String password, String telefono, String email,int estado ,String no_personal){
		this.idusuario=idusuario;
		this.nombre=nombre;
		this.apellido=apellido;
		this.nick=nick;
		this.password=password;
		this.telefono=telefono;
		this.email=email;
		this.estado=estado;
		this.no_personal=no_personal;
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

