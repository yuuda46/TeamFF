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

//				åªèÛÇÕâΩÇ‡ì¸ÇÍÇÈÇ‡ÇÃÇ™Ç†ÇËÇ‹ÇπÇÒ

			} catch (Exception e) {
				e.printStackTrace(out);
		}
			return "toukou_form.jsp";
		}
}
