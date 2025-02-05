<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- 文字化けの対策 --%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<c:import url="/common/base.jsp">
    <c:param name="scripts"></c:param>
    <c:param name="content">
        <link rel="stylesheet" href="../css/collection.css">
        <div class="function">
            <section class="mo-4">
                <h2 class="h3 mb-3 fw-norma bg-opacity-10 py-2 px-4 C test large-bold">入金ページ</h2>
                <h3 class="h3 mb-3 fw-norma bg-opacity-10 py-2 px-4 C test small-bold">このページには、まだ入金していない項目のみ表示しています</h3>

                <%-- 検索フォーム --%>
                <form action="CollectionDeposit.action" method="get">
                <div class="row border mx-3 mb-3 py-2 align-items-center rounded" id="filter">
                <div class="test-wide mx-3">
                    <%-- signid フィールド --%>
                    <div class="col-xl select-wide">
                        <label class="form-label" for="signid">ユーザ名 (Sign ID)</label><br>
                        <input type="text" name="signid" placeholder="利用者IDを入力してください" required="required" value="${param.signid}"> <%-- ここを修正しました --%>
                    </div>
                    <div class="col-xl text-center">
                        <button class="btn btn-secondary" id="filter-button">検索</button>
                    </div>
                    <div class="mt-2 text-warning">${errors.get("f1")}</div>
                </div>
                </div>
                </form>

                <%-- 名前の表示 --%>
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
                                                                <td class="test-table-wide test-boder">
								    <c:choose>
								        <c:when test="${empty Collection.monetary or Collection.monetary == 0}">
								            -
								        </c:when>
								        <c:otherwise>
								            ${Collection.monetary}
								        </c:otherwise>
								    </c:choose>
								</td>
                                <td class="test-table-wide test-boder">
								    <c:choose>
								        <c:when test="${empty Collection.deadline}">
								            -
								        </c:when>
								        <c:otherwise>
								            ${Collection.deadline}
								        </c:otherwise>
								    </c:choose>
								</td>


                                <td class="text-center test-boder">
                                    <%-- signid をリンクに追加 --%>
                                    <a href="../collection/CollectionDepositCheck.action?no=${Collection.id}&signid=${param.signid}"> <%-- ここを修正しました --%>
                                        <button>入金完了</button>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </c:if>
            </section>
        </div>
    </c:param>
</c:import>