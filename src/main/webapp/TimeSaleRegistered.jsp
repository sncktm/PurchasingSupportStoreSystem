<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="model.StoreBeans,model.TimeSaleBeans, model.TimeSaleGoodsBeans" %>
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
		
		.form-section {
    margin-bottom: 24px;
}

.section-header {
    background: var(--color-section-header);
    padding: 8px;
    border: 1px solid var(--color-border);
    margin-bottom: 8px;
}

.full-width-input {
    width: 100%;
    padding: 8px;
    border: 1px solid var(--color-border);
    border-radius: 4px;
}

.date-time-inputs {
    display: flex;
    align-items: center;
    gap: 16px;
    padding: 8px;
}

.select-box {
    padding: 6px;
    border: 1px solid var(--color-border);
    border-radius: 4px;
}

.time-range {
    display: flex;
    align-items: center;
    gap: 16px;
}

.time-inputs {
    display: flex;
    align-items: center;
    gap: 8px;
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
    <h1 class="title">タイムセール登録</h1>
    
   <form action="TimeSaleRegisteredConfirmServlet" method="post">
        
        <label for="timesale_Application_Flag">適用:</label>
	    <input type="checkbox" id="timesale_Application_Flag" name="timesale_Application_Flag">
	
	    <label for="name">タイムセール名:</label>
	    <input type="text" id="name" name="name" required>
	
	    <label for="start_date">開始日:</label>
	    <input type="date" id="start_date" name="start_date" required>
	
	    <label for="end_date">終了日:</label>
	    <input type="date" id="end_date" name="end_date" required>
	
	    <label for="start_time">開始時間:</label>
	    <input type="time" id="start_time" name="start_time" required>
	
	    <label for="end_time">終了時間:</label>
	    <input type="time" id="end_time" name="end_time" required>
	
	    <label for="repeat">繰り返しパターン:</label>
	    <select id="repeat" name="repeat">
		    <option value="daily">毎日</option>
		    <option value="weekly">毎週</option>
		    <option value="monthly">毎月</option>
	    </select>
	
	    <!-- 曜日選択（毎週選択時に表示） -->
		<div class="days-section" style="display: none;">
		    <label for="days">曜日（毎週の場合のみ選択可能）:</label>
		    <input type="checkbox" name="days" value="monday">月
		    <input type="checkbox" name="days" value="tuesday">火
		    <input type="checkbox" name="days" value="wednesday">水
		    <input type="checkbox" name="days" value="thursday">木
		    <input type="checkbox" name="days" value="friday">金
		    <input type="checkbox" name="days" value="saturday">土
		    <input type="checkbox" name="days" value="sunday">日
		</div>
		
		<!-- 日にち選択（毎月選択時に表示） -->
		<div class="date-section" style="display: none;">
		    <label for="day_of_month">日にち（毎月の場合のみ選択可能）:</label>
		    <input type="number" id="day_of_month" name="day_of_month" min="1" max="31">
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
            <button type="submit" class="button confirmed-button">確認する</button>
        </div>
    </form>
    
</main>
<script>
//ページロード時に繰り返しの状態に応じて表示・非表示を設定
window.onload = function() {
    toggleRepeatOptions();
};

// 繰り返しパターンに応じた曜日や日にちの表示制御
document.getElementById("repeat").addEventListener("change", toggleRepeatOptions);

function toggleRepeatOptions() {
    const repeatValue = document.getElementById("repeat").value;
    const daysSection = document.querySelector("label[for='days']").parentNode;
    const dateSection = document.querySelector("label[for='day_of_month']").parentNode;

    // 曜日チェックボックス（毎週選択時のみ表示）
    if (repeatValue === "weekly") {
        daysSection.style.display = "block"; // 毎週の場合は曜日を表示
    } else {
        daysSection.style.display = "none"; // その他の場合は曜日を非表示
    }

    // 日にち選択（毎月選択時のみ表示）
    if (repeatValue === "monthly") {
        dateSection.style.display = "block"; // 毎月の場合は日にち入力を表示
    } else {
        dateSection.style.display = "none"; // その他の場合は日にち入力を非表示
    }
}



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