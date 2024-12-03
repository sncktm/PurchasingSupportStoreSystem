package model;

import java.sql.Date;

public class GoodsInfoBeans {
	private String sales_flag, jan_code, goods_name, goods_marker, classification;
	private Date update_date;
	private int sales_price;
	
	public GoodsInfoBeans(String sales_flag, Date update_date, String jan_code, String goods_name, String goods_marker, String classification, int sales_price) {
		this.sales_flag = sales_flag;
		this.update_date = update_date;
		this.jan_code = jan_code;
		this.goods_name = goods_name;
		this.goods_marker = goods_marker;
		this.classification = classification;
		this.sales_price = sales_price;
		
	}

	public String getSales_flag() {
		return sales_flag;
	}

	public void setSales_flag(String sales_flag) {
		this.sales_flag = sales_flag;
	}

	public String getJan_code() {
		return jan_code;
	}

	public void setJan_code(String jan_code) {
		this.jan_code = jan_code;
	}

	public String getGoods_name() {
		return goods_name;
	}

	public void setGoods_name(String goods_name) {
		this.goods_name = goods_name;
	}
	
	public String getGoods_marker() {
		return goods_marker;
	}

	public void setGoods_marker(String goods_marker) {
		this.goods_marker = goods_marker;
	}

	public String getClassification() {
		return classification;
	}

	public void setClassification(String classification) {
		this.classification = classification;
	}

	public Date getUpdate_date() {
		return update_date;
	}

	public void setUpdate_date(Date update_date) {
		this.update_date = update_date;
	}

	public int getSales_price() {
		return sales_price;
	}

	public void setSales_price(int sales_price) {
		this.sales_price = sales_price;
	}

	
}
