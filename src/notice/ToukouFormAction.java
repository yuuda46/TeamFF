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
	            // �G���[�����������ꍇ�̏���
	            out.println("<html><body>");
	            out.println("<h3>�G���[���������܂����B������x���������������B</h3>");
	            out.println("<p>�ڍ�: " + e.getMessage() + "</p>");
	            out.println("</body></html>");
	            e.printStackTrace(out); // �G���[���O���o��
		}
			return "toukou_form.jsp";
		}
}
