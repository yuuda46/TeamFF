package bean;

public class Account {

	private String id;
	private String name;
	private String user_name;
	private String password;
	private String phone_number;
	private String email;
	private String address;
	private String post_code;
	private String admini;

 	public String getId() {
		return id;
	}
	public String getName() {
		return name;
	}
	public String getUser_name() {
		return user_name;
	}
	public String getPassword() {
		return password;
	}
	public String getPhone_number() {
		return phone_number;
	}
	public String getEmail() {
		return email;
	}
	public String getAddress() {
		return address;
	}
	public String getPost_code() {
		return post_code;
	}
	public String getAdmini() {
		return admini;
	}

	public void setId(String id){
		this.id=id;
	}
	public void setName(String name){
		this.name=name;
	}
	public void setUser_name(String user_name){
		this.user_name=user_name;
	}
	public void setPassword(String password){
		this.password=password;
	}
	public void setPhone_number(String phone_number){
		this.phone_number=phone_number;
	}
	public void setEmail(String email){
		this.email=email;
	}
	public void setAddress(String address){
		this.address=address;
	}
	public void setPost_code(String post_code) {
		this.post_code=post_code;

	}
	public void setAdmini(String admini) {
		this.admini=admini;

	}


}