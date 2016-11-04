package sales;

public class Sales {
	private int merchandiseUniqueKey;
	private String merchandiseName;
	private int materialPrice;
	private int cafeUniqueKey;
	private int cafeName;
	private int count;
	
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
	public int getMaterialPrice() {
		return materialPrice;
	}
	public void setMaterialPrice(int materialPrice) {
		this.materialPrice = materialPrice;
	}
	public int getCafeUniqueKey() {
		return cafeUniqueKey;
	}
	public void setCafeUniqueKey(int cafeUniqueKey) {
		this.cafeUniqueKey = cafeUniqueKey;
	}
	public int getCafeName() {
		return cafeName;
	}
	public void setCafeName(int cafeName) {
		this.cafeName = cafeName;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public Sales() {}
	public Sales(int merchandiseUniqueKey, String merchandiseName, int count) {
		this.merchandiseName = merchandiseName;
		this.count = count;
		this.merchandiseUniqueKey = merchandiseUniqueKey;
	}
}
