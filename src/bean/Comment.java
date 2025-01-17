package bean;


public class Comment {
    private String user_id;
    private String comment_id;
    private String proposal;
    private String time;
    private String user_name;


    public String getUser_id() {
        return user_id;
    }

    public String getComment_id() {
        return comment_id;
    }

    public String getProposal() {
        return proposal;
    }

    public String getTime() {
        return time;
    }

    public String getUser_name() {
        return user_name;
    }




	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public void setComment_id(String comment_id) {
		this.comment_id = comment_id;
	}

    public void setProposal(String proposal) {
        this.proposal = proposal;
    }


    public void setTime(String time) {
        this.time = time;
    }

    public void setUser_name(String user_name) {
        this.user_name = user_name;
    }

}