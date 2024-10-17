package service;

import org.springframework.stereotype.Service;

import dto.ProductCategory;
import util.ProductCategoryParser;

@Service
public class CommonService {

    public ProductCategory getProductCategoryDetails(String categoryCode) {
        return ProductCategoryParser.parseCategoryCode(categoryCode);
    }
}
