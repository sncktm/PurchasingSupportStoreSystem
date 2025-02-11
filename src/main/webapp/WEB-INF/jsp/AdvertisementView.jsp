<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import= "model.StoreBeans" %>
    <% StoreBeans loginStore = (StoreBeans) session.getAttribute("loginStore"); %>
    <% String successMessage = (String) session.getAttribute("successMessage"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/style.css?v=1.0">
<style>
/* 現在の広告セクション */
<!--.ad-management {-->

<!--    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);-->
<!--}-->

.info {
    color: #d9534f;
    margin-bottom: 20px;
    font-size: 18px;
    font-weight: 500;
}


.btn {
    color: white;
    padding: 0.75rem 2rem;
    border-radius: 30px;
    border: none;
    cursor: pointer;
    transition: background-color 0.3s, transform 0.2s;
    margin: 5px 0;
}

.btn:hover {
    transform: scale(1.05);
}

/* ボタンのデザイン調整 */
.btn-new{
	width: 20%;
	margin: 40px;
}

button:focus {
    outline: none;
}
</style>

</head>
<body>
<header>
<div class="header-content">
	<div class="store-name">
    	<img alt="" src="images/logo.png" width="50px" height="50px">
    </div>
    <nav>
        <ul class="menu-lists">
            <li class="menu-list">
                <a href="#">店舗情報管理</a>
                <ul class="dropdown-lists">
                    <li class="dropdown-list"><a href="#">店舗情報閲覧</a></li>
                </ul>
            </li>
            <li class="menu-list">
                <a href="#">商品情報管理</a>
                <ul class="dropdown-lists">
                    <li class="dropdown-list"><a href="#">商品情報登録</a></li>
                    <li class="dropdown-list"><a href="#">商品情報変更・削除</a></li>
                    <li class="dropdown-list"><a href="GoodsInfomationViewServlet">商品情報閲覧</a></li>
                </ul>
            </li>
            <li class="menu-list">
                <a href="#">広告管理</a>
                <ul class="dropdown-lists">
                    <li class="dropdown-list"><a href="AdvertisementViewServlet">広告情報一覧</a></li>
                </ul>
            </li>
            <li class="menu-list">
                <a href="#">情報分析</a>
            </li>
            <li class="menu-list">
                <a href="#">タイムセール管理</a>
                <ul class="dropdown-lists">
                    <li class="dropdown-list"><a href="TimeSaleRegistered.jsp">タイムセール登録</a></li>
                    <li class="dropdown-list"><a href="TimeSaleListServlet">タイムセール一覧</a></li>
                </ul>
            </li>
        </ul>
    </nav>
    <div class="store-name">
    	<%= loginStore.getStore_name() %>
    </div>
</div>
</header>
<script>
	$(function() {
	    $("ul.menu li").hover(
	      function() {
	        $(".menuSub:not(:animated)", this).slideDown();
	      },
	      function() {
	        $(".menuSub", this).slideUp();
	      }
	    );
	  });
</script>
</body>
</style>
</head>

<body>
<main>
	<h1 class="title">広告一覧</h1>
		<div class="ad-management">
			
			<div class="info">あと ${dataCount} 個登録可能</div>
			<table class="ad-table table-css">
				<thead>
					<tr>
						<th>広告名</th>
						<th>詳細</th>
						<th>変更</th>
						<th>削除</th>
					</tr>
				</thead>
				<tbody>
					<%-- セッションから広告情報を取得 --%>
					<%
            java.util.ArrayList<model.AdCommodityBeans> advertise = (java.util.ArrayList<model.AdCommodityBeans>) session.getAttribute("advertise");
            if (advertise != null && !advertise.isEmpty()) {
            	for (model.AdCommodityBeans ad : advertise) {
            %>
					<form method="post" action="AdvertisementDetailViewServlet">
					<tr>
						<td><%= ad.getAdvertisement_title() %></td>

						<td><input type="hidden" name="Advertisement_No"
							value="<%= ad.getAdvertisement_No() %>"> <input
							type="hidden" name="Advertisement_type"
							value="<%= ad.getAdvertisement_type() %>">
							<button type="submit" name="action" value="details" class="btn detail-button">詳細</button>
						</td>
						<td><input type="hidden" name="Advertisement_No"
							value="<%= ad.getAdvertisement_No() %>"> <input
							type="hidden" name="Advertisement_type"
							value="<%= ad.getAdvertisement_type() %>">
							<button type="submit" name="action" value="edit" class="btn confirmed-button">変更</button>
						</td>
						<td><input type="hidden" name="Advertisement_No"
							value="<%= ad.getAdvertisement_No() %>"> <input
							type="hidden" name="Advertisement_type"
							value="<%= ad.getAdvertisement_type() %>">
							<button type="submit" name="action" value="delete" class="btn delete-button">削除</button>
						</td>
					</tr>
					</form>
					<%
                    }
                } else {
            %>
					<tr>
						<td colspan="5">広告はありません。</td>
					</tr>
					<%
                }
            %>

				</tbody>
			</table>
			<form action="AdselectServlet" method="get"
				enctype="multipart/form-data">
				<% 
    			Integer dataCount = (Integer) request.getAttribute("dataCount"); 
    			if (dataCount == null) {
        			dataCount = 0; // デフォルト値を設定
    			}
				%>
				<center>
					<button class="button cancel-button btn-new" <% if (dataCount <= 0) { %> disabled
						<% } %>>新規作成</button>
				</center>
			</form>

		</div>
		
		
		<!-- 完了通知モーダル -->
    <div id="completionModal" class="modal">
      <div class="modal-content completion">
        <h2><%= successMessage %></h2>
        <button onclick="closeCompletionModal()" class="button confirmed-button">閉じる</button>
      </div>
    </div>
</main>
<script>
	const completionModal = document.getElementById('completionModal');
	
	<% System.out.println("メッセージ" + successMessage); %>

	<% if (successMessage != null && !successMessage.isEmpty()) { %>
		completionModal.style.display = "flex";
	<% } %>
	
	//完了モーダルを閉じる
	function closeCompletionModal() {
	  completionModal.style.display = "none";
	  window.location.href = "clearMessageServlet?redirectPage=AdvertisementViewServlet"; // セッションを削除するServletへ遷移
	}
</script>
</body>
</html>