<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!DOCTYPE html>
<html lang="ja">

<head>

<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>home</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="ここにサイト説明を入れます">
<meta name="keywords" content="キーワード１,キーワード２,キーワード３,キーワード４,キーワード５">
<link href="https://fonts.googleapis.com/css?family=Noto+Serif+JP" rel="stylesheet">
<link rel="stylesheet" href="../css/style.css">
<link rel="stylesheet" href="../css/style2.css">
<link rel="stylesheet" href="../css/notice.css">
</head>

<body>

<header>

    <% String username = (String) session.getAttribute("username"); %>
    <% if (username != null) { %>
        <a href="../login/logout-in.jsp" class="button12">ログアウト</a>
    <% } else { %>
        <a href="../login/login.jsp" class="button12">ログイン</a>
        <a href="../account/signUp.jsp" class="button12">新規登録</a>
    <% } %>


 <%
        // セッションからadminフラグを取得
        Boolean isAdmin = (Boolean) session.getAttribute("admin");

        // 管理者フラグがtrueの場合にメニューを表示
        if (isAdmin != null && isAdmin) {
    %>
        <!-- 管理者用ドロップダウンメニュー -->
        <div class="dropdown">
            <button class="dropdown-toggle">メニュー ▼</button>
            <ul class="dropdown-menu">
                <li><a href="../account/AccountList.action">個人情報</a></li>
                <li><a href="../notice/NoticeForm.action">回覧物投稿</a></li>
				<li><a href="../notice/NoticeAdmin.action">回覧物編集</a></li>
				<li><a href="../c_detail/C_detailList.action">集金物投稿</a></li>
				<li><a href="../collection/CollectionDeposit.action">集金完了</a></li>
				<li><a href="../collection/CollectionConfirm.action">納金確認</a></li>
            </ul>
        </div>
    <% } %>



<h1 id="logo"><a href="index.jsp"><img src="../images/logo.png" alt="SAMPLE COMPANY"></a></h1>
<nav id="menubar">
<ul>
<li><a href="../notice/Notice.action">回覧物</a></li>
<li><a href="../notice/Tokou.action">掲示板</a></li>
<li><a href="../notice/ToukouForm.action">掲示板投稿</a></li>
<li><a href="../collection/CollectionList.action">集金一覧</a></li>
<li><a href="../account/contactForm.jsp">お問い合わせ</a></li>
</ul>
</nav>
</header>




<div class="container3">

<!-- 掲示板機能ここから -->
<%
    // ユーザーがログインしているか確認
    if (username != null) {
%>

    <h1 class="notice_left">掲示板</h1>
    <%-- ここにコンテンツを挟む --%>

    <form class="position_right" action="../notice/ToukouForm.action" method="post">
		<button class="button_style il_button  margin_top_30px" type="submit">議題投稿する</button>
	</form>
        <form action="../notice/Tokou.action" method="get">
            <c:choose>
                <c:when test="${not empty list2}">
                	<div class="position_right ">
                    <div class="top_margin ">件数:${list2.size()}件</div>
                    </div>
                    <hr>
                    <c:forEach var="post" items="${list2}">
                        <h1><a href="../notice/ToukouNotice.action?items=${post.postId}">${post.title}</a></h1>
                        <p>
					        <c:choose>
					            <c:when test="${fn:length(post.content) > 75}">
					                ${fn:substring(post.content, 0, 75)}...
					            </c:when>
					            <c:otherwise>
					                ${post.content}
					            </c:otherwise>
					        </c:choose>
				    	</p>
                        <p>${post.postDay}</p>
                        <hr>
                    </c:forEach>
                </c:when>
            </c:choose>
        </form>

<%
    } else {
%>
    <!-- 未ログイン時のメッセージ -->
	<!-- サイトの機能説明  -->

    <div class="container">
    	<div class="card" data-number="01">
            <div class="icon">
                <img src="../images/toukou.jpg" alt="アイコン1">
            </div>
            <div class="title">
                <span>投稿</span>
            </div>
            <div class="text">
                連絡文書をカテゴリーごとに絞り込んで閲覧できる
            </div>
        </div>

        <div class="card" data-number="02">
            <div class="icon">
                <img src="../images/keiji.png" alt="アイコン2">
            </div>
            <div class="title">
                <span>掲示板</span>
            </div>
            <div class="text">
				住民どうしのコミュニケーションが出来ます
			</div>
        </div>

        <div class="card" data-number="03">
            <div class="icon">
                <img src="../images/mane.jpg" alt="アイコン3">
            </div>
            <div class="title">
                <span>集金一覧</span>
            </div>
            <div class="text">
				集金をお願いしています。
			</div>
        </div>

        <div class="card" data-number="04">
            <div class="icon">
                <img src="../images/toiawase.jpg" alt="アイコン4">
            </div>
            <div class="title">
                <span>お問い合わせ</span>
            </div>
            <div class="text">
				問い合わせメールを管者メールアドレスに送信できる
            </div>
        </div>
    </div>
<%
    }
%>
<!-- 掲示板機能ここまで -->

</div>

	<footer>
	<small>Copyright&copy; <a href="index.html">SAMPLE COMPANY</a> All Rights Reserved.</small>
	</footer>

<!--jQueryファイルの読み込み-->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<!--ページの上部へ戻るボタンとスクリプト-->
<p class="scroll"><a href="#">↑</a></p>
<script src="../js/scroll.js"></script>

</body>
</html>
