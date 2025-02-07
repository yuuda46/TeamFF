package bean;

import java.sql.Timestamp;

public class Post2{
	private String post_id;
	private String title;
	private String content;
	private String name;
	private Timestamp post_day;
	private int category_id;


	public String getPostId() {
		return post_id;
	}
	public String getTitle() {
		return title;
	}
	public String getContent() {
		return content;
	}
	public String getName() {
		return name;
	}
	public Timestamp getPostDay() {
		return post_day;
	}
	public int getCategoryId() {
		return category_id;
	}


	public void setPostId(String string){
		this.post_id=string;
	}
	public void setTitle(String title){
		this.title=title;
	}
	public void setContent(String content){
		this.content=content;
	}
	public void setName(String name){
		this.name=name;
	}
	public void setPostDay(Timestamp post_day){
		this.post_day=post_day;
	}
	public void setCategoryId(int category_id){
		this.category_id=category_id;
	}
  }

