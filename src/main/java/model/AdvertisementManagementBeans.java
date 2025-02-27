package model;

public class AdvertisementManagementBeans {
    private String Goods_Name;
    private String Goods_Maker;
    private String Classification;
    private int Sales_Price;

    // コンストラクタ
    public AdvertisementManagementBeans(String Goods_Name, String Goods_Maker,String Classification,int Sales_Price) {
        this.Goods_Name = Goods_Name;
        this.Goods_Maker = Goods_Maker;
        this.Classification = Classification;
        this.Sales_Price = Sales_Price;
    }

    // ゲッターとセッター
    public String getGoods_Name() {
        return Goods_Name;
    }

    public void setGoods_Name(String Goods_Name) {
        this.Goods_Name = Goods_Name;
    }

    public String getGoods_Maker() {
        return Goods_Maker;
    }

    public void setGoods_Maker(String Goods_Maker) {
        this.Goods_Maker = Goods_Maker;
    }
    public String getClassification() {
        return Classification;
    }

    public void setClassification(String Classification) {
        this.Classification = Classification;
    }
    public int getSales_Price() {
        return Sales_Price;
    }

    public void setSales_Price(int Sales_Price) {
        this.Sales_Price = Sales_Price;
    }
}