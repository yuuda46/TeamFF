<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- 文字化けの対策 --%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<c:import url="/common/base.jsp">

    <c:param name="scripts"></c:param>

    <c:param name="content">

   <%-- <c:import url="/common/sidemenu.jsp"></c:import> --%>

<link rel="stylesheet" href="../css/collection.css">

    <div class="function">
        <section class="mo-4">
        <h2 class="h3 mb-3 fw-norma bg-opacity-10 py-2 px-4 C test large-bold">入金確認</h2>
        <h3 class="h3 mb-3 fw-norma bg-opacity-10 py-2 px-4 C test small-bold">入金済みのリストを表示します</h3>
        <%--    <div class="my-2 text-end px-4">
                <a href="../test/testCreate.action">新規登録</a>
            </div> --%>

            <c:choose>
                <c:when test="${Confirm.size() > 0}">
                    <table class="test-table table-hover mx-3">
                        <tr>
                            <th class="test-boder test-table-wide">集金完了番号</th>
                            <th class="test-boder test-table-wide">投稿番号</th>
                            <th class="test-boder test-table-wide">投稿タイトル</th>
                            <th class="test-boder test-table-wide">投稿日</th>
                            <th class="test-boder test-table-wide">詳細番号</th>
                            <th class="test-boder test-table-wide">金額</th>
                            <th class="test-boder test-table-wide">ユーザーID</th>
                            <th class="test-boder test-table-wide">ユーザー名</th>
                            <th class="test-boder test-table-wide">納金日</th>
                        </tr>
                        <c:forEach var="collection" items="${Confirm}">
                            <tr>
                                <td class="test-table-wide test-border">${collection.paymentID}</td>
                                <td class="test-table-wide test-border">${collection.postID}</td>
                                <td class="test-table-wide test-border">${collection.title}</td>
                                <td class="test-table-wide test-border">${collection.post_day}</td>
                                <td class="test-table-wide test-border">${collection.detailid}</td>
                                <td class="test-table-wide test-border">${collection.monetary}</td>
                                <td class="test-table-wide test-border">${collection.signID}</td>
                                <td class="test-table-wide test-border">${collection.name}</td>
                                <td class="test-table-wide test-border">${collection.depositdate}</td>
                            </tr>
                        </c:forEach>
                    </table>
                </c:when>
                <c:otherwise>
                    <div>現在入金されている項目はありません</div>
                </c:otherwise>
            </c:choose>
        </section>
        <p>
        ${forward_test}
        ${forward_test2}
        ${name}
        </p>
        </div>
    </c:param>
</c:import>