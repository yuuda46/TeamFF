<%@ page contentType="text/html;charset=UTF-8" %>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>ログインエラー</title>
</head>
<body>
    <h1>ログインエラー</h1>
    <p><%= request.getAttribute("errorMessage") %></p>
    <p><a href="login.jsp">戻る</a></p>
</body>
</html>
