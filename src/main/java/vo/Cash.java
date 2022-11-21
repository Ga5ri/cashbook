package vo;

public class Cash {
	private int cashNo;
	// Map타입 사용 안할시 private Category category; 필요! 
	private int categoryNo; // FK -> INNER JOIN -> Map타입
	private long cashPrice;
	private String cashMemo;
	private String updatedate;
	private String createdate;
	public int getCashNo() {
		return cashNo;
	}
	public void setCashNo(int cashNo) {
		this.cashNo = cashNo;
	}
	public int getCategoryNo() {
		return categoryNo;
	}
	public void setCategoryNo(int categoryNo) {
		this.categoryNo = categoryNo;
	}
	public long getCashPrice() {
		return cashPrice;
	}
	public void setCashPrice(long cashPrice) {
		this.cashPrice = cashPrice;
	}
	public String getCashMemo() {
		return cashMemo;
	}
	public void setCashMemo(String cashMemo) {
		this.cashMemo = cashMemo;
	}
	public String getUpdatedate() {
		return updatedate;
	}
	public void setUpdatedate(String updatedate) {
		this.updatedate = updatedate;
	}
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
}
