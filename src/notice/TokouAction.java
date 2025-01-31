package notice;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
//import javax.servlet.RequestDispatcher;
//import javax.servlet.http.HttpSession;

import bean.Post2;
import dao.Postdao2;
import tool.Action;

public class TokouAction extends Action {
	public String execute(
		HttpServletRequest request, HttpServletResponse response
		) throws ServletException, IOException {

		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out=response.getWriter();
		try {
			// �폜�Ώۂ̓��eID���擾
            String id = request.getParameter("items");
            System.out.println("ikiteru?" +id);
            if (id != null && !id.isEmpty()) {
                // �폜����
                Postdao2 dao = new Postdao2();
                List<Post2> list = dao.delete(id); // delete���\�b�h��Postdao2�Ŏ������Ă���Ɖ���

                // �폜��̓��e�������N�G�X�g�����ɃZ�b�g
                request.setAttribute("list2", list);

                // �폜�����������ꍇ�A���e�ꗗ�y�[�W�Ƀ��_�C���N�g
                response.sendRedirect("../notice/Tokou.action"); // �Ⴆ�΁A���e�ꗗ�y�[�W�ւ̃��_�C���N�g
                return null; // ���_�C���N�g��͏������I��
            }

			Postdao2 dao=new Postdao2();
			List<Post2> list=dao.tokou();



			// JSP
			request.setAttribute("list2", list);

		} catch (Exception e) {
	 		e.printStackTrace(out);
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "�G���[���N���܂���");
		}
		return "../common/index.jsp";
	}
}
