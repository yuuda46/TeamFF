package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.Post;

public class PostDAO extends DAO {

  //Postテーブルの中のデータを全て取り出す
	public List<Post> all() throws Exception {
		List<Post> list=new ArrayList<>();

		Connection con=getConnection();

		PreparedStatement st=con.prepareStatement(
			"select * from post");
		ResultSet rs=st.executeQuery();

		while (rs.next()){
			Post p=new Post();
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

	public List<Post> notice() throws Exception {
		List<Post> list=new ArrayList<>();

		Connection con=getConnection();

		PreparedStatement st=con.prepareStatement(
			"select id, title, content, name, post_day from post "
			+ "where category_id is not null");
		ResultSet rs=st.executeQuery();

		while (rs.next()){
			Post p=new Post();
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

	public List<Post> notice_detail(String id) throws Exception {
		List<Post> list=new ArrayList<>();

		Connection con=getConnection();

		PreparedStatement st=con.prepareStatement(
			"select title, content, name, post_day from post "
			+ "where id = ?");

		st.setString(1, id);

		ResultSet rs=st.executeQuery();

//		System.out.println(rs);

		while (rs.next()){
			Post p=new Post();
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

	public List<Post> notice_search(Integer boot) throws Exception {
		List<Post> list=new ArrayList<>();

		Connection con=getConnection();

		PreparedStatement st=con.prepareStatement(
			"select id, title, post_day from post "
			+ "where category_id = ?");

		st.setInt(1, boot);

		ResultSet rs=st.executeQuery();

		while (rs.next()){
			Post p=new Post();
			p.setPostId(rs.getString("id"));
			p.setTitle(rs.getString("title"));
			p.setPostDay(rs.getDate("post_day"));

			list.add(p);
		}

		st.close();
		con.close();

		return list;
	}

	public int insert(Post post) throws Exception {

		Connection con=getConnection();
		PreparedStatement st=con.prepareStatement(
				"insert into post (id,title,content,name,post_day,category_id)"
				+ "values(?,?,?,?,?,?)");

		st.setString(1, post.getPostId());
		st.setString(2, post.getTitle());
		st.setString(3, post.getContent());
		st.setString(4, post.getName());
		st.setDate(5, post.getPostDay());
		st.setInt(6, post.getCategoryId());

		int line= st.executeUpdate();

		st.close();
		con.close();

		return line;
	}

	public int delete(String post_id) throws Exception {

		Connection con=getConnection();
		PreparedStatement st=con.prepareStatement(
				"delete from post where id=?");

		st.setString(1, post_id);
		int line=st.executeUpdate();
		st.close();
		con.close();
		return line;
		}

	public int picture_update(Post post) throws Exception {

		Connection con=getConnection();
		PreparedStatement st=con.prepareStatement(
				 "update post set "
				+ "content = ?,"
				+ "post_day = ?"
				+ "where id = ?");

		st.setString(1, post.getPostId());
		st.setString(2, post.getContent());
		st.setDate(3, post.getPostDay());
		int line= st.executeUpdate();

		st.close();
		con.close();
		return line;
	}

	public int notice_update(Post post) throws Exception {

		Connection con=getConnection();
		PreparedStatement st=con.prepareStatement(
				 "update post set "
				+ "title = ?,"
				+ "name = ?,"
				+ "category_id = ?,"
				+ "post_day = ?"
				+ "where id = ?");

		System.out.println("asdf");

		st.setString(1, post.getTitle());
		st.setString(2, post.getName());
		st.setInt(3, post.getCategoryId());
		st.setDate(4, post.getPostDay());
		st.setString(5, post.getPostId());
		int line= st.executeUpdate();

		st.close();
		con.close();
		return line;
	}

	public List<Post> admin_search(Integer boot) throws Exception {
		List<Post> list=new ArrayList<>();

		Connection con=getConnection();

		PreparedStatement st=con.prepareStatement(
			"select * from post "
			+ "where category_id = ?");

		st.setInt(1, boot);

		ResultSet rs=st.executeQuery();

		while (rs.next()){
			Post p=new Post();
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
}
