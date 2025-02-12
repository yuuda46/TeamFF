<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<% request.setCharacterEncoding("UTF-8"); %>

<link rel="stylesheet" href="../css/notice.css">

<c:import url="/common/base.jsp">
    <c:param name="content">
        <section class="mo-4">
            <h2 class="titlesize h3 mb-3 fw-normal bg-opacity-10 py-2 px-4 user position_center">集金物入力</h2>

            <div class="container2">

            <form class="mx-3 detail_font" action="c_detail_con.jsp" method="post">
<%
    // Javaから受け取った postid を取得
    String postid = (String) request.getAttribute("postid");
    System.out.println("Received in form.jsp: " + postid); // 確認用
%>

<input type="hidden" name="postid" value="<%= postid %>">

					<div class="form-group">
					    <label class="right_margin">金額:</label>
					    <input class="select-shape form_text2 form_top margin_left_10"
					           type="number"
					           name="monetary"
					           placeholder="例:1000(円)"
					           required="required"
					           min="0"
					           max="999999999"
					           step="10"
					           value="${monetary}"
					           style="${not empty errorMonetary ? 'border: 2px solid red;' : ''}">
					    <br>
					    <c:if test="${not empty errorMonetary}">
					        <div id="error-message" style="color:red;">${errorMonetary}</div>
					    </c:if>
					</div>

                    <div class="form-group">
                        <label class="right_margin">期限:</label>
                        <input class="select-shape form_text3 form_top margin_left_10" type="date" name="deadline" placeholder="期限を入力してください" required="required" value="${deadline}"><br>
                        <c:if test="${not empty errorDeadline}">
                            <div id="error-message" style="color:red;">${errorDeadline}</div>
                        </c:if>
                    </div>




                <button type="submit" class="C_detail.action button_style keep_button float_right margin_top_18">データを登録</button>
            </form>

            <form action="../c_detail/C_detailList.action" method="get">
                <button class="btn btn-secondary button_style keep_button" type="submit">戻る</button>
            </form>
				</div>
        </section>

        <script>
        document.getElementById("monetary").addEventListener("input", function() {
            let monetaryField = document.getElementById("monetary");
            let errorField = document.getElementById("monetary-error");
            let value = monetaryField.value;

            if (value.length > 9) {
                monetaryField.value = value.slice(0, 9); // 10桁に制限
                errorField.textContent = "金額は10桁までしか入力できません。";
            } else {
                errorField.textContent = "";
            }
        });
    </script>
    </c:param>
</c:import>
