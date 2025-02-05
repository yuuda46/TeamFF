<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- 文字化けの対策 --%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ja">

<head>
    <meta charset="UTF-8">
    <title>アカウント権限を外す</title>
    <link href="https://fonts.googleapis.com/css?family=Noto+Serif+JP" rel="stylesheet">
    <link rel="stylesheet" href="../css/account2.css">
    <style>

    </style>
</head>
<body>

<header>


<h1 id="logo"><img src="../images/logo.png" alt="SAMPLE COMPANY"></h1>



</header>

    <div class="main-container">
    <h2>アカウント権限を外しました</h2>
    <p><c:out value="${name}" default="ユーザー" />さんは組員になりました<br>管理者の権限が外されました</p>
        <form action="AccountList.action" method="get">
        <button type="submit">アカウント一覧</button>
    </form>
    </div>
    <footer>
	<small>Copyright&copy; SAMPLE COMPANY All Rights Reserved.</small>
	</footer>

</body>
</html>
