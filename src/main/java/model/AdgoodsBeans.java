package model;

public class AdgoodsBeans {
	private String Sales_No;
	private String Goods_Name;
    private String Goods_Maker;
    private String Classification;
    private int Sales_Price;
    
    public AdgoodsBeans(String Sales_No, String Goods_Name, String Goods_Maker,String Classification,int Sales_Price) {
    	this.Sales_No = Sales_No;
        this.Goods_Name = Goods_Name;
        this.Goods_Maker = Goods_Maker;
        this.Classification = Classification;
        this.Sales_Price = Sales_Price;
    }

    
	public String getSales_No() {
		return Sales_No;
	}


	public void setSales_No(String sales_No) {
		Sales_No = sales_No;
	}


	public String getGoods_Name() {
		return Goods_Name;
	}
	public void setGoods_Name(String goods_Name) {
		Goods_Name = goods_Name;
	}
	public String getGoods_Maker() {
		return Goods_Maker;
	}
	public void setGoods_Maker(String goods_Maker) {
		Goods_Maker = goods_Maker;
	}
	public String getClassification() {
		return Classification;
	}
	public void setClassification(String classification) {
		Classification = classification;
	}
	public int getSales_Price() {
		return Sales_Price;
	}
	public void setSales_Price(int sales_Price) {
		Sales_Price = sales_Price;
	}

}
