<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import= "model.StoreBeans, model.TimeSaleGoodsBeans,model.TimeSaleBeans,java.util.List,java.util.ArrayList, java.sql.Date, java.sql.Time" %>
<%
StoreBeans loginStore = (StoreBeans) session.getAttribute("loginStore");
%>
<%
TimeSaleBeans TimeSaleBean = (TimeSaleBeans) session.getAttribute("TimeSaleBean");
%>
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

.form-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 2rem;
    margin-bottom: 2rem;
}

.form-group {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
}

.form-label {
    font-weight: 500;
    background-color: #FFF8DC;
    padding: 0.5rem;
    border: 1px solid var(--color-border);
}

.form-input {
    padding: 0.5rem;
    border: 1px solid var(--color-border);
    border-radius: 4px;
    font-size: 1rem;
}

.form-input-sm {
    width: 80px;
}

.date-time-group {
    display: flex;
    align-items: center;
    gap: 0.5rem;
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
		
		<div class="form-grid">
			<div class="form-group">
                    <label class="form-label">タイムセール名</label>
                    <p><%= TimeSaleBean.getTime_Sale_Name() %></p>
                </div>
                
                <div class="form-group">
                    <label class="form-label">日時</label>
                    <div class="date-time-group">
                        <p><%= TimeSaleBean.getStartDate() %> <%= TimeSaleBean.getStartTime() %> ～ <%= TimeSaleBean.getEndDate() %> <%= TimeSaleBean.getEndTime() %></p>
                    </div>
                </div>
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
			<button class="button　delete-button">削除する</button>
			<button class="button　cancel-button">戻る</button>
			<button class="button confirmed-button">変更する</button>
		</div>
	</main>
</body>

</html>










    
    
    
    
