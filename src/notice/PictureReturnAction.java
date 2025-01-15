package notice;

import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tool.Action;

public class PictureReturnAction extends Action {
	public String execute (
		HttpServletRequest request, HttpServletResponse response
		) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out=response.getWriter();
		try{
			String path = request.getParameter("path");
			String filename = request.getParameter("filename");
			String post_id=request.getParameter("post_id");

//			削除するファイルのパス文字列をPath型に変換
			Path delete_path = Paths.get(path+"/"+ filename);

//			ファイル削除
			Files.deleteIfExists(delete_path);

			request.setAttribute("post_id", post_id);

		}catch (Exception e) {
			e.printStackTrace(out);
		}
		return "picture_update.jsp";
	}
}
