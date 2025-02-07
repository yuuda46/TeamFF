package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.Post2;
import bean.Comment;


public class Postdao2 extends DAO {

  //Postテーブルの中のデータを全て取り出す
	public List<Post2> all() throws Exception {
		List<Post2> list=new ArrayList<>();

		Connection con=getConnection();

		PreparedStatement st=con.prepareStatement(
			"select * from post");
		ResultSet rs=st.executeQuery();

		while (rs.next()){
			Post2 p=new Post2();
			p.setPostId(rs.getString("id"));
			p.setTitle(rs.getString("title"));
			p.setContent(rs.getString("content"));
			p.setName(rs.getString("name"));
			p.setPostDay(rs.getDate("post_day"));
			p.setCategoryId(rs.getInt("category_id"));

			list.add(p);
		}
		st.close();
		con.close();

		return list;
	}

	public List<Post2> notice() throws Exception {
		List<Post2> list=new ArrayList<>();

		Connection con=getConnection();

		PreparedStatement st=con.prepareStatement(
				"select id, title, content, name, post_day from post "
				+ "where category_id is not null");
			ResultSet rs=st.executeQuery();

		while (rs.next()){
			Post2 p=new Post2();
			p.setPostId(rs.getString("id"));
			p.setTitle(rs.getString("title"));
			p.setContent(rs.getString("content"));
			p.setName(rs.getString("name"));
			p.setPostDay(rs.getDate("post_day"));

			list.add(p);
		}
		st.close();
		con.close();

		return list;
	}

	public List<Post2> notice_search(Integer boot) throws Exception {
		List<Post2> list=new ArrayList<>();

		Connection con=getConnection();

		PreparedStatement st=con.prepareStatement(
			"select id, title, post_day from post "
			+ "where category_id = ?");

		st.setInt(1, boot);

		ResultSet rs=st.executeQuery();

		while (rs.next()){
			Post2 p=new Post2();
			p.setPostId(rs.getString("id"));
			p.setTitle(rs.getString("title"));
			p.setPostDay(rs.getDate("post_day"));

			list.add(p);
		}

		st.close();
		con.close();

		return list;
	}

	public List<Post2> tokou() throws Exception {
		List<Post2> list2=new ArrayList<>();

		Connection con=getConnection();

		PreparedStatement st=con.prepareStatement(
			"select id, title, content, name, post_day from post "
				+ "where category_id is null "
				+ "AND display = true "
				+" order by post_day desc");
		ResultSet rs=st.executeQuery();

		while (rs.next()){
			Post2 p=new Post2();
			p.setPostId(rs.getString("id"));
			p.setTitle(rs.getString("title"));
			p.setContent(rs.getString("content"));
			p.setPostDay(rs.getDate("post_day"));
			p.setName(rs.getString("name"));

			list2.add(p);
		}
		st.close();
		con.close();

		return list2;
	}

	public List<Post2> notice_detail(String id) throws Exception {
		List<Post2> list=new ArrayList<>();

		Connection con=getConnection();

		PreparedStatement st=con.prepareStatement(
			"select id, title, content, name, post_day from post "
			+ "where id = ?");

		st.setString(1, id);


		ResultSet rs=st.executeQuery();

		System.out.println(rs);

		while (rs.next()){
			Post2 p=new Post2();
			p.setPostId(rs.getString("id"));
			p.setTitle(rs.getString("title"));
			p.setContent(rs.getString("content"));
			p.setName(rs.getString("name"));
			p.setPostDay(rs.getDate("post_day"));

			list.add(p);
		}

		st.close();
		con.close();

		//System.out.println("bbb");
		//System.out.println(list);

		return list;
	}

	public List<Post2> delete(String id) throws Exception {
	    List<Post2> list = new ArrayList<>();

	    // コネクションを取得
	    Connection del = getConnection();
	    System.out.println(del);

	    // display カラムを false に更新
	    PreparedStatement st = del.prepareStatement(
	        "UPDATE post SET display = false "
	    		+" WHERE id = ?");

	    st.setString(1, id);
	    st.executeUpdate(); // UPDATEを実行

	    // 更新後のデータを再取得（削除された投稿の詳細を取得するクエリ）
	    PreparedStatement st2 = del.prepareStatement(
	        "SELECT id, title, content, name, post_day FROM post"
	    		+" WHERE id = ?");

	    st2.setString(1, id);
	    ResultSet rs = st2.executeQuery();

	    // 結果をリストに追加
	    while (rs.next()) {
	        Post2 p = new Post2();
	        p.setPostId(rs.getString("id"));
	        p.setTitle(rs.getString("title"));
	        p.setContent(rs.getString("content"));
	        p.setName(rs.getString("name"));
	        p.setPostDay(rs.getDate("post_day"));
	        list.add(p);
	    }

	    // クローズ処理
	    st.close();
	    st2.close();
	    del.close();

	    return list;
	}



	/**
	 * Product表からキーワードを検索し、該当する商品のListを返却する。
	 * @param keyword
	 * @return list<Product>
	 * @throws Exception
	 */
	public List<Post2> search(String keyword) throws Exception {
		List<Post2> list=new ArrayList<>();

		Connection con=getConnection();

		PreparedStatement st=con.prepareStatement(
				"select * from post where name like ?");
		st.setString(1, "%"+keyword+"%");
		ResultSet rs=st.executeQuery();

		while (rs.next()){
			Post2 p=new Post2();
			p.setPostId(rs.getString("post_id"));
			p.setTitle(rs.getString("title"));
			p.setContent(rs.getString("content"));
			p.setName(rs.getString("name"));
			p.setPostDay(rs.getDate("category_id"));
			list.add(p);
		}

		st.close();
		con.close();

		return list;
	}



