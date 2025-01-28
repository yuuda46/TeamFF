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
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "IDが指定されて�ません");
                return null;
            }

            //
			Postdao2 dao=new Postdao2();
			List<Post2> list=dao.notice_detail(id);
			if (list == null || list.isEmpty()) {
                request.setAttribute("errorMessage", "�w�肳�ꂽ���e��������܂���");
                return "toukou2.jsp";  // ���e�����݂��Ȃ��ꍇ�̃G���[���b�Z�[�W
            }

			Postdao2 com=new Postdao2();
			//System.out.println("w");
			List<Comment> list4=com.come(id);
			request.setAttribute("comment", list4);
			//
			//System.out.println("o-");
			// JSP
			request.setAttribute("list2", list);

//			�Z�b�V�������烆�[�U�[�l�[�����擾
			HttpSession session = request.getSession();
			String user_name = (String) session.getAttribute("username");
			System.out.println("iwae:" + user_name);

			//
            request.setAttribute("content", list);
			request.setAttribute("items", id);//

			System.out.println(id);
		}catch (Exception e) {
			 // �\�����Ȃ��G���[�̏ꍇ
            request.setAttribute("errorMessage", "�G���[���������܂����B������x���������������B");
            e.printStackTrace(out);  // �G���[���O���o��
            return "toukou2.jsp";  // �G���[���b�Z�[�W��\�����ăt�H�[���ɖ߂�
		}
		//
		return "toukou2.jsp";
	}
}

