package notice;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tool.Action;

public class ToukouUploadAction extends Action {
	public String execute(
		HttpServletRequest request, HttpServletResponse response
		) throws ServletException,IOException {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out=response.getWriter();

		try{

		String title=request.getParameter("title");
		System.out.println(title);
		String name=request.getParameter("name");
		System.out.println(name);

//		テキストエリアの入力内容を取得
		String content = request.getParameter("content");

		System.out.println("Received Content: " + content);

//		改行をHTML用に変換
		String indent_content = content.replace("\n", "<br>");

		PrintWriter out2= response.getWriter();
        out2.println("<html><body>");
        out2.println("<h1>送信内容</h1>");
        out2.println("<p>" + indent_content + "</p>");
        out2.println("</body></html>");

        request.setAttribute("title", title);
        request.setAttribute("name", name);
        request.setAttribute("content", indent_content);

		} catch (Exception e) {
		e.printStackTrace(out);
	}
		return "toukou_result.jsp";
	}

}
