package util;

import dto.ProductCategory;

public class ProductCategoryParser {

    public static ProductCategory parseCategoryCode(String categoryCode) {
        // categoryCode가 유효한지 확인 (길이 10 이상)
        if (categoryCode == null || categoryCode.length() != 10) {
            throw new IllegalArgumentException("Invalid category code format");
        }

        // 카테고리 코드 파싱
        String brand = categoryCode.substring(0, 2);  // 브랜드
        String type = categoryCode.substring(2, 4);   // 종류
        String color = categoryCode.substring(4, 6);  // 색상
        String size = categoryCode.substring(6, 9);   // 사이즈
        String gender = categoryCode.substring(9, 10); // 성별

        return new ProductCategory(brand, type, color, size, gender, categoryCode);
    }
}
