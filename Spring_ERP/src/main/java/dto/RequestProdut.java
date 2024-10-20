package dto;

import lombok.Data;

@Data
public class RequestProdut {
    private int requestId;
    private String orgId;
    private int productId;
    private int requestQuantity;
    private double salesPrice;
    private double tax;
    private double totalAmount;
    private int requestStatus;
    private String productCategory; // 제품 카테고리 문자열 (예: "NI-SN-BL-270-M")
    private ProductCategory productCategoryDetails;  // 제품 카테고리 파싱 결과
    private String userId;
    

}