package notice;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
			//
			String id = request.getParameter("items");

			if (id == null || id.isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID縺梧欠螳壹＆繧後※縺縺ｾ縺帙ｓ");
                return null;
            }

            //
			Postdao2 dao=new Postdao2();
			List<Post2> list=dao.notice_detail(id);
			if (list == null || list.isEmpty()) {
                request.setAttribute("errorMessage", "指定された投稿が見つかりません");
                return "toukou2.jsp";  // 投稿が存在しない場合のエラーメッセージ
            }

			Postdao2 com=new Postdao2();
			//System.out.println("w");
			List<Comment> list4=com.come(id);
			request.setAttribute("comment", list4);
			//
			//System.out.println("o-");
			// JSP
			request.setAttribute("list2", list);

//			セッションからユーザーネームを取得
			HttpSession session = request.getSession();
			String user_name = (String) session.getAttribute("username");
			System.out.println("iwae:" + user_name);

			//
            request.setAttribute("content", list);
			request.setAttribute("items", id);//

			System.out.println(id);
		}catch (Exception e) {
			 // 予期しないエラーの場合
            request.setAttribute("errorMessage", "エラーが発生しました。もう一度お試しください。");
            e.printStackTrace(out);  // エラーログを出力
            return "toukou2.jsp";  // エラーメッセージを表示してフォームに戻る
		}
		//
		return "toukou2.jsp";
	}
}

