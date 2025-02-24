package bean;

import java.sql.Date;
import java.sql.Timestamp;

public class Post {
	private String post_id;
	private String title;
	private String content;
	private String name;
	private Timestamp post_day;
	private int category_id;
	private String category_name;

	private String id ;
	private Integer monetary;
	private Date deadline;
	private String transferee;
	private String judgement;

	public String getPost_id() {
		return post_id;
	}
	public void setPost_id(String post_id) {
		this.post_id = post_id;
	}
	public Timestamp getPost_day() {
		return post_day;
	}
	public void setPost_day(Timestamp post_day) {
		this.post_day = post_day;
	}
	public int getCategory_id() {
		return category_id;
	}
	public void setCategory_id(int category_id) {
		this.category_id = category_id;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
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
	public String getCategoryName(){
		return category_name;
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
	public void setPostDay(Timestamp post_day2){
		this.post_day=post_day2;
	}
	public void setCategoryId(int category_id){
		this.category_id=category_id;
	}
	public void setCategoryName(String name){
		this.category_name=name;
	}

	public Integer getMonetary() {
	    return monetary;
	}

	public void setMonetary(Integer monetary) {
	    this.monetary = monetary;
	}

	public Date getDeadline() {
	    return deadline;
	}

	public void setDeadline(Date deadline) {
	    this.deadline = deadline;
	}

	public String getTransferee() {
	    return transferee;
	}

	public void setTransferee(String transferee) {
	    this.transferee = transferee;
	}
    public String getJudgement() {
        return judgement;
    }

    public void setJudgement(String judgement) {
        this.judgement = judgement;
    }
  }
