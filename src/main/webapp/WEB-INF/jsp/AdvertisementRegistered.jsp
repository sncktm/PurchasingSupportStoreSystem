<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="model.AdgoodsBeans"%>
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
	margin: 40px auto;
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

/* 共通ボタンスタイル */
button {
	padding: 10px 20px; /* 内側の余白 */
	font-size: 16px; /* 文字サイズ */
	border: none; /* 枠線をなくす */
	border-radius: 5px; /* 角の丸み */
	cursor: pointer; /* カーソルをポインターに */
	text-align: center; /* テキスト中央揃え */
	transition: background-color 0.3s; /* ホバー時のアニメーション */
	width: auto; /* 幅を自動調整 */
	flex: 0 0 auto; /* Flexbox内での伸縮防止 */
}

/* ボタンの配置用コンテナ */
.button-container {
	display: flex; /* ボタンを横並びに */
	justify-content: center; /* 中央揃え */
	gap: 20px; /* ボタン間の余白 */
	margin-top: 20px; /* 上の余白 */
}

/* アップロードボタン */
button.upload {
	background-color: #0071BB; /* 青 */
	color: #ffffff; /* 文字色 */
}

button.upload:hover {
	background-color: #005fa3;
}

/* 確認ボタン */
button.confirm {
	background-color: #FFD700; /* 黄色 */
	color: #333333;
}

button.confirm:hover {
	background-color: #e6c100;
}

/* 戻るボタン */
button.back {
	background-color: #6C757D; /* グレー */
	color: #ffffff;
}

button.back:hover {
	background-color: #5a6268;
}

/* 変更ボタン */
button.change {
	background-color: #FF7F50; /* コーラル */
	color: #ffffff;
}

