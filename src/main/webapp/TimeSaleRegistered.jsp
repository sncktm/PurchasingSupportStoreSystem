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

        .btn {
            background: #f7941d;
            color: white;
            padding: 0.75rem 2rem;
            border: none;
            border-radius: 25px;
            font-size: 1rem;
            cursor: pointer;
            transition: background-color 0.2s;
        }

        .btn:hover {
            background: #e88a15;
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
    <h1 class="title">タイムセール登録</h1>
    
   <form class="form-container" action="TimeSaleRegisteredConfirmServlet" method="post">
            <div class="form-header">
                <div class="timesale-section left-section">
                    <div class="form-group">
                        <label for="name">タイムセール名:</label>
                        <input type="text" id="name" class="timesale-name" name="name" required>
                    </div>
                    <div class="form-group">
                        <label for="timesale_Application_Flag">適用:</label>
                        <input type="checkbox" id="timesale_Application_Flag" name="timesale_Application_Flag">
                        <div class="tooltip2">
						    <img class="question" alt="" src="images/question.png" width="15px" height="15px">
						    <div class="description2">登録後、即時タイムセール情報を適用したい場合はチェックをつけてください。</div>
						</div>
                    </div>
                </div>

                <div class="timesale-section right-section">
                    <div class="form-group">
                        <label for="se_date">開始日 ～ 終了日：</label>
                        <input type="date" id="se_date" name="start_date" required>
                         ～ 
                        <input type="date" id="se_date" name="end_date" required>
                    </div>
                    
                    <div class="repeat-section">
                        <label for="repeat">繰り返し：</label>
                        <select id="repeat" name="repeat">
                            <option value="daily">毎日</option>
                            <option value="weekly">毎週</option>
                            <option value="monthly">毎月</option>
                        </select>

                        <div class="days-section" style="display: none;">
                            <div class="weekday-group">
                                <label><input type="checkbox" name="days" value="monday">月</label>
                                <label><input type="checkbox" name="days" value="tuesday">火</label>
                                <label><input type="checkbox" name="days" value="wednesday">水</label>
                                <label><input type="checkbox" name="days" value="thursday">木</label>
                                <label><input type="checkbox" name="days" value="friday">金</label>
                                <label><input type="checkbox" name="days" value="saturday">土</label>
                                <label><input type="checkbox" name="days" value="sunday">日</label>
                            </div>
                        </div>

                        <div class="date-section" style="display: none;">
                            <input type="number" id="day_of_month" name="day_of_month" min="1" max="31" style="width: 50px">
                            <label for="day_of_month">日</label>
                        </div>
                    </div>

                    <div class="form-group">
                    	<label for="se_time">開始時間 ～ 終了時間：</label>
                        <input type="time" id="se_time" name="start_time" required>
                         ～ 
                        <input type="time" id="se_time" name="end_time" required>
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
               
<!--                <th>画像</th>-->
            </tr>
            <%for(int i = 0; i<5; i++) {%>
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
            <button type="submit" class="btn confirmed-button">確認する</button>
        </div>
    </form>
    
</main>
<script>
//ページロード時に繰り返しの状態に応じて表示・非表示を設定
window.onload = function() {
    toggleRepeatOptions();
};

<!--// 繰り返しパターンに応じた曜日や日にちの表示制御-->
<!--document.getElementById("repeat").addEventListener("change", toggleRepeatOptions);-->

<!--function toggleRepeatOptions() {-->
<!--    const repeatValue = document.getElementById("repeat").value;-->
<!--    const daysSection = document.querySelector("label[for='days']").parentNode;-->
<!--    const dateSection = document.querySelector("label[for='day_of_month']").parentNode;-->

<!--    // 曜日チェックボックス（毎週選択時のみ表示）-->
<!--    if (repeatValue === "weekly") {-->
<!--        daysSection.style.display = "block"; // 毎週の場合は曜日を表示-->
<!--    } else {-->
<!--        daysSection.style.display = "none"; // その他の場合は曜日を非表示-->
<!--    }-->

<!--    // 日にち選択（毎月選択時のみ表示）-->
<!--    if (repeatValue === "monthly") {-->
<!--        dateSection.style.display = "block"; // 毎月の場合は日にち入力を表示-->
<!--    } else {-->
<!--        dateSection.style.display = "none"; // その他の場合は日にち入力を非表示-->
<!--    }-->
<!--}-->
document.getElementById('repeat').addEventListener('change', function() {
    const daysSection = document.querySelector('.days-section');
    const dateSection = document.querySelector('.date-section');
    
    // Hide both sections first
    daysSection.style.display = 'none';
    dateSection.style.display = 'none';
    
    // Show relevant section based on selection
    if (this.value === 'weekly') {
        daysSection.style.display = 'inline-flex';
    } else if (this.value === 'monthly') {
        dateSection.style.display = 'inline-flex';
    }
});



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