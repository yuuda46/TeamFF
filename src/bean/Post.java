package bean;

import java.sql.Date;

public class Post {
	private String post_id;
	private String title;
	private String content;
	private String name;
	private Date post_day;
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
	public Date getPostDay() {
		return post_day;
	}
	public int getCategoryId() {
		return category_id;
	}


	public void setPostId(String id){
		this.post_id=id;
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
	public void setPostDay(Date post_day){
		this.post_day=post_day;
	}
	public void setCategoryId(int category_id){
		this.category_id=category_id;
	}
  }
