<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="model.StoreBeans,model.TimeSaleBeans1, model.TimeSaleGoodsBeans" %>
<% StoreBeans loginStore = (StoreBeans) session.getAttribute("loginStore"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>タイムセール登録完了</title>
<link rel="stylesheet" href="css/style.css?v=1.0">
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
<h1>登録しました。</h1>
</body>
</html>