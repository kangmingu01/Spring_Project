package dto;

import lombok.Data;

/*
CREATE TABLE product (
    product_id NUMBER PRIMARY KEY, -- 고유 식별자(시퀀스)
    product_category VARCHAR2(100), -- 상품 카테고리(생상,사이즈 등 조합코드)
    product_name VARCHAR2(100), -- 상품 이름
    product_price NUMBER,  -- 입고 가격
    delivery_price NUMBER,  -- 출고 가격
    product_img varchar2(500),
    CONSTRAINT unique_category_name UNIQUE (product_category, product_name)
);
CREATE SEQUENCE product_seq;
*/

@Data
public class Product {
    private int productId;
    private String productCategory;
    private String productName;
    private int productPrice;
    private int deliveryPrice;
    private String productImg;
}