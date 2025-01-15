<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import= "model.StoreBeans" %>
    <% StoreBeans loginStore = (StoreBeans) session.getAttribute("loginStore"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/style.css?v=1.0">
<style>

main {
    padding: 20px;
    font-family: 'Arial', sans-serif;
}

.ad-management h1 {
    margin-bottom: 20px;
    font-size: 24px;
    color: #333;
}

.info {
    color: #d9534f;
    margin-bottom: 20px;
    font-size: 16px;
}

.ad-table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 20px;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

.ad-table thead {
    background-color: #f8f9fa;
}

.ad-table th, .ad-table td {
    padding: 10px;
    border: 1px solid #ddd;
    text-align: center;
}

.ad-table th {
    font-weight: bold;
}

.btn {
    padding: 10px 30px;
    border: none;
    background-color: #007bff;
    color: white;
    cursor: pointer;
    border-radius: 3px;
    font-size: 14px;
    transition: background-color 0.3s;
}

.btn:hover {
    background-color: #0056b3;
}

.new-create {
    padding: 15px 30px;
    background-color: #28a745;
    color: white;
    border: none;
    border-radius: 3px;
    cursor: pointer;
    font-size: 16px;
    transition: background-color 0.3s;
}

.new-create:hover {
    background-color: #218838;
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
    <div class="ad-management">
        <center><h1>現在の広告</h1></center>
    
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
                <tr>
                    <td><%= ad.getAdvertisement_title() %></td>
                    <form method="post" action="AdvertisementDetailViewServlet">
    					<td>
    						<!-- Advertisement_Noを送信 -->
    						<input type="hidden" name="Advertisement_No" value="<%= ad.getAdvertisement_No() %>">
    
    						<!-- Advertisement_typeを送信 -->
    						<input type="hidden" name="Advertisement_type" value="<%= ad.getAdvertisement_type() %>">
        					<button type="submit"  class="btn">詳細</button>
    					</td>
    					
					</form>
					<td><button class="btn" onclick="location.href='AdEditServlet?id=1'">変更</button></td>
					<td>
					<form action="MylistRegisteredServlet" method="post">
					<button class="btn" onclick="if(confirm('削除しますか？')) location.href='AdDeleteServlet?id=1';">削除</button>
					</form>
					</td>
                </tr>
             <%
                    }
                } else {
            %>
                    <tr><td colspan="5">広告はありません。</td></tr>
            <%
                }
            %>
             
            </tbody>
        </table>
        <form action="Registered.jsp" method="post">
        	<center><button class="new-create">新規作成</button></center>
        </form>
        
    </div>
</main>
</body>
</html>