<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
<header>
<h1 id="logo"><img src="../images/logo.png" alt="SAMPLE COMPANY"></h1>
<h3 class="titlesize">PsReset</h3>
</header>

<head>
<meta charset="UTF-8">
<title>パスワードリセット</title>
<style>

header {
    height: 300px; /* 高さを画面の一部に設定 */
    position: relative;
    background: url(../images/mainimg.jpg) no-repeat center center / cover; /* 背景画像の読み込み */
}

/* ロゴ画像のスタイル */
header {
    height: 300px; /* 高さを指定 */
    position: relative;
    background: url(../images/mainimg.jpg) no-repeat center center / cover; /* 背景画像 */
}

/* ロゴ画像のスタイル */
header #logo img {
    display: block;
    width: 200px; /* ロゴ画像の幅を変更 */
    position: absolute;
    left: 50%;
    transform: translateX(-50%); /* 画像を中央に配置 */
    bottom: 80px; /* 画像を下から80pxに配置 */
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

/* フッター */
footer {
    color: #000000; /* 文字色 */
    text-align: center;
    font-size: 85%; /* 文字サイズ */
    padding: 10px 0; /* 上下の余白を追加 */
    background-color: #f8f8f8; /* 背景色を薄いグレーに設定 */
    margin-top: 10px; /* 青い枠線の下に表示されるように余白を追加 */
}

.container {
    width: 300px;
    margin: 0 auto;
    padding: 30px;
    border: 2px solid #007bff;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    margin-top: 30px; /* 上部に余白 */
    margin-bottom: 50px; /* footerとの間に余白を確保 */
}

.container.visible {
    opacity: 1;
    transform: translateY(0);
}

.form-group {
    margin: 10px 0;s
}

label {
    display: block;
    text-align: left;
    margin-bottom: 5px;
}

input, button {
    width: 100%; /* 幅を100%に設定して枠の長さを統一 */
    padding: 10px; /* パディングを追加して内部スペースを統一 */
    margin-bottom: 15px;
    border-radius: 4px;
    box-sizing: border-box; /* ボックスの幅にパディングとボーダーを含める */
    height: 40px; /* 高さを指定してボタンと一致させる */
}

input {
    border: 1px solid #ccc;
}

button {
    background-color: #ff3333; /* 赤色 */
    color: white;
    border: none;
    cursor: pointer;
}

button:hover {
    background-color: #e60000; /* ホバー時に少し濃い赤 */
}

.back-btn {
    display: inline-block;
    padding: 5px 10px; /* 少し小さめに調整 */
    text-decoration: none; /* 下線を引かない */
    color: black; /* 通常時は黒色 */
    font-size: 16px; /* 文字サイズを調整 */
}

.back-btn:hover {
    color: red; /* ホバー時に赤色に変更 */
}

.login-link {
    display: inline-block;
    padding: 5px 10px;
    text-decoration: none;
    color: #007bff; /* 通常時は青色 */
    font-size: 16px;
}

.login-link:hover {
    color: #0056b3; /* ホバー時に少し濃い青に変更 */
}

.message {
    color: green;
    margin-bottom: 15px;
}

.error {
    color: red;
    margin-bottom: 15px;
}

h2 {
    color: #333;
    font-size: 2em;
    font-weight: bold;
    margin-bottom: 20px; /* 下の余白を減らす */
    padding-left: 20px;
    text-align: center; /* 文字を中央揃え */
}

</style>
</head>

<body>
<h2>パスワードの再設定</h2>
<div class="container" id="resetFormContainer">

<%
    // 初期化
    String message = "";
    List<String> errorMessages = new ArrayList<String>();

    // パスワードに関する正規表現（半角英数字5文字以上）
    String passwordRegex = "^[a-zA-Z0-9]{5,}$"; // 半角英数字5文字以上
    // パスワードに同じ文字が連続して使われていないか確認する正規表現
    String noRepeatingCharsRegex = "(.)\\1"; // 同じ文字が1回連続する場合にマッチ

    // POSTリクエスト時の処理
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String username = request.getParameter("username");
        String newPassword = request.getParameter("newPassword");

        // パスワードのチェック（5文字以上の半角英数字）
        if (newPassword == null || !newPassword.matches(passwordRegex)) {
            errorMessages.add("新しいパスワードは半角英数字5文字以上で入力してください。");
        }

        // パスワードに同じ文字が連続して使われていないかチェック
        if (newPassword != null && newPassword.matches(".*(\\w)\\1.*")) {
            errorMessages.add("パスワードには同じ文字を連続して使用できません。");
        }

        // エラーがなければパスワードを更新
        if (errorMessages.isEmpty()) {
            // データベース接続情報
            String url = "jdbc:postgresql://localhost:5432/team_f"; // サーバモードでの接続
            String dbUser = "postgres";  // ユーザー名
            String dbPassword = "Team_F";  // パスワード
            Connection conn = null;
            PreparedStatement stmt = null;

            try {
                Class.forName("org.postgresql.Driver");
                // サーバモードでデータベース接続
                conn = DriverManager.getConnection(url,dbUser, dbPassword);
                String query = "UPDATE SIGNUP SET PASSWORD = ? WHERE USER_NAME = ?";
                stmt = conn.prepareStatement(query);
                stmt.setString(1, newPassword);
                stmt.setString(2, username);

                int updated = stmt.executeUpdate();

                if (updated > 0) {
                    message = "パスワードが正常にリセットされました。";
                } else {
                    errorMessages.add("ユーザーが見つかりません。");
                }
            } catch (Exception e) {
                errorMessages.add("エラーが発生しました: " + e.getMessage());
            } finally {
                // リソースを閉じる
                try {
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close(); // 接続を閉じる
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
%>

<%-- メッセージ表示 --%>
<% if (!message.isEmpty()) { %>
<div class="message"><%= message %></div>
<% } %>
<% if (!errorMessages.isEmpty()) { %>
<div class="error">
<ul>
<% for (String error : errorMessages) { %>
<li><%= error %></li>
<% } %>
</ul>
</div>
<% } %>

<%-- パスワードリセットフォーム --%>

	<form method="POST" action="">
    <label for="username">ユーザー名:</label>
    <input type="text" id="username" name="username" placeholder="ユーザー名を入力" required>

    <label for="currentPassword">現在のパスワード:</label>
    <input type="password" id="currentPassword" name="currentPassword" placeholder="現在のパスワードを入力" required>

    <label for="newPassword">新しいパスワード:</label>
    <input type="password" id="newPassword" name="newPassword" placeholder="新しいパスワードを入力" required>

    <button type="submit">パスワードを変更</button>
</form>

	<!-- ログイン画面に戻る -->
<p style="text-align: center;"><a href="login.jsp" class="login-link">ログイン画面に戻る</a></p>

	<!-- 戻るボタン -->
<p style="text-align: center;"><a href="javascript:history.back()" class="back-btn" id="backLink">戻る</a></p>

</div>

<footer>
<small>Copyright&copy; <a href="index.html" style="text-decoration: underline; color: #007bff; border: none; background: transparent;">SAMPLE COMPANY</a> All Rights Reserved.</small>
</footer>

<!-- スクロール機能の読み込み -->
<%@ include file="scroll.jsp" %>

</body>
</html>