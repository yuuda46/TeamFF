<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>集金物投稿確認</title>
    <link rel="stylesheet" href="../css/accountInfo.css">
</head>
<body>
    <header>
        <h1 id="logo"><img src="../images/logo.png" alt="SAMPLE COMPANY"></h1>
    </header>

    <section class="mo-3">
        <h2>集金物投稿確認</h2>
        <p>投稿内容は以下でよろしいですか？</p>

        <table border="1">
            <tr><th>金額</th><td>${param.monetary} 円</td></tr>
            <tr><th>期限</th><td>${param.deadline}</td></tr>
            <tr><th>振込先</th><td>${param.transferee}</td></tr>
        </table>

        <form action="../c_detail/C_detail.action" method="post">
            <input type="hidden" name="postid" value="${param.postid}">
            <input type="hidden" name="monetary" value="${param.monetary}">
            <input type="hidden" name="deadline" value="${param.deadline}">
            <input type="hidden" name="transferee" value="${param.transferee}">
            <button type="submit">登録する</button>
        </form>

        <button type="submit" onclick="history.back()">戻る</button>
    </section>

    <footer>
        <small>Copyright&copy;SAMPLE COMPANY All Rights Reserved.</small>
    </footer>
</body>
</html>
