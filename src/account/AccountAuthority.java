package account;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Account;
import dao.AccountDAO;

@WebServlet(urlPatterns={"/account/AccountAuthority"})
public class AccountAuthority extends HttpServlet {

	@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    		throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        try {
            String email = request.getParameter("email");

            // アカウント情報取得
            AccountDAO dao = new AccountDAO();
            Account account = dao.findByEmail(email);
            if (account != null) {
                request.setAttribute("account", account);
                request.getRequestDispatcher("authority.jsp").forward(request, response);
            } else {
                response.getWriter().println("アカウントが見つかりませんでした。");
            }
        } catch (Exception e) {
            e.printStackTrace(response.getWriter());
        }
    }

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {
	    response.setContentType("text/html; charset=UTF-8");
	    String name = request.getParameter("name"); // name を取得
	    String email = request.getParameter("email");

	    try {
	        AccountDAO dao = new AccountDAO();
	        int result = dao.Authority(email);

	        if (result > 0) {

	        	 request.setAttribute("name", name);
	             request.getRequestDispatcher("authority_done.jsp").forward(request, response);
	            // 権限付与が成功した場合、signup_list.jspにリダイレクト

	        } else {
	            response.getWriter().println("権限付与に失敗しました。");
	        }
	    } catch (Exception e) {
	        e.printStackTrace(response.getWriter());
	    }
	}


}
