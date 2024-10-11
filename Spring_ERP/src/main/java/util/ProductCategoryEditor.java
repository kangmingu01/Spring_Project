package util;

import java.beans.PropertyEditorSupport;
import dto.ProductCategory;

public class ProductCategoryEditor extends PropertyEditorSupport {
    @Override
    public void setAsText(String text) throws IllegalArgumentException {
        if (text == null || text.isEmpty() || "undefined".equals(text)) {
            setValue(null);
        } else {
            // ProductCategoryParser 사용
            ProductCategory productCategory = ProductCategoryParser.parseCategoryCode(text);
            setValue(productCategory);
        }
    }
}
