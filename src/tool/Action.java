package tool;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public abstract class Action extends HttpServlet {
	public abstract String execute(
			HttpServletRequest request, HttpServletResponse response
			) throws Exception;
}
