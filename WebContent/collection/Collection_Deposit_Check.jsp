<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- 文字化けの対策 --%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<%
	String sign_id=(String)request.getAttribute("sign_id");
%>
 <link rel="stylesheet" href="../css/collection.css">

<c:import url="/common/base.jsp">
    <c:param name="scripts"></c:param>
    <c:param name="content">
    <div class="function">
<%--<c:import url="/common/sidemenu.jsp">
    </c:import> --%>

        <section class="mo-4">
            <h2 class="h3 mb-3 fw-norma bg-opacity-10 py-2 px-4 C test large-bold">入金管理</h2>
            <label class="h3 mb-3 fw-norma bg-opacity-10 py-2 px-4 C test small-bold">
            最終確認です、以下の入金が完了している場合、<br>
            「入金が完了しました」ボタンを押してください
            </label>

        <form action="../collection/CollectionDeposit.action" method="get">
          <input type="hidden" name="signid" value=<%=sign_id%>>
          <button type="submit" class="CollectionDeposit.action">
          未入金確認画面に戻る
          </button>
        </form>

        <c:if test="${not empty Signup}">
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

        <c:choose>
                <c:when test="${Post.size()>0}">
                    <table class="test-table table-hover mx-3">
                        <tr>
                            <th class="test-boder test-table-wide">集金番号</th>
                            <th class="test-boder test-table-wide">目的</th>
                            <th class="test-boder test-table-wide">投稿日</th>
                            <th class="test-boder test-table-wide">金額</th>
                            <th class="test-boder test-table-wide">期限</th>

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

                            </tr>
                        <%--ここでsignidとcollectionidをCompleteActionに渡して登録 --%>
                        <td class="text-center student-table-wide">
                            <a href="../collection/CollectionDepositComplete.action?postId=${Collection.id}&signid=${param.signid}">
                                <button type="submit" class="CollectionDepositComplete.action">
                                    入金が完了しました
                                </button>
                            </a>
                        </td>
                        </c:forEach>
                    </table>
                </c:when>
            </c:choose>

        </section>
        </div>
    </c:param>
</c:import>