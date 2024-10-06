<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%> 
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/reset.css' />">    
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/purchase.css' />">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
          crossorigin="anonymous">
	<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
    <title>발주 등록</title>
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>  
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
</head>

<body>
<div class="content">
    <!-- 헤더부분 -->
 <div class="content_header">
     <div class="content_header_title">발주 등록</div>
     <div class="content_header_btn">
         <div class="content_header_search_btn" onclick="searchOrder()">
             <div>
                 <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
                     <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
                 </svg>
             </div>
             <span>제품조회</span>
         </div>
         <div class="content_header_registers_btn" onclick="submitForm('registerForm')">
             <div>
                 <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-plus-circle" viewBox="0 0 16 16">
                     <path d="M8 4a.5.5 0 0 1 .5.5V7.5H11.5a.5.5 0 0 1 0 1H8.5V11.5a.5.5 0 0 1-1 0V8.5H4.5a.5.5 0 0 1 0-1H7.5V4.5A.5.5 0 0 1 8 4z"/>
                     <path d="M8 15A7 7 0 1 0 8 1a7 7 0 0 0 0 14zM8 14A6 6 0 1 1 8 2a6 6 0 0 1 0 12z"/>
                 </svg>   
             </div>
             <span>등록</span>
         </div>
         <div class="content_header_reset_btn" onclick="resetForm()">
             <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                  class="bi bi-arrow-clockwise" viewBox="0 0 16 16">
                 <path fill-rule="evenodd"
                       d="M8 3a5 5 0 1 0 4.546 2.914.5.5 0 0 1 .908-.417A6 6 0 1 1 8 2z"/>
                 <path
                         d="M8 4.466V.534a.25.25 0 0 1 .41-.192l2.36 1.966c.12.1.12.284 0 .384L8.41 4.658A.25.25 0 0 1 8 4.466"/>
             </svg>
             <span>초기화</span>
         </div>
     </div>
 </div>
 <!-- 바디부분 -->
 <div class="content_body">
     <!-- 발주 등록 폼 -->
     <form id="registerForm" action="<c:url value='/purchase/orders/register'/>" method="post">
         <div class="content_body_search">
         <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
         <input type="hidden" name="userId" value="${userId}" />
             <div>
                 <div>
                     <label>발주일자</label>
                     <input type="date" id="ordersDate" name="ordersDate" readonly class="read-only-field"/>
                 </div>
                 <div>
                     <label style="color: red;">제품번호</label>
                     <input type="text" name="productId" class="result" id="productId" readonly style="background-color: #e9e9e9;"/>
                 </div>
                 <div>
                     <label>제품명</label>
                     <input type="text" id="productName" name="productName" readonly class="read-only-field"/>
                 </div>
                 <div>
                     <label>브랜드</label>
                     <input type="text" id="brand" name="brand" readonly class="read-only-field"/>
                 </div>
             </div>
             <div>
                 <div>
                     <label>종류</label>
                     <input type="text" id="type" name="type" readonly class="read-only-field"/>
                 </div>
                 <div>
                     <label>색상</label>
                     <input type="text" id="color" name="color" readonly class="read-only-field"/>
                 </div>
                 <div>
                     <label>사이즈</label>
                     <input type="text" id="size" name="size" readonly class="read-only-field"/>
                 </div>
                 <div>
                     <label>성별</label>
                     <input type="text" id="gender" name="gender" readonly class="read-only-field"/>
                 </div>
             </div>
         </div>
         
         <div class="content_body_search_price">
             <div>
                 <div>
                    <label>공급업체</label>
					<select id="supplier" name="supplierId">
					    <option value="">공급 업체 선택</option>
					    <c:forEach var="supplier" items="${supplierList}">
					        <option value="${supplier.supplierId}">${supplier.supplierName}</option>
					    </c:forEach>
					</select>
                 </div>
                 <div>
                     <label>발주수량</label>
                     <input type="number" id="ordersQuantity" name="ordersQuantity"/>
                 </div>
                 <div>
                     <label>단가</label>
                     <input type="number" id=productPrice name="productPrice"/>
                 </div>
                 <div>
                     <label>납기일</label>
                     <input type="date" id="deliveryDate" name="deliveryDate" style="text-align: left;"/>
                 </div>
             </div>
         </div>
         
     </form>

     <!-- 발주 목록 테이블 -->
     <div class="content_body_list">
         <table>
             <thead>
             <tr>
                 <th>제품번호</th>
                 <th>제품명</th>
                 <th>브랜드</th>
                 <th>종류</th>
                 <th>색상</th>
                 <th>사이즈</th>
                 <th>성별</th>
                 <th>공급업체</th>
                 <th>발주수량</th>
                 <th>단가</th>
                 <th>총액</th>
                 <th>납기일</th>
             </tr>
             </thead>
             <tbody id="orderTable" class="sty">
          	    <c:forEach var="order" items="${ordersList}">
			        <tr>
			            <td>${order.productId}</td>
			            <td>${order.productName}</td>
			            <td>${order.brand}</td>
			            <td>${order.type}</td>
			            <td>${order.color}</td>
			            <td>${order.size}</td>
			            <td>${order.gender}</td>
			            <td>${order.supplierId}</td>
			            <td>${order.ordersQuantity}</td>
			            <td>${order.productPrice}</td>
			            <td>${order.totalPrice}</td> <!-- 총액 계산 필드 필요 시 추가 -->
			            <td>${order.deliveryDate}</td>
			        </tr>
			    </c:forEach>
			</tbody>
                </tbody>
            </table>
        </div>
    </div>
