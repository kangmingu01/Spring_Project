package dto;

import lombok.Data;

@Data

public class Sales {
	private int salesId;
	private String salesDate;
	private String salesCharge;
	private String orgId;
	
	private int productId;
	private int requestId;
	private int requestQuantity;
	private int salesQuantity;
	private double productDeliveryPrice;
	private double tax;
	private double totalAmount;
	private int auth;
	private String orgName;
	private String productCategory;
	private String productName;
	private int invCurrentQty;
	private int invWarehouseId;
	
   
    private ProductCategory productCategoryDetails;  // 제품 카테고리 파싱 결과
	
}
