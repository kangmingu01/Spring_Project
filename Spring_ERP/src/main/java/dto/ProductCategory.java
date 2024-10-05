package dto;

import lombok.Data;

@Data
public class ProductCategory {
    private String brand;    // 브랜드 코드 (예: "NI")
    private String type;     // 제품 종류 코드 (예: "SN")
    private String color;    // 색상 코드 (예: "BL")
    private String size;     // 사이즈 코드 (예: "270")
    private String gender;   // 성별 코드 (예: "M")

    // 커스텀 생성자 추가
    public ProductCategory(String brand, String type, String color, String size, String gender) {
        this.brand = brand;
        this.type = type;
        this.color = color;
        this.size = size;
        this.gender = gender;
    }

    @Override
    public String toString() {
        return "ProductCategory{" +
                "brand='" + brand + '\'' +
                ", type='" + type + '\'' +
                ", color='" + color + '\'' +
                ", size='" + size + '\'' +
                ", gender='" + gender + '\'' +
                '}';
    }
}
