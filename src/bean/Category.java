package bean;

public class Category {
	private int category_id;
	private String category_name;


	public int getCategoryId(){
		return category_id;
	}

	public String getCategoryName(){
		return category_name;
	}


	public void setCategoryId(int id){
		this.category_id=id;
	}
	public void setCategoryName(String name){
		this.category_name=name;
	}
}