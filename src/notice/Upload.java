package notice;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.UUID;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import bean.Category;
import dao.CategoryDAO;

@WebServlet("/notice/Upload")
@MultipartConfig(
	location="/tmp/files",
//	C:\Users\*個人のファイル名*\Downloads\4.6.3\pleiades\Team_F2\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\work\Catalina\localhost\teee\tmp\files?
//	このディレクトリ存在しないから手動で作る
	maxFileSize=10000000,
	maxRequestSize=10000000,
	fileSizeThreshold=10000000
	)



public class Upload extends HttpServlet {

	private static final String UPLOAD_DIR = "/upload";

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		PrintWriter out=response.getWriter();

		try{
		System.out.println("b");

		String title=request.getParameter("title");
		String name=request.getParameter("name");
		Integer num = Integer.parseInt(request.getParameter("num"));
//		String numParam = request.getParameter("num");
//        Integer num = (numParam != null && !numParam.isEmpty()) ? Integer.parseInt(numParam) : 0;


		//name属性がpictのファイルをPartオブジェクトとして取得
		Part part=request.getPart("pict");

		//ファイル名を取得
		//String filename=part.getSubmittedFileName();//ie対応が不要な場合
		String filename=Paths.get(part.getSubmittedFileName()).getFileName().toString();

		//アップロードするフォルダ
		String path=getServletContext().getRealPath("");

		String upload_path = path + UPLOAD_DIR;

		// 保存先ディレクトリが存在しない場合は作成
        File uploadDir = new File(upload_path);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();  // ディレクトリを作成
        }

		//実際にファイルが保存されるパス確認
		System.out.println(path);

		// 保存先のファイルパスを作成
        File file = new File(upload_path, filename);

		//書き込み
        part.write(file.getAbsolutePath());

//		絶対に重複しないであろうID(36桁)
		String uuid = UUID.randomUUID().toString();

		File oldNameFile = new File(upload_path+File.separator+filename);
		File newNameFile = new File(upload_path+File.separator+uuid+".png");
		oldNameFile.renameTo(newNameFile);

		System.out.println(uuid);

		// エラーメッセージの文字列
		String error_message = "";

//		タイトルの文字数を調べる
		int count_title = title.length();
		System.out.println(count_title);
		if (count_title > 20){
			System.out.println("error");
			error_message = "タイトルが20文字以上です";
		}

			if (error_message != ""){

				System.out.println("True");
//				h2コンソールからカテゴリーを取得
				CategoryDAO dao=new CategoryDAO();
				List<Category> list=dao.all();

				Path delete_path = Paths.get(upload_path+"/"+uuid+".png");
				Files.deleteIfExists(delete_path);

				System.out.println(part);

				request.setAttribute("title", title);
				request.setAttribute("name", name);
				request.setAttribute("select_list", list);
				request.setAttribute("error_message", error_message);
				RequestDispatcher rd = request.getRequestDispatcher("/notice/form.jsp");
				rd.forward(request,response);

			}
			else{
				System.out.println("False");
			}

		request.setAttribute("title",title);
		request.setAttribute("name", name);
		request.setAttribute("num", num);
		request.setAttribute("path", upload_path);
		request.setAttribute("filename", uuid+".png");
		RequestDispatcher rd=request.getRequestDispatcher("/notice/result.jsp");
		rd.forward(request, response);
	}catch (Exception e) {
		e.printStackTrace(out);
	}
}
}
