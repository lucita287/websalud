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
	public CUsuario(int idusuario, String nombre, String apellido,String nick, String password, String telefono, String email, CArea areaidarea){
		this.idusuario=idusuario;
		this.nombre=nombre;
		this.apellido=apellido;
		this.nick=nick;
		this.password=password;
		this.telefono=telefono;
		this.email=email;
		this.areaidarea=areaidarea;
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
}

