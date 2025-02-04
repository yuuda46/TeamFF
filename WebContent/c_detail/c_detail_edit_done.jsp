<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>編集完了</title>
    <link rel="stylesheet" href="../css/account2.css">
</head>
<body>
    <header>
        <h1 id="logo"><img src="../images/logo.png" alt="SAMPLE COMPANY"></h1>
    </header>

    <div class="main-container">
        <h2>編集完了</h2>
        <p>編集が完了しました。</p>
        <form action="C_detailList.action" method="get">
            <button type="submit">集金物一覧へ</button>
        </form>
    </div>

    <footer>
        <small>Copyright&copy; SAMPLE COMPANY All Rights Reserved.</small>
    </footer>
</body>
</html>
