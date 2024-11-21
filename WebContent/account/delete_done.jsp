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
    <title>アカウント削除完了</title>
    <link rel="stylesheet" href="../css/account2.css">
    <style>

    </style>
</head>
<body>

    <div class="main-container">
    <h2>アカウント削除</h2>
    <p>アカウントの削除が完了しました。</p>
        <form action="AccountList.action" method="get">
        <button type="submit">アカウント一覧</button>
    </form>
    </div>
    <footer>
	<small>Copyright&copy; <a href="index.html">SAMPLE COMPANY</a> All Rights Reserved.</small>
	</footer>

</body>
</html>
