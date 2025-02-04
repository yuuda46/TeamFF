package notice;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Post2;
import dao.Postdao2;
import tool.Action;

public class TokouAction extends Action {
    public String execute(
        HttpServletRequest request, HttpServletResponse response
    ) throws ServletException, IOException {

        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            // ���e�폜�Ώۂ̓��eID���擾
            String postId = request.getParameter("items");
            if (postId != null && !postId.isEmpty()) {
                // ���e�폜����
                Postdao2 dao = new Postdao2();
                List<Post2> list = dao.delete(postId); // delete���\�b�h�œ��e���폜

                // �폜��̓��e�������N�G�X�g�����ɃZ�b�g
                request.setAttribute("list2", list);

                // ���e�폜��A���e�ꗗ�y�[�W�Ƀ��_�C���N�g
                response.sendRedirect("../notice/Tokou.action");
                return null; // ���_�C���N�g��͏������I��
            }

//            // �R�����g�폜�Ώۂ̃R�����gID���擾
//            String commentIdParam = request.getParameter("commentId");
//            if (commentIdParam != null && !commentIdParam.isEmpty()) {
//                // �R�����g�폜����
//                int commentId = Integer.parseInt(commentIdParam);
//                Postdao2 dao = new Postdao2();
//
//                // �R�����g���폜
//                dao.deleteComment(commentId); // deleteComment���\�b�h���Ăяo���ăR�����g���폜
//
//                // �폜��̓��e�����Ď擾
//                List<Post2> list = dao.tokou();
//                request.setAttribute("list2", list);
//
//                // �폜��̓��e�ꗗ�y�[�W�Ƀ��_�C���N�g
//                response.sendRedirect("../notice/Tokou.action");
//                return null; // ���_�C���N�g��͏������I��
//            }

            // ���e�ꗗ��\�����鏈��
            Postdao2 dao = new Postdao2();
            List<Post2> list = dao.tokou();
            request.setAttribute("list2", list);

        } catch (Exception e) {
            e.printStackTrace(out);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "�G���[���N���܂���");
        }
        return "../common/index.jsp"; // ���e�ꗗ��\��
    }
}
