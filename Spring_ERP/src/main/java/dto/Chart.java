package dto;

import lombok.Data;

@Data
public class Chart {
    private String productName;
    private int productCount;
    private int totalCurrentQty;
    private int totalDamagedQty;
    private String lastDate;

    private String month;
    private int inQuantity;
    private int outQuantity;
}
