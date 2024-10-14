package dto;

import lombok.Data;

/*
CREATE TABLE product (
    product_id NUMBER PRIMARY KEY, -- ���� �ĺ���(������)
    product_category VARCHAR2(100), -- ��ǰ ī�װ�(����,������ �� �����ڵ�)
    product_name VARCHAR2(100), -- ��ǰ �̸�
    product_price NUMBER,  -- �԰� ���� 
    delivery_price NUMBER,  -- ��� ����
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
	private ProductCategory productCategoryDetails;
}
