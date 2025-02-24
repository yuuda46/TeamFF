package bean;

import java.sql.Date;
import java.sql.Timestamp;

public class Collection {

//	上からpayment、post、signup、c_detailで纏めている。
	private String paymentID ;
	private Date depositdate ;

	private String postID ;
	private String title ;
	private Timestamp post_day ;

	private String signID ;
	private String name ;

	private String detailid ;
	private int monetary ;
	private String judgement;


	public String getPaymentID() {
		return paymentID;
	}
	public void setPaymentID(String paymentID) {
		this.paymentID = paymentID;
	}

	public Date getDepositdate() {
		return depositdate;
	}
	public void setDepositdate(Date depositdate) {
		this.depositdate = depositdate;
	}


	public String getPostID() {
		return postID;
	}
	public void setPostID(String postID) {
		this.postID = postID;
	}

	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}

	public Timestamp getPost_day() {
		return post_day;
	}
	public void setPost_day(Timestamp post_day) {
		this.post_day = post_day;
	}


	public String getSignID() {
		return signID;
	}
	public void setSignID(String signID) {
		this.signID = signID;
	}

	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}


	public String getDetailid() {
		return detailid;
	}
	public void setDetailid(String detailid) {
		this.detailid = detailid;
	}

	public int getMonetary() {
		return monetary;
	}
	public void setMonetary(int monetary) {
		this.monetary = monetary;
	}
    public String getJudgement() {
        return judgement;
    }

    public void setJudgement(String judgement) {
        this.judgement = judgement;
    }

}
