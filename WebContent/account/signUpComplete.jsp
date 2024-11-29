<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>

<header>
    <h1 id="logo"><img src="../images/logo.png" alt="SAMPLE COMPANY"></h1>
    <h3 class="titlesize">ACCOUNT</h3>
</header>
<head>

    <title>登録完了</title>
    <link rel="stylesheet" href="../css/account.css">

        <script>
        // カウントダウン用の秒数を設定
        var countdown = 5;

        // カウントダウンを表示する関数
        function updateCountdown() {
            if (countdown <= 0) {
                window.location.href = "../login/login.jsp"; // 5秒後に自動で遷移
            } else {
                document.getElementById("countdown").textContent = countdown + "秒後にホーム画面へ戻ります";
                countdown--; // 秒数を1減らす
            }
        }

        // 1秒ごとにカウントダウンを更新
        setInterval(updateCountdown, 1000);
    </script>
</head>

<body>
    <div class="main-container">
        <h2>登録が完了しました。</h2>
        <p id="countdown">5秒後にログイン画面に移動します。</p>
        <p>すぐに移動する場合は<a href="../login/login.jsp">こちら</a>をクリックしてください。</p>
    </div>
    <footer>
    <small>Copyright&copy; <a href="index.html">SAMPLE COMPANY</a> All Rights Reserved.</small>
	</footer>
</body>


</html>
