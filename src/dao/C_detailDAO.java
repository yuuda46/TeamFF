package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.C_detail;
import bean.Post;


public class C_detailDAO extends DAO {


	    public int insert(C_detail detail) throws Exception {
	        Connection con = getConnection();
	        PreparedStatement st = con.prepareStatement(
	            "INSERT INTO c_detail (detailid, postid, monetary, deadline, transferee, judgement) "
	                + "VALUES (?, ?, ?, ?, ?, ?)"
	        );

	        // パラメータをセット
	        st.setString(1, detail.getDetailid());
	        st.setString(2, detail.getPostid());
	        st.setObject(3, detail.getMonetary()); // monetaryはnullの可能性があるためsetObjectを使用
	        st.setDate(4, detail.getDeadline());
	        st.setString(5, detail.getTransferee());
	        st.setString(6, "true");

	        // データベースに挿入
	        int result = st.executeUpdate();

	        // リソースをクローズ
	        st.close();
	        con.close();

	        return result;
	    }
//		未入金signID検索
		public List<Post> search(String sessionId) throws Exception {
			List<Post> list=new ArrayList<>();

			Connection con= getConnection();

//			sql文は、idで検索をかけ、idがpaymentテーブルにないもののみ表示するようになっている。
			PreparedStatement st = con.prepareStatement(
		    	    "SELECT p.ID, p.TITLE, p.CONTENT, p.POST_DAY, " +
		    	    "       c.monetary, c.deadline, c.Transferee " +  // c_detail のカラムを追加
		    	    "FROM PUBLIC.POST p " +
		    	    "LEFT JOIN PUBLIC.PAYMENT pay ON p.ID = pay.POSTID AND pay.SIGNID = ? " +
		    	    "LEFT JOIN PUBLIC.c_detail c ON p.ID = c.postid " + // c_detail を LEFT JOIN
		    	    "WHERE p.CATEGORY_ID = 2 " +
		    	    "AND pay.SIGNID IS NULL "+
		    	    "ORDER BY c.judgement DESC; "

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



	}
