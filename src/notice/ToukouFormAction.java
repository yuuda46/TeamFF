package notice;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tool.Action;

public class ToukouFormAction extends Action {
	public String execute(
			HttpServletRequest request, HttpServletResponse response
			) throws ServletException,IOException {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out=response.getWriter();
			try{
			} catch (Exception e) {
	            // エラーが発生した場合の処理
	            out.println("<html><body>");
	            out.println("<h3>エラーが発生しました。もう一度お試しください。</h3>");
	            out.println("<p>詳細: " + e.getMessage() + "</p>");
	            out.println("</body></html>");
	            e.printStackTrace(out); // エラーログを出力
		}
			return "toukou_form.jsp";
		}
}