button.change:hover {
	background-color: #e06e48;
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

select {
	width: 100%; /* テキスト入力と同じ幅 */
	padding: 10px; /* テキスト入力と同じ内側余白 */
	font-size: 16px; /* フォントサイズを統一 */
	border: 1px solid #ddd; /* テキスト入力と同じ枠線 */
	border-radius: 5px; /* 角丸を統一 */
	background-color: #fff; /* 背景色を統一 */
	appearance: none; /* ブラウザ依存のデザインを無効化 */
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

	<form class="product-form" method="post" action="AdCreationServlet"
		enctype="multipart/form-data">

		<div class="container">
			<div class="section-title">広告の詳細</div>


			<div class="section">
				<span class="label">タイトル</span>
				<div class="form-row">
					<input type="text" id="ad-title" name="ad-title" value="タイトル">
				</div>

				<script>
					document.addEventListener("DOMContentLoaded",
							function() {
								const adTypeSelect = document
										.getElementById("ad-type");
								const productSection = document
										.getElementById("product-section");

								// 広告種別の選択に応じてセクションを表示・非表示にする関数
								function toggleProductSection() {
									const selectedValue = adTypeSelect.value;

									// 商品またはタイムセールが選択された場合のみ表示
									if (selectedValue === "2"
											|| selectedValue === "3") {
										productSection.style.display = "block";
									} else {
										productSection.style.display = "none";
									}
								}

								// 初期化: ページ読み込み時に状態を確認
								toggleProductSection();

								// 広告種別の変更を監視
								adTypeSelect.addEventListener("change",
										toggleProductSection);
							});
				</script>

				<span class="label">広告種別</span>
				<div class="form-row">
					<select id="ad-type" name="ad-type">
						<option value="">選択してください</option>
						<option value="1">店舗</option>
						<option value="2">商品</option>
						<option value="3">タイムセール</option>
					</select>
				</div>

				<span class="label">テキスト</span>
				<div class="form-row">
					<input type="text" id="ad-text" name="ad-text" value="テキスト">
				</div>
			</div>
			<br>
			<!-- 写真とバナーを横並び -->
			<div class="content-container">
				<!-- 左側：写真表示部分 -->
				<script>
document.addEventListener("DOMContentLoaded", function () {
    const fileInput = document.getElementById("file-upload");
    const previewImage = document.getElementById("preview-image");
    const popup = document.getElementById("popup");
    const popupImage = document.getElementById("popup-image");
    const closeBtn = document.getElementById("close-btn");

    // 画像アップロード時の処理
    fileInput.addEventListener("change", function (event) {
        const file = event.target.files[0]; // 選択したファイルを取得
        if (file) {
            const reader = new FileReader();

            reader.onload = function (e) {
                previewImage.src = e.target.result; // 画像をプレビュー表示
                previewImage.style.display = "block"; // 非表示状態を解除
            };

            reader.readAsDataURL(file); // ファイルを読み込んでBase64に変換
        }
    });

    // 画像クリックでポップアップ表示
    previewImage.addEventListener("click", function () {
        popupImage.src = previewImage.src; // ポップアップの画像を設定
        popup.style.display = "flex"; // ポップアップを表示
    });

    // 閉じるボタンの処理
    closeBtn.addEventListener("click", function () {
        popup.style.display = "none"; // ポップアップを非表示
    });

    // ポップアップの外側クリックで閉じる
    popup.addEventListener("click", function (event) {
        if (event.target === popup) {
            popup.style.display = "none";
        }
    });
});
</script>

<!-- 左側：画像プレビュー -->
<div class="photo-section">
    <img id="preview-image" src="" alt="プレビュー画像" style="display: none; cursor: pointer;">
</div>

<!-- ポップアップ用のオーバーレイ -->
<div id="popup" class="popup-overlay" style="display: none;">
    <div class="popup-content">
        <span class="close-btn" id="close-btn">&times;</span>
        <img id="popup-image" src="" alt="拡大写真">
    </div>
</div>


				<!-- 右側：バナー選択とボタン -->
				<div class="right-section">
					<div>
						<div>
							<label class="label" for="banner">バナーの種類</label> 
							<select id="ad-priority" name="ad-priority">
								<option value="01">大</option>
								<option value="02">中</option>
								<option value="03">タイムセール</option>
							</select>
						</div>

						<div class="right-section">
							<label class="label" for="file-upload">写真アップロード</label>
							<input
								type="file" id="file-upload" name="image" accept="image/*"
								style="display: none;" required>
							<button type="button" class="upload"
								onclick="document.getElementById('file-upload').click();">アップロード</button>
							<button type="button" class="confirm">確認</button>
						</div>

					</div>
				</div>
			</div>


			<br> <br>

			<!-- 広告商品の登録セクション -->
			<div class="section" id="product-section" style="display: none;">
				<!-- 初期状態で非表示 -->
				<div class="section-title">広告商品の登録</div>

				<label for="goods">商品名:</label> <select name="goods" id="goods">
					<option value="">選択してください</option>
					<% 
        List<AdgoodsBeans> goodsList = (List<AdgoodsBeans>) request.getAttribute("goods");
        String selectedGoods = request.getParameter("goods");
        if (goodsList != null) {
            for (AdgoodsBeans product : goodsList) {
                String goodsName = product.getGoods_Name(); 
                String goodsMaker = product.getGoods_Maker(); 
                String classification = product.getClassification(); 
                int salesPrice = product.getSales_Price(); 
    %>
					<option value="<%= goodsName %>" data-maker="<%= goodsMaker %>"
						data-classification="<%= classification %>"
						data-sales-price="<%= salesPrice %>"
						data-sales-no="<%= product.getSales_No() %>"
						<%= (goodsName.equals(selectedGoods)) ? "selected" : "" %>>
						<%= goodsName %>
					</option>
					<% 
            }
        }
    %>

				</select> <br>
				<br>
				<!-- 商品詳細情報エリア -->
				<div class="table-container">
					<table>
						<thead>
							<tr>
								<th>商品名</th>
								<th>メーカー</th>
								<th>分類</th>
								<th>値段</th>
								<th>状態</th>
							</tr>
						</thead>
						<tbody id="product-details">
							<!-- 商品選択後に表示される情報がここに追加される -->
						</tbody>
					</table>
				</div>

			</div>
		</div>
		<div class="button-container">
			<button type="button" class="back" onclick="history.back();">戻る</button>
			<button type="submit" class="change">登録</button>
		</div>
	</form>
</main>
	<script>
	document.addEventListener("DOMContentLoaded", function () {
	    const goodsSelect = document.getElementById("goods");
	    const productDetailsTbody = document.getElementById("product-details");
	    const form = document.querySelector(".product-form");
	    const adTypeSelect = document.getElementById("ad-type");  // 広告種別セレクトボックスを取得

	    goodsSelect.addEventListener("change", function () {
	        const selectedOption = goodsSelect.options[goodsSelect.selectedIndex];
	        const salesNo = selectedOption.getAttribute("data-sales-no");

	        // 広告種別が「店舗」の場合、Sales_Noは不要
	        if (adTypeSelect.value === "1") {
	            let salesNoInput = document.getElementById("salesNoInput");
	            if (salesNoInput) {
	                salesNoInput.remove();  // 店舗選択時にはSales_Noを削除
	            }
	            return;  // Sales_Noが必要ないため、処理を終了
	        }

	        // 商品またはタイムセールが選ばれた場合のみSales_Noを設定
	        if (!salesNo) return;  // Sales_Noがない場合は処理を停止

	        // 商品の詳細情報を表示
	        productDetailsTbody.innerHTML = "";
	        let newRow = productDetailsTbody.insertRow();
	        newRow.insertCell(0).textContent = selectedOption.textContent.trim();
	        newRow.insertCell(1).textContent = selectedOption.getAttribute("data-maker");
	        newRow.insertCell(2).textContent = selectedOption.getAttribute("data-classification");
	        newRow.insertCell(3).textContent = selectedOption.getAttribute("data-sales-price") + " 円";
	        newRow.insertCell(4).textContent = "販売中";

	        // Sales_Noをフォームに追加
	        let salesNoInput = document.getElementById("salesNoInput");
	        if (!salesNoInput) {
	            salesNoInput = document.createElement("input");
	            salesNoInput.type = "hidden";
	            salesNoInput.id = "salesNoInput";
	            salesNoInput.name = "salesNo";
	            form.appendChild(salesNoInput);
	        }
	        salesNoInput.value = salesNo;  // Sales_Noを設定
	    });
	});


    			</script>
</body>
</html>
