package notice;

import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Post;
import dao.PostDAO;
import tool.Action;

public class PictureKeepAction extends Action {

	private static final String UPLOAD_DIR = "upload";

	public String execute (
			HttpServletRequest request, HttpServletResponse response
			) throws ServletException, IOException {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out=response.getWriter();
			try{
				String post_id = request.getParameter("post_id");

				System.out.println("ここから:" + post_id);

//				h2コンソールから投稿内容を取得
				PostDAO dao1=new PostDAO();
				List<Post> list=dao1.notice_detail(post_id);

//				削除する画像の名前をリストから取得
				System.out.println("画像タイトル:" + list.get(0).getContent());

//				Webアプリケーションの実際のファイルパスを取得
				String path=request.getServletContext().getRealPath("");
				System.out.println("パス:" + path);

//				削除するファイルの入っているフォルダのパスと結合
				String searth_path = path + UPLOAD_DIR;

//				削除する画像ファイルの名前と結合
				String delete_file = searth_path + "/" + list.get(0).getContent();

//				削除するファイルのパスの文字列をPath型に変換
				Path delete_path = Paths.get(delete_file);

//				ファイルを削除
				Files.deleteIfExists(delete_path);

//				LocalDate型の日付を取得
				LocalDateTime localDate = LocalDateTime.now();
				String string_date = localDate.format(DateTimeFormatter.ofPattern("uuuu-MM-dd HH:mm:ss"));
				DateTimeFormatter formatter = DateTimeFormatter.ofPattern("uuuu-MM-dd HH:mm:ss");
				LocalDateTime date_time = LocalDateTime.parse(string_date, formatter);

				Timestamp post_day = Timestamp.valueOf(date_time);
				System.out.println(post_day);

				String filename = request.getParameter("filename");

				System.out.println("新規画像:" + filename);

//				h2コンソールに書き込み
//				PostDAO dao=new PostDAO();
				Post p = new Post();
				p.setPostId(post_id);
				p.setContent(filename);
				p.setPostDay(post_day);

				int line=dao1.picture_update(p);

			}catch (Exception e) {
				e.printStackTrace(out);
			}
			return "picture_update_done.jsp";
		}
}
