<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import= "model.StoreBeans, model.TimeSaleGoodsBeans,java.util.List, java.util.ArrayList" %>
<% StoreBeans loginStore = (StoreBeans) session.getAttribute("loginStore"); %>
<% ArrayList<TimeSaleGoodsBeans> TimeSaleGoodsBeans = (ArrayList<TimeSaleGoodsBeans>) session.getAttribute("TimeSaleGoodsBeans"); %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>タイムセール管理</title>
<link rel="stylesheet" href="css/style.css?v=1.0">
<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}


main {
	padding: 20px;
}

.form-section, .table-section {
	margin-bottom: 20px;
}

.form-section input, .form-section select {
	padding: 5px;
	margin-right: 10px;
}

table {
	width: 100%;
	border-collapse: collapse;
}

th, td {
	border: 1px solid #000;
	padding: 10px;
	text-align: center;
}

th {
	background-color: #f0e68c;
}

.buttons {
	display: flex;
	justify-content: center;
	gap: 20px;
}

.buttons button {
	padding: 10px 20px;
	border: none;
	color: white;
	cursor: pointer;
}

.delete-btn {
	background-color: #ff6347;
}

.back-btn {
	background-color: #4682b4;
}

.update-btn {
	background-color: #ffa500;
}
</style>
</head>
<body>
<header>
<div class="header-content">
	<div class="store-name">
    	ろご
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
                    <li class="dropdown-list"><a href="#">広告情報登録</a></li>
                    <li class="dropdown-list"><a href="#">広告情報変更・削除</a></li>
                    <li class="dropdown-list"><a href="AdvertisementViewServlet">広告情報閲覧</a></li>
                </ul>
            </li>
            <li class="menu-list">
                <a href="#">情報分析</a>
                <ul class="dropdown-lists">
                    <li class="dropdown-list"><a href="#">aa</a></li>
                    <li class="dropdown-list"><a href="#">aa</a></li>
                </ul>
            </li>
            <li class="menu-list">
                <a href="#">タイムセール管理</a>
                <ul class="dropdown-lists">
                    <li class="dropdown-list"><a href="TimeSaleRegistered.jsp">タイムセール登録</a></li>
                    <li class="dropdown-list"><a href="#">タイムセール変更・削除</a></li>
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
	<main>
		<h1 class="title">タイムセール詳細</h1>
		<div class="form-section">
			<label for="sale-name">タイムセール名</label> <input type="text"
				id="sale-name"> <label for="date">日時</label> <select
				id="frequency">
				<option>毎週</option>
			</select> <input type="text" placeholder="MM"> <input type="text"
				placeholder="月"> <input type="text" placeholder="DD">
			<input type="text" placeholder="日"> <input type="text"
				placeholder="00:00"> <span>~</span> <input type="text"
				placeholder="00:00">
		</div>
		<div class="table-section">
			<table class="search-list_table">
				<tr>
				    <th class="sort" data-sort="day">適用フラグ</th>
					<th class="sort" data-sort="day">JANコード</th>
					<th class="sort" data-sort="day">商品名</th>
					<th class="sort" data-sort="day">メーカー</th>
					<th class="sort" data-sort="day">分類</th>
					<th class="sort" data-sort="day">値段</th>
					<th class="sort" data-sort="day">セール価格</th>
					<th class="sort" data-sort="day">画像</th>
				</tr>
				<%
				for (TimeSaleGoodsBeans bean : TimeSaleGoodsBeans) {
				%>
				<tr class="list">
				    <td class="day"><%=bean.getTimesale_goods_Application_Flag()%></td>
					<td class="day"><%=bean.getJan_code()%>
					<td class="day"><%=bean.getGoods_Name()%></td>
					<td class="day"><%=bean.getGoods_Maker()%></td>
					<td class="day"><%=bean.getClassification()%></td>
					<td class="day"><%=bean.getTime_Sales_Prise()%></td>
					<td class="day"><%=bean.getSales_Price()%></td>
					<td class="day"><%=bean.getImage()%></td>
				</tr>
				<% } %>
			</table>
		</div>
		<div class="buttons">
			<button class="delete-btn">削除する</button>
			<button class="back-btn">戻る</button>
			<button class="update-btn">変更する</button>
		</div>
	</main>
</body>

</html>










    
    
    
    
