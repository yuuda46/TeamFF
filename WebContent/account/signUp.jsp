<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<!DOCTYPE html>
<html lang="ja">
<header>


<h1 id="logo"><img src="../images/logo.png" alt="SAMPLE COMPANY"></h1>
<h3 class="titlesize">ACCOUNT</h3>



</header>
<head>
    <meta charset="UTF-8">
    <title>新規ユーザー登録</title>
    <!-- style.cssを読み込む -->
    <link rel="stylesheet" href="../css/account.css">
    <script>
        // パスワード表示/非表示切り替え
        function togglePasswordVisibility() {
            const passwordField = document.getElementById("password");
            const passwordToggle = document.getElementById("passwordToggle");

            if (passwordToggle.checked) {
                passwordField.type = "text";
            } else {
                passwordField.type = "password";
            }
        }
    </script>
</head>

<body>
    <section class="mo-4">



        <h2 class="titlesize h3 mb-3 fw-normal bg-opacity-10 py-2 px-4 user">新規ユーザー登録</h2>


        <form class="mx-3" action="../account/SignUp.action" method="post">

    <div class="form-row">
        <div class="form-group">
        <label>氏名</label><br>
		<input class="select-shape" type="text" name="name" placeholder="氏名を入力してください" required="required" value="${name}"><br>
		<c:if test="${not empty errorName}">
		    <div id="error-message" style="color:red;">
		        ${errorName}
		    </div>
		</c:if>
		</div>

	<div class="form-group">
		<label>ユーザ名</label><br>
		<input class="select-shape" type="text" name="user_name" placeholder="ユーザ名を入力(英数字＆記号)" required="required" value="${user_name}"><br>
		<c:if test="${not empty errorUserName}">
		    <div id="error-message" style="color:red;">
		        ${errorUserName}
		    </div>
		</c:if>
		   <%-- エラーメッセージの表示 --%>
            <c:if test="${not empty error1}">
                <div id="error-message" style="color:red;">
                    ${error1}
                </div>
            </c:if>
           </div>
    	</div>


    <div class="form-row">
        <div class="form-group">
		<div class="password-container">
		    <label>パスワード</label>
		    <input class="select-shape" type="password" id="password" name="password" placeholder="パスワードを入力(英数字＆記号)" required="required" value="${password}">
		    <label class="password-toggle-label">
		        <input type="checkbox" id="passwordToggle" class="password-toggle" onclick="togglePasswordVisibility()">
		        表示
		    </label>
		    <c:if test="${not empty errorPassword}">
		        <div id="error-message" style="color:red;">
		            ${errorPassword}
		        </div>
		    </c:if>
		    </div>

		   <%-- エラーメッセージの表示 --%>
            <c:if test="${not empty error2}">
                <div id="error-message" style="color:red;">
                    ${error2}
                </div>
            </c:if>
		</div>


		<div class="form-group">
		<label>電話番号</label><br>
		<input class="select-shape" type="text" name="phone_number" placeholder="電話番号を入力(例)090-090-090" required="required" value="${phone_number}"><br>
		<c:if test="${not empty errorPhoneNumber}">
		    <div id="error-message" style="color:red;">
		        ${errorPhoneNumber}
		    </div>
		</c:if>

		   <%-- エラーメッセージの表示 --%>
            <c:if test="${not empty error3}">
                <div id="error-message" style="color:red;">
                    ${error3}
                </div>
            </c:if>
          </div>
    	</div>


    <div class="form-row">
        <div class="form-group">
		<label>メールアドレス</label><br>
		<input class="select-shape" type="email" name="email" placeholder="メールアドレスを入力してください" required="required" value="${email}"><br>
		<c:if test="${not empty errorEmail}">
		    <div id="error-message" style="color:red;">
		        ${errorEmail}
		    </div>
		</c:if>


		   <%-- エラーメッセージの表示 --%>
            <c:if test="${not empty error4}">
                <div id="error-message" style="color:red;">
                    ${error4}
                </div>
            </c:if>
            </div>


	<div class="form-group">
		<label>郵便番号</label><br>
		<input class="select-shape" type="text" name="post_code" placeholder="郵便番号(例)090-090" required="required" value="${post_code}"><br>
		<c:if test="${not empty errorPostCode}">
		    <div id="error-message" style="color:red;">
		        ${errorPostCode}
		    </div>
		</c:if>
		</div>
		</div>

		<label>住所</label><br>
		<input class="select-shape" type="text" name="address" placeholder="住所を入力してください" required="required" value="${address}"><br>
		<c:if test="${not empty errorAddress}">
		    <div id="error-message" style="color:red;">
		        ${errorAddress}
		    </div>
		</c:if>


     <button type="submit" class="SignUp.action">登録して終了</button>
        </form>

        <form action="../menu/index.html" method="get">
            <button class="btn btn-secondary mt-3" type="submit">戻る</button>
        </form>
    </section>
    <footer>
	<small>Copyright&copy; <a href="index.html">SAMPLE COMPANY</a> All Rights Reserved.</small>
	</footer>
</body>
</html>
