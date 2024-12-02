package notice;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tool.Action;

public class UpdatePermissionAction extends Action {
	public String execute (
		HttpServletRequest request, HttpServletResponse response
		) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out=response.getWriter();
		try{
			String post_id=request.getParameter("post_id");

//			アトリビュートの中に入れるやつ
			request.setAttribute("post_id", post_id);
		}
		catch (Exception e) {
			e.printStackTrace(out);
		}
		return "update_permission.jsp";
	}
}
