package notice;

import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Post2;
import dao.Postdao2;



@WebServlet("/notice/ToukouDelete.action")
public class ToukouDeleteAction extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        try {

        	//index.jspからデータを取得する
			String id = request.getParameter("items");


			if (id == null || id.isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "IDが指定されていません");
                return;
            }

			// 指定IDのデータを取得
            Postdao2 dao1 = new Postdao2();
            List<Post2> list = dao1.notice_detail(id);
            if (list == null || list.isEmpty()) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "指定された投稿が見つかりません");
                return;
            }

//			list1のサイズを取得
			int loop = list.size();

//			リストを作成
			List<String> string_times = new ArrayList<String>();

			for (int i = 0; i < loop; i++) {

//				beenからpost_dayを取得
				Timestamp timestamp = list.get(i).getPostDay();
		        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
//		        Timestamp型からString型に変換
		        String string_time = sdf.format(timestamp);
		        System.out.println(string_time);

//		        リストに入れる
		        string_times.add(string_time);
			}

			request.setAttribute("list2", list);
			request.setAttribute("items", id);
			request.setAttribute("post_day", string_times);


			 // 削除後の情報を表示するためにJSPにフォワード
            request.getRequestDispatcher("/notice/toukoudelete.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "データの保存に失敗しました");
        }
    }
}
