<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import= "model.StoreBeans,model.TimeSaleBeans,java.util.List,java.util.ArrayList, java.sql.Date, java.sql.Time, java.time.DayOfWeek,java.time.LocalDate, java.time.LocalTime, java.time.ZoneId, java.util.Calendar" %>
<%
StoreBeans loginStore = (StoreBeans) session.getAttribute("loginStore");
%>
<%
ArrayList<TimeSaleBeans> TimeSaleListArray = (ArrayList<TimeSaleBeans>) session.getAttribute("TimeSaleListArray");
%>
<% String successMessage = (String) session.getAttribute("successMessage"); %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>タイムセール管理</title>
    <link rel="stylesheet" href="css/style.css?v=1.0">
    <style>

        
       
		.time{
			
		}
		
		.status-content {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 0.25rem;
}


		.status-badge {
		    background-color: #ddd;
		    padding: 0.125rem 0.5rem;
		    border-radius: 5px;
		    font-size: 0.75rem;
		    font-weight: 500;
		}
		.highlight {
		    background-color: #FFD700;
		}
       
       .actions {
		    display: flex;
		    justify-content:space-around;
		}
       
       .button-container{
      		display: flex;
      		justify-content:center;
      		
      		
       }
       .button{
       width:15%;
       	margin: 40px 50px;
       }
       
       .btn {
       		color: white;
		    padding: 0.75rem 2rem;
		    border-radius: 30px;
		    border: none;
		    cursor: pointer;
		    
		}
		a{
			color: #fff;
			border: none;
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

<main>
    <div class="container">
        
        <h1 class="title">タイムセール一覧</h1>

		<table class="table-css">
			<tr>
				<th>適用</th>
				<th>タイムセール名</th>
				<th>日時</th>
				<th>商品点数</th>
				<th>　</th>
			</tr>
			<%
			for(TimeSaleBeans bean : TimeSaleListArray){
			// タイムセールの開始・終了日時を取得
	            Date startDate = bean.getStartDate();
	            Date endDate = bean.getEndDate();
	            Time startTime = bean.getStartTime();
	            Time endTime = bean.getEndTime();
				//TimeをLocalTimeに変換
	            LocalTime localStartTime = startTime.toLocalTime();
	            LocalTime localEndTime = endTime.toLocalTime();
	
	            // 現在の日時を取得
	            java.util.Date currentDate = new java.util.Date();
	            LocalDate localDate = currentDate.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
	            LocalTime currentTime = LocalTime.now();

	
	            // タイムセール中かどうかを判定
	            boolean isInTimeSale = false;
	            System.out.println("タイムセール中？" + bean.getTimesale_Application_Flag());
	            if(bean.getTimesale_Application_Flag().equals("on")){
	            	System.out.println("タイムセール中if");
		            if ((currentDate.after(startDate) || currentDate.equals(startDate)) &&
		                (currentDate.before(endDate) || currentDate.equals(endDate))) {
		            	System.out.println("タイムセール中日にち");
		            	// タイムセール中かどうかを判定（時間のみ）
		            	if ((currentTime.isAfter(localStartTime) || currentTime.equals(localStartTime)) &&
		            	    (currentTime.isBefore(localEndTime) || currentTime.equals(localEndTime))) {
		            		System.out.println("タイムセール中時間");
		            	    switch (bean.getRepeatPattern()) {
		                    case "daily":
		                    	isInTimeSale = true;
		                        break;
		                    case "weekly":
		                    	//文字列の曜日を配列に分割
		                    	System.out.println("タイムセール中曜日");
		                        String[] daysArray = bean.getRepeatValue().split(",");
		                            DayOfWeek dayOfWeek = localDate.getDayOfWeek();
		                            for(String day: daysArray) {
		                            	
		                            	System.out.println("日" + day);
		                            	System.out.println(day.equals(dayOfWeek.name().toLowerCase()));
		                            	
		                            	if (day.equals(dayOfWeek.name().toLowerCase())) {
		                            		isInTimeSale = true;
		            	                    System.out.println("週がtrue");
		                            	}
		                            }  
		                        break;
		                    case "monthly":
		                    	
		                    	Calendar currentCalendar = Calendar.getInstance();
		                        currentCalendar.setTime(currentDate);
		                        int currentDay = currentCalendar.get(Calendar.DAY_OF_MONTH);
		                        int day = Integer.parseInt(bean.getRepeatValue());
		                    	if (currentDay == day) {
	                        		isInTimeSale = true;
	        	                    System.out.println("日付がtrue");
	                        	}
		                        break;
		                    }
		            	    
		            	    
		            	}
		            	
		            }	
		            		
	            }
	
	            // 背景色の適用
	            String rowClass = isInTimeSale ? "highlight" : "";
	        %>
			<tr class="list">
				<td class="status">
					<div class="status-content">
						<span><%= bean.getTimesale_Application_Flag() %></span>
						<span class="status-badge <%= rowClass %>"><%= isInTimeSale ? "タイムセール中" : "終了" %></span>
					</div>
				</td>
				<td class="name"><%= bean.getTime_Sale_Name() %></td>
				<td class="time">
					<%= bean.getStartDate() %>  ～ <%= bean.getEndDate() %><br>
					<%= bean.getStartTime() %> ～ <%= bean.getEndTime() %><br>
					
					<% if(bean.getRepeatPattern().equals("daily")){ %>
						毎日
					<% }else if(bean.getRepeatPattern().equals("weekly")){ %>
						毎週：
						<%
						String[] daysArray = bean.getRepeatValue().split(",");
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
						<%= japaneseDay %>
						<% } %>
						
					<% }else{ %>
						毎月<%= bean.getRepeatValue() %>日
					<% } %>
					
				</td>
				<td class="count"><%= bean.getGoods_Count() %>点</td>
				
				<td class="table-buttons">
					<div class="actions">
						<form action="TimeSaleDetailServlet" method="post"><button value="<%= bean.getTime_Sale_No() %>" name="time-sale-No" class="btn detail-button">詳細</button></form>
						<form action="#" method="post"><button value="<%= bean.getTime_Sale_No() %>" name="time-sale-No" class="btn confirmed-button">変更</button></form>
					</div>
				</td>
			</tr>
			<% } %>
		</table>
	</div>

        <div class="button-container">
            <button class="cancel-button button"><a href="TimeSaleRegistered.jsp">登録</a></button>
            <button class="delete-button button">削除</button>
        </div>
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
	  <% session.removeAttribute("successMessage"); %>  ポップアップ後にメッセージをクリア 
	}
</script>
</body>
</html>