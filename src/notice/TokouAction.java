package notice;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Post2;
import dao.Postdao2;
import tool.Action;

public class TokouAction extends Action {
    public String execute(
        HttpServletRequest request, HttpServletResponse response
    ) throws ServletException, IOException {

        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            // 投稿削除対象の投稿IDを取得
            String postId = request.getParameter("items");
            if (postId != null && !postId.isEmpty()) {
                // 投稿削除処理
                Postdao2 dao = new Postdao2();
                List<Post2> list = dao.delete(postId); // deleteメソッドで投稿を削除

                // 削除後の投稿情報をリクエスト属性にセット
                request.setAttribute("list2", list);

                // 投稿削除後、投稿一覧ページにリダイレクト
                response.sendRedirect("../notice/Tokou.action");
                return null; // リダイレクト後は処理を終了
            }
//            // コメント削除対象のコメントIDを取得
//            String commentIdParam = request.getParameter("commentId");
//            if (commentIdParam != null && !commentIdParam.isEmpty()) {
//                // コメント削除処理
//                int commentId = Integer.parseInt(commentIdParam);
//                Postdao2 dao = new Postdao2();
//
//                // コメントを削除
//                dao.deleteComment(commentId); // deleteCommentメソッドを呼び出してコメントを削除
//
//                // 削除後の投稿情報を再取得
//                List<Post2> list = dao.tokou();
//                request.setAttribute("list2", list);
//
//                // 削除後の投稿一覧ページにリダイレクト
//                response.sendRedirect("../notice/Tokou.action");
//                return null; // リダイレクト後は処理を終了
//            }

            // 投稿一覧を表示する処理
            Postdao2 dao = new Postdao2();
            List<Post2> list = dao.tokou();

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
            request.setAttribute("post_day", string_times);

        } catch (Exception e) {
            e.printStackTrace(out);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "エラーが起きました");
        }
        return "../common/index.jsp"; // 投稿一覧を表示
    }
}
