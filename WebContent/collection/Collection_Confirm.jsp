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

<link rel="stylesheet" href="../css/collection_C.css">

    <div class="function">
        <section class="mo-4">
        <h2 class="h3 mb-3 fw-norma bg-opacity-10 py-2 px-4 C test large-bold">入金確認</h2>
        <h3 class="h3 mb-3 fw-norma bg-opacity-10 py-2 px-4 C test small-bold">入金済みのリストを表示します</h3>


        <%-- 検索フォーム --%>
			<form action="CollectionConfirm.action" method="get">
			    <div class="row border mx-3 mb-3 py-2 align-items-center rounded" id="filter">
			        <div class="test-wide mx-3">
			            <%-- postID フィールド --%>
			            <div class="col-xl select-wide">
			                <label class="form-label" for="postID">投稿番号検索</label><br>
			                <input type="text" name="postid" placeholder="投稿番号(PostID)を入力" required="required" value="${param.postid}">
			            </div>
			            <div class="col-xl text-center">
			                <button class="btn btn-secondary" id="filter-button">検索</button>
			            </div>
			            <div class="mt-2 text-warning">${errors.get("f1")}</div>
			        </div>
			    </div>
			</form>

            <c:choose>
		    <c:when test="${Confirm.size() > 0}">
		        <table class="test-table table-hover mx-3">
		            <tr>

		                <th class="test-boder-C test-table-wide-C">投稿番号</th>
		                <th class="test-boder-C test-table-wide-C">投稿タイトル</th>
		                <th class="test-boder-C test-table-wide-C">投稿日</th>
		                <th class="test-boder-C test-table-wide-C">詳細番号</th>
		                <th class="test-boder-C test-table-wide-C">金額</th>
		            </tr>
		            <c:forEach var="collection" items="${Element}">
		                <tr>

		                    <td class="test-table-wide-C test-boder-C">${collection.postID}</td>
		                    <td class="test-table-wide-C test-boder-C">${collection.title}</td>
		                    <td class="test-table-wide-C test-boder-C">${collection.post_day}</td>
		                    <td class="test-table-wide-C test-boder-C">${collection.detailid}</td>
		                    <td class="test-table-wide-C test-boder-C">${collection.monetary}</td>
		                </tr>
		            </c:forEach>
		        </table>

		        <table class="test-table table-hover mx-3 mt-3">
		            <tr>
		            	<th class="test-boder-C test-table-wide-C">集金完了番号</th>
		                <th class="test-boder-C test-table-wide-C">ユーザーID</th>
		                <th class="test-boder-C test-table-wide-C">ユーザー名</th>
		                <th class="test-boder-C test-table-wide-C">納金日</th>
		            </tr>
		            <c:forEach var="collection" items="${Confirm}">
		                <tr>
		                	<td class="test-table-wide-C test-boder-C">${collection.paymentID}</td>
		                    <td class="test-table-wide-C test-boder-C">${collection.signID}</td>
		                    <td class="test-table-wide-C test-boder-C">${collection.name}</td>
		                    <td class="test-table-wide-C test-boder-C">${collection.depositdate}</td>
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