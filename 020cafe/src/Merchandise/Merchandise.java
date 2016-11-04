package Merchandise;

public class Merchandise {
	
	private int merchandiseUniqueKey;
	private String merchandiseName;
	private int price;
	private String image;
	
	public Merchandise() {}
	public Merchandise(int merchandiseUniqueKey, String merchandiseName, int price, String image) {
		//this.count = count;
		this.merchandiseUniqueKey = merchandiseUniqueKey;
		this.merchandiseName = merchandiseName;
		this.price = price;
		this.image = image;
	}
	public int getMerchandiseUniqueKey() {
		return merchandiseUniqueKey;
	}
	public void setMerchandiseUniqueKey(int merchandiseUniqueKey) {
		this.merchandiseUniqueKey = merchandiseUniqueKey;
	}
	public String getMerchandiseName() {
		return merchandiseName;
	}
	public void setMerchandiseName(String merchandiseName) {
		this.merchandiseName = merchandiseName;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
}
