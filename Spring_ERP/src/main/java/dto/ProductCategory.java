package dto;

import lombok.Data;

@Data
public class ProductCategory {
    private String brand;    // 브랜드 코드
    private String type;     // 제품 종류 코드
    private String color;    // 색상 코드
    private String size;     // 사이즈 코드
    private String gender;   // 성별 코드
    private String originalCode; // 원본 코드 추가

    // 기본 생성자
    public ProductCategory() {}

    // 커스텀 생성자
    public ProductCategory(String brand, String type, String color, String size, String gender, String originalCode) {
        this.brand = brand;
        this.type = type;
        this.color = color;
        this.size = size;
        this.gender = gender;
        this.originalCode = originalCode;
    }

    @Override
    public String toString() {
        return "ProductCategory{" +
                "brand='" + brand + '\'' +
                ", type='" + type + '\'' +
                ", color='" + color + '\'' +
                ", size='" + size + '\'' +
                ", gender='" + gender + '\'' +
                ", originalCode='" + originalCode + '\'' +
                '}';
    }
}
