<%-- 共通部分JSP --%>
<%@ page contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- 文字化けの対策 --%>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>掲示板(仮)</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="ここにサイト説明を入れます">
<meta name="keywords" content="キーワード１,キーワード２,キーワード３,キーワード４,キーワード５">
<link href="https://fonts.googleapis.com/css?family=Noto+Serif+JP" rel="stylesheet">
<link rel="stylesheet" href="../css/style.css">
</head>

<body>

<header class="head">

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
            <ul class="dropdown-menu dropdown-menu2">
                <li class="li_width"><a href="../account/AccountList.action">個人情報</a></li>
                <li><a href="../notice/NoticeForm.action">回覧物投稿</a></li>
				<li><a href="../notice/NoticeAdmin.action">回覧物編集</a></li>
            	<li><a href="../c_detail/C_detailList.action">集金物投稿</a></li>
            	<li><a href="../collection/CollectionDeposit.action">集金完了</a></li>
            	<li><a href="../collection/CollectionConfirm.action">納金確認</a></li>
            </ul>
        </div>
    <% } %>

<h1 id="logo"><a href="index.jsp"><img src="../images/logo.png" alt="SAMPLE COMPANY"></a></h1>
<nav class="menubar container3">
<ul>
<li><a href="../notice/Notice.action">回覧物</a></li>
<li><a href="../notice/Tokou.action">掲示板</a></li>
<li><a href="../notice/ToukouForm.action">掲示板投稿</a></li>
<li><a href="../collection/CollectionList.action">集金一覧</a></li>
<li><a href="../account/contactForm.jsp">お問い合わせ</a></li>
</ul>
</nav>
</header>

<div class="content">
${param.content}
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