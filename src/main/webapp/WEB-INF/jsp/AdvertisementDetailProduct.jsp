<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import= "model.StoreBeans" %>
<% StoreBeans loginStore = (StoreBeans) session.getAttribute("loginStore"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>広告管理画面</title>
<link rel="stylesheet" href="css/style.css?v=1.0">

<style>
   /* 全体のリセット */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
    background-color: #f8f9fa;
    margin: 0;
}

/* コンテナスタイル */
.container {
    max-width: 800px;
    margin: 0 auto;
    padding: 20px;
    background-color: #fff;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

/* タイトルセクション */
.section-title {
    background-color: #E5F0F8;
    padding: 10px;
    border-left: 5px solid #0071BB;
    margin-bottom: 20px;
    font-size: 18px;
    font-weight: bold;
    color: #333;
}

/* ラベルとデータボックス共通スタイル */
.label, .data-box {
    display: block;
    font-size: 16px;
    margin-bottom: 8px;
}

.label {
    font-weight: bold;
    color: #555;
}

.data-box {
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 8px;
    background-color: #f8f8f8;
}

/* Flexbox配置 */
.content-container {
    display: flex;
    gap: 20px;
}

/* 写真エリア */
.photo-section {
    flex: 2;
    border: 1px solid #ccc;
    border-radius: 8px;
    overflow: hidden;
    height: 250px;
    cursor: pointer; /* クリック可能なことを示す */
}

.photo-section img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    display: block; /* 画像の隙間対策 */
}

/* 右側セクション */
.right-section {
    flex: 1;
    display: flex;
    flex-direction: column;
    gap: 20px;
}



/* ボタンの配置用コンテナ */
.button-container {
    display: flex; /* ボタンを横並びに */
    justify-content: center; /* 中央揃え */
    gap: 20px; /* ボタン間の余白 */
}


/* ポップアップのオーバーレイ背景 */
.popup-overlay {
    display: none; /* 初期状態では非表示 */
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.8); /* 背景を暗くする */
    justify-content: center;
    align-items: center;
    z-index: 1000; /* 他の要素の上に表示 */
}

/* ポップアップのコンテンツ */
.popup-content {
    position: relative;
    max-width: 90%;
    max-height: 90%;
}

.popup-content img {
    width: 100%;
    height: auto;
    display: block; /* 隙間を消す */
}

/* 閉じるボタン */
.close-btn {
    position: absolute;
    top: 10px;
    right: 15px;
    font-size: 30px;
    color: #fff;
    cursor: pointer;
    transition: color 0.3s;
}

.close-btn:hover {
    color: #ddd;
}
.table-container {
    overflow-x: auto;
}
table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 20px;
}

table th, table td {
    border: 1px solid #ddd;
    padding: 8px;
    text-align: left;
}

table th {
    background-color: #f2f2f2;
    font-weight: bold;
}
/* 商品名入力とボタンの横並び */
.product-form .form-row {
    display: flex;
    align-items: center;
    gap: 50px; /* 入力欄とボタンの間隔 */
    margin-top: 10px; /* ラベルと入力欄の間隔 */
}

.product-form input[type="text"] {
    flex: 1; /* 幅を自動で調整 */
    padding: 10px; /* 内側の余白 */
    font-size: 16px; /* 文字サイズ */
    border: 1px solid #ddd; /* 枠線 */
    border-radius: 5px; /* 角丸 */
}

