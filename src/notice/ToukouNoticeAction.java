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
			//toukou.jsp����f�[�^���擾����
			String id = request.getParameter("items");

			if (id == null || id.isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID���w�肳��Ă��܂���");
                return null;
            }

            // �w��ID�̃f�[�^���擾
			Postdao2 dao=new Postdao2();
			List<Post2> list=dao.notice_detail(id);

			Postdao2 com=new Postdao2();
			//System.out.println("w");
			List<Comment> list4=com.come(id);
			request.setAttribute("comment", list4);
			// �R�����g�p���X�g
			//System.out.println("o-");
			// JSP�Ƀ��X�g��n��
			request.setAttribute("list2", list);

			// �f�[�^�����N�G�X�g�����ɐݒ�
            request.setAttribute("content", list);
			request.setAttribute("items", id);//�@�q�h�D��

			//System.out.println(id);
		}catch (Exception e) {
			e.printStackTrace(out);
			 response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "�f�[�^�̎擾���ɃG���[���������܂���");
		}
		//toukou2.jsp�Ƀf�[�^�𑗐M
		return "toukou2.jsp";
	}
}

