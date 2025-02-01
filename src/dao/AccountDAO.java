package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.Account;

public class AccountDAO extends DAO {



    // ユーザーの登録を行うメソッド
    public int insert(Account signUp) throws Exception {
        Connection con = getConnection();
        PreparedStatement st = con.prepareStatement(
            "INSERT INTO SIGNUP (name, user_name, password, phone_number, email, post_code, address, id) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)"
        );

        // パラメータをセット
        System.out.println("DAO");
        st.setString(1, signUp.getName());
        st.setString(2, signUp.getUser_name());
        st.setString(3, signUp.getPassword());
        st.setString(4, signUp.getPhone_number());
        st.setString(5, signUp.getEmail());
        st.setString(6, signUp.getPost_code());
        st.setString(7, signUp.getAddress());
        st.setString(8, signUp.getId());

        // データベースに挿入
        int result = st.executeUpdate();

        st.close();
        con.close();

        return result;
    }

    // アカウントを削除するメソッド
    public int delete(Account signup) throws Exception {

        // Delete from SIGNUP table using email as the key
        Connection con1 = getConnection();
        PreparedStatement st1 = con1.prepareStatement(
                "DELETE FROM signup WHERE email = ?;"
        );

        // Set the email parameter
        st1.setString(1, signup.getEmail());
        int line = st1.executeUpdate();
        st1.close();

        con1.close();
        return line; // Return the result of the deletion
    }



     //アカウントの情報を取得
     public List<Account> all() throws Exception {
          List<Account> accountList = new ArrayList<>();
          Connection con = getConnection();

          PreparedStatement st = con.prepareStatement("SELECT * FROM SIGNUP ORDER BY CASE WHEN admini = 'true' THEN 1 ELSE 0 END DESC,user_name ASC");
          ResultSet rs = st.executeQuery();

          while (rs.next()) {

        	  Account account = new Account();
              account.setName(rs.getString("name"));
              account.setUser_name(rs.getString("user_name"));
              account.setPassword(rs.getString("password"));
              account.setPhone_number(rs.getString("phone_number"));
              account.setEmail(rs.getString("email"));
              account.setPost_code(rs.getString("post_code"));
              account.setAddress(rs.getString("address"));
              account.setAdmini(rs.getString("admini"));
              //System.out.println("YYYY");
              accountList.add(account);
            }


            st.close();
            con.close();

            return accountList;
        }

  // 特定のメールアドレスでアカウント情報を取得するメソッド
     public Account findByEmail(String email) throws Exception {
         Connection con = getConnection();
         PreparedStatement st = con.prepareStatement(
             "SELECT * FROM signup WHERE email = ?"
         );

         st.setString(1, email);
         ResultSet rs = st.executeQuery();

         Account account = null;
         if (rs.next()) {
             account = new Account();
             account.setName(rs.getString("name"));
             account.setUser_name(rs.getString("user_name"));
             account.setPassword(rs.getString("password"));
             account.setPhone_number(rs.getString("phone_number"));
             account.setEmail(rs.getString("email"));
             account.setPost_code(rs.getString("post_code"));
             account.setAddress(rs.getString("address"));
             account.setAdmini(rs.getString("admini"));
         }


         st.close();
         con.close();

         return account;
     }

  // ユーザ名の重複チェックを行うメソッド
     public boolean checkUser_nameDuplicate(String user_name) throws Exception {
         Connection con = getConnection();
         PreparedStatement st = con.prepareStatement(
             "SELECT COUNT(*) FROM SIGNUP WHERE user_name = ?"
         );
         st.setString(1, user_name);

         ResultSet rs = st.executeQuery();
         boolean exists = false;

         if (rs.next() && rs.getInt(1) > 0) {
             exists = true;
         }

         st.close();
         con.close();

         return exists;
     }

     // パスワードの重複チェックを行うメソッド
     public boolean checkPasswordDuplicate(String password) throws Exception {
         Connection con = getConnection();
         PreparedStatement st = con.prepareStatement(
             "SELECT COUNT(*) FROM SIGNUP WHERE password = ?"
         );
         st.setString(1, password);

         ResultSet rs = st.executeQuery();
         boolean exists = false;

         if (rs.next() && rs.getInt(1) > 0) {
             exists = true;
         }

         st.close();
         con.close();

         return exists;
     }

     // 電話番号の重複チェックを行うメソッド
     public boolean checkPhone_numberDuplicate(String phone_number) throws Exception {
         Connection con = getConnection();
         PreparedStatement st = con.prepareStatement(
             "SELECT COUNT(*) FROM SIGNUP WHERE phone_number = ?"
         );
         st.setString(1, phone_number);

         ResultSet rs = st.executeQuery();
         boolean exists = false;

         if (rs.next() && rs.getInt(1) > 0) {
             exists = true;
         }

         st.close();
         con.close();

         return exists;
     }

     // メールアドレスの重複チェックを行うメソッド
     public boolean checkEmailDuplicate(String email) throws Exception {
         Connection con = getConnection();
         PreparedStatement st = con.prepareStatement(
             "SELECT COUNT(*) FROM SIGNUP WHERE email = ?"
         );
         st.setString(1, email);

         ResultSet rs = st.executeQuery();
         boolean exists = false;

         if (rs.next() && rs.getInt(1) > 0) {
             exists = true;
         }

         st.close();
         con.close();

         return exists;
     }

  // メールアドレスでユーザーに管理者権限を付与するメソッド
     public int Authority(String email) throws Exception {
         Connection con = getConnection();
         PreparedStatement st = con.prepareStatement(
             "UPDATE SIGNUP SET ADMINI = 'true' WHERE EMAIL = ?"
         );
         st.setString(1, email);

         int result = st.executeUpdate();
         st.close();
         con.close();

         return result;
     }


     public int RevokeAuthority(String email) throws Exception {
         Connection con = getConnection();
         PreparedStatement st = con.prepareStatement(
             "UPDATE SIGNUP SET ADMINI = NULL WHERE EMAIL = ?"
         );
         st.setString(1, email);

         int result = st.executeUpdate();
         st.close();
         con.close();

         return result;
     }

//     ユーザーネームから指名を検索するSQL
     public List<Account>upload_name(String user_name) throws Exception {
    	 List<Account> list=new ArrayList<>();

    	 Connection con=getConnection();
    	 PreparedStatement st=con.prepareStatement(
    			 "select name from signup where user_name=?");

    	 st.setString(1, user_name);

    	 ResultSet rs=st.executeQuery();

    	 while (rs.next()){
    		 Account account=new Account();
    		 account.setName(rs.getString("name"));

    		 list.add(account);
    	 }
    	 st.close();
    	 con.close();

    	 return list;
     }

    }
