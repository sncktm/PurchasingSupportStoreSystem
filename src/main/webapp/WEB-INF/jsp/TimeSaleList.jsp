<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import= "model.TimeSaleBeans,java.util.List, java.util.ArrayList" %>
<% ArrayList<TimeSaleBeans> TimeSaleListArray = (ArrayList<TimeSaleBeans>) session.getAttribute("TimeSaleListArray"); %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>タイムセール管理</title>
    <link rel="stylesheet" href="css/style.css?v=1.0">
    <style>
       
        .container {
            width: 100%;
            max-width: 800px;
            margin: 0 auto;
        }
        
   
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f5f5f5;
        }
        .button-detail {
            background-color: #4a90e2;
            color: white;
            border: none;
            padding: 5px 15px;
            border-radius: 4px;
            cursor: pointer;
        }
        .button-update {
            background-color: #f5a623;
            color: white;
            border: none;
            padding: 5px 15px;
            border-radius: 4px;
            cursor: pointer;
        }
        .button-container {
            display: flex;
            gap: 10px;
            justify-content: center;
            margin: 20px 0;
        }
        .button-register {
            background-color: #4a90e2;
            color: white;
            border: none;
            padding: 10px 30px;
            border-radius: 4px;
            cursor: pointer;
        }
        .button-delete {
            background-color: #d0021b;
            color: white;
            border: none;
            padding: 10px 30px;
            border-radius: 4px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div class="container">
        
        <h1 class="title">タイムセール一覧</h1>

         <div id="js-search-list">
	<table class="search-list_table">
		<tr>
			<th class="sort" data-sort="day">適用フラグ</th>
			<th class="sort" data-sort="day">タイムセール名</th>
			<th class="sort" data-sort="day">日時</th>
			<th class="sort" data-sort="day">商品点数</th>
			<th class="sort" data-sort="day"></th>
			
			
			
			
		</tr>
		<% for(TimeSaleBeans bean : TimeSaleListArray){ %>
		<tr class="list">
			<td class="day"><%= bean.getTimesale_Application_Flag() %></td>
			<td class="day"><%= bean.getTime_Sale_Name() %></td>
			<td class="day"><%= bean.getYear() %>,<%= bean.getMonth() %>,<%= bean.getDay() %>,<%= bean.getDay_Of_Week() %>,<%= bean.getStart_Time() %>,<%= bean.getEnd_Time() %></td>
			<td class="day"><%= bean.getGoods_Count() %></td>
			<td class="day"><form action="TimeSaleDetailServlet" method="post"><button value="<%= bean.getTime_Sale_No() %>" name="time-sale-No">詳細</button></form></td>
			
			
		</tr>
		<% } %>
	</table>
</div>

        <div class="button-container">
            <button class="button-register">登録</button>
            <button class="button-delete">削除</button>
        </div>
    </div>
</body>
</html>