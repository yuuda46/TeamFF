package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import bean.C_detail;

public class C_detailDAO extends DAO {


	    public int insert(C_detail detail) throws Exception {
	        Connection con = getConnection();
	        PreparedStatement st = con.prepareStatement(
	            "INSERT INTO c_detail (detailid, postid, monetary, deadline, transferee) "
	                + "VALUES (?, ?, ?, ?, ?)"
	        );

	        // パラメータをセット
	        st.setString(1, detail.getDetailid());
	        st.setString(2, detail.getPostid());
	        st.setObject(3, detail.getMonetary()); // monetaryはnullの可能性があるためsetObjectを使用
	        st.setDate(4, detail.getDeadline());
	        st.setString(5, detail.getTransferee());

	        // データベースに挿入
	        int result = st.executeUpdate();

	        // リソースをクローズ
	        st.close();
	        con.close();

	        return result;
	    }

	}
