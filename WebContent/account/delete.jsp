<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- 文字化けの対策 --%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>


<!DOCTYPE html>
<html lang="ja">

<head>
    <meta charset="UTF-8">
    <title>アカウント削除確認</title>
    <link href="https://fonts.googleapis.com/css?family=Noto+Serif+JP" rel="stylesheet">
    <link rel="stylesheet" href="../css/accountInfo.css">
</head>
<body>

<header>


<h1 id="logo"><img src="../images/logo.png" alt="SAMPLE COMPANY"></h1>




</header>

<section class="mo-3">
    <h2>アカウント削除確認</h2>
    <p>以下のアカウントを削除してよろしいですか？</p>

    <table border="1">
        <tr><th>名前</th><td>${account.name}</td></tr>
        <tr><th>ユーザー名</th><td>${account.user_name}</td></tr>
        <tr><th>電話番号</th><td>${account.phone_number}</td></tr>
        <tr><th>メール</th><td>${account.email}</td></tr>
        <tr><th>郵便番号</th><td>${account.post_code}</td></tr>
        <tr><th>住所</th><td>${account.address}</td></tr>
        <tr><th>権限</th><td>${account.admini}</td></tr>
    </table>

    <form action="AccountDelete" method="post">
        <input type="hidden" name="email" value="${account.email}">
        <button type="submit">削除する</button>
    </form>

	<button type="submit" onclick="history.back()">戻る</button>
	</section>
	<footer>
	<small>Copyright&copy;SAMPLE COMPANY All Rights Reserved.</small>
	</footer>

</body>
</html>