</div>

 <!-- 제품 목록 모달 -->
 <div class="modal fade" id="productModal" tabindex="-1" aria-labelledby="productModalLabel" aria-hidden="true">
     <div class="modal-dialog modal-lg">
         <div class="modal-content">
             <div class="modal-header">
                 <h5 class="modal-title" id="productModalLabel">제품 목록</h5>
                 <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
             </div>
             <div class="modal-body">
                 <!-- 검색 필드 통합 -->
                 <div class="input-group mb-3">
                     <input type="text" class="form-control" id="productSearch" placeholder="제품명 또는 브랜드 검색" aria-label="검색">
                     <button type="button" onclick="filterProducts()">검색</button>
                 </div>
                 <table class="table" id="productTable">
                     <thead>
                     <tr>
                         <th>제품번호</th>
                         <th>제품명</th>
                         <th>브랜드</th>
                         <th>종류</th>
                         <th>색상</th>
                         <th>사이즈</th>
                         <th>성별</th>
                         <th>선택</th>
                     </tr>
                     </thead>
                     <tbody>
					   <c:forEach var="product" items="${productList}">
					    <tr>
					        <td>${product.productId}</td>
					        <td>${product.productName}</td>
					        <td>${product.productCategoryDetails.brand}</td>
					        <td>${product.productCategoryDetails.type}</td>
					        <td>${product.productCategoryDetails.color}</td>
					        <td>${product.productCategoryDetails.size}</td>
					        <td>${product.productCategoryDetails.gender}</td>
					        <td>
					            <button type="button" onclick="selectProduct('${product.productId}', '${product.productName}', '${product.productCategoryDetails.brand}', '${product.productCategoryDetails.type}', '${product.productCategoryDetails.color}', '${product.productCategoryDetails.size}', '${product.productCategoryDetails.gender}')">선택</button>
					        </td>
					    </tr>
					</c:forEach>
					</tbody>
                 </table>
                 <div class="pagination">                   
                <div style="text-align: center;">
                    <c:choose>
                        <c:when test="${pager.startPage > pager.blockSize}">
                            <button type="button" onclick="loadProductPage(${pager.prevPage})" class="btn btn-link">[이전]</button>
                        </c:when>
                        <c:otherwise>
                            <span>[이전]</span>
                        </c:otherwise>
                    </c:choose>

                    <c:forEach var="i" begin="${pager.startPage}" end="${pager.endPage}">
                        <c:choose>
                            <c:when test="${pager.pageNum != i}">
                                <button type="button" onclick="loadProductPage(${i})" class="btn btn-link">[${i}]</button>
                            </c:when>
                            <c:otherwise>
                                <span>[${i}]</span>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>

                    <c:choose>
                        <c:when test="${pager.endPage != pager.totalPage}">
                            <button type="button" onclick="loadProductPage(${pager.nextPage})" class="btn btn-link">[다음]</button>
                        </c:when>
                        <c:otherwise>
                            <span>[다음]</span>
                        </c:otherwise>
                    </c:choose>
                </div>
                </div>
             </div>
         </div>
     </div>
 </div>
 
