package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.Category;

public class CategoryDAO extends DAO {
	public List<Category> all() throws Exception {
		List<Category> list=new ArrayList<>();

		Connection con=getConnection();

		PreparedStatement st=con.prepareStatement(
			"select * from category");

		ResultSet rs=st.executeQuery();

		while(rs.next()){
			Category p=new Category();
			p.setCategoryId(rs.getInt("id"));
			p.setCategoryName(rs.getString("name"));

			list.add(p);
		}
		st.close();
		con.close();

		return list;
	}

	public List<Category> category_upload(Integer num) throws Exception {
		List<Category> list=new ArrayList<>();

		Connection con=getConnection();

		PreparedStatement st=con.prepareStatement(
				"select name from category "
				+ "where id = ?");

		st.setInt(1, num);

		ResultSet rs=st.executeQuery();

		while (rs.next()){
			Category p=new Category();
			p.setCategoryName(rs.getString("name"));

			list.add(p);
		}

		st.close();
		con.close();

		return list;
	}
}
