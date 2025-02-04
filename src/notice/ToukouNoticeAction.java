package notice;

import java.io.IOException;
import java.io.PrintWriter;
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

			Postdao2 com=new Postdao2();
			List<Comment> list4=com.come(id);
			request.setAttribute("comment", list4);
			request.setAttribute("list2", list);
            request.setAttribute("content", list);
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

