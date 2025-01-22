package servlet;

import java.io.IOException;
//import java.sql.Connection;
//import java.sql.PreparedStatement;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.Comment;
import bean.Post2;
import dao.Postdao2;



@WebServlet("/notice/commentSubmit")
public class CommentSubmitServlet extends HttpServlet {


    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String proposal = request.getParameter("proposalContent"); // �e�L�X�g�G���A�̓��e
        Date time = new Date(); // ���݂̓���
        try {

        	//toukou.jsp����f�[�^���擾����
			String id = request.getParameter("items");

			if (id == null || id.isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID���w�肳��Ă��܂���");
                return;
            }

            // �w��ID�̃f�[�^���擾
			Postdao2 dao1=new Postdao2();
			List<Post2> list=dao1.notice_detail(id);
			request.setAttribute("list2", list);

            Postdao2 dao = new Postdao2();
            HttpSession session = request.getSession();
            String user_name = (String) session.getAttribute("username");
            String password = (String) session.getAttribute("password");

         // Postdao�N���X�̃C���X�^���X�𐶐����āAid_search���\�b�h���Ăяo��
            Postdao2 comment = new Postdao2();
            List<Comment> userList = comment.id_search(user_name, password);

//          if (!userList.isEmpty()) {
            String user_id = userList.get(0).getUser_id();  // user_id���擾
            dao.insertComment(id, user_id, proposal, time);
            request.setAttribute("items", id);
        	//�Bgetparamete�Ńq�h�D�����擾
            //System.out.println("���炽��");
            // �R�����g�}����A���e�ڍ׃y�[�W�Ƀ��_�C���N�g
            request.getRequestDispatcher("toukou3.jsp")
            	.forward(request, response);
//        }
            } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "�f�[�^�̕ۑ��Ɏ��s���܂���");
        }
    }

}
