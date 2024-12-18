package notice;

import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Post;
import dao.PostDAO;
import tool.Action;

public class PictureUpdateAction extends Action{

	private static final String UPLOAD_DIR = "upload";

	public String execute (
		HttpServletRequest request, HttpServletResponse response
		) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out=response.getWriter();
		try{

			String post_id=request.getParameter("post_id");

//			h2コンソールから投稿内容を取得
			PostDAO dao=new PostDAO();
			List<Post> list=dao.notice_detail(post_id);

//			削除する画像の名前をリストから取得
			System.out.println(list.get(0).getContent());

//			Webアプリケーションの実際のファイルパスを取得
			String path=request.getServletContext().getRealPath("");

//			削除するファイルの入っているフォルダのパスと結合
			String searth_path = path + UPLOAD_DIR;

//			削除する画像ファイルの名前と結合
			String delete_file = searth_path + "/" + list.get(0).getContent();

//			削除するファイルのパスの文字列をPath型に変換
			Path delete_path = Paths.get(delete_file);

//			ファイルを削除
			Files.deleteIfExists(delete_path);

			request.setAttribute("post_id", post_id);
		}
		catch (Exception e) {
			e.printStackTrace(out);
		}
		return "picture_update.jsp";
	}
}
