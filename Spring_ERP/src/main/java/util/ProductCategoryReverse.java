package util;

import java.util.ResourceBundle;

public class ProductCategoryReverse {

    private static final ResourceBundle bundle = ResourceBundle.getBundle("product-category");

    public static String reverseBrand(String brandName) {
        return bundle.keySet().stream()
            .filter(key -> key.startsWith("brand.") && bundle.getString(key).equals(brandName))
            .findFirst()
            .map(key -> key.split("\\.")[1])
            .orElse(brandName); // 매칭되지 않으면 원래 값을 반환
    }

    public static String reverseType(String typeName) {
        return bundle.keySet().stream()
            .filter(key -> key.startsWith("type.") && bundle.getString(key).equals(typeName))
            .findFirst()
            .map(key -> key.split("\\.")[1])
            .orElse(typeName);
    }

    public static String reverseColor(String colorName) {
        return bundle.keySet().stream()
            .filter(key -> key.startsWith("color.") && bundle.getString(key).equals(colorName))
            .findFirst()
            .map(key -> key.split("\\.")[1])
            .orElse(colorName);
    }

    public static String reverseSize(String sizeName) {
        return bundle.keySet().stream()
            .filter(key -> key.startsWith("size.") && bundle.getString(key).equals(sizeName))
            .findFirst()
            .map(key -> key.split("\\.")[1])
            .orElse(sizeName);
    }

    public static String reverseGender(String genderName) {
        return bundle.keySet().stream()
            .filter(key -> key.startsWith("gender.") && bundle.getString(key).equals(genderName))
            .findFirst()
            .map(key -> key.split("\\.")[1])
            .orElse(genderName);
    }
}
