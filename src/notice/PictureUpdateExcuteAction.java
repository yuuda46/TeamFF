package notice;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Paths;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import tool.Action;

@MultipartConfig(
		location="/tmp/files",
		maxFileSize=10000000,
		maxRequestSize=10000000,
		fileSizeThreshold=10000000
		)

public class PictureUpdateExcuteAction extends Action {

	private static final String UPLOAD_DIR = "upload";

	public String execute (
		HttpServletRequest request, HttpServletResponse response
		) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out=response.getWriter();
		try{

			System.out.println("asdf");

			String post_id=request.getParameter("post_id");

			System.out.println(post_id);

			//name属性がpictのファイルをPartオブジェクトとして取得
			Part part=request.getPart("pict");

			System.out.println(part);

			//ファイル名を取得
			//String filename=part.getSubmittedFileName();//ie対応が不要な場合
			String filename=Paths.get(part.getSubmittedFileName()).getFileName().toString();

			System.out.println(filename);

//			Webアプリケーションの実際のファイルパスを取得
			String path=request.getServletContext().getRealPath("");

			String upload_path = path + UPLOAD_DIR;

			//実際にファイルが保存されるパス確認
	        System.out.println(upload_path);

			// 保存先のファイルパスを作成
	        File file = new File(upload_path, filename);

			//書き込み
	        part.write(file.getAbsolutePath());

//			絶対に重複しないであろうID(36桁)
			String uuid = UUID.randomUUID().toString();

			File oldNameFile = new File(upload_path+File.separator+filename);
			File newNameFile = new File(upload_path+File.separator+uuid+".png");
			oldNameFile.renameTo(newNameFile);

			System.out.println(uuid);

			request.setAttribute("post_id", post_id);
			request.setAttribute("path", upload_path);
			request.setAttribute("filename", uuid+".png");

		}catch (Exception e) {
			e.printStackTrace(out);
		}
		return "picture_permission.jsp";
	}
}
