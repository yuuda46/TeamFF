package collection;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Post;
import bean.Signup;
import dao.CollectionDAO;
import tool.Action;

public class CollectionDepositCheckAction extends Action {

    public String execute(
            HttpServletRequest request, HttpServletResponse response
    ) throws ServletException, IOException {

        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            // postIdを取得
            String postId = request.getParameter("no");
            // signidも取得
            String signId = request.getParameter("signid");

            // postIdを使ってタイトル、説明を持ってきて何に入金するのかを確認する
            CollectionDAO dao = new CollectionDAO();
            List<Post> list = dao.retrieval(postId);

//			list1のサイズを取得
			int loop = list.size();

//			リストを作成
			List<String> string_times = new ArrayList<String>();

			for (int i = 0; i < loop; i++) {

//				beenからpost_dayを取得
				Timestamp timestamp = list.get(i).getPost_day();
		        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//		        Timestamp型からString型に変換
		        String string_time = sdf.format(timestamp);
		        System.out.println(string_time);

//		        リストに入れる
		        string_times.add(string_time);
			}

            // 名前も確認するためにやる
            CollectionDAO Name = new CollectionDAO();
            List<Signup> list2 = Name.nameget(signId);

            // データをjspへ
            request.setAttribute("Post", list);
            request.setAttribute("Signup", list2);
            request.setAttribute("post_day", string_times);

        } catch (Exception e) {
            e.printStackTrace(out);
        }
        return "Collection_Deposit_Check.jsp" ;
    }
}