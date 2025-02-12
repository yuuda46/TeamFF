<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
<header>
    <h1 id="logo"><img src="../images/logo.png" alt="SAMPLE COMPANY"></h1>
    <title>パスワードリセット</title>
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
#resetFormContainer {
    width: 350px; /* 横幅を指定 */
    padding: 20px;
    border: 2px solid #ccc; /* 枠線の色 */
    border-radius: 8px; /* 角丸を追加 */
    margin: 0 auto; /* 左右中央揃え */
    background-color: #ffffff; /* 背景色を白に設定 */
    text-align: left; /* テキストを左寄せに設定 */
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
/* ラベルと入力欄、ボタンの間隔を調整 */
label {
    display: block;
    text-align: left;
    margin-bottom: 5px; /* ラベルと入力欄の間に10pxの間隔を追加 */
}

input[type="password"], input[type="text"] {
    display: block;
    width: 300px;
    height: 40px;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
    margin-bottom: 10px; /* 入力欄同士の間隔を15pxに変更 */
}

button {
    width: 300px;
    height: 40px;
    padding: 10px;
    border: none;
    border-radius: 4px;
    background-color: #000000;
    color: white;
    font-size: 14px;
    cursor: pointer;
    text-transform: uppercase;
    font-weight: bold;
    margin-top: 10px; /* ボタンと入力欄の間に20pxの間隔を追加 */
}

footer {
    color: #fff; /* 文字色 */
    text-align: center;
    font-size: 85%; /* 文字サイズ */
    padding: 10px 0; /* 上下の余白を追加 */
    background-color: #000; /* 背景色を薄いグレーに設定 */
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

.error {
    color: red;
    font-size: 14px;
    text-align: left;
    margin-top: 10px;
    padding-left: 0px;
    width: 300px;
    margin-left: 0px;
}

.error ul {
    padding-left: 20px;
    list-style-type: none;
}

.error li {
    margin-bottom: 5px;
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
    String message = "";
    List<String> errorMessages = new ArrayList<String>();

    // パスワードの長さ（5文字以上）のチェック
    String lengthError = "・5文字以上で入力してください。";
    // 半角英数字のチェック
    String passwordRegex = "^[a-zA-Z0-9]{5,}$"; // 半角英数字5文字以上
    String noRepeatingCharsRegex = "(.)\\1"; // 同じ文字や数字が1回連続する場合にマッチ
    String alphabetOnlyRegex = "^[a-zA-Z]{5,}$"; // 英字のみのパスワードにマッチ
    String numberOnlyRegex = "^[0-9]{5,}$"; // 数字のみのパスワードにマッチ
    String alphaNumericRegex = "^(?=.*[a-zA-Z])(?=.*[0-9])[a-zA-Z0-9]{5,}$"; // 英字と数字両方を含むパスワード

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String username = request.getParameter("username");
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");

        // ユーザー名のチェック
        if (username == null || username.isEmpty()) {
            errorMessages.add("・ユーザー名を入力してください。");
        }

        // 現在のパスワードのチェック
        if (currentPassword == null || currentPassword.isEmpty()) {
            errorMessages.add("・現在のパスワードを入力してください。");
        } else {
            String url = "jdbc:postgresql://localhost:5432/team_f";
            String dbUser = "postgres";
            String dbPassword = "Team_F";
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;

            try {
                Class.forName("org.postgresql.Driver");
                conn = DriverManager.getConnection(url, dbUser, dbPassword);

                String query = "SELECT * FROM SIGNUP WHERE USER_NAME = ?";
                stmt = conn.prepareStatement(query);
                stmt.setString(1, username);
                rs = stmt.executeQuery();

                if (!rs.next()) {
                    errorMessages.add("・ユーザーが見つかりません。");
                } else {
                    // ユーザーが存在する場合、パスワードのチェック
                    String storedPassword = rs.getString("PASSWORD");
                    if (!storedPassword.equals(currentPassword)) {
                        errorMessages.add("・現在のパスワードが違います。");
                    }
                }
            } catch (Exception e) {
                errorMessages.add("エラーが発生しました: " + e.getMessage());
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

        // 新しいパスワードの長さチェック（5文字以上）
        if (newPassword == null || newPassword.length() < 5) {
            errorMessages.add(lengthError);
        }

        // 新しいパスワードの英数字チェック（半角英数字のみ）
        if (newPassword != null && !newPassword.matches("^[a-zA-Z0-9]+$")) {
            errorMessages.add("・半角英数字で入力してください。");
        }
        // 英字と数字両方を含むパスワードチェック
        if (newPassword != null && !newPassword.matches(alphaNumericRegex)) {
            errorMessages.add("・英字と数字を両方含む必要があります。");
        }

        // 同じ文字や数字を連続して使えないチェック
        if (newPassword != null && newPassword.matches(noRepeatingCharsRegex)) {
            errorMessages.add("・同じ文字や数字を連続して使用できません。");
        }

        // エラーがない場合、パスワード更新処理を実行
        if (errorMessages.isEmpty()) {
            String url = "jdbc:postgresql://localhost:5432/team_f";
            String dbUser = "postgres";
            String dbPassword = "Team_F";
            Connection conn = null;
            PreparedStatement stmt = null;

            try {
                Class.forName("org.postgresql.Driver");
                conn = DriverManager.getConnection(url, dbUser, dbPassword);
                String query = "UPDATE SIGNUP SET PASSWORD = ? WHERE USER_NAME = ?";
                stmt = conn.prepareStatement(query);
                stmt.setString(1, newPassword);
                stmt.setString(2, username);

                int updated = stmt.executeUpdate();

                if (updated > 0) {
                    message = "パスワードが正常にリセットされました。";
                    response.sendRedirect("login.jsp");  // ログイン画面にリダイレクト
                    return;
                } else {
                    errorMessages.add("・ユーザーが見つかりません。");
                }
            } catch (Exception e) {
                errorMessages.add("エラーが発生しました: " + e.getMessage());
            } finally {
                try {
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
%>

<form method="POST" action="">
    <label for="username">ユーザー名:</label>
    <input type="text" id="username" name="username" placeholder="ユーザー名を入力" required>

    <label for="currentPassword">現在のパスワード:</label>
    <input type="password" id="currentPassword" name="currentPassword" placeholder="現在のパスワードを入力" required>

    <label for="newPassword">新しいパスワード:</label>
    <input type="password" id="newPassword" name="newPassword" placeholder="新しいパスワードを入力" required>

    <%-- エラーメッセージ表示 --%>
    <% if (!errorMessages.isEmpty()) { %>
        <div class="error">
            <% for (String error : errorMessages) { %>
                <p><%= error %></p>
            <% } %>
        </div>
    <% } %>

    <button type="submit">パスワードを変更</button>
</form>

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

.highlight {
    color: #ff0000; /* 常時赤色に設定 */
    text-decoration: underline; /* 下線を追加 */
}

.highlight:hover {
    color: #cc0000; /* ホバー時に少し濃い赤色に設定 */
}

</style>

    </div>
<!-- フッター -->
<footer>
    <small>Copyright&copy; SAMPLE COMPANY All Rights Reserved.</small>
</footer>
<!-- スクロール機能の読み込み -->
<%@ include file="scroll.jsp" %>

</body>
</html>
