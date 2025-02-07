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

import bean.Comment;
import bean.Post2;
import dao.Postdao2;
import tool.Action;

public class ToukouNoticeAction extends Action {
	public String execute(
		HttpServletRequest request, HttpServletResponse response
		) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out=response.getWriter();

		try{
			String id = request.getParameter("items");
			//System.out.println("items" + id);

			if (id == null || id.isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "IDが指定されていません");
                return null;
            }


			// コメント削除対象のコメントIDを取得
            String commentIdParam = request.getParameter("commentId");
//            System.out.println("commentIdParam" + commentIdParam);
            if (commentIdParam != null && !commentIdParam.isEmpty()) {
                // コメント削除処理
                int commentId = Integer.parseInt(commentIdParam);
                Postdao2 dao1 = new Postdao2();

                // コメントを削除
                dao1.deleteComment(commentId); // deleteCommentメソッドを呼び出してコメントを削除

                // 削除後の投稿情報を再取得
                List<Post2> list9 = dao1.tokou();
                request.setAttribute("list2", list9);

                // 削除後の投稿一覧ページにリダイレクト
                response.sendRedirect("../notice/ToukouNotice.action?items="+ id);
                return null; // リダイレクト後は処理を終了
            }


	     // Postdao2のインスタンスを作成
			Postdao2 dao=new Postdao2();
			List<Post2> list=dao.notice_detail(id);
			if (list == null || list.isEmpty()) {
                request.setAttribute("errorMessage", "指定された投稿が見つかりません");
                return "toukou2.jsp";  // 投稿が存在しない場合のエラーメッセージ
            }

//			list1のサイズを取得
			int loop = list.size();

			System.out.println(loop);

//			リストを作成
			List<String> string_times = new ArrayList<String>();

			for (int i = 0; i < loop; i++) {

////				beenからtitleを取得
//				String title = list.get(i).getTitle();
//
////				beenからcontentを取得
//				String content = list.get(i).getContent();
//
////				beenからname取得
//				String name = list.get(i).getName();

//				beenからpost_dayを取得
				Timestamp timestamp = list.get(i).getPostDay();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
//				Timestamp型からString型に変換
				String string_time = sdf.format(timestamp);
				System.out.println(string_time);

//				リストに入れる
//				string_times.add(title);
//				string_times.add(content);
//				string_times.add(name);
				string_times.add(string_time);
			}

			System.out.println(list);

			Postdao2 com=new Postdao2();
			List<Comment> list4=com.come(id);
			request.setAttribute("comment", list4);
			request.setAttribute("list2", list);
            request.setAttribute("content", list);
            request.setAttribute("content2", string_times);
			request.setAttribute("items", id);


		}catch (Exception e) {
			 // 予期しないエラーの場合
            request.setAttribute("errorMessage", "エラーが発生しました。もう一度お試しください。");
            e.printStackTrace(out);  // エラーログを出力
            return "toukou2.jsp";  // エラーメッセージを表示してフォームに戻る
		}

		return "toukou2.jsp";
	}
}

