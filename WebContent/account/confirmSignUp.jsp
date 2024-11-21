<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ja">
<header>
    <h1 id="logo"><img src="../images/logo.png" alt="SAMPLE COMPANY"></h1>
    <h3 class="titlesize">ACCOUNT</h3>
</header>

<head>
    <!-- Link to the same stylesheet as the first JSP -->
    <link rel="stylesheet" href="../css/account.css">
</head>

<body>
<section class="mo-4">
    <h2 class="titlesize h3 mb-3 fw-normal bg-opacity-10 py-2 px-4 user">ユーザー情報確認</h2>

    <form class="mx-3" action="SignUp.action" method="post">
        <input type="hidden" name="confirm" value="true">
        <input class="select-shape" type="hidden" name="name" value="${name}">
        <input type="hidden" name="user_name" value="${user_name}">
        <input type="hidden" name="password" value="${password}">
        <input type="hidden" name="phone_number" value="${phone_number}">
        <input type="hidden" name="email" value="${email}">
        <input type="hidden" name="post_code" value="${post_code}">
        <input type="hidden" name="address" value="${address}">


        <div class="form-row">
            <div class="form-group">
            <div class="select-shape"><label>氏名: </label><span>${name}</span><br>
            </div>

            </div>
            <div class="form-group">
            <div class="select-shape">
                <label>ユーザ名: </label><span>${user_name}</span><br>
                </div>
            </div>
        </div>

        <div class="form-row">
            <div class="form-group">
				<div class="select-shape">
                <label>パスワード: </label>
                <span id="passwordDisplay">********</span>
                </div>
                <label class="password-toggle-label">
                    <input type="checkbox" id="togglePassword" class="password-toggle">表示/非表示
                </label><br>

            </div>
            <div class="form-group">
            <div class="select-shape">
                <label>電話番号: </label><span>${phone_number}</span><br>
                </div>
            </div>
        </div>

        <div class="form-row">
            <div class="form-group">
            <div class="select-shape">
                <label>メールアドレス: </label><span>${email}</span><br>
                </div>
            </div>
            <div class="form-group">
            <div class="select-shape">
                <label>郵便番号: </label><span>${post_code}</span><br>
                </div>
            </div>
        </div>

        <div class="form-group">
        <div class="select-shape">
            <label>住所: </label><span>${address}</span><br>
            </div>
        </div>


        <button type="submit" class="btn btn-primary">登録</button>
    </form>


    <button class="btn btn-secondary mt-3" type="submit" onclick="history.back()">戻る</button>
</section>

<footer>
    <small>Copyright&copy; <a href="index.html">SAMPLE COMPANY</a> All Rights Reserved.</small>
</footer>

<script>
    // Password toggle functionality for display
    const togglePassword = document.querySelector("#togglePassword");
    const passwordDisplay = document.querySelector("#passwordDisplay");

    togglePassword.addEventListener("change", function () {
        if (togglePassword.checked) {
            passwordDisplay.textContent = "${password}";
        } else {
            passwordDisplay.textContent = "********";
        }
    });
</script>
</body>
</html>
