package model;

import java.sql.Date;
import java.sql.Time;

public class TimeSaleBeans {
	private String store_No;
	private String time_Sale_No;
	private String time_Sale_Name;
	private Date startDate;
	private Date endDate;
	private Time startTime;
	private Time endTime;
	private String repeatPattern; // 繰り返しパターン
	private String repeatValue;
	private String timesale_Application_Flag;
	private int goods_Count;
	
	
	public TimeSaleBeans() {
		
	}
	
	public TimeSaleBeans(String store_No, String time_Sale_Name, Date startDate, Time startTime, Date endDate, Time endTime, String repeatPattern, String repeatValue, String timesale_Application_Flag) {
		this.store_No = store_No;
		this.time_Sale_Name = time_Sale_Name;
		this.startDate = startDate;
		this.endDate = endDate;
		this.startTime = startTime;
		this.endTime = endTime;
		this.repeatPattern = repeatPattern;
		this.repeatValue = repeatValue;
		this.timesale_Application_Flag = timesale_Application_Flag;
	}
	
	
	public TimeSaleBeans(String time_Sale_No, String time_Sale_Name, Date startDate, Time startTime, Date endDate, Time endTime, String repeatPattern, String repeatValue, String timesale_Application_Flag, int goods_Count) {
		this.time_Sale_No = time_Sale_No;
		this.time_Sale_Name = time_Sale_Name;
		this.startDate = startDate;
		this.endDate = endDate;
		this.startTime = startTime;
		this.endTime = endTime;
		this.repeatPattern = repeatPattern;
		this.repeatValue = repeatValue;
		this.timesale_Application_Flag = timesale_Application_Flag;
		this.goods_Count = goods_Count;
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
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	public Time getStartTime() {
		return startTime;
	}
	public void setStartTime(Time startTime) {
		this.startTime = startTime;
	}
	public Time getEndTime() {
		return endTime;
	}
	public void setEndTime(Time endTime) {
		this.endTime = endTime;
	}
	public String getRepeatPattern() {
		return repeatPattern;
	}
	public void setRepeatPattern(String repeatPattern) {
		this.repeatPattern = repeatPattern;
	}
	public String getRepeatValue() {
		return repeatValue;
	}
	public void setRepeatValue(String repeatValue) {
		this.repeatValue = repeatValue;
	}
	public String getTimesale_Application_Flag() {
		return timesale_Application_Flag;
	}
	public void setTimesale_Application_Flag(String timesale_Application_Flag) {
		this.timesale_Application_Flag = timesale_Application_Flag;
	}
	public int getGoods_Count() {
		return goods_Count;
	}
	public void setGoods_Count(int goods_Count) {
		this.goods_Count = goods_Count;
	}

}