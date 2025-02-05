<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>編集確認</title>
    <link rel="stylesheet" href="../css/accountInfo.css">
</head>
<body>
    <header>
        <h1 id="logo"><img src="../images/logo.png" alt="SAMPLE COMPANY"></h1>
    </header>

    <section class="mo-3">
        <h2>編集内容確認</h2>
        <p>以下の内容で編集します。よろしいですか？</p>

        <table border="1">
            <tr><th>金額</th><td>${param.monetary} 円</td></tr>
            <tr><th>期限</th><td>${param.deadline}</td></tr>

        </table>

        <form action="../c_detail/C_detailUpdate.action" method="post">
            <input type="hidden" name="postid" value="${param.postid}">
            <input type="hidden" name="monetary" value="${param.monetary}">
            <input type="hidden" name="deadline" value="${param.deadline}">

            <button type="submit">編集を確定</button>
        </form>

        <button type="button" onclick="history.back()">戻る</button>
    </section>

    <footer>
        <small>Copyright&copy; SAMPLE COMPANY All Rights Reserved.</small>
    </footer>
</body>
</html>
