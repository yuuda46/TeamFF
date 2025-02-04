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

			String id = request.getParameter("items");
			//System.out.println("items" + id);

			if (id == null || id.isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID���w�肳��Ă��܂���");
                return null;
            }


			// �R�����g�폜�Ώۂ̃R�����gID���擾
            String commentIdParam = request.getParameter("commentId");
//            System.out.println("commentIdParam" + commentIdParam);
            if (commentIdParam != null && !commentIdParam.isEmpty()) {
                // �R�����g�폜����
                int commentId = Integer.parseInt(commentIdParam);
                Postdao2 dao1 = new Postdao2();

                // �R�����g���폜
                dao1.deleteComment(commentId); // deleteComment���\�b�h���Ăяo���ăR�����g���폜

                // �폜��̓��e�����Ď擾
                List<Post2> list9 = dao1.tokou();
                request.setAttribute("list2", list9);

                // �폜��̓��e�ꗗ�y�[�W�Ƀ��_�C���N�g
                response.sendRedirect("../notice/ToukouNotice.action?items="+ id);
                return null; // ���_�C���N�g��͏������I��
            }


	     // Postdao2�̃C���X�^���X���쐬
			Postdao2 dao=new Postdao2();
			List<Post2> list=dao.notice_detail(id);
			if (list == null || list.isEmpty()) {
                request.setAttribute("errorMessage", "�w�肳�ꂽ���e��������܂���");
                return "toukou2.jsp";  // ���e�����݂��Ȃ��ꍇ�̃G���[���b�Z�[�W
            }

			Postdao2 com=new Postdao2();
			List<Comment> list4=com.come(id);
			request.setAttribute("comment", list4);
			request.setAttribute("list2", list);
            request.setAttribute("content", list);
			request.setAttribute("items", id);


		}catch (Exception e) {
			 // �\�����Ȃ��G���[�̏ꍇ
            request.setAttribute("errorMessage", "�G���[���������܂����B������x���������������B");
            e.printStackTrace(out);  // �G���[���O���o��
            return "toukou2.jsp";  // �G���[���b�Z�[�W��\�����ăt�H�[���ɖ߂�
		}

		return "toukou2.jsp";
	}
}

