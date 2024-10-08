package util;

import dto.ProductCategory;

public class ProductCategoryParser {

    public static ProductCategory parseCategoryCode(String categoryCode) {
        if (categoryCode == null || categoryCode.length() < 10) {
            throw new IllegalArgumentException("Invalid category code");
        }

        String brand = categoryCode.substring(0, 2);
        String type = categoryCode.substring(2, 4);
        String color = categoryCode.substring(4, 6);
        String size = categoryCode.substring(6, 9);
        String gender = categoryCode.substring(9, 10);

        // ProductCategory 객체를 생성하면서 값을 설정
        return new ProductCategory(brand, type, color, size, gender);
    }
}
