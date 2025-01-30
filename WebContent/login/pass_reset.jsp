<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
<header>
    <h1 id="logo"><img src="../images/logo.png" alt="SAMPLE COMPANY"></h1>
    <h3 class="titlesize">PsReset</h3>
</header>

<style>
/* 共通 */
/* 背景画像の設定 */
header {
    height: 300px; /* 高さを画面の一部に設定 */
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
    bottom: 80px; /* 画像を下から80pxに配置 */
}
header {
    margin-bottom: 30px;  /* ヘッダーの下に30pxの余白を追加 */
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
    bottom: 90px; /* 画像を下から90pxに配置 */
    margin: 0;
}
body {
    margin: 0;
    min-height: 100vh; /* ビューポートの高さに合わせて最小高さを設定 */
    display: flex;
    flex-direction: column; /* コンテンツを縦に並べる */
}

/* フォーム内の入力欄とボタンの中央揃え */
.container {
    display: flex;
    flex-direction: column;
    align-items: center; /* 水平方向の中央揃え */
    justify-content: center; /* 垂直方向の中央揃え（フォーム内のスペース調整） */
    text-align: center; /* フォーム内のテキストも中央揃え */
    margin-top: 50px; /* 必要に応じて上部に余白を追加 */
}

/* パスワードリセットフォーム */
form {
    display: block; /* デフォルトで縦並びになるように設定 */
}

/* 入力欄とボタンを縦に並べる */
input[type="password"], input[type="text"] {
    display: block;
    width: 300px;
    height: 40px;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
    margin-bottom: 5px; /* 入力欄同士の間隔 */
}

button {
    width: 300px;
    height: 40px;
    padding: 10px;
    border: none;
    border-radius: 4px;
    background-color: #000000;
    color: white;
    font-size: 14px; /* 文字サイズを14pxに変更 */
    cursor: pointer;
    text-transform: uppercase;
    font-weight: bold;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    transition: all 0.3s ease;
}


button:hover {
    background-color: #ff4d4d; /* ホバー時の背景色 */
}


/* パスワードを忘れたボタンと戻るボタンのスタイル */
.reset-button, .back-button {
    display: inline-block; /* インラインブロック要素にして、横並びを防ぐ */
}

.reset-button:hover, .back-button:hover {
    background-color: #ff0000; /* ホバー時の色 */
}

h1 {
    margin: 0;
}

.logout-btn {
    text-align: center;
}

.logout-btn a {
    padding: 10px 20px;
    background-color: #000000;
    color: white;
    text-decoration: none;
    border-radius: 4px;
    font-size: 16px;
}

.logout-btn a:hover {
    background-color: #c82333;
}

.login-message {
    text-align: center;
    font-size: 18px;
    color: red;
    font-weight: bold;
}

/* ラベルのスタイル */
label {
    display: block;
    text-align: left;
    margin-bottom: 5px;
}

footer {
    color: #000000; /* 文字色 */
    text-align: center;
    font-size: 85%; /* 文字サイズ */
    padding: 10px 0; /* 上下の余白を追加 */
    background-color: #f8f8f8; /* 背景色を薄いグレーに設定 */
    margin-top: 60px; /* 青い枠線の下に表示されるように余白を追加 */
}

h2 {
    text-align: center;  /* 中央揃え */
    color: #333;
    font-size: 2em;
    font-weight: bold;
    margin-bottom: 10px; /* 下部のマージンを縮める */
}

.container {
    margin-top: 10px; /* ログインフォームの上部の余白を縮める */
}


/* 通常時のリンクのスタイル */
.login-link {
    color: black; /* 通常時は黒色 */
    text-decoration: none; /* 下線を消す */
    font-size: 16px; /* フォントサイズ */
}

.login-link:hover {
    color: darkred; /* ホバー時に濃い赤色 */
}

.highlight {
    font-weight: bold; /* 「こちら」の部分を太字 */
    color: inherit; /* 「こちら」の部分の色を親の色（黒色）に合わせる */
}

</style>

<%
    if (session.getAttribute("username") != null) {
        response.sendRedirect("../common/index.jsp");
        return;
    }
%>

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
                String currentPassword = request.getParameter("currentPassword");
                String newPassword = request.getParameter("newPassword");

                // 現在のパスワードが正しいか確認
                if (currentPassword == null || currentPassword.isEmpty()) {
                    errorMessages.add("現在のパスワードを入力してください。");
                } else {
                    // データベース接続情報
                    String url = "jdbc:postgresql://localhost:5432/team_f"; // サーバモードでの接続
                    String dbUser = "postgres";  // ユーザー名
                    String dbPassword = "Team_F";  // パスワード
                    Connection conn = null;
                    PreparedStatement stmt = null;
                    ResultSet rs = null;

                    try {
                        Class.forName("org.postgresql.Driver");
                        // サーバモードでデータベース接続
                        conn = DriverManager.getConnection(url, dbUser, dbPassword);

                        // ユーザー名と現在のパスワードを照合
                        String query = "SELECT * FROM SIGNUP WHERE USER_NAME = ? AND PASSWORD = ?";
                        stmt = conn.prepareStatement(query);
                        stmt.setString(1, username);
                        stmt.setString(2, currentPassword);
                        rs = stmt.executeQuery();

                        if (!rs.next()) {
                            errorMessages.add("現在のパスワードが間違っています。");
                        }
                    } catch (Exception e) {
                        errorMessages.add("エラーが発生しました: " + e.getMessage());
                    } finally {
                        try {
                            if (rs != null) rs.close();
                            if (stmt != null) stmt.close();
                            if (conn != null) conn.close(); // 接続を閉じる
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                }

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
                        conn = DriverManager.getConnection(url, dbUser, dbPassword);
                        String query = "UPDATE SIGNUP SET PASSWORD = ? WHERE USER_NAME = ?";
                        stmt = conn.prepareStatement(query);
                        stmt.setString(1, newPassword);
                        stmt.setString(2, username);

                        int updated = stmt.executeUpdate();

                        if (updated > 0) {
                            message = "パスワードが正常にリセットされました。";
                            response.sendRedirect("login.jsp");
                            return;
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

        <!-- ログイン画面に戻るリンク -->
       <p style="text-align: center;">
    ログイン画面に戻る方は <a href="login.jsp" class="login-link"><span class="highlight">こちら</span></a>
</p>


        <style>
    .reset-link {
        font-size: 16px; /* フォントサイズ */
        color: black; /* 通常時のリンクの色 */
        text-decoration: none; /* 下線を除去 */
    }

    .reset-link:hover {
        color: black; /* リンク全体の色はホバー時も黒 */
    }

    /* 「こちら」部分の色を赤色、下線あり */
    .highlight {
        color: #ff0000; /* 通常時の色を赤色 */
        text-decoration: underline; /* 下線を表示 */
    }

    /* 「こちら」部分にホバー時に少し濃い赤色を適用 */
    .highlight:hover {
        color: #cc0000; /* ホバー時に少し濃い赤色 */
    }
</style>

    </div>

    <footer>
        <small>Copyright&copy; <a href="index.html" style="text-decoration: underline; color: #007bff; border: none; background: transparent;">SAMPLE COMPANY</a> All Rights Reserved.</small>
    </footer>

    <!-- スクロール機能の読み込み -->
    <%@ include file="scroll.jsp" %>

</body>
</html>