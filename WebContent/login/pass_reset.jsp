<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>パスワードリセット</title>
<style>
    body {
        font-family: Arial, sans-serif;
        text-align: center;
        margin: 20px;
    }
    .container {
        width: 300px;
        margin: 0 auto;
        padding: 30px;
        border: 2px solid #007bff;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
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
        background-color: #ff4d4d; /* 赤色 */
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
        text-decoration: underline; /* 下線を引く */
        color: #007bff; /* 青色に設定 */
        font-size: 16px; /* 文字サイズを調整 */
    }
    .back-btn:hover {
        color: #0056b3; /* ホバー時に青色が少し濃くなる */
    }
    .message {
        color: green;
        margin-bottom: 15px;
    }
    .error {
        color: red;
        margin-bottom: 15px;
    }
</style>
</head>
<body>
<h1>パスワードの再設定</h1>
<div class="container">

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
            String url = "jdbc:h2:tcp://localhost:9092/~/Team_F"; // サーバモードでの接続
            String user = "sa";
            String password = "";

            Connection conn = null;
            PreparedStatement stmt = null;

            try {
                Class.forName("org.h2.Driver");
                // サーバモードでデータベース接続
                conn = DriverManager.getConnection(url, user, password);
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
<form method="POST" action="pass_reset.jsp">
    <label for="username">ユーザー名:</label>
    <input type="text" id="username" name="username" placeholder="ユーザー名を入力" required>

    <label for="newPassword">新しいパスワード:</label>
    <input type="password" id="newPassword" name="newPassword" placeholder="新しいパスワードを入力" required>

    <button type="submit">パスワードを変更</button>
</form>

<!-- 戻るボタン -->
<a href="login.jsp" class="back-btn">ログイン画面に戻る</a>

</div>
</body>
</html>
