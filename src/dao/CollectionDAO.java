package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bean.Collection;
import bean.Payment;
import bean.Post;

public class CollectionDAO extends DAO {

//	未入金signID検索
	public List<Post> search(String sessionId) throws Exception {
		List<Post> list=new ArrayList<>();

		Connection con= getConnection();

//		sql文は、idで検索をかけ、idがpaymentテーブルにないもののみ表示するようになっている。
		PreparedStatement st = con.prepareStatement(
	    	    "SELECT p.ID, p.TITLE, p.CONTENT, p.POST_DAY, " +
	    	    "       c.monetary, c.deadline, c.Transferee " +  // c_detail のカラムを追加
	    	    "FROM PUBLIC.POST p " +
	    	    "LEFT JOIN PUBLIC.PAYMENT pay ON p.ID = pay.POSTID AND pay.SIGNID = ? " +
	    	    "LEFT JOIN PUBLIC.c_detail c ON p.ID = c.postid " + // c_detail を LEFT JOIN
	    	    "WHERE p.CATEGORY_ID = 2 " +
	    	    "AND pay.SIGNID IS NULL " +
	    	    "ORDER BY c.deadline ASC NULLS LAST;"
	    	);

	        st.setString(1, sessionId);

	        ResultSet rs = st.executeQuery();

	        while (rs.next()) {
	            Post p = new Post();
	            p.setId(rs.getString("ID"));
	            p.setTitle(rs.getString("TITLE"));
	            p.setContent(rs.getString("CONTENT"));
	            p.setPost_day(rs.getDate("POST_DAY"));

		        // 追加: c_detail のデータもセット
		        p.setMonetary(rs.getInt("MONETARY"));
		        p.setDeadline(rs.getDate("DEADLINE"));
		        p.setTransferee(rs.getString("TRANSFEREE"));

	            list.add(p);
	        }
	        st.close();
	        con.close();

	        return list;
	    }

// 選択されたものを表示するためのやつ
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

//入金済み検索
	public List<Collection> Completed_search(String PostID) throws Exception {
	    List<Collection> list = new ArrayList<>();

	    Connection con = getConnection();

	    //SQL要改良？
	    PreparedStatement st = con.prepareStatement(
	    		"SELECT * " +
	    		"FROM payment AS pay " +
	    		"JOIN post AS p ON pay.postid = p.id " +
	    		"JOIN signup AS s ON pay.signid = s.id " +
	    		"JOIN c_detail AS c ON p.id = c.postid " +
	    		"WHERE p.category_id = 2 " +
//	    		ここでそれぞれ表として出すための抽出文。作り方によっては使わない。
//	    		"and pay.postid = '?'"+
	    		"AND pay.signid IS NOT NULL "+
	    		"ORDER BY CAST(paymentid AS INTEGER) ASC NULLS LAST;"
	    );

	 // デバッグ出力
	    System.out.println(st.toString());

//	    st.setString(1, Postid);

	    ResultSet rs = st.executeQuery();

	    while (rs.next()) {
	        Collection p = new Collection();
	        // ResultSetからCollectionオブジェクトにデータを設定
	        p.setPaymentID(rs.getString("paymentID"));
	        p.setDepositdate(rs.getDate("depositDate"));
	        p.setPostID(rs.getString("postID"));
	        p.setTitle(rs.getString("title"));
	        p.setPost_day(rs.getDate("post_day"));
	        p.setSignID(rs.getString("signID"));
	        p.setName(rs.getString("name"));
	        p.setDetailid(rs.getString("detailID"));
	        p.setMonetary(rs.getInt("monetary"));
	        list.add(p);
	    }
	    st.close();
	    con.close();

 // デバッグ出力
System.out.println("List size in DAO: " + list.size());


	    return list;
	}
	// 入金
	public int insert(Payment payment) throws Exception {
	    Connection con = null;
	    PreparedStatement st = null;
	    int line = 0;

	    try {
	        con = getConnection();
	        st = con.prepareStatement(
	        		"INSERT INTO payment (paymentid, postid, signid, depositdate) " +
	        	    "SELECT COALESCE(MAX(CAST(paymentid AS integer)), 0) + 1, ?, ?, CURRENT_DATE " +
	        	    "FROM payment"
	        );

	        st.setString(1, payment.getPostID());
	        st.setString(2, payment.getSignID());

	        line = st.executeUpdate();
	    } catch (SQLException e) {
	        // ログにエラーを記録
	        e.printStackTrace();
	        throw new Exception("Database error: " + e.getMessage());
	    } finally {
	        if (st != null) {
	            try {
	                st.close();
	            } catch (SQLException e) {
	                e.printStackTrace();
	            }
	        }
	        if (con != null) {
	            try {
	                con.close();
	            } catch (SQLException e) {
	                e.printStackTrace();
	            }
	        }
	    }

	    return line;
	}
}
