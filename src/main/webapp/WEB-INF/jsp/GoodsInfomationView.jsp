<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import= "model.GoodsInfoBeans,java.util.List, java.util.ArrayList" %>
    
    <% ArrayList<GoodsInfoBeans> goodsList = (ArrayList<GoodsInfoBeans>) session.getAttribute("goodsInfoArrayBeans"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/style.css?v=1.0">
<script type="text/javascript" src="js/list.min.js"></script>

<style>
	.search-box{
		margin-bottom: 20px;
	}
	input{
		padding: 10px;
        border: 1px solid;
        border-radius:4px;
	}
	.contents{
		margin: auto;
	}

	table{
		width: 80%;
		text-align: center;
		border-collapse: collapse;
		border-spacing: 0;
		border: solid 3px black;
	}td{
		border: solid 2px black;
		padding: 5px;
	}th{
		background: #fff2cc;
		border: solid 3px black;
		padding: 5px;
		}
	.search-list_table th.sort {
	  cursor: pointer;
	  position: relative;
	}
	
	.search-list_table th.sort::after {
	  content: '';
	  margin-left: 10px;
	  font-size: 16px;
	}
	
	.search-list_table th.sort.desc::after {
	  content: "▼";
	}
	
	.search-list_table th.sort.asc::after {
	  content: "▲";
	}


</style>
</head>
<body>
<header>
<div class="header-content">
    <nav>
        <ul class="menu-lists">
            <li class="menu-list">
                <a href="#">店舗情報管理</a>
                <ul class="dropdown-lists">
                    <li class="dropdown-list"><a href="GoodsInfomationViewServlet">商品情報登録</a></li>
                    <li class="dropdown-list"><a href="GoodsInfomationViewServlet">商品情報変更・削除</a></li>
                    <li class="dropdown-list"><a href="GoodsInfomationViewServlet">商品情報閲覧</a></li>
                </ul>
            </li>
            <li class="menu-list">
                <a href="#">商品情報管理</a>
                <ul class="dropdown-lists">
                    <li class="dropdown-list"><a href="GoodsInfomationViewServlet">商品情報登録</a></li>
                    <li class="dropdown-list"><a href="GoodsInfomationViewServlet">商品情報変更・削除</a></li>
                    <li class="dropdown-list"><a href="GoodsInfomationViewServlet">商品情報閲覧</a></li>
                </ul>
            </li>
            <li class="menu-list">
                <a href="#">広告管理</a>
                <ul class="dropdown-lists">
                    <li class="dropdown-list"><a href="GoodsInfomationViewServlet">商品情報登録</a></li>
                    <li class="dropdown-list"><a href="GoodsInfomationViewServlet">商品情報変更・削除</a></li>
                    <li class="dropdown-list"><a href="GoodsInfomationViewServlet">商品情報閲覧</a></li>
                </ul>
            </li>
            <li class="menu-list">
                <a href="#">情報分析</a>
                <ul class="dropdown-lists">
                    <li class="dropdown-list"><a href="GoodsInfomationViewServlet">商品情報登録</a></li>
                    <li class="dropdown-list"><a href="GoodsInfomationViewServlet">商品情報変更・削除</a></li>
                    <li class="dropdown-list"><a href="GoodsInfomationViewServlet">商品情報閲覧</a></li>
                </ul>
            </li>
            <li class="menu-list">
                <a href="#">タイムセール管理</a>
                <ul class="dropdown-lists">
                    <li class="dropdown-list"><a href="GoodsInfomationViewServlet">商品情報登録</a></li>
                    <li class="dropdown-list"><a href="GoodsInfomationViewServlet">商品情報変更・削除</a></li>
                    <li class="dropdown-list"><a href="GoodsInfomationViewServlet">商品情報閲覧</a></li>
                </ul>
            </li>
        </ul>
    </nav>
</div>
</header>

<main>
<h1 class="title">商品情報一覧</h1>
<div class="contents">
	<div class="search-list" id="js-search-list">
		<div class="search-box">
			<input type="search" class="search" placeholder="検索">
		</div>
		
	
		<table class="search-list_table">
			<thead>
				<tr>
					<th>販売中</th>
					<th class="sort" data-sort="day">登録日</th>
					<th class="sort" data-sort="jan">JANコード</th>
					<th class="sort" data-sort="goods">商品名</th>
					<th>メーカー</th>
					<th>分類</th>
					<th class="sort" data-sort="price">値段</th>
				</tr>
			</thead>
			<tbody class="list">
				<% for(GoodsInfoBeans bean : goodsList){ %>
				<tr>
					<td></td>
					<td class="day"><%= bean.getUpdate_date() %></td>
					<td class="jan"><%= bean.getJan_code() %></td>
					<td class="goods"><%= bean.getGoods_name() %></td>
					<td><%= bean.getGoods_marker() %></td>
					<td><%= bean.getClassification() %></td>
					<td class="price"><%= bean.getSales_price() %></td>
					
				</tr>
				<% } %>
			</tbody>
		</table>
	</div>
</div>
</main>
<script>
	const options = {
		valueNames: [
			'jan',
			'goods',
			'day',
			'price'
			],
		};

	const searchList = new List("js-search-list", options);
</script>
</body>
</html>