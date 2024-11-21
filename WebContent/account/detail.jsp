<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ja">

<header>


<h1 id="logo"><img src="../images/logo.png" alt="SAMPLE COMPANY"></h1>
<h3 class="titlesize">ACCOUNT</h3>



</header>
<head>

    <title>アカウント情報</title>
    <link rel="stylesheet" href="../css/accountInfo.css">
</head>
<body>
<section class="mo-3">
    <h2 class="titlesize h3 mb-3 fw-normal bg-opacity-10 py-2 px-4 user">アカウント情報</h2>

    <table border="1">
        <tr><th>名前</th><td>${account.name}</td></tr>
        <tr><th>ユーザー名</th><td>${account.user_name}</td></tr>
        <tr><th>電話番号</th><td>${account.phone_number}</td></tr>
        <tr><th>メール</th><td>${account.email}</td></tr>
        <tr><th>郵便番号</th><td>${account.post_code}</td></tr>
        <tr><th>住所</th><td>${account.address}</td></tr>
        <tr><th>権限</th><td>${account.admini}</td></tr>
    </table>

    <div class="link-container">
        <a href="AccountDelete?email=${account.email}">削除</a>
        <c:choose>
            <c:when test="${account.admini == null}">
                <a href="AccountAuthority?email=${account.email}">権限を付与する</a>
            </c:when>
            <c:otherwise>
                <a href="Deprivation?email=${account.email}">権限を剥奪する</a>
            </c:otherwise>
        </c:choose>
    </div>

    <form action="AccountList.action" method="get">
        <button type="submit">戻る</button>
    </form>
    </section>
        <footer>
	<small>Copyright&copy; <a href="index.html">SAMPLE COMPANY</a> All Rights Reserved.</small>
	</footer>
</body>
</html>