    public void insertComment(String id, String user_id, String proposal, java.util.Date time) throws Exception {
        Connection con = getConnection();
        PreparedStatement st = con.prepareStatement(
            "INSERT INTO comment (id, user_id, proposal, time, display) VALUES (?, ?, ?, ?, true)");
        st.setString(1,id);
        st.setString(2,user_id);
        st.setString(3, proposal);
        st.setTimestamp(4, new java.sql.Timestamp(time.getTime()));

//        System.out.println("Id: " + id);
//        System.out.println("User_Id: " + user_id);
//        System.out.println("Proposal: " + proposal);
//        System.out.println("Current Time: " + time);

        st.executeUpdate();
        st.close();
        con.close();
    }
//
//
//	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//	    request.setCharacterEncoding("UTF-8");
//
//	    String proposal = request.getParameter("proposal"); // テキストエリアの内容
//	    java.util.Date time = new java.util.Date(); // 現在の日時
//
//	    try {
//	        Postdao2 dao = new Postdao2();
//	        dao.insertComment(0, , proposal, time);
//	     // 投稿内容をリクエスト属性に設定する
//	        request.setAttribute("proposal", proposal);
//	        request.setAttribute("time", time);
//	     // リダイレクトまたは、再度リクエスト属性として設定しJSPに返す処理
//	        response.sendRedirect("toukou2.jsp?");
//
//	    } catch (Exception e) {
//	        e.printStackTrace();
//	        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "データの保存に失敗しましたw");
//	    }
//	}

	public List<Comment> come(String id) throws Exception {
		List<Comment> list4=new ArrayList<>();

		Connection con=getConnection();
		PreparedStatement st=con.prepareStatement(
			"select comment.user_id, comment.id, comment.comment_id, comment.proposal, comment.time, signup.user_name from comment inner join signup on comment.user_id = signup.id"
				+ " where comment.id = ? "
				+ " AND display = true "
				+" order by time desc");

		st.setString(1, id);

		ResultSet rs=st.executeQuery();

		while (rs.next()){
			Comment p=new Comment();

			p.setUser_name(rs.getString("user_name"));
			p.setComment_id(rs.getInt("comment_id"));
			p.setProposal(rs.getString("proposal"));
			 // time列の文字列からミリ秒部分を切り捨て
		    String time = rs.getString("time");
		    if (time != null && time.length() > 19) {
		        time = time.substring(0, 19); // 'YYYY-MM-DD HH:MM:SS' の部分だけを取得
		    }
		    p.setTime(time);


			list4.add(p);

		}
		st.close();
		con.close();

		return list4;
	}

	public List<Comment> id_search(String gin, String ss) throws Exception {
		List<Comment> list=new ArrayList<>();
//a
		Connection con=getConnection();
		//select id from signupでidを取得するけどuser_nameとpasswordのおなじid
		PreparedStatement st=con.prepareStatement(
			"select id from signup "
			+ "where user_name = ? and password = ?");

		st.setString(1, gin);
		st.setString(2, ss);

		ResultSet rs=st.executeQuery();

		while (rs.next()){
			Comment p=new Comment();
			p.setUser_id(rs.getString("id"));


			list.add(p);
		}

		st.close();
		con.close();

		return list;
	}

	public List<Comment> deleteComment(int commentId) throws Exception {
	    List<Comment> list = new ArrayList<>();

	    // コネクションを取得
	    Connection con = getConnection();
	    System.out.println(con);

	    // display カラムを false に更新（コメント削除）
	    PreparedStatement st = con.prepareStatement(
	        "UPDATE comment SET display = false WHERE comment_id = ?"
	    );
	    st.setInt(1, commentId);
	    st.executeUpdate();  // コメントの非表示更新

	    // 更新後のコメントデータを再取得（削除されたコメントの詳細を取得するクエリ）
	    PreparedStatement st2 = con.prepareStatement(
	        "SELECT comment_id, proposal, time, user_id FROM comment WHERE comment_id = ?"
	    );
	    st2.setInt(1, commentId);
	    ResultSet rs = st2.executeQuery();

	    // 結果をリストに追加
	    while (rs.next()) {
	        Comment c = new Comment();
	        c.setComment_id(rs.getInt("comment_id"));
	        c.setProposal(rs.getString("proposal"));
	        c.setTime(rs.getString("time"));
	        c.setUser_id(rs.getString("user_id"));
	        list.add(c);
	    }

	    // クローズ処理
	    st.close();
	    st2.close();
	    con.close();

	    return list;
	}

	public List<Comment> comment_detail(int id) throws Exception {
		List<Comment> list=new ArrayList<>();

		Connection con=getConnection();

		PreparedStatement st=con.prepareStatement(
			"select comment_id, proposal, time from comment "
			+ "where comment_id = ?");

		st.setInt(1, id);


		ResultSet rs=st.executeQuery();

		System.out.println(rs);

		while (rs.next()){
			Comment p=new Comment();
			p.setComment_id(rs.getInt("comment_id"));
			System.out.println("aaa");
			p.setProposal(rs.getString("proposal"));
			 // time列の文字列からミリ秒部分を切り捨て
		    String time = rs.getString("time");
		    if (time != null && time.length() > 19) {
		        time = time.substring(0, 19); // 'YYYY-MM-DD HH:MM:SS' の部分だけを取得
		    }
		    p.setTime(time);


			list.add(p);
		}

		st.close();
		con.close();


		return list;
	}
}




