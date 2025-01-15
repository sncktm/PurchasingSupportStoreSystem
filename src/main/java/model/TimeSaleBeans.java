package model;

import java.io.Serializable;
import java.sql.Date;
public class TimeSaleBeans implements Serializable {
	private String store_No;
	private String time_Sale_No;
	private String time_Sale_Name;
	private String year;
	private String month;
	private String day;
	private String day_Of_Week;
	private Date  start_Time;
	private Date  end_Time;
	private String timesale_Application_Flag;
	private int goods_Count;
	
	public int getGoods_Count() {
		return goods_Count;
	}


	public void setGoods_Count(int goods_Count) {
		this.goods_Count = goods_Count;
	}


	public TimeSaleBeans() { }
	
	
	public  TimeSaleBeans(String store_No,String time_Sale_No, String time_Sale_Name, String year, String month, String day, String day_Of_WeeK, Date start_Time, Date end_Time, String timesale_Application_Flag) {
		
        this.store_No = store_No;
		this.time_Sale_Name = time_Sale_Name;
		this.year = year;
		this.month = month;
		this.day = day;
		this.day_Of_Week = day_Of_WeeK;
		this.start_Time = start_Time;
		this.end_Time = end_Time;
		this.timesale_Application_Flag = timesale_Application_Flag;
		
	}
	public  TimeSaleBeans(String time_Sale_No, String time_Sale_Name, String year, String month, String day, String day_Of_WeeK, Date start_Time, Date end_Time, String timesale_Application_Flag,int goods_Count) {
			
			this.time_Sale_No = time_Sale_No;
			this.time_Sale_Name = time_Sale_Name;
			this.year = year;
			this.month = month;
			this.day = day;
			this.day_Of_Week = day_Of_WeeK;
			this.start_Time = start_Time;
			this.end_Time = end_Time;
			this.timesale_Application_Flag = timesale_Application_Flag;
			this.goods_Count = goods_Count;
			
		}
	
	//タイムセール登録で使用
	public  TimeSaleBeans(String time_Sale_Name, String year, String month, String day, String day_Of_WeeK, Date start_Time, Date end_Time, String store_No, String timesale_Application_Flag) {
		
		this.time_Sale_Name = time_Sale_Name;
		this.year = year;
		this.month = month;
		this.day = day;
		this.day_Of_Week = day_Of_WeeK;
		this.start_Time = start_Time;
		this.end_Time = end_Time;
		this.store_No = store_No;
		this.timesale_Application_Flag = timesale_Application_Flag;
		
	}


	public String getStore_No() {
		return store_No;
	}


	public void setStore_No(String store_No) {
		this.store_No = store_No;
	}


	public String getTime_Sale_No() {
		return time_Sale_No;
	}


	public void setTime_Sale_No(String time_Sale_No) {
		this.time_Sale_No = time_Sale_No;
	}


	public String getTime_Sale_Name() {
		return time_Sale_Name;
	}


	public void setTime_Sale_Name(String time_Sale_Name) {
		this.time_Sale_Name = time_Sale_Name;
	}


	public String getYear() {
		return year;
	}


	public void setYear(String year) {
		this.year = year;
	}


	public String getMonth() {
		return month;
	}


	public void setMonth(String month) {
		this.month = month;
	}


	public String getDay() {
		return day;
	}


	public void setDay(String day) {
		this.day = day;
	}


	public String getDay_Of_Week() {
		return day_Of_Week;
	}


	public void setDay_Of_Week(String day_Of_Week) {
		this.day_Of_Week = day_Of_Week;
	}


	public Date getStart_Time() {
		return start_Time;
	}


	public void setStart_Time(Date start_Time) {
		this.start_Time = start_Time;
	}


	public Date getEnd_Time() {
		return end_Time;
	}


	public void setEnd_Time(Date end_Time) {
		this.end_Time = end_Time;
	}


	public String getTimesale_Application_Flag() {
		return timesale_Application_Flag;
	}


	public void setTimesale_Application_Flag(String timesale_Application_Flag) {
		this.timesale_Application_Flag = timesale_Application_Flag;
	}
	
	

}