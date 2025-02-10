<%-- お知らせJSP --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- 文字化けの対策 --%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<link rel="stylesheet" href="../css/notice.css">
<c:import url="/common/base.jsp">
	<c:param name="content">
		<div class="container2">
		<form class="padding_bottom_0" action="../notice/ToukouUpload.action" method="post">
			<div>
				<div class="padding_top_10 padding_bottom_10">
			        タイトル:
			        <input class="border_style tea" type="text" name="title" required="required" value="${param.title}" placeholder="20文字以内で入力してください"><br>
				</div>

				<div class="padding_top_10 padding_bottom_10 ">
		        	<textarea class="textarea border_style" name="content"  required="required" rows="5" cols="50" maxlength="10000" placeholder="本文を入力してください">${param.content}</textarea>
		    	</div>
		    </div>


			<%--改行を保持したままjavaに送信するためのテキストエリア --%>
			<%--rows:テキストエリアの縦幅(行) cols:テキストエリアの横幅(文字) --%>
			<div class="float_right">
				<button class="button_style detail_button" type="submit">投稿</button>
			</div>
		</form>

		<form action="../notice/Tokou.action" method="get">
			<button class="button_style detail_button yy_margin " type="submit">戻る</button>
		</form>


	<!-- エラーメッセージ表示 -->
        <c:if test="${not empty errorMessage}">
            <div style="color: red;">
                <p>${errorMessage}</p>
            </div>
        </c:if>
        </div>
	</c:param>
</c:import>