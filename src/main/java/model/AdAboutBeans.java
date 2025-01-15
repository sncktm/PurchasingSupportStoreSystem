package model;

public class AdAboutBeans {

	private String Store_No;
	private String Advertisement_No;
	
	
	public AdAboutBeans (String Store_No,String Advertisement_No ) {
		
		this.Store_No = Store_No;
		this.Advertisement_No = Advertisement_No;
		
		
	}
	
	public String getStore_No() {
		return Store_No;
	}

	public void setStore_No(String Store_No) {
		this.Store_No = Store_No;
	}

	public String getAdvertisement_No() {
		return Advertisement_No;
	}

	public void setAdvertisement_No(String advertisement_No) {
		Advertisement_No = advertisement_No;
	}
}
