package bean;

import java.sql.Date;


	public class C_detail {
	    private String detailid;
	    private String postid;
	    private Integer monetary;
	    private Date deadline;
	    private String transferee;
	    private String judgement;


	    public String getDetailid() {
	        return detailid;
	    }

	    public void setDetailid(String detailid) {
	        this.detailid = detailid;
	    }

	    public String getPostid() {
	        return postid;
	    }

	    public void setPostid(String postid) {
	        this.postid = postid;
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