package notice;

import java.io.IOException;
import java.net.URLEncoder;
//import java.sql.Connection;
//import java.sql.PreparedStatement;
//import java.util.Date;
import java.util.List;
//import java.sql.Timestamp; // Timestamp���C���|�[�g
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;

import bean.Post2;
import dao.Postdao2;



@WebServlet("/notice/toukoudeleteaction")
public class ToukouDeleteAction extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        try {

        	//toukou.jsp����f�[�^���擾����
			String id = request.getParameter("items");

			if (id == null || id.isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID���w�肳��Ă��܂���");
                return;
            }

            // �w��ID�̃f�[�^���擾
			Postdao2 dao1=new Postdao2();
			List<Post2> list=dao1.delete(id);
			request.setAttribute("list2", list);

			response.sendRedirect("/teee/notice/ToukouNotice.action?items=" + id);
            } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "�f�[�^�̕ۑ��Ɏ��s���܂���");
        }
    }

}
