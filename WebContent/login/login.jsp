<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ログインページ</title>
    <style>
        /* ヘッダーのスタイル */
      /* ヘッダーのスタイル */
/* ヘッダーのスタイル */
header {
    height: 300px; /* 高さを少し高くして背景が見えるように調整 */
    position: relative;
    background: url(../images/mainimg.jpg) no-repeat center center / cover; /* 背景画像の読み込み */
    background-size: cover;  /* 背景画像が画面に合わせて拡大縮小 */
}

/* ロゴ画像のスタイル */
header #logo img {
    display: block;
    width: 200px; /* ロゴ画像の幅を200pxに戻す */
    position: absolute;
    left: 50%;
    transform: translateX(-50%); /* 画像を中央に配置 */
    bottom: 80px; /* 画像を下から80pxに配置 */
}

h1 {
    margin: 0;
}

/* タイトル */
h3 {
    font-size: 105px; /* ロゴ文字の大きさを元に戻す */
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

/* フッター */
footer {
    color: #000000; /* 文字色 */
    text-align: center;
    font-size: 85%; /* 文字サイズ */
    padding: 10px 0; /* 上下の余白を追加 */
    background-color: #f8f8f8; /* 背景色を薄いグレーに設定 */
    margin-top: 20px; /* フッターとの間に余白を追加 */
}

.container {
    width: 300px;
    margin: 0 auto;
    padding: 30px;
    border: 2px solid #007bff;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    margin-top: 30px; /* 上部に余白 */
    margin-bottom: 60px; /* footerとの間に余白を確保 */
    opacity: 0;
    transform: translateY(100px);
    transition: opacity 1s ease, transform 1s ease;
}

.container.visible {
    opacity: 1;
    transform: translateY(0);
}

.form-group {
    margin: 10px 0;
}

label {
    display: block;
    text-align: left;
    margin-bottom: 5px;
}

input[type="text"], input[type="password"], button {
    width: 100%;
    padding: 12px;
    border: 1px solid #ccc;
    border-radius: 4px;
    margin-bottom: 10px;
    box-sizing: border-box;
    height: 40px;
    font-size: 16px;
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


    </style>
</head>

<%
    // すでにセッションが開始されている場合はログイン画面にアクセスできないようにする
    if (session.getAttribute("username") != null) {
        response.sendRedirect("../common/index.jsp");
        return;
    }

    String loginMessage = "";

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // データベース接続情報
        String url = "jdbc:postgresql://localhost:5432/team_f"; // サーバモードでの接続
        String dbUser = "postgres";  // ユーザー名
        String dbPassword = "Team_F";  // パスワード
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("org.postgresql.Driver");
            // PostgreSQLデータベース接続
            conn = DriverManager.getConnection(url, dbUser, dbPassword);
            String sql = "SELECT * FROM SIGNUP WHERE USER_NAME = ? AND PASSWORD = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);
            rs = stmt.executeQuery();

            // ユーザーが見つかればセッションに設定
            if (rs.next()) {
                session.setAttribute("username", username);
                response.sendRedirect("../common/index.jsp");
            } else {
                loginMessage = "ユーザー名またはパスワードが間違っています。";
            }
        } catch (Exception e) {
            e.printStackTrace();
            loginMessage = "エラーが発生しました: " + e.getMessage();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>

<body>

<header>
    <!-- ロゴ画像を囲むdiv要素 -->
    <div id="logo">
        <img src="../images/logo.png" alt="ロゴ画像"> <!-- 画像のパスを正しく設定 -->
        <h3>Login</h3> <!-- ロゴテキストを「Login」に変更 -->
    </div>
</header>

<h2>ログインページ</h2>

<div class="container" id="loginFormContainer">

<form method="POST" action="login.jsp" autocomplete="off">
    <div class="form-group">
        <label for="username">ユーザー名:</label>
        <input type="text" name="username" id="username" placeholder="ユーザー名を入力" value="" required autocomplete="off">
    </div>
    <div class="form-group">
        <label for="password">パスワード:</label>
        <input type="password" name="password" id="password" placeholder="パスワードを入力" value="" required autocomplete="off">
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
        loginForm.classList.add('visible');  // フォームを表示

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
        }, 15); // 10ミリ秒ごとにスクロールを更新（速さを調整）
    };
</script>

</body>
</html>
