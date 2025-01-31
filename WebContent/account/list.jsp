<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- アカウント一覧表示 --%>
<html>
<header>
<h1 id="logo"><img src="../images/logo.png" alt="SAMPLE COMPANY"></h1>
</header>
<head>
    <title>アカウント一覧</title>
    <link rel="stylesheet" href="../css/account.css">

</head>
<body>


<section class="mo-3">
    <h2 class="titlesize h3 mb-3 fw-normal bg-opacity-10 py-2 px-4 user">個人情報一覧</h2>
    <table border="1">
        <tr>
            <th>名前</th>
            <th>ユーザー名</th>
            <th>電話番号</th>
            <th>メール</th>
            <th>郵便番号</th>
            <th>住所</th>
            <th>権限</th>
        </tr>
       <c:forEach var="account" items="${accountList}">
            <tr>
                <td>${account.name}</td>
                <td>${account.user_name}</td>
                <td>${account.phone_number}</td>
                <td>${account.email}</td>
                <td>${account.post_code}</td>
                <td>${account.address}</td>
                <td>${account.admini}</td>
                <td><a href="AccountDetail?email=${account.email}">詳細</a></td>

            </tr>
        </c:forEach>
    </table>



    <form action="../common/index.jsp" method="get">
    <button class="btn btn-secondary" type="submit">戻る</button>
    </form>
    </section>
        <footer>
	<small>Copyright&copy; <a href="index.jsp">SAMPLE COMPANY</a> All Rights Reserved.</small>
	</footer>
</body>
</html>
