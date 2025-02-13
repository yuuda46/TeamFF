<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- 文字化けの対策 --%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<%
	String sign_id=(String)request.getAttribute("sign_id");
%>

<c:import url="/common/base.jsp">
    <c:param name="content">
        <link rel="stylesheet" href="../css/collection.css">
        <div class="function container3">
            <section class="mo-4">
                <h2 class="h3 mb-3 fw-norma bg-opacity-10 py-2 px-4 C test large-bold position_center">入金ページ</h2>

                <%-- 検索フォーム --%>
                <form action="CollectionDeposit.action" method="get" onsubmit="return validateSignId()">
                    <div class="row border mx-3 mb-3 py-2 align-items-center rounded" id="filter">
                        <div class="test-wide mx-3">
                            <%-- signid フィールド --%>
                            <div class="notice_center">
	                            <div class="col-xl select-wide">
	                                <select class="select_size detail_font" required id="notice-f1-select" name="signid">
										<option value="0">----------</option>
										<c:forEach var="select" items="${select}">
											<option value=${select.id } <c:if test="${select.name==f2}">selected</c:if>>${select.name}</option>
										</c:forEach>
									</select>
	                            </div>
	                            <div class="col-xl text-center">
	                                <button class="margin_left_10 btn btn-secondary button_size button_style detail_font" id="filter-button">検索</button>
	                            </div>
                            </div>
                            <div class="mt-2 text-warning" id="error-message">${errors.get("f1")}</div>
                        </div>
                    </div>
                </form>

                <script>
                    function validateSignId() {
                        var signid = document.getElementById("signid").value;
                        if (signid.length !== 36) {
                            document.getElementById("error-message").innerText = "IDが36桁ではありません。入力し直してください。";
                            return false;
                        }
                        return true;
                    }
                </script>

				<c:if test="${empty Signup}">
                	<h3 class="h3 mb-3 fw-norma bg-opacity-10 py-2 px-4 C test small-bold">利用者を選択して検索してください</h3>
                </c:if>

                <%-- 名前の表示 --%>
                <c:if test="${not empty Signup}">
                	<h3 class="h3 mb-3 fw-norma bg-opacity-10 py-2 px-4 C test small-bold">このページには、まだ入金していない項目のみ表示しています</h3>
                    <h3>利用者情報</h3>
                    <table class="test-table table-hover mx-3">
                        <tr>
                            <th class="test-boder test-table-wide">ID</th>
                            <th class="test-boder test-table-wide">名前</th>
                        </tr>
                        <c:forEach var="signup" items="${Signup}">
                            <tr>
                                <td class="test-table-wide test-boder">${signup.id}</td>
                                <td class="test-table-wide test-boder">${signup.name}</td>
                            </tr>
                        </c:forEach>
                    </table>
                </c:if>

                <%-- 検索結果の表示 --%>
                <c:if test="${not empty Post}">
                    <table class="test-table table-hover mx-3">
                        <tr>
                            <th class="test-boder test-table-wide">集金番号</th>
                            <th class="test-boder test-table-wide">目的</th>
                            <th class="test-boder test-table-wide">投稿日</th>
                            <th class="test-boder test-table-wide">金額</th>
                            <th class="test-boder test-table-wide">期限</th>
                            <th class="test-boder test-table-wide"></th>
                        </tr>
                        <c:forEach var="Collection" items="${Post}" varStatus="loop">
                            <%-- 期限をDate型に変換 --%>
                            <fmt:parseDate var="deadlineDate" value="${Collection.deadline}" pattern="yyyy-MM-dd" type="date" />
                            <%-- 現在の日付を取得し、Date型に変換 --%>
                            <jsp:useBean id="now" class="java.util.Date" />
                            <fmt:formatDate var="todayStr" value="${now}" pattern="yyyy-MM-dd" />
                            <fmt:parseDate var="today" value="${todayStr}" pattern="yyyy-MM-dd" type="date" />
                            <%-- 期限切れか判定 --%>
                            <c:set var="isExpired" value="${deadlineDate.time < today.time}" />
                            <tr style="${isExpired ? 'color:red;' : ''}">
                                <td class="test-table-wide test-boder">${Collection.id}</td>
                                <td class="test-table-wide test-boder">${Collection.title}</td>
                                <td class="test-table-wide test-boder">${post_day[loop.index]}</td>
                                <td class="test-table-wide test-boder">${Collection.monetary}</td>
                                <td class="test-table-wide test-boder">${Collection.deadline}</td>
                                <td class="text-center test-boder">
                                    <%-- signid をリンクに追加 --%>
                                    <a href="../collection/CollectionDepositCheck.action?no=${Collection.id}&signid=${param.signid}">
                                        <button>入金完了</button>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </c:if>
            </section>
        </div>
        <script type="text/javascript">
        window.onload = function() {
            var signId = '<%=sign_id%>';  // JSPから受け取った sign_id
            var select = document.getElementById("notice-f1-select");

            for (var i = 0; i < select.options.length; i++) {
                if (select.options[i].value === signId) {
                    select.options[i].selected = true;
                    break;
                }
            }
        };

		</script>
    </c:param>
</c:import>