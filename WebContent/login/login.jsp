<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page session="true" %> <!-- セッションを有効にする -->
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ログインページ</title>

<link href="https://fonts.googleapis.com/css?family=Noto+Serif+JP" rel="stylesheet">

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

/* タイトル */
h3 {
	font-size: 105px;
    color: #ffffff;
    width: 60px; /* ロゴ画像の幅 */
    height:140px;
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
    font-family: 'Noto Serif JP', sans-serif;
}


        .form-group {
            margin: 10px 0;
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

/* 入力欄とボタンのスタイルを調整 */
input[type="text"], input[type="password"], button, .reset-button, .back-button {
    width: 300px; /* 入力欄とボタンを同じ幅にする */
    height: 40px; /* 入力欄とボタンを同じ高さにする */
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
    margin-bottom: 10px; /* 入力欄とボタンの間にスペース */
    font-family: 'Noto Serif JP', sans-serif;
}

/* ボタンのスタイル */
button {
    background-color: #00bfff; /* 薄い青色 */
    color: white;
    cursor: pointer;
    border: none;
    font-size: 16px;
    font-family: 'Noto Serif JP', sans-serif;
}

button:hover {
    background-color: #0056b3;
}

/* パスワードを忘れたボタンと戻るボタンのスタイル */
.reset-button, .back-button {
    display: inline-block; /* インラインブロック要素にして、横並びを防ぐ */
}

.reset-button:hover, .back-button:hover {
    background-color: #ff0000; /* ホバー時の色 */
}


        h1{
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


/* ボタンの間隔を縮める */
button {
    margin-bottom: 5px; /* ログインボタンの下の余白を縮める */
}

/* 「パスワードを忘れた」ボタンとログインボタンの間隔を縮める */
p {
    margin-top: 5px;
    margin-bottom: 5px; /* 「パスワードを忘れた」ボタンとログインボタンの間隔を縮める */
}

/* 戻るボタンの間隔を縮める */
p a {
    margin-top: 5px;
    margin-bottom: 5px; /* 戻るボタンと「パスワードを忘れた」ボタンの間隔を縮める */
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

<header>


<h1 id="logo"><img src="../images/logo.png" alt="SAMPLE COMPANY"></h1>
<h3 class="titlesize">Login</h3>



</header>

<h2>ログインページ</h2>

<div class="container" id="loginFormContainer">
<%
    String message = "";
    List<String> errorMessages = new ArrayList<String>();

    // パスワードの長さ（5文字以上）のチェック
    String lengthError = "・新しいパスワードは5文字以上で入力してください。";
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
            errorMessages.add("・新しいパスワードは半角英数字で入力してください。");
        }

        // 新しいパスワードが英字のみの場合
        if (newPassword != null && newPassword.matches(alphabetOnlyRegex)) {
            errorMessages.add("・新しいパスワードは英字だけでは登録できません。");
        }

        // 新しいパスワードが数字のみの場合
        if (newPassword != null && newPassword.matches(numberOnlyRegex)) {
            errorMessages.add("・新しいパスワードは数字だけでは登録できません。");
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
    <input type="text" id="username" name="username" placeholder="ユーザー名を入力(半角英数字)" required>

    <label for="currentPassword">現在のパスワード:</label>
    <input type="password" id="currentPassword" name="currentPassword" placeholder="現在のパスワードを入力(半角英数字)" required>

    <label for="newPassword">新しいパスワード:</label>
    <input type="password" id="newPassword" name="newPassword" placeholder="新しいパスワードを入力(半角英数字)" required>

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
    .form-group {
        margin: 5px 0; /* 上下の余白を少し広げる */
        position: relative; /* エラーメッセージの配置基準にする */
    }
    .error-message {
      color: red;
      font-size: 12px;
      margin-top: 5px; /* エラーメッセージと入力欄の間隔を開ける */
      text-align: left; /* 左揃えにする */
      width: 100%; /* 入力欄に合わせて幅を広げる */
      padding-left: 0; /* 左端からの余白を削除 */
    }


    .error-message:last-child {
        margin-top: 10px; /* ログインエラーメッセージの間隔調整 */
        font-size: 14px; /* ログインエラーメッセージのフォントサイズを調整 */
    }

    button {
        margin-top: 10px; /* ボタンとエラーメッセージの間隔を確保 */
    }

        /* ログインボタン */
    .login-btn {
        width: 300px; /* 幅を指定 */
        height: 40px; /* 高さを指定 */
        background-color: black; /* 通常時の色を黒に変更 */
        color: white; /* 文字色は白 */
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-size: 16px;
        text-align: center;
    }
    .login-btn:hover {
        background-color: #ff4d4d;  /* ホバー時に少し薄い黒色に変更 */
    }

    /* 戻るボタンのスタイル */
     .back-button {
        display: inline-block;
        padding: 10px 20px;
        background-color: #808080; /* 通常時の色を灰色に変更 */
        color: white; /* 文字色は白 */
        text-decoration: none;
        border-radius: 4px;
        font-size: 16px;
        cursor: pointer;
    }

/* フォーム全体を中央に配置 */
#loginFormContainer {
    width: 350px; /* フォームの幅 */
    padding: 20px;
    border: 2px solid #ccc;
    border-radius: 8px;
    margin: 0 auto; /* フォーム全体を中央に配置 */
    text-align: left; /* テキストの配置は左寄せ（ラベルや入力欄など） */
}



/* 入力欄やボタンに個別の枠線は変更しない */
input[type="text"], input[type="password"], button, .reset-button, .back-button {
    width: 300px; /* 入力欄とボタンを同じ幅にする */
    height: 40px; /* 入力欄とボタンを同じ高さにする */
    padding: 10px;
    border: 1px solid #ccc; /* 枠線を追加 */
    border-radius: 4px;
    box-sizing: border-box;
    margin-bottom: 10px; /* 入力欄とボタンの間にスペース */
    font-family: 'Noto Serif JP', sans-serif;
}

/* ログインボタンに追加のスタイル */
button {
    background-color: #00bfff; /* 薄い青色 */
    color: white;
    cursor: pointer;
    border: none;
    font-size: 16px;
}

button:hover {
    background-color: #0056b3; /* ホバー時に色が変わる */
}

</style>

<!-- パスワードを忘れたリンク -->
<p style="text-align: center;">
    <a href="pass_reset.jsp" class="reset-link">パスワードを忘れた方は<span class="highlight">こちら</span></a>
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

<!-- CSSスタイル -->
<style>
    /* ボタン共通のスタイル */
    .reset-button, .back-button {
        display: inline-block;
        padding: 10px 20px;
        color: white;
        text-decoration: none;
        border-radius: 5px;
        font-size: 16px;
        cursor: pointer;
    }

    /* ホバー時のスタイル */
    .reset-button:hover {
        background-color: #ff0000; /* パスワードリセットボタンのホバー時の色 */
    }

    .back-button:hover {
        background-color: #ff4d4d; /* 戻るボタンのホバー時の色 */
    }

    /* 左揃えにする */
    p {
        text-align: left; /* ボタンを左揃えにする */
    }
</style>

</div>

<!-- フッター -->
<footer>
    <small>Copyright&copy; SAMPLE COMPANY All Rights Reserved.</small>
</footer>

<script>
    window.onload = function() {
        // フォームを表示
        var loginForm = document.getElementById('loginFormContainer');
        loginForm.classList.add('visible');
    };
</script>
<!-- スクロール機能の読み込み -->
<%@ include file="scroll.jsp" %>

</body>
</html>
