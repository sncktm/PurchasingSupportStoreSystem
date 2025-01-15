<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="model.StoreBeans, model.TimeSaleBeans, model.TimeSaleGoodsBeans" %>
<% StoreBeans loginStore = (StoreBeans) session.getAttribute("loginStore"); %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>タイムセール登録</title>
    <link rel="stylesheet" href="css/style.css?v=1.0">
</head>
<style>
	body{
		margin: 0;
		padding: 0;
	}
	table{
		width: 80%;
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
    <%
        // Get current date as java.sql.Date
        java.sql.Date currentDate = new java.sql.Date(System.currentTimeMillis());
        
        // Create Calendar instance for date manipulation
        Calendar cal = Calendar.getInstance();
        cal.setTime(currentDate);
        
        // Format date for display
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String formattedDate = sdf.format(currentDate);
        
        // Get individual components
        int year = cal.get(Calendar.YEAR);
        int month = cal.get(Calendar.MONTH) + 1;
        int day = cal.get(Calendar.DAY_OF_MONTH);
    %>
<main>
    <h1 class="title">タイムセール登録</h1>
    
   <form action="TimeSaleRegisteredservlet" method="post">
        <div>
            <input type="checkbox" name="timesale_Application_Flag" checked>
             <label for="time_Sale_Name">タイムセール名:</label>
            <input type="text" id="time_Sale_Name" name="time_Sale_Name" required>
            
        </div>
        
        <div>
            <label>日時:</label>
            <select name="month">
                <% for(int i = 1; i <= 12; i++) { %>
                    <option value="<%= i %>" <%= (i == month) ? "selected" : "" %>><%= i %>月</option>
                <% } %>
            </select>
            
            <select name="day">
                <% for(int i = 1; i <= 31; i++) { %>
                    <option value="<%= i %>" <%= (i == day) ? "selected" : "" %>><%= i %>日</option>
                <% } %>
            </select>
            
            <input type="radio" id="allDay" name="timeType" value="allDay">
            <label for="allDay">終日</label>
            
            <select name="start_Time">
                <% for(int i = 0; i < 24; i++) { %>
                    <option value="<%= i %>"><%= String.format("%02d:00", i) %></option>
                <% } %>
            </select>
            ～
            <select name="end_Time">
                <% for(int i = 0; i < 24; i++) { %>
                    <option value="<%= i %>"><%= String.format("%02d:00", i) %></option>
                <% } %>
            </select>
        </div>
        
        <table border="1">
            <tr>
                <th>運用</th>
                <th>JANコード</th>
                <th>商品名</th>
                <th>メーカー</th>
                <th>分類</th>
                <th>通常価格</th>
                <th>セール価格</th>
               
<!--                <th>画像</th>-->
            </tr>
            <%for(int i = 0; i<6; i++) {%>
            <tr>
                <td><input type="checkbox" name="timesale_goods_Application_Flag<%= i %>" checked></td>
                <td>
				    <input type="text" id="jan_Code<%= i %>" name="jan_Code<%= i %>" 
				           onkeydown="checkEnter(event, this, <%= i %>)">
				</td>
                <td> <input type="text" id="Goods_Name<%= i %>" name="Goods_Name<%= i %>" readonly></td>
                <td> <input type="text" id="Goods_Maker<%= i %>" name="Goods_Maker<%= i %>" readonly></td>
                <td> <input type="text" id="Classification<%= i %>" name="Classification<%= i %>" readonly></td>
                <td> <input type="text" id="Sales_Price<%= i %>" name="Sales_Price<%= i %>" readonly></td>
                <td> <input type="text" id="time_Sales_Prise<%= i %>" name="time_Sales_Prise<%= i %>"></td>
                <input type="hidden" id="sales_No<%= i %>" name="sales_No<%= i %>"/>
<!--                <td> <input type="text" id="Image<%= i %>" name="Image<%= i %>" readonly></td>-->
                
<!--                <td>アップロード済み</td>-->
            </tr>
            <%} %>
            
        </table>
        
        <div style="margin-top: 20px; text-align: center;">
            <button type="submit" class="button confirmed-button">登録する</button>
        </div>
    </form>
    
    <%-- Example of converting form data to java.sql.Date --%>
    <%!
        public java.sql.Date createSqlDate(int year, int month, int day) {
            Calendar cal = Calendar.getInstance();
            cal.set(year, month - 1, day);
            return new java.sql.Date(cal.getTimeInMillis());
        }
    %>
    
</main>
<script>
	function fetchGoodsName(input, index) {
	    const jan_Code = input.value;
		
	    if (jan_Code.length > 0) {
	        const xhr = new XMLHttpRequest();
	        xhr.open("GET", "SalesNoServlet?jan_Code=" + encodeURIComponent(jan_Code), true);
	
	        xhr.onreadystatechange = function () {
	            if (xhr.readyState === 4 && xhr.status === 200) {
	                const response = JSON.parse(xhr.responseText);
	                document.getElementById("Goods_Name" + index).value = response.Goods_Name;
	                document.getElementById("Goods_Maker" + index).value = response.Goods_Maker;
	                document.getElementById("Classification" + index).value = response.Classification;
	                document.getElementById("Sales_Price" + index).value = response.Sales_Price;
	                document.getElementById("sales_No" + index).value = response.sales_No;
	            }
	        };

	
	        xhr.send();
	    }
	}
	
	
	    // エンターキーの押下を検知
	   function checkEnter(event, input, index) {
	    if (event.key === "Enter") {
	        event.preventDefault();  // ページがリロードされるのを防ぐ
	        fetchGoodsName(input, index);
	    }
	}

</script>

</body>
</html>