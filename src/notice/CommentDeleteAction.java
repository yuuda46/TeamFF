package notice;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.Comment;
import dao.Postdao2;


@WebServlet("/notice/CommentDelete.action")
public class CommentDeleteAction extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        try {
        	String id = request.getParameter("items");
        	//System.out.println("comment!" + id);
        	HttpSession session = request.getSession();
            Boolean isAdmin = (Boolean) session.getAttribute("admin");

            if (isAdmin == null || !isAdmin) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "����������܂���");
                return;
            }

            // �R�����gID���擾 (String�^�Ŏ擾�����̂ŁAint�ɕϊ�)
            String commentIdParam = request.getParameter("commentId");
            String postId = request.getParameter("postId");

            // commentId����̏ꍇ�̓G���[
            if (commentIdParam == null || commentIdParam.isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "�R�����gID���w�肳��Ă��܂���");
                return;
            }


            // commentId �� int �^�ɕϊ�
            int commentId = Integer.parseInt(commentIdParam);
            // �R�����g�폜�����idisplay �� false �ɂ���j
            Postdao2 dao = new Postdao2();
//            dao.deleteComment(commentId);

         // �R�����g���폜�ΏۂƂ��Ď擾
            List<Comment> comment = dao.comment_detail(commentId);
            if (comment == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "�w�肳�ꂽ�R�����g��������܂���");
                return;
            }

            // �R�����g�������N�G�X�g�����ɃZ�b�g
            request.setAttribute("Commentdel", comment);
            request.setAttribute("items", id);

            // �폜�m�F��ʂɃt�H���[�h
            request.getRequestDispatcher("/notice/commentdelete.jsp").forward(request, response);


        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "�R�����g�폜�Ɏ��s���܂���");
        }
    }
}
