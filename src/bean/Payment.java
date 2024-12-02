package bean;

import java.util.Date;

public class Payment {


	private String paymentID ;
	private String postID ;
	private String signID ;
	private Date depositDate ;


	public String getPaymentID() {
		return paymentID;
	}
	public void setPaymentID(String paymentID) {
		this.paymentID = paymentID;
	}

	public String getPostID() {
		return postID;
	}
	public void setPostID(String postID) {
		this.postID = postID;
	}

	public String getSignID() {
		return signID;
	}
	public void setSignID(String signID) {
		this.signID = signID;
	}

	public Date getDepositDate() {
		return depositDate;
	}
	public void setDepositDate(Date depositDate) {
		this.depositDate = depositDate;
	}


}
