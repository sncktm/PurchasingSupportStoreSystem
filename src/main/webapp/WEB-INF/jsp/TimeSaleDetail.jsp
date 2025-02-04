<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import= "model.StoreBeans, model.TimeSaleGoodsBeans,model.TimeSaleBeans,java.util.List,java.util.ArrayList, java.sql.Date, java.sql.Time" %>
<%
StoreBeans loginStore = (StoreBeans) session.getAttribute("loginStore");
%>
<%
TimeSaleBeans TimeSaleBean = (TimeSaleBeans) session.getAttribute("TimeSaleBean");
%>
<% ArrayList<TimeSaleGoodsBeans> TimeSaleGoodsBeansArray = (ArrayList<TimeSaleGoodsBeans>) session.getAttribute("TimeSaleGoodsBeans"); %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>タイムセール管理</title>
<link rel="stylesheet" href="css/style.css?v=1.0">
<style>
.form-container {
    display: flex;
    flex-direction: column;
    gap: 1rem;
}

.form-header {
    display: flex;
    gap: 2rem;
}

.timesale-section {
    background: #f8f9fa;
    padding: 0.5rem;
    border-radius: 4px;
    border: 1px solid #aaa;
}

.left-section {
    flex: 1.5;
}

.right-section {
    flex: 2;
}

.form-group {
    display: flex;
    align-items: center;
    gap: 1rem;
    margin: 0.25rem;
}

.repeat-section {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    flex-wrap: wrap;
    margin: 0.25rem;
}

table {
    text-align: center;
    border-collapse: collapse;
    border-spacing: 0;
    border: solid 1px #333;
    width: 100%;
}

td, th {
    border: solid 1px #333;
    padding: 5px;
}

th {
    background: #fff2cc;
}

@media (max-width: 768px) {
    .form-header {
        flex-direction: column;
    }

    .left-section,
    .right-section {
        width: 100%;
    }
}


	.button-container{
      		display: flex;
      		justify-content:center;
       }
       .button{
       width:15%;
       	margin: 40px 30px;
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
                    <li class="dropdown-list"><a href="#">広告情報登録</a></li>
                    <li class="dropdown-list"><a href="#">広告情報変更・削除</a></li>
                    <li class="dropdown-list"><a href="AdvertisementViewServlet">広告情報閲覧</a></li>
                </ul>
            </li>
            <li class="menu-list">
                <a href="#">情報分析</a>
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
		
		<div class="form-container">
		<div class="form-header">
			<div class="timesale-section left-section">
				<div class="form-group">
					<label for="name">タイムセール名:</label>
					<%= TimeSaleBean.getTime_Sale_Name() %>
				</div>
				<div class="form-group">
					<label for="timesale_Application_Flag">適用:</label>
					<%= TimeSaleBean.getTimesale_Application_Flag() %>
				</div>
			</div>
	
			<div class="timesale-section right-section">
				<div class="form-group">
					<label for="se_date">開始日 ～ 終了日：</label>
					<%= TimeSaleBean.getStartDate() %>
					 ～ 
					<%= TimeSaleBean.getEndDate() %>
				</div>
	            
				<div class="repeat-section">
					<label for="repeat">繰り返し：</label>
	                
					<% if(TimeSaleBean.getRepeatPattern().equals("daily")){ %>
						<p>毎日</p>
					<% }else if(TimeSaleBean.getRepeatPattern().equals("weekly")){ %>
						<p>毎週　
						<%
						String[] daysArray = TimeSaleBean.getRepeatValue().split(",");
						String japaneseDay = "";
						for(String day : daysArray){
							if ("sunday".equals(day)) { japaneseDay = "日曜日"; }
							else if ("monday".equals(day)) { japaneseDay = "月曜日"; }
							else if ("tuesday".equals(day)) { japaneseDay = "火曜日"; }
							else if ("wednesday".equals(day)) { japaneseDay = "水曜日"; }
							else if ("thursday".equals(day)) { japaneseDay = "木曜日"; }
							else if ("friday".equals(day)) { japaneseDay = "金曜日"; }
							else { japaneseDay = "土曜日"; }
							
						%>
						<%= japaneseDay %></p>
						<% } %>
						
					<% }else{ %>
						<p>毎月<%= TimeSaleBean.getRepeatValue() %>日</p>
					<% } %>
				</div>
	
				<div class="form-group">
					<label for="se_time">開始時間 ～ 終了時間：</label>
					<%= TimeSaleBean.getStartTime() %>
					 ～ 
					<%= TimeSaleBean.getEndTime() %>
				</div>
			</div>
		</div>
		<table border="1">
			<tr>
			    <th>適用</th>
			    <th>JANコード</th>
			    <th>商品名</th>
			    <th>メーカー</th>
			    <th>分類</th>
			    <th>通常価格</th>
			    <th>セール価格</th>
			</tr>
			<%
			    if (TimeSaleGoodsBeansArray != null && !TimeSaleGoodsBeansArray.isEmpty()) {
			        for (TimeSaleGoodsBeans goods : TimeSaleGoodsBeansArray) {
			%>
			<tr>
			    <td><%= goods.getTimesale_goods_Application_Flag() %></td>
			    <td><%= goods.getJan_code() %></td>
			    <td><%= goods.getGoods_Name() %></td>
			    <td><%= goods.getGoods_Maker() %></td>
			    <td><%= goods.getClassification() %></td>
			    <td><%= goods.getSales_Price() %></td>
			    <td><%= goods.getTime_Sales_Prise() %></td>
			</tr>
			<%
			        }
			    } else {
			%>
			<tr>
			    <td colspan="7">対象商品がありません。</td>
			</tr>
			<% } %>
		</table>
    </div>
		
		
		<div class="button-container">
            <button class="button delete-button">削除する</button>
			<button class="button cancel-button" onclick="history.back()">戻る</button>
			<button class="button confirmed-button">変更する</button>
        </div>
	</main>
</body>

</html>










    
    
    
    
