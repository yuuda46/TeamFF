<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- 文字化けの対策 --%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>


<!DOCTYPE html>
<html lang="ja">
<header>


<h1 id="logo"><img src="../images/logo.png" alt="SAMPLE COMPANY"></h1>
<h3 class="titlesize">ACCOUNT</h3>



</header>
<head>
    <meta charset="UTF-8">
    <title>アカウント権限付与確認</title>
    <link rel="stylesheet" href="../css/accountInfo.css">
</head>
<body>
<section class="mo-3">
    <h2>アカウント付与確認</h2>
    <p>以下のアカウントに権限を付与してよろしいですか？</p>

    <table border="1">
        <tr><th>名前</th><td>${account.name}</td></tr>
        <tr><th>ユーザー名</th><td>${account.user_name}</td></tr>
        <tr><th>電話番号</th><td>${account.phone_number}</td></tr>
        <tr><th>メール</th><td>${account.email}</td></tr>
        <tr><th>郵便番号</th><td>${account.post_code}</td></tr>
        <tr><th>住所</th><td>${account.address}</td></tr>
        <tr><th>権限</th><td>${account.admini}</td></tr>
    </table>




	<form action="AccountAuthority" method="post">
	    <input type="hidden" name="email" value="${account.email}">
	    <button type="submit">付与する</button>
	</form>

        <button onclick="history.back()">戻る</button>
    <footer>
	<small>Copyright&copy; <a href="index.html">SAMPLE COMPANY</a> All Rights Reserved.</small>
	</footer>

</body>
</html>
