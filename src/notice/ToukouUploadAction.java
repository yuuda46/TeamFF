package notice;

import java.io.IOException;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.Post;
import dao.PostDAO;
import tool.Action;

public class ToukouUploadAction extends Action {
    public String execute(
            HttpServletRequest request, HttpServletResponse response
    ) throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");

        try {
            // �Z�b�V�������烆�[�U�[�����擾
            HttpSession session = request.getSession();
            String user_name = (String) session.getAttribute("username");

            // �t�H�[������^�C�g���ƃR���e���c���擾
            String title = request.getParameter("title");
            String content = request.getParameter("content");

            // �^�C�g����21�����ȏ�Ȃ�G���[
            if (title != null && title.length() > 20) {
                request.setAttribute("errorMessage", "�^�C�g����20�����ȓ��œ��͂��Ă��������B");
                return "toukou_form.jsp";  // �t�H�[����ʂɖ߂�
            }

            // ���݂̓��t���擾
            LocalDate localDate = LocalDate.now();
            java.sql.Date post_day = java.sql.Date.valueOf(localDate);

            // ���e�I�u�W�F�N�g���쐬
            Post p = new Post();
            p.setTitle(title);
            p.setContent(content);
            p.setName(user_name);
            p.setPostDay(post_day);

            // ���e���f�[�^�x�[�X�ɕۑ�
            PostDAO dao2 = new PostDAO();
            int line = dao2.insert2(p);  // ���e��ۑ�

            // ���s�R�[�h�� <br> �^�O�ɒu��
            String indent_content = content.replace("\n", "<br>");

            // �t�H�[���f�[�^�����N�G�X�g�ɃZ�b�g
            request.setAttribute("title", title);
            request.setAttribute("name", user_name);
            request.setAttribute("content", indent_content);

        } catch (Exception e) {
            // �G���[�������Ƀt�H�[����ʂɖ߂�
            e.printStackTrace();
            request.setAttribute("errorMessage", "���e�̏������ɃG���[���������܂����B");
            return "toukou_form.jsp";
        }

        // ���e�������A���ʃy�[�W�ɑJ��
        return "toukou_result.jsp";
    }
}
