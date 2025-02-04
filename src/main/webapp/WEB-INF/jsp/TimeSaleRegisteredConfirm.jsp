<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="model.StoreBeans,model.TimeSaleBeans, model.TimeSaleGoodsBeans" %>
<% StoreBeans loginStore = (StoreBeans) session.getAttribute("loginStore"); %>
<%@ page import="java.util.ArrayList, java.sql.Date, java.sql.Time" %>
<%
    TimeSaleBeans timeSaleConfirmBeans = (TimeSaleBeans) session.getAttribute("timeSaleConfirmBeans");
    ArrayList<TimeSaleGoodsBeans> TimeSaleGoodsBeansArray =
        (ArrayList<TimeSaleGoodsBeans>) session.getAttribute("TimeSaleGoodsConfirmBeansArray");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>タイムセール登録</title>
    <link rel="stylesheet" href="css/style.css?v=1.0">
</head>
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
            gap: 0.5rem;
            margin: 0.25rem;
        }

        input[type="text"],
        input[type="date"],
        input[type="time"],
        select {
            padding: 0.25rem;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 0.9rem;
        }

        .repeat-section {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            flex-wrap: wrap;
            margin: 0.25rem;
        }

        .weekday-group {
            display: flex;
            gap: 0.25rem;
        }

        table{
		text-align: center;
		border-collapse: collapse;
		border-spacing: 0;
		border: solid 1px #333;
		}td{
			border: solid 1px #333;
			padding: 5px;
		}th{
			background: #fff2cc;
			border: solid 1px #333;
			padding: 5px;
			}

        input[type="text"],
        input[type="date"],
        input[type="time"],
        select {
            padding: 0.5rem;
            border: 1px solid #ddd;
            border-radius: 4px;
            width: auto;
        }

        input[type="text"]:focus,
        input[type="date"]:focus,
        input[type="time"]:focus,
        select:focus {
            outline: none;
            border-color: #4a90e2;
            box-shadow: 0 0 0 2px rgba(74,144,226,0.2);
        }

        .button {
            padding: 0.75rem 2rem;
            border: none;
            border-radius: 25px;
            font-size: 1rem;
            cursor: pointer;
            transition: background-color 0.2s;
        }


        /* 新しく追加したスタイル */
        .form-group {
            display: flex;
            align-items: center;            gap: 1rem;

        }

        .form-group label {
            min-width: 120px;
        }

        .weekday-checkbox {
            display: inline-flex;
            align-items: center;
            gap: 0.25rem;
        }
        
        .timesale-name {
    width: 100%;  /* 親要素いっぱいに広げる */
    max-width: 500px; /* 必要に応じて最大幅を設定 */
    padding: 0.5rem;
    border: 1px solid #ddd;
    border-radius: 4px;
}

	.tooltip2{
	    position: relative;
	    cursor: pointer;
	    display: inline-block;
	}
	.description2 {
	    display: none;
	    position: absolute;
	    padding: 10px;
	    font-size: 12px;
	    line-height: 1.6em;
	    color: #fff;
	    border-radius: 5px;
	    background: #333;
	    width: 150px;
	}
	.description2:before {
	    content: "";
	    position: absolute;
	    top: 0%;
	    right: 95%;
	    border: 15px solid transparent;
	    border-top: 15px solid #333;
	    margin-left: -15px;
	    transform: rotateZ(90deg);
	}
	.tooltip2:hover .description2{
	    display: inline-block;
	    top: 0px;
	    left: 25px;
	    transform: translateY(-10%);
	}
        
        .question{
        	margin: auto;
  display: block;
  
        }

        /* レスポンシブ対応 */
        @media (max-width: 768px) {
            .form-header {
                flex-direction: column;
            }

            .left-section,
            .right-section {
                width: 100%;
            }
        }
</style>
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
	<h1 class="title">タイムセール内容確認</h1>
	<p>登録したタイムセールの内容を確認してください。</p>
	<div class="form-container">
		<div class="form-header">
			<div class="timesale-section left-section">
				<div class="form-group">
					<label for="name">タイムセール名:</label>
					<%= timeSaleConfirmBeans.getTime_Sale_Name() %>
				</div>
				<div class="form-group">
					<label for="timesale_Application_Flag">適用:</label>
					<%= timeSaleConfirmBeans.getTimesale_Application_Flag() %>
				</div>
			</div>
	
			<div class="timesale-section right-section">
				<div class="form-group">
					<label for="se_date">開始日 ～ 終了日：</label>
					<%= timeSaleConfirmBeans.getStartDate() %>
					 ～ 
					<%= timeSaleConfirmBeans.getEndDate() %>
				</div>
	            
				<div class="repeat-section">
					<label for="repeat">繰り返し：</label>
	                
					<% if(timeSaleConfirmBeans.getRepeatPattern().equals("daily")){ %>
						<p>毎日</p>
					<% }else if(timeSaleConfirmBeans.getRepeatPattern().equals("weekly")){ %>
						<p>毎週　
						<%
						String[] daysArray = timeSaleConfirmBeans.getRepeatValue().split(",");
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
						<p>毎月<%= timeSaleConfirmBeans.getRepeatValue() %>日</p>
					<% } %>
				</div>
	
				<div class="form-group">
					<label for="se_time">開始時間 ～ 終了時間：</label>
					<%= timeSaleConfirmBeans.getStartTime() %>
					 ～ 
					<%= timeSaleConfirmBeans.getEndTime() %>
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
    
    <div style="text-align: center;">
        <form action="TimeSaleRegisteredservlet" method="post" style="display: inline-block;">
            <button type="submit" class="button confirmed-button">確定</button>
        </form>
        <form action="TimeSaleRegistered.jsp" method="get" style="display: inline-block;">
            <button type="button" class="button cancel-button" onclick="history.back()">修正</button>
        </form>
    </div>
</main>

</body>
</html>