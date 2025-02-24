package tool;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(urlPatterns={"*.action"})
public class FrontController extends HttpServlet {

	public void doPost(
		HttpServletRequest request, HttpServletResponse response
	) throws ServletException, IOException {
		PrintWriter out=response.getWriter();
		try {
            HttpSession session = request.getSession();
            String user_name = (String) session.getAttribute("username");
            String password = (String) session.getAttribute("password");
            System.out.println(user_name);
            System.out.println(password);
            // 未ログインの場合、ログイン画面にリダイレクト
            if (user_name == null || password == null) {
                // リダイレクト前に遷移元のURLを保存
                String requestedUrl = request.getRequestURI();
                if (!requestedUrl.contains("SignUp.action")) {
                    // リダイレクト前に遷移元のURLを保存
                    session.setAttribute("requestedUrl", requestedUrl);
                    // ログインページにリダイレクト
                    response.sendRedirect("../login/login.jsp");
                    return;
                }
            }






			// URLの取得
			String path=request.getServletPath().substring(1);
			// 「〇〇.action」を「〇〇Action」に変更する。
			// search.action ⇒ searchAction

			String name=path.replace(".a", "A").replace('/', '.');

			// ↑で作成した該当するフォルダの中にあるクラスを設定
			Action action=(Action)Class.forName(name).
				getDeclaredConstructor().newInstance();

			// ↑で設定したクラスの実行。
			// 戻り値はString型。これは、該当するクラスから戻ってくるとき
			// 画面を表示するJSPを返すため。
			String url=action.execute(request, response);

			// ↑で返却されたJSPにここで飛ばす。
			request.getRequestDispatcher(url).
				forward(request, response);
		} catch (Exception e) {
			e.printStackTrace(out);
		}
	}

	private boolean isHomePageRequest(HttpServletRequest request) {
		// TODO 自動生成されたメソッド・スタブ
		return false;
	}

	public void doGet(
		HttpServletRequest request, HttpServletResponse response
	) throws ServletException, IOException {
		doPost(request, response);
	}
}