.button{
	width: 20%;
	margin: 40px;
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
<h1 class="title">広告詳細</h1>
    <div class="container">
    <div class="section-title">広告の詳細</div>
        <%
            model.AdCommodityBeans store = (model.AdCommodityBeans) session.getAttribute("Store");
            if (store != null) {
        %>

        <div class="section">
            <span class="label">タイトル</span>
            <div class="data-box"><%= store.getAdvertisement_title() %></div>
        </div>

        <div class="section">
            <span class="label">広告種別</span>
            <div class="data-box">
                <%
                    String adType = store.getAdvertisement_type();
                    String adTypeLabel = "";

                    if ("1".equals(adType)) {
                        adTypeLabel = "店舗";
                    } else if ("2".equals(adType)) {
                        adTypeLabel = "商品";
                    } else if ("3".equals(adType)) {
                        adTypeLabel = "タイムセール";
                    }
                %>
                <%= adTypeLabel %>
            </div>
        </div>

        <div class="section">
            <span class="label">説明文</span>
            <div class="data-box"><%= store.getAdvertisement_Explanation() %></div>
        </div>

        <!-- 写真とバナーを横並び -->
        <div class="content-container">
            <!-- 左側：写真表示部分 -->
            <script>
    		document.addEventListener("DOMContentLoaded", function () {
        	const photo = document.getElementById("photo");
        	const popup = document.getElementById("popup");
        	const closeBtn = document.getElementById("close-btn");

        	photo.addEventListener("click", function () {
            popup.style.display = "flex";
        	});

        	closeBtn.addEventListener("click", function () {
            popup.style.display = "none";
        	});

        	popup.addEventListener("click", function (event) {
            if (event.target === popup) {
                popup.style.display = "none";
            }
        	});
    		});
			</script>
            
            <div class="photo-section">
                <img src="images/advertisement/<%= store.getAdvertisement_Image() %>" alt="広告画像"id="photo" />
            </div>
            <!-- ポップアップ用のオーバーレイ -->
    		<div id="popup" class="popup-overlay">
        		<div class="popup-content">
            		<span class="close-btn" id="close-btn">&times;</span>
            		<img src="images/advertisement/<%= store.getAdvertisement_Image() %>" alt="拡大写真" id="popup-image">
        		</div>
    		</div>

            <!-- 右側：バナー選択とボタン -->
            <div class="right-section">
                <div>
                    <label class="label" for="banner">バナーの種類</label>
                    <div class="data-box">
                <%
                    String adpriority = store.getAdvertisement_priority();
                    String adpriorityLabel = "";

                    if ("1".equals(adType)) {
                    	adpriorityLabel = "大";
                    } else if ("2".equals(adType)) {
                    	adpriorityLabel = "中";
                    } else if ("3".equals(adType)) {
                        adpriorityLabel = "小";
                    }
                %>
                <%= adpriorityLabel %>
            </div>
                </div>
                
                <div class="parent-container">
 
                </div>
            </div>
        </div>

        <%
            } else {
        %>
        <p>広告情報が見つかりませんでした。</p>
        <%
            }
        %>
        <br><br>

		<div class="section">
			<div class="section-title">広告商品</div>
							<%
				// サーブレットから受け取ったデータを取得
				java.util.List<model.AdvertisementManagementBeans> ProductArray = 
				(java.util.List<model.AdvertisementManagementBeans>) request.getAttribute("ProductArray");

				if (ProductArray != null && !ProductArray.isEmpty()) {
				%>
			<form class="product-form">
									<%
						for (model.AdvertisementManagementBeans sales : ProductArray) {
						%>
				<label for="product-name" class="label">商品名</label>
				<div class="form-row">
					<input type="text" id="product-name" name="product-name"
						value="<%= sales.getGoods_Name() %>">
					
				</div>
			</form>
			<br>
			<br>


			<div class="table-container">



				<table>
					<thead>
						<tr>
							<th>商品名</th>
							<th>メーカー</th>
							<th>分類</th>
							<th>値段</th>
							<th>画像</th>
						</tr>
					</thead>
					<tbody>

						<tr>
							<td><%= sales.getGoods_Name() %></td>
							<td><%= sales.getGoods_Maker() %></td>
							<td><%= sales.getClassification() %></td>
							<td><%= sales.getSales_Price() %></td>
							<td>アップロード済み</td>
						</tr>
						<%
						}
						%>
					</tbody>
				</table>
				<%
		} else {
	%>
				<p class="no-data">広告の詳細データが存在しません。</p>
				<%
		}
	%>
			</div>
		</div>
	</div>
	

	<div class="button-container">
        <button type="button" class="button cancel-button" onclick="history.back();">戻る</button>
    </div>
</main>
</body>
</html>
