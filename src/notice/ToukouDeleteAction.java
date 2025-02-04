package notice;

import java.io.IOException;


import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import bean.Post2;
import dao.Postdao2;



@WebServlet("/notice/ToukouDelete.action")
public class ToukouDeleteAction extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        try {

        	//index.jsp����f�[�^���擾����
			String id = request.getParameter("items");


			if (id == null || id.isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID���w�肳��Ă��܂���");
                return;
            }

			// �w��ID�̃f�[�^���擾
            Postdao2 dao1 = new Postdao2();
            List<Post2> list = dao1.notice_detail(id);
            if (list == null || list.isEmpty()) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "�w�肳�ꂽ���e��������܂���");
                return;
            }

			request.setAttribute("list2", list);


			 // �폜��̏���\�����邽�߂�JSP�Ƀt�H���[�h
            request.getRequestDispatcher("/notice/toukoudelete.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "�f�[�^�̕ۑ��Ɏ��s���܂���");
        }
    }
}
