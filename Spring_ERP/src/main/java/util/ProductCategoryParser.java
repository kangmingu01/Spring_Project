package util;

import java.util.ResourceBundle;

import dto.ProductCategory;

public class ProductCategoryParser {

    private static final ResourceBundle bundle = ResourceBundle.getBundle("product-category");

    public static ProductCategory parseCategoryCode(String categoryCode) {
    	// categoryCode가 유효한지 확인 (길이 10 이상)
        if (categoryCode == null || categoryCode.length() != 10) {
            throw new IllegalArgumentException("Invalid category code format");
        }
        
        // 카테고리 코드 파싱
        String brandCode = categoryCode.substring(0, 2);
        String typeCode = categoryCode.substring(2, 4);
        String colorCode = categoryCode.substring(4, 6);
        String sizeCode = categoryCode.substring(6, 9);
        String genderCode = categoryCode.substring(9, 10);

        // 프로퍼티에서 한글로 변환
        String brand = bundle.containsKey("brand." + brandCode) ? bundle.getString("brand." + brandCode) : brandCode;
        String type = bundle.containsKey("type." + typeCode) ? bundle.getString("type." + typeCode) : typeCode;
        String color = bundle.containsKey("color." + colorCode) ? bundle.getString("color." + colorCode) : colorCode;
        String size = bundle.containsKey("size." + sizeCode) ? bundle.getString("size." + sizeCode) : sizeCode;
        String gender = bundle.containsKey("gender." + genderCode) ? bundle.getString("gender." + genderCode) : genderCode;

        return new ProductCategory(brand, type, color, size, gender, categoryCode);
    }
}
