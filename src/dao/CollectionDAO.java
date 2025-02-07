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
import bean.Signup;

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
	    	    "AND pay.SIGNID IS NULL;"
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

    // signidで検索する
    public List<Post> searchBySignId(String signid) throws Exception {
        List<Post> list = new ArrayList<>();

        Connection con = getConnection();

        // SQLクエリの準備
        PreparedStatement st = con.prepareStatement(
    	    "SELECT * " +
    	    "FROM PUBLIC.POST p " +
    	    "LEFT JOIN PUBLIC.PAYMENT pay ON p.ID = pay.POSTID AND pay.SIGNID = ? " +
    	    "LEFT JOIN PUBLIC.c_detail c ON p.ID = c.postid " + // c_detail を LEFT JOIN
    	    "WHERE p.CATEGORY_ID = 2 " +
    	    "AND pay.SIGNID IS NULL;"
        );

        // パラメータの設定
        st.setString(1, signid);

        // クエリの実行
        ResultSet rs = st.executeQuery();

        // 結果セットの処理
        while (rs.next()) {
            Post p = new Post();
            p.setId(rs.getString("ID"));
            p.setTitle(rs.getString("TITLE"));
            p.setContent(rs.getString("CONTENT"));
            p.setPost_day(rs.getDate("POST_DAY"));
            p.setMonetary(rs.getInt("monetary"));
            p.setDeadline(rs.getDate("deadline"));
            p.setTransferee(rs.getString("Transferee"));

            list.add(p);
        }
        st.close();
        con.close();

        return list;
    }

    public List<Signup> nameget(String signid) throws Exception {
        List<Signup> list2 = new ArrayList<>();

        Connection con = getConnection();

        PreparedStatement st = con.prepareStatement(
            "SELECT * " +
            "FROM signup " +
            "WHERE id = ?"
        );

        // パラメータの設定
        st.setString(1, signid);

        // デバッグ用にクエリとパラメータを出力
        System.out.println("Executing query: SELECT * FROM signup WHERE id = " + signid);

        // クエリの実行
        ResultSet rs = st.executeQuery();

        // 結果セットの処理
        while (rs.next()) {
            Signup n = new Signup();
            n.setId(rs.getString("ID"));
            n.setName(rs.getString("Name"));

            // デバッグ用に取得したデータを出力
            System.out.println("Retrieved Signup: ID=" + n.getId() + ", Name=" + n.getName());

            list2.add(n);
        }
        st.close();
        con.close();

        return list2;
    }
// 選択されたものを表示するためのやつ
	public List<Post> retrieval(String payment) throws Exception {
	    List<Post> list = new ArrayList<>();

	    Connection con = getConnection();

	    // SQLは、WHEREで持ってきた番号（collection_listで選択された番号）を入れて返す。
	    PreparedStatement st = con.prepareStatement(
	    	"SELECT * " +
	        "FROM POST " +
	        "JOIN c_detail ON post.id = c_detail.postid " +
	        "WHERE ID = ?"
	    );

	    st.setString(1, payment);

	    ResultSet rs = st.executeQuery();

	    while (rs.next()) {
	    	Post p = new Post();
            p.setId(rs.getString("ID"));
            p.setTitle(rs.getString("TITLE"));
            p.setContent(rs.getString("CONTENT"));
            p.setPost_day(rs.getDate("POST_DAY"));
            p.setMonetary(rs.getInt("monetary"));
            p.setDeadline(rs.getDate("deadline"));
            p.setTransferee(rs.getString("Transferee"));

	        list.add(p);
	    }
	    st.close();
	    con.close();

	    return list;
	}

	// 入金済み検索
	public List<Collection> Completed_search(String PostID) throws Exception {
	    List<Collection> list = new ArrayList<>();

	    Connection con = getConnection();

	    // SQL要改良？
	    PreparedStatement st = con.prepareStatement(
	    "SELECT pay.paymentid, pay.depositdate, pay.postid, " +
	    "p.title, p.post_day, " +
	    "s.id AS signid, s.name, " +
	    "c.detailid, c.monetary " +
	    "FROM payment AS pay " +
	    "JOIN post AS p ON pay.postid = p.id " +
	    "JOIN signup AS s ON pay.signid = s.id " +
	    "JOIN c_detail AS c ON p.id = c.postid " +
	    "WHERE p.category_id = 2 " +
	    "AND pay.signid IS NOT NULL " +
	    "AND p.id = ? " +
	    "ORDER BY CAST(pay.paymentid AS INTEGER) DESC NULLS LAST;"
	    );

	    // デバッグ出力
	    System.out.println(st.toString());

	    // PostIDパラメータを設定
	    st.setString(1, PostID);

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

	// 入金済みpostのみ検索
		public List<Collection> Completed_search_Post(String PostID) throws Exception {
		    List<Collection> list3 = new ArrayList<>();

		    Connection con = getConnection();

		    // SQL要改良？
		    PreparedStatement st = con.prepareStatement(
		    "SELECT * " +
		    "FROM post AS p " +
		    "JOIN c_detail AS c ON p.id = c.postid " +
		    "WHERE p.category_id = 2 " +
		    "and p.id = ?"
		    );

		    // デバッグ出力
		    System.out.println(st.toString());

		    // PostIDパラメータを設定
		    st.setString(1, PostID);

		    ResultSet rs = st.executeQuery();

		    while (rs.next()) {
		        Collection E = new Collection();
		        // ResultSetからCollectionオブジェクトにデータを設定

		        E.setPostID(rs.getString("postID"));
		        E.setTitle(rs.getString("title"));
		        E.setPost_day(rs.getDate("post_day"));

		        E.setDetailid(rs.getString("detailID"));
		        E.setMonetary(rs.getInt("monetary"));
		        list3.add(E);
		    }
		    st.close();
		    con.close();

		    // デバッグ出力
		    System.out.println("List size in DAO: " + list3.size());

		    return list3;
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
