package model;

public class StoreBeans {
	private String store_no, store_name;
	
	public StoreBeans() {
		
	}

	public StoreBeans(String store_no, String store_name) {
		this.setStore_no(store_no);
		this.setStore_name(store_name);
	}

	public String getStore_no() {
		return store_no;
	}

	public void setStore_no(String store_no) {
		this.store_no = store_no;
	}

	public String getStore_name() {
		return store_name;
	}

	public void setStore_name(String store_name) {
		this.store_name = store_name;
	}
}
