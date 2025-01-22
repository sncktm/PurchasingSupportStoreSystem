<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.TimeSaleBeans, model.TimeSaleGoodsBeans" %>
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
    <title>タイムセール確認</title>
    <link rel="stylesheet" href="css/style.css?v=1.0">
</head>
<body>
<header>
    <h1>タイムセール内容確認</h1>
</header>
<main>
    <h2>登録したタイムセールの内容を確認してください。</h2>
    <section>
        <table border="1" style="width: 100%; border-collapse: collapse; text-align: left;">
            <tr>
                <th>タイムセール名</th>
                <td><%= timeSaleConfirmBeans.getTime_Sale_Name() %></td>
            </tr>
            <tr>
                <th>開始日</th>
                <td><%= timeSaleConfirmBeans.getStartDate() %></td>
            </tr>
            <tr>
                <th>終了日</th>
                <td><%= timeSaleConfirmBeans.getEndDate() %></td>
            </tr>
            <tr>
                <th>開始時間</th>
                <td><%= timeSaleConfirmBeans.getStartTime() %></td>
            </tr>
            <tr>
                <th>終了時間</th>
                <td><%= timeSaleConfirmBeans.getEndTime() %></td>
            </tr>
            <tr>
                <th>繰り返しパターン</th>
                <td><%= timeSaleConfirmBeans.getRepeatPattern() %></td>
            </tr>
        </table>
    </section>
    <br>
    <section>
        <h3>タイムセール対象商品</h3>
        <table border="1" style="width: 100%; border-collapse: collapse; text-align: center;">
            <tr>
                <th>運用フラグ</th>
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
    </section>
    <br>
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
