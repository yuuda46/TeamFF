<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<!DOCTYPE html>
<html lang="ja">

<head>

<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>home</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="ここにサイト説明を入れます">
<meta name="keywords" content="キーワード１,キーワード２,キーワード３,キーワード４,キーワード５">
<link rel="stylesheet" href="../css/style.css">
</head>

<body>

<header>

<%String username = (String) session.getAttribute("username");
    if (username != null) {%>
    <a href="../login/logout-in.jsp" class="button12">ログアウト</a>
<%} else {%>
    <a href="../login/login.jsp" class="button12">ログイン</a>
<%}%>
<a href="../account/signUp.jsp" class="button12">新規登録</a>



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
                <li><a href="../account/AccountList.action">アカウント</a></li>
                <li><a href="../notice/NoticeForm.action">アップロード</a></li>
				<li><a href="../notice/NoticeAdmin.action">投稿編集</a></li>
            </ul>
        </div>
    <% } %>



<h1 id="logo"><a href="index.jsp"><img src="../images/logo.png" alt="SAMPLE COMPANY"></a></h1>
<nav id="menubar">
<ul>
<li><a href="../notice/Notice.action">投稿</a></li>
<li><a href="../notice/Tokou.action">掲示板</a></li>
<li><a href="../collection/CollectionList.action">集金一覧</a></li>
<li><a href="../account/contactForm.jsp">お問い合わせ</a></li>
</ul>
</nav>
</header>





<div id="container">

<div id="contents">

<section id="new">

<h2>What's New</h2>
<c:param name="content">
<%-- ここにコンテンツを挟む --%>
		<form action="../notice/Tokou.action" method="get">
		    <input placeholder="検索" name="searchQuery">
		    <div>
		        <button id="filter-button" type="submit">検索</button>
		    </div>

		    <c:choose>
		        <c:when test="${not empty list2}">
		            <div>件数:${list2.size()}件</div>
		            <c:forEach var="post" items="${list2}">
		                <h1><a href="../notice/ToukouNotice.action?items=${post.postId}">${post.title}</a></h1>
		                <p>${post.postDay}</p>
		                <p>${post.content}</p>
		                <hr>
		            </c:forEach>
		        </c:when>
		    </c:choose>
		</form>
</c:param>

</section>
<!--/#new-->

<section id="company">



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
