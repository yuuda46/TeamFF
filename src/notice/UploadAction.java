package notice;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.*;
import javax.servlet.http.Part;

import tool.Action;

@WebServlet("/notice/UploadAction")

//@WebServlet("/Upload1")
@MultipartConfig(
	location="/tmp/files",
	maxFileSize=10000000,
	maxRequestSize=10000000,
	fileSizeThreshold=10000000
	)
public class UploadAction extends Action {

	public String execute(
		HttpServletRequest request, HttpServletResponse response
		) throws ServletException,IOException {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out=response.getWriter();

		try{

		String name=request.getParameter("name");
		System.out.println(name);
		String word=request.getParameter("word");
		System.out.println(word);

		//name属性がpictのファイルをPartオブジェクトとして取得
		Part part=request.getPart("pict");
		System.out.println(part);
		String pict=request.getParameter("pict");
		System.out.println(pict);

		System.out.println("c");
		Integer num = Integer.parseInt(request.getParameter("num"));
		System.out.println("d");
		System.out.println(num);

		File f = new File(pict);
		BufferedImage bi = ImageIO.read(f);

		System.out.println(bi);

		} catch (Exception e) {
		e.printStackTrace(out);
	}
		return "result.jsp";
	}

}
