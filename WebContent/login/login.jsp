<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ログインページ</title>
<header>
    <h1 id="logo"><img src="../images/logo.png" alt="SAMPLE COMPANY"></h1>
    <h3 class="titlesize">Login</h3>
</header>

<style>
/* 共通 */
body {
    margin: 0;
}

/* 背景画像の設定 */
header {
    height: 300px; /* 高さを画面の一部に設定 (必要に応じて調整) */
    position: relative;
    background: url(../images/mainimg.jpg) no-repeat center center / cover; /* 背景画像の読み込み */
}

/* ロゴ画像のスタイル */
header #logo img {
    display: block;
    width: 200px; /* ロゴ画像の幅 */
    position: absolute;
    left: 50%;
    transform: translateX(-50%); /* 画像を中央に配置 */
    bottom: 80px; /* 画像を下から60pxに配置 (必要に応じて調整) */
}

/* タイトル */
h3 {
    font-size: 105px;
    color: #ffffff;
    width: 60px; /* ロゴ画像の幅 */
    height: 140px;
    position: absolute;
    left: 55%;
    transform: translateX(-50%); /* 画像を中央に配置 */
    bottom: 90px; /* 画像を下から20pxに配置 */
    margin: 0;
}

body {
    margin: 0;
    min-height: 100vh; /* ビューポートの高さに合わせて最小高さを設定 */
    display: flex;
    flex-direction: column; /* コンテンツを縦に並べる */
}

/* ログインフォーム */
.container {
    width: 300px;
    margin: 0 auto;
    padding: 30px;
    border: 2px solid #007bff;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    text-align: left;
    opacity: 0;
    transform: translateY(100px);
    transition: opacity 1s ease, transform 1s ease;
}

/* フォームの表示 */
.container.visible {
    opacity: 1;
    transform: translateY(0);
}



input[type="text"], input[type="password"], button {
    width: 100%;
    padding: 12px; /* 入力欄の高さを調整 */
    border: 1px solid #ccc;
    border-radius: 4px;
    margin-bottom: 10px;
    box-sizing: border-box;
    height: 40px;
    font-size: 16px; /* 入力欄の文字サイズを調整 */
}

button {
    background-color: #00bfff;
    color: white;
    cursor: pointer;
    border: none;
    padding: 12px;
    border-radius: 5px;
    font-size: 16px;
}

button:hover {
    background-color: #0056b3;
}

h2 {
    text-align: center;
    color: #333;
    font-size: 2em;
    font-weight: bold;
    margin-bottom: 30px;
}

footer {
    color: #000000;
    text-align: center;
    font-size: 85%;
    padding: 10px 0;
    background-color: #f8f8f8;
    margin-top: 20px;
}
</style>
</head>

<%
    if (session.getAttribute("username") != null) {
        response.sendRedirect("../common/index.jsp");
        return;
    }
%>

<body>

<h2>ログインページ</h2>

<div class="container" id="loginFormContainer">

<%
    String loginMessage = "";
    // データベース接続コードが続きます
%>

<form method="POST" action="login.jsp" autocomplete="off">
    <div class="form-group">
        <label for="username">ユーザー名:</label>
        <input type="text" name="username" placeholder="ユーザー名を入力" value="" required autocomplete="off">
    </div>
    <div class="form-group">
        <label for="password">パスワード:</label>
        <input type="password" name="password" placeholder="パスワードを入力" value="" required autocomplete="off">
    </div>
    <button type="submit">ログイン</button>
</form>

<p class="login-message"><%= loginMessage %></p>

<p style="text-align: center;"><a href="pass_reset.jsp">パスワードを忘れた</a></p>

</div>

<footer>
    <small>Copyright&copy; <a href="index.html">SAMPLE COMPANY</a> All Rights Reserved.</small>
</footer>

<script>
    window.onload = function() {
        // フォームを表示
        var loginForm = document.getElementById('loginFormContainer');
        loginForm.classList.add('visible');

        // スクロール対象の位置
        var targetPosition = loginForm.offsetTop - 20; // 20pxの余白をつけてスクロール
        var currentPosition = window.pageYOffset; // 現在のスクロール位置
        var distance = targetPosition - currentPosition; // 移動すべき距離
        var step = distance / 100; // スクロールのステップ数を指定

        // スクロールを遅くするための遅延処理
        var scrollInterval = setInterval(function() {
            window.scrollBy(0, step); // スクロール位置を少しずつ更新

            // スクロールが目標位置に近づいたら停止
            if (Math.abs(window.pageYOffset - targetPosition) <= Math.abs(step)) {
                window.scrollTo(0, targetPosition); // 目標位置にぴったりスクロール
                clearInterval(scrollInterval); // インターバルをクリア
            }
        }, 15); // 15ミリ秒ごとにスクロールを更新
    };
</script>


</body>
</html>
