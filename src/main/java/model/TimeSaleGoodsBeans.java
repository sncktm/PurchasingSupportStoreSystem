package model;

import java.io.Serializable;



public class TimeSaleGoodsBeans implements Serializable {
	private String jan_code;
	private String goods_Name;
	private String goods_Maker;
	private String classification;
	private int sales_No;
	private String image;
	private int sales_Price;
	private int time_Sales_Prise;
	private String Timesale_goods_Application_Flag;
	
	
public  TimeSaleGoodsBeans(String jan_code,String goods_Name, String goods_Maker, String classification, String image, int  sales_Price, int time_Sales_Prise,String Timesale_goods_Application_Flag) {
		
        this.jan_code = jan_code;
		this.goods_Name = goods_Name;
		this.goods_Maker = goods_Maker;
		this.classification = classification;
		this.image = image;
		this.sales_Price = sales_Price;
		this.time_Sales_Prise = time_Sales_Prise;
		this.Timesale_goods_Application_Flag = Timesale_goods_Application_Flag;
		
		
	}


public String getTimesale_goods_Application_Flag() {
	return Timesale_goods_Application_Flag;
}


public void setTimesale_goods_Application_Flag(String timesale_goods_Application_Flag) {
	Timesale_goods_Application_Flag = timesale_goods_Application_Flag;
}


public String getJan_code() {
	return jan_code;
}


public void setJan_code(String jan_code) {
	this.jan_code = jan_code;
}


public String getGoods_Name() {
	return goods_Name;
}


public void setGoods_Name(String goods_Name) {
	this.goods_Name = goods_Name;
}


public String getGoods_Maker() {
	return goods_Maker;
}


public void setGoods_Maker(String goods_Maker) {
	this.goods_Maker = goods_Maker;
}


public String getClassification() {
	return classification;
}


public void setClassification(String classification) {
	this.classification = classification;
}


public int getSales_No() {
	return sales_No;
}


public void setSales_No(int sales_No) {
	this.sales_No = sales_No;
}


public String getImage() {
	return image;
}


public void setImage(String image) {
	this.image = image;
}


public int getSales_Price() {
	return sales_Price;
}


public void setSales_Price(int sales_Price) {
	this.sales_Price = sales_Price;
}


public int getTime_Sales_Prise() {
	return time_Sales_Prise;
}


public void setTime_Sales_Prise(int time_Sales_Prise) {
	this.time_Sales_Prise = time_Sales_Prise;
}

	

	

}
