package util;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

public class CategoryConverter {
    private Properties properties;

    // 생성자에서 properties 파일을 읽어옴
    public CategoryConverter() throws IOException {
        properties = new Properties();
        // Properties 파일 경로 설정
        FileInputStream input = new FileInputStream("src/main/resources/products_category.properties");
        properties.load(input);
        input.close();
    }

    // categoryCode를 받아 변환하는 함수
    public String convertCategory(String code) {
        // 코드에서 각 부분을 잘라서 properties에서 해당 값을 찾음
        String brand = properties.getProperty(code.substring(0, 2), "N/A"); // 'brand'
        String item = properties.getProperty(code.substring(2, 4), "N/A");  // 'item'
        String color = properties.getProperty(code.substring(4, 6), "N/A");  // 'color'
        String size = code.substring(6, 9);                                  // '270'은 변환 없이 그대로 사용
        String gender = properties.getProperty(code.substring(9), "N/A");   // 'm'

        // 변환된 값을 반환
        return brand + " " + item + " " + color + " " + size + " " + gender;
    }
}