<script type="text/javascript">
document.addEventListener("DOMContentLoaded", function () {
    // 발주일자 필드에 현재 날짜를 설정하고 수정 불가능하게 처리
    const ordersDateInput = document.getElementById("ordersDate");
    const today = new Date().toISOString().split('T')[0];
    ordersDateInput.value = today;

    // 모든 필드가 입력되었는지 확인하는 함수
    function checkFields() {
        const productId = document.getElementById("productId").value;
        const ordersQuantity = document.getElementById("ordersQuantity").value;
        const productPrice = document.getElementById("productPrice").value;
        const supplier = document.getElementById("supplier").value;
        const deliveryDate = document.getElementById("deliveryDate").value;

        // 모든 필드가 비어있지 않으면 등록 버튼 활성화
        if (productId && ordersQuantity && productPrice && supplier && deliveryDate) {
            document.querySelector(".content_header_registers_btn").classList.remove("disabled");
            document.querySelector(".content_header_registers_btn").onclick = function() {
                submitForm('registerForm');
            };
        } else {
            document.querySelector(".content_header_registers_btn").classList.add("disabled");
            document.querySelector(".content_header_registers_btn").onclick = null;
        }
    }

    // 입력 필드에 이벤트 리스너 추가
    document.getElementById("ordersQuantity").addEventListener("input", checkFields);
    document.getElementById("productPrice").addEventListener("input", checkFields);
    document.getElementById("supplier").addEventListener("change", checkFields);
    document.getElementById("deliveryDate").addEventListener("input", checkFields);
    document.getElementById("productId").addEventListener("input", checkFields);

    // 초기 상태에서 버튼 비활성화
    checkFields();
});

// 제품 목록 모달 열기
function openProductModal() {
    var productModal = new bootstrap.Modal(document.getElementById('productModal'));
    productModal.show();
}

// 검색 버튼 클릭 시 제품 목록 모달 열기
function searchOrder() {
    openProductModal();
}

// 제품 목록 검색 필터 함수 (하나의 검색 필드에서 제품명과 브랜드 검색)
function filterProducts() {
    const searchQuery = document.getElementById("productSearch").value.toLowerCase();
    const productTable = document.getElementById("productTable");
    const rows = productTable.getElementsByTagName("tr");

    for (let i = 1; i < rows.length; i++) { // 첫 번째 행은 헤더이므로 제외
        const productName = rows[i].getElementsByTagName("td")[1].textContent.toLowerCase();
        const productBrand = rows[i].getElementsByTagName("td")[2].textContent.toLowerCase();

        if (productName.includes(searchQuery) || productBrand.includes(searchQuery) || searchQuery === "") {
            rows[i].style.display = ""; // 검색 조건에 맞으면 표시
        } else {
            rows[i].style.display = "none"; // 검색 조건에 맞지 않으면 숨기기
        }
    }
}

//제품 선택 함수
function selectProduct(code, name, brand, type, color, size, gender) {
    document.getElementById("productId").value = code;   // 제품번호 필드에 ID 수정
    document.getElementById("productName").value = name;
    document.getElementById("brand").value = brand;
    document.getElementById("type").value = type;
    document.getElementById("color").value = color;
    document.getElementById("size").value = size;
    document.getElementById("gender").value = gender;

 	// 모달 닫기
    var productModal = bootstrap.Modal.getOrCreateInstance(document.getElementById('productModal'));
    productModal.hide();
    
    // 필드 채워짐에 따라 등록 버튼 상태 확인
    checkFields();
    
}

function submitForm(formId) {
    document.getElementById(formId).submit();
}

function resetForm() {
    document.getElementById('registerForm').reset();
    checkFields(); // 초기화 후 등록 버튼 상태 업데이트
}

</script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>

</html>
