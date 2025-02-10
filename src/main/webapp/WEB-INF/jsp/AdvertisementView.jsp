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
.ad-management {
    margin-bottom: 40px;
    background-color: #f8f9fa;
    padding: 30px;
    border-radius: 10px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
}

.ad-management h1 {
    text-align: center;
    font-size: 32px;
    color: #333;
    margin-bottom: 20px;
    font-weight: 600;
}

.info {
    color: #d9534f;
    margin-bottom: 20px;
    font-size: 18px;
    font-weight: 500;
}

/* 広告テーブルのデザイン */
.ad-table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 20px;
    border-radius: 8px;
    overflow: hidden;
}

.ad-table thead {
    background-color: #343a40;
    color: white;
}

.ad-table th, .ad-table td {
    padding: 16px 24px;
    border: 1px solid #ddd;
    text-align: center;
    font-size: 16px;
    color: #495057;
}

.ad-table th {
    font-weight: bold;
    background-color: #f8f9fa;
}

.ad-table td {
    background-color: #fff;
}

.ad-table tr:hover {
    background-color: #f1f1f1;
    cursor: pointer;
}

.ad-table button {
    padding: 8px 20px;
    background-color: #007bff;
    color: white;
    border: none;
    border-radius: 5px;
    font-size: 14px;
    transition: background-color 0.3s, transform 0.2s;
}

.ad-table button:hover {
    background-color: #0056b3;
    transform: scale(1.05);
}

/* ボタンのデザイン調整 */
.new-create {
    padding: 15px 40px;
    background-color: #28a745;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 18px;
    transition: background-color 0.3s, transform 0.2s;
    display: block;
    margin: 0 auto;
}

.new-create:hover {
    background-color: #218838;
    transform: scale(1.05);
}

button:focus {
    outline: none;
}

/* 「現在の広告」セクションタイトル */
.ad-management h1 {
    text-align: center;
    font-size: 36px; /* 文字を大きくしてインパクトを増す */
    color: #007bff; /* 強調するために青色に変更 */
    font-weight: 700; /* 太字 */
    letter-spacing: 2px; /* 文字間隔を広げて洗練させる */
    margin-bottom: 20px;
    text-transform: uppercase; /* 上記のデザインの強調効果 */
    text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.1); /* 文字に影をつけて立体感を強調 */
    border-bottom: 3px solid #007bff; /* 下線を追加 */
    padding-bottom: 10px; /* 下線との間隔を調整 */
    transition: all 0.3s ease; /* アニメーション効果 */
}

.ad-management h1:hover {
    color: #0056b3; /* ホバー時に色が変わる */
    text-shadow: 2px 2px 10px rgba(0, 0, 0, 0.3); /* 影の強調 */
    transform: scale(1.05); /* 少し拡大するアニメーション */
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
                    <li class="dropdown-list"><a href="AdselectServlet">広告情報登録</a></li>
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
			<table class="ad-table">
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
							<button type="submit" name="action" value="details" class="btn">詳細</button>
						</td>
						<td><input type="hidden" name="Advertisement_No"
							value="<%= ad.getAdvertisement_No() %>"> <input
							type="hidden" name="Advertisement_type"
							value="<%= ad.getAdvertisement_type() %>">
							<button type="submit" name="action" value="edit" class="btn">変更</button>
						</td>
						<td><input type="hidden" name="Advertisement_No"
							value="<%= ad.getAdvertisement_No() %>"> <input
							type="hidden" name="Advertisement_type"
							value="<%= ad.getAdvertisement_type() %>">
							<button type="submit" name="action" value="delete" class="btn">削除</button>
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
			<form action="AdselectServlet" method="get" enctype="multipart/form-data">
				<center>
					<button class="new-create">新規作成</button>
				</center>
			</form>

		</div>
		
		
		<!-- 完了通知モーダル -->
    <div id="completionModal" class="modal">
      <div class="modal-content completion">
        <h2><%= successMessage %></h2>
        <button onclick="closeCompletionModal()" class="class="button confirmed-button"">閉じる</button>
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
	  <% session.removeAttribute("successMessage"); %>  ポップアップ後にメッセージをクリア 
	}
</script>
</body>
</html>