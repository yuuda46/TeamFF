<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- 文字化けの対策 --%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<%
	String post_id=(String)request.getAttribute("post_id");
%>

<c:import url="/common/base.jsp">

    <c:param name="scripts"></c:param>

    <c:param name="content">

   <%-- <c:import url="/common/sidemenu.jsp"></c:import> --%>

<link rel="stylesheet" href="../css/collection_C.css">

    <div class="function container3">
        <section class="mo-4">
        <h2 class="h3 mb-3 fw-norma bg-opacity-10 py-2 px-4 C test large-bold  position_center">入金確認</h2>
        <h3 class="h3 mb-3 fw-norma bg-opacity-10 py-2 px-4 C test small-bold">入金済みのリストを表示します</h3>


        <%-- 検索フォーム --%>
			<form action="CollectionConfirm.action" method="get">
			    <div class="row border mx-3 mb-3 py-2 align-items-center rounded" id="filter">
			        <div class="test-wide mx-3">
			           <div class="notice_center padding_bottom_10">
	                   		<div class="col-xl select-wide right_margin">
	                        	<select class="select_size detail_font" required id="notice-f1-select" name="postid">
									<option value="0">----------</option>
									<c:forEach var="select_id" items="${select_id}">
										<option value=${select_id.post_id } <c:if test="${select_id.post_id==f2}">selected</c:if>>${select_id.post_id}</option>
									</c:forEach>
								</select>
							</div>
							<div class="col-xl text-center">
								<button class="margin_left_10 btn btn-secondary button_size button_style detail_font" id="filter-button">検索</button>
							</div>
                      </div>
			            <div class="mt-2 text-warning">${errors.get("f1")}</div>
			        </div>
			    </div>
			</form>

            <c:choose>
			    <c:when test="${empty post_id}">
			        <h3 class="h3 mb-3 fw-norma bg-opacity-10 py-2 px-4 C test small-bold">集金番号を選択して検索してください</h3>
			    </c:when>
			    <c:when test="${post_id == '0'}">
			        <h3 class="h3 mb-3 fw-norma bg-opacity-10 py-2 px-4 C test small-bold">集金番号を選択して検索してください</h3>
			    </c:when>
			</c:choose>

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
		            <c:forEach var="collection" items="${Element}" varStatus="loop">
		                <tr>
		                    <td class="test-table-wide-C test-boder-C">${collection.postID}</td>
		                    <td class="test-table-wide-C test-boder-C">${collection.title}</td>
		                    <td class="test-table-wide-C test-boder-C">${post_day[loop.index]}</td>
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

        <script type="text/javascript">
        window.onload = function() {
            var signId = '<%=post_id%>';  // JSPから受け取った post_id
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