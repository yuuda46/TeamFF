<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- 文字化けの対策 --%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<c:import url="/common/base.jsp">

    <c:param name="scripts"></c:param>

    <c:param name="content">

   <%-- <c:import url="/common/sidemenu.jsp"></c:import> --%>

<link rel="stylesheet" href="../css/collection.css">

    <div class="function">
        <section class="mo-4">
        <h2 class="h3 mb-3 fw-norma bg-opacity-10 py-2 px-4 C test large-bold">入金ページ</h2>
		<h3 class="h3 mb-3 fw-norma bg-opacity-10 py-2 px-4 C test small-bold">このページには、まだ入金していない項目のみ表示しています</h3>
        <%--    <div class="my-2 text-end px-4">
                <a href="../test/testCreate.action">新規登録</a>
            </div> --%>

            <c:choose>
                <c:when test="${Post.size()>0}">
                    <table class="test-table table-hover mx-3">
                        <tr>
                            <th class="test-boder test-table-wide">集金番号</th>
                            <th class="test-boder test-table-wide">目的</th>
                            <th class="test-boder test-table-wide">投稿日</th>
                            <th class="test-boder test-table-wide">金額</th>
                            <th class="test-boder test-table-wide">期限</th>
                            <th class="test-boder test-table-wide">振込先</th>
                            <th class="test-boder test-table-wide"></th>
                        </tr>
                        <c:forEach var="Collection" items="${Post}">
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
                                <td class="test-table-wide test-boder">${Collection.post_day}</td>
                                <td class="test-table-wide test-boder">${Collection.monetary}</td>
                                <td class="test-table-wide test-boder">${Collection.deadline}</td>
                                <td class="test-table-wide test-boder">${Collection.transferee}</td>


								<%-- 入金ボタン↓現状張りぼて。
								こちらをのボタンを押したらpostのidを持っていってdeposit.jspで表示する --%>

								<%-- 二次目標：一つ一つそれぞれのお知らせに飛ぶようにする --%>

                             </tr>
                        </c:forEach>
                    </table>
                </c:when>
                <c:otherwise>
                    <div>現在入金待ちの項目はありません</div>
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