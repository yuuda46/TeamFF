package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import bean.Post;

public class PostDAO extends DAO {

  //Post
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
			"select post.id as post_id, title, content, post.name as post_name, post_day, category.name as category_name from post "
			+ "left join category "
			+ "on category_id = category.id "
			+ "where category_id is not null "
			+ "order by post_day desc");
		ResultSet rs=st.executeQuery();

		while (rs.next()){
			Post p=new Post();
			p.setPostId(rs.getString("post_id"));
			p.setTitle(rs.getString("title"));
			p.setContent(rs.getString("content"));
			p.setName(rs.getString("post_name"));
			p.setPostDay(rs.getDate("post_day"));
			p.setCategoryName(rs.getString("category_name"));

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
			"select title, content, post.name as post_name, post_day, category_id, category.name as category_name from post "
			+ "left join category "
			+ "on category_id = category.id "
			+ "where post.id = ?");

		st.setString(1, id);

		ResultSet rs=st.executeQuery();

//		System.out.println(rs);

		while (rs.next()){
			Post p=new Post();
			p.setTitle(rs.getString("title"));
			p.setContent(rs.getString("content"));
			p.setName(rs.getString("post_name"));
			p.setPostDay(rs.getDate("post_day"));
			p.setCategoryId(rs.getInt("category_id"));
			p.setCategoryName(rs.getString("category_name"));

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
			"select post.id as post_id, title, content, post_day, category.name as category_name from post "
			+ "left join category "
			+ "on category_id = category.id "
			+ "where category_id = ? "
			+ "order by post_day desc");

		st.setInt(1, boot);

		ResultSet rs=st.executeQuery();

		while (rs.next()){
			Post p=new Post();
			p.setPostId(rs.getString("post_id"));
			p.setTitle(rs.getString("title"));
			p.setContent(rs.getString("content"));
			p.setPostDay(rs.getDate("post_day"));
			p.setCategoryName(rs.getString("category_name"));

			list.add(p);
		}

		st.close();
		con.close();

		return list;
	}

	public int insert(Post post) throws Exception {

		Connection con=getConnection();
		PreparedStatement st=con.prepareStatement(
				"insert into post (id,title,content,name,post_day,category_id) "
				+ "SELECT COALESCE(MAX(CAST(id AS integer)), 0) + 1,?,?,?,?,? " +
				"from post");

		st.setString(1, post.getTitle());
		st.setString(2, post.getContent());
		st.setString(3, post.getName());
		st.setDate(4, post.getPostDay());
		st.setInt(5, post.getCategoryId());

		int line= st.executeUpdate();

		st.close();
		con.close();

		return line;
	}

	public int insert2(Post post) throws Exception {

		Connection con=getConnection();
		PreparedStatement st=con.prepareStatement(
				"insert into post (id, title, content, name, post_day, display) "
				+ "SELECT COALESCE(MAX(CAST(id AS integer)), 0) + 1,?,?,?,?,true " +
				"from post");

		st.setString(1, post.getTitle());
		st.setString(2, post.getContent());
		st.setString(3, post.getName());
		st.setDate(4, post.getPostDay());

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

		System.out.println("update in!");

		Connection con=getConnection();
		PreparedStatement st=con.prepareStatement(
				 "update post set "
				+ "content = ?,"
				+ "post_day = ?"
				+ " where id = ?");

		System.out.println("SQL complete!!");

		st.setString(1, post.getContent());
		st.setDate(2, post.getPostDay());
		st.setString(3, post.getPostId());
		int line= st.executeUpdate();

		System.out.println("update complete!!!");

		st.close();
		con.close();

		System.out.println("insert out!!!!");

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
				+ " where id = ?");

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

	public List<Post> notice_all() throws Exception {
		List<Post> list=new ArrayList<>();

		Connection con=getConnection();

		PreparedStatement st=con.prepareStatement(
			"select post.id as post_id, title, content, post.name as post_name, post_day, category_id, category.name as category_name from post "
			+ "left join category "
			+ "on category_id = category.id "
			+ "where category_id is not null");
		ResultSet rs=st.executeQuery();

		while (rs.next()){
			Post p=new Post();
			p.setPostId(rs.getString("post_id"));
			p.setTitle(rs.getString("title"));
			p.setContent(rs.getString("content"));
			p.setName(rs.getString("post_name"));
			p.setPostDay(rs.getDate("post_day"));
			p.setCategoryId(rs.getInt("category_id"));
			p.setCategoryName(rs.getString("category_name"));

			list.add(p);
		}
		st.close();
		con.close();

		return list;
	}

	public List<Post> admin_search(Integer boot) throws Exception {
		List<Post> list=new ArrayList<>();

		Connection con=getConnection();

		PreparedStatement st=con.prepareStatement(
			"select post.id as post_id, title, content, post.name as post_name, post_day, category_id, category.name as category_name from post "
			+ "left join category "
			+ "on category_id = category.id "
			+ "where category_id = ?");

		st.setInt(1, boot);

		ResultSet rs=st.executeQuery();

		while (rs.next()){
			Post p=new Post();
			p.setPostId(rs.getString("post_id"));
			p.setTitle(rs.getString("title"));
			p.setContent(rs.getString("content"));
			p.setName(rs.getString("post_name"));
			p.setPostDay(rs.getDate("post_day"));
			p.setCategoryId(rs.getInt("category_id"));
			p.setCategoryName(rs.getString("category_name"));

			list.add(p);
		}

		st.close();
		con.close();

		return list;
	}


	public void insertPost(String id, String title, String content, String user_name, Date post_day) throws Exception {
        Connection con = getConnection();
        PreparedStatement st = con.prepareStatement(
            "INSERT INTO POST (id, title, content, name, post_day) VALUES (?, ?, ?, ?, ?)");
        st.setString(1,id);
        st.setString(2,title);
        st.setString(3, content);
        st.setString(4, user_name);
        st.setTimestamp(5, new java.sql.Timestamp(post_day.getTime()));
        System.out.println("Id: " + id);
        System.out.println("title: " + title);
        System.out.println("content: " + content);
        System.out.println("name: " + user_name);
        System.out.println("post_day: " + post_day);
        st.executeUpdate();
        st.close();
        con.close();

    }
}
