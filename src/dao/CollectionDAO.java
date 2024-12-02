package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.Payment;
import bean.Post;

public class CollectionDAO extends DAO {

//	未入金検索
	public List<Post> search(String sessionId) throws Exception {
		List<Post> list=new ArrayList<>();

		Connection con= getConnection();

//		sql文は、idで検索をかけ、idがpaymentテーブルにないもののみ表示するようになっている。
		PreparedStatement st = con.prepareStatement(
	            "SELECT * "
	            + "FROM PUBLIC.POST p "
	            + "LEFT JOIN PUBLIC.PAYMENT pay ON p.ID = pay.POSTID AND pay.SIGNID = ? "
	            + "WHERE p.CATEGORY_ID = 2 "
	            + "AND pay.SIGNID IS NULL;"
	        );

	        st.setString(1, sessionId);

	        ResultSet rs = st.executeQuery();

	        while (rs.next()) {
	            Post p = new Post();
	            p.setId(rs.getString("ID"));
	            p.setTitle(rs.getString("TITLE"));
	            p.setContent(rs.getString("CONTENT"));
	            p.setPost_day(rs.getDate("POST_DAY"));

	            list.add(p);
	        }
	        st.close();
	        con.close();

	        return list;
	    }

// 未入金検索
	public List<Post> retrieval(String payment) throws Exception {
	    List<Post> list = new ArrayList<>();

	    Connection con = getConnection();

	    // SQLは、WHEREで持ってきた番号（collection_listで選択された番号）を入れて返す。
	    PreparedStatement st = con.prepareStatement(
	        "SELECT ID, TITLE, CONTENT, POST_DAY FROM PUBLIC.POST WHERE ID = ?"
	    );

	    st.setString(1, payment);

	    ResultSet rs = st.executeQuery();

	    while (rs.next()) {
	        Post p = new Post();
	        p.setId(rs.getString("ID"));
	        p.setTitle(rs.getString("TITLE"));
	        p.setContent(rs.getString("CONTENT"));
	        p.setPost_day(rs.getDate("POST_DAY"));

	        list.add(p);
	    }
	    st.close();
	    con.close();

	    return list;
	}

//	入金
	public int insert(Payment payment) throws Exception {

		Connection con=getConnection();
		PreparedStatement st=con.prepareStatement(
			"INSERT INTO payment (paymentid, postid, signid, depositdate)"
			+"SELECT IFNULL(MAX(paymentid), 0) + 1, ?, ?, CURDATE()"
			+"FROM payment");

		st.setString(1, payment.getPostID());
		st.setString(2, payment.getSignID());


		int line= st.executeUpdate();
		st.close();
		con.close();

		return line;
	}


}
