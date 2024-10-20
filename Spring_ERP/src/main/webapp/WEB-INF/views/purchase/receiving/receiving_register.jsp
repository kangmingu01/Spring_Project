<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
 	<title>입고 등록</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
    <style>
        th, td {
            text-align: center;
        }
    </style>
</head>

<body>
  <div class="content">
    <!-- 헤더부분 -->
    <div class="content_header">
      <div class="content_header_title">입고 등록</div>
      <div class="content_header_btn">
        <div class="content_header_search_btn" onclick="searchOrders()">
          <div><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
            <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
          </svg></div>
          <span>발주조회</span>
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
              d="M8 3a5 5 0 1 0 4.546 2.914.5.5 0 0 1 .908-.417A6 6 0 1 1 8 2z" />
            <path
              d="M8 4.466V.534a.25.25 0 0 1 .41-.192l2.36 1.966c.12.1.12.284 0 .384L8.41 4.658A.25.25 0 0 1 8 4.466" />
          </svg>
          <span>초기화</span>
        </div>
      </div>
    </div>

    <!-- 바디부분 -->
    <div class="content_body">
      <!-- 입고 등록 폼 -->
      <form id="registerForm" action="<c:url value='/purchase/receiving/register'/>" method="post">
      <div class="content_body_search">
      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
      <input type="hidden" name="userId" value="${userId}" />
        <div>
          <div>
            <label>입고일자</label>
            <input type="date" id="receivingDate" name="receivingDate" readonly class="read-only-field" />
          </div>
          <div>
            <label>발주번호</label>
            <input type="text" name="ordersId" class="result" id="ordersId" readonly style="background-color: #e9e9e9;" />
          </div>

          <div>
            <label>제품번호</label>
            <input type="text" name="productId" class="result" id="productId" readonly style="background-color: #e9e9e9;" />
          </div>
          <div>
            <label>제품명</label>
            <input type="text" id="productName" name="productName" readonly class="read-only-field" />
          </div>
         </div>
         <div>
           <div>
            <label>제품코드</label>
            <input type="text" id="productCategoryDetails" name="productCategoryDetails" readonly class="read-only-field" />
          </div>
          <div>
            <label>브랜드</label>
            <input type="text" id="brand" name="brand" readonly class="read-only-field"/>
          </div>
          <div>
            <label>종류</label>
            <input type="text" id="type" name="type" readonly class="read-only-field"/>
          </div>
          <div>
            <label>색상</label>
             <input type="text" id="color" name="color" readonly class="read-only-field"/>
          </div>
          </div>
          <div>
          <div>
            <label>사이즈</label>
             <input type="text" id="size" name="size" readonly class="read-only-field"/>
          </div>
          <div>
            <label>성별</label>
           <input type="text" id="gender" name="gender" readonly class="read-only-field"/>
          </div>
             <div>
              <label>공급업체</label>
              <input type="text" id="supplier" name="supplier" readonly class="read-only-field" />
            </div>
            <div>
              <label>발주수량</label>
              <input type="number" id="ordersQuantity" name="ordersQuantity" readonly class="read-only-field" />
            </div>
            </div>
            <div>
            <div>
              <label>단가</label>
              <input type="number" id=productPrice name="productPrice" readonly class="read-only-field" />
            </div>
            <div>
              <label>납기일</label>
               <input type="date" id="deliveryDate" name="deliveryDate" style="text-align: left;" readonly class="read-only-field" />
            </div>
          </div>
      </div>

      <div class="content_body_search_price">
        <div>
          <div>
            <label>창고</label>
            <select id="warehouse" name="warehouseId" required>
              <option value="">창고 선택</option>
              <c:forEach var="warehouse" items="${warehouseList}">
                <option value="${warehouse.warehouseId}">${warehouse.warehouseName}</option>
              </c:forEach>
            </select>
          </div>
          <div>
            <label>통과수량</label>
            <input type="number" id="quantity" name="quantity" required />
          </div>
        </div>
        <div>
        <div></div>
        <div>
        <span id="quantity-error" style="color:red; display:none; font-size: 12px">통과수량은 발주수량을 초과할 수 없습니다.</span>
        </div>
        </div>
      </div>
       </form>

      <!-- 테이블 부분 -->
      <div class="content_body_list">
        <table>
          <thead>
            <tr>
              <th>발주번호</th>
              <th>제품번호</th>
              <th>제품명</th>
              <th>제품코드</th>
              <th>브랜드</th>
              <th>종류</th>
              <th>색상</th>
              <th>사이즈</th>
              <th>성별</th>
              <th>공급업체</th>
              <th>발주수량</th>
              <th style="color: red;">통과수량</th>
              <th style="color: red;">단가</th>
              <th style="color: red;">총액</th>
              <th style="color: red;">납기일</th>
              <th>창고</th>
            </tr>
          </thead>
          <tbody id="receivingTable" class="sty">
             <c:if test="${not empty newReceiving}">
		                <tr>
		                    <td>${newReceiving.ordersId}</td>
		                    <td>${newReceiving.productId}</td>
		                    <td>${newReceiving.productName}</td>
		                    <td>${productCode}</td>
		                    <td>${productCategory.brand}</td>                            
                            <td>${productCategory.type}</td>
                            <td>${productCategory.color}</td>
                            <td>${productCategory.size}</td>
                            <td>${productCategory.gender}</td>
		                    <td>${newReceiving.supplierName}</td>
		                    <td>${newReceiving.ordersQuantity}</td>
		                    <td>${newReceiving.quantity}</td>
		                    <td>${newReceiving.productPrice}</td>
		                    <td>${newReceiving.quantity * newReceiving.productPrice}</td>
		                    <td>${fn:substring(newReceiving.deliveryDate, 0, 10)}</td>
		                    <td>${newReceiving.warehouseName}</td>
		                </tr>
		            </c:if>
          </tbody>
        </table>
      </div>
    </div>
  </div>

  <!-- 발주 목록 모달 -->
  
  <div class="modal fade" id="ordersModal" tabindex="-1" aria-labelledby="ordersModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="max-width: 61%;">
          <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="ordersModalLabel">발주 목록</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
                 <!-- 검색 필드 통합 -->
                 <div class="input-group mb-3">
                     <input type="text" class="form-control" id="ordersSearch" placeholder="제품명 또는 공급업체 검색" aria-label="검색">
                     <button type="button" onclick="filterOrders()">검색</button>
                 </div>
                 <table class="table" id="productTable">
                     <thead>
              <tr>
                <th>발주번호</th>
                <th>제품번호</th>
                <th>제품명</th>
                <th>제품코드</th>
                <th>브랜드</th>
                <th>종류</th>
                <th>색상</th>
                <th>사이즈</th>
                <th>성별</th>
                <th>공급업체</th>
                <th>발주수량</th>
                <th>단가</th>
                <th>납기일</th>
                <th>선택</th>
              </tr>
            </thead>
            <tbody>
			   <c:forEach var="orders" items="${ordersResult}">
			    <tr>
			        <td>${orders.ordersId}</td>
			        <td>${orders.productId}</td>
			        <td>${orders.productName}</td>
			        <td>
					    <!-- 카테고리 출력 부분 -->
					    <c:if test="${not empty orders.productCategoryDetails.brand}">
					        ${fn:substring(orders.productCategoryDetails.brand, 0, 2)}
					    </c:if>
					    <c:if test="${not empty orders.productCategoryDetails.type}">
					        ${fn:substring(orders.productCategoryDetails.type, 0, 2)}
					    </c:if>
					    <c:if test="${not empty orders.productCategoryDetails.color}">
					        ${fn:substring(orders.productCategoryDetails.color, 0, 2)}
					    </c:if>
					    <c:if test="${not empty orders.productCategoryDetails.size}">
					        ${orders.productCategoryDetails.size}
					    </c:if>
					    <c:if test="${not empty orders.productCategoryDetails.gender}">
					        ${fn:substring(orders.productCategoryDetails.gender, 0, 1)}
					    </c:if>
					</td>
			        <td>${orders.productCategoryDetails.brand}</td>
			        <td>${orders.productCategoryDetails.type}</td>
			        <td>${orders.productCategoryDetails.color}</td>
			        <td>${orders.productCategoryDetails.size}</td>
			        <td>${orders.productCategoryDetails.gender}</td>
			        <td>${orders.supplierName}</td>
			        <td>${orders.ordersQuantity}</td>
			        <td>${orders.productPrice}</td>
			        <td>${fn:substring(orders.deliveryDate, 0, 10)}</td>
			        <td>
				    <button type="button"
				    onclick="selectOrders({
				        ordersId: '${fn:escapeXml(orders.ordersId)}',
				        productId: '${fn:escapeXml(orders.productId)}',
				        productName: '${fn:escapeXml(orders.productName)}',
				        productCategoryDetails: {
				            brand: '${fn:escapeXml(orders.productCategoryDetails.brand)}',
				            type: '${fn:escapeXml(orders.productCategoryDetails.type)}',
				            color: '${fn:escapeXml(orders.productCategoryDetails.color)}',
				            size: '${fn:escapeXml(orders.productCategoryDetails.size)}',
				            gender: '${fn:escapeXml(orders.productCategoryDetails.gender)}'
				        },
				        supplierName: '${fn:escapeXml(orders.supplierName)}',
				        ordersQuantity: '${fn:escapeXml(orders.ordersQuantity)}',
				        productPrice: '${fn:escapeXml(orders.productPrice)}',
				        deliveryDate: '${fn:substring(orders.deliveryDate, 0, 10)}'
				    })">
				    선택
				</button>
				</td>
			    </tr>
					</c:forEach>
					</tbody>
                 </table>
			              <div id="pagination" style="text-align:center;">
			    <!-- Ajax로 페이징 번호가 동적으로 여기에 추가됩니다 -->
			</div>
             </div>
         </div>
     </div>
 </div>

<script>
  document.addEventListener("DOMContentLoaded", function () {
	    // 입고일자 필드에 현재 날짜를 설정하고 수정 불가능하게 처리
	    const receivingDateInput = document.getElementById("receivingDate");
	    const today = new Date().toISOString().split('T')[0];
	    receivingDateInput.value = today;

	    // 필수 입력 필드 확인 후 등록 버튼 활성화
	    function checkFields() {
	        const ordersId = document.getElementById("ordersId").value;
	        const quantity = document.getElementById("quantity").value;
	        const warehouse = document.getElementById("warehouse").value;

	        // 필수 입력 값 확인 후 등록 버튼 활성화
	        if (ordersId && quantity && warehouse) {
	            document.querySelector(".content_header_registers_btn").classList.remove("disabled");
	            document.querySelector(".content_header_registers_btn").onclick = function () {
	                submitForm('registerForm');
	            };
	        } else {
	            document.querySelector(".content_header_registers_btn").classList.add("disabled");
	            document.querySelector(".content_header_registers_btn").onclick = null;
	        }
	    }

	    // 통과 수량 검증 및 경고 메시지 처리
	    document.getElementById("quantity").addEventListener("input", function() {
	        const ordersQuantity = parseInt(document.getElementById("ordersQuantity").value); // 발주수량
	        const quantity = parseInt(this.value); // 입력된 통과수량
	        const errorSpan = document.getElementById("quantity-error"); // 에러 메시지 표시할 span

	        // 통과수량이 발주수량을 초과하면 경고 메시지 표시
	        if (quantity > ordersQuantity) {
	            errorSpan.style.display = "inline";  // 에러 메시지 표시
	            this.value = "";  // 잘못된 입력값 제거
	        } else {
	            errorSpan.style.display = "none";  // 에러 메시지 숨김
	        }
	    });

	    // 입력 필드에 이벤트 리스너 추가
	    document.getElementById("ordersId").addEventListener("input", checkFields);
	    document.getElementById("quantity").addEventListener("input", checkFields);
	    document.getElementById("warehouse").addEventListener("change", checkFields);

	    // 초기 상태에서 버튼 비활성화
	    checkFields();
	});

	// 발주 목록 모달 열기
	function openOrdersModal() {
	    var ordersModal = new bootstrap.Modal(document.getElementById('ordersModal'));
	    ordersModal.show();
	}

	// 발주 조회 버튼 클릭 시 발주 목록 모달 열기
	function searchOrders() {
	    openOrdersModal();
	}

	// 발주 목록 검색 필터 함수 (제품명과 공급업체로 검색 가능)
	function filterOrders() {
	    const searchQuery = document.getElementById("ordersSearch").value.toLowerCase();
	    const ordersTable = document.getElementById("productTable");
	    const rows = ordersTable.getElementsByTagName("tr");

	    for (let i = 1; i < rows.length; i++) { // 첫 번째 행은 헤더이므로 제외
	        const productName = rows[i].getElementsByTagName("td")[2].textContent.toLowerCase(); // 제품명
	        const supplierName = rows[i].getElementsByTagName("td")[9].textContent.toLowerCase(); // 공급업체명

	        if (productName.includes(searchQuery) || supplierName.includes(searchQuery) || searchQuery === "") {
	            rows[i].style.display = ""; // 검색 조건에 맞으면 표시
	        } else {
	            rows[i].style.display = "none"; // 검색 조건에 맞지 않으면 숨기기
	        }
	    }
	}

	function selectOrders(order) {
	    document.getElementById("ordersId").value = order.ordersId;
	    document.getElementById("productId").value = order.productId;
	    document.getElementById("productName").value = order.productName;

	    // 카테고리 코드 부분 축약 (브랜드, 종류, 색상, 사이즈, 성별)
	    var shortCategory = '';
	    if (order.productCategoryDetails.brand) {
	        shortCategory += order.productCategoryDetails.brand.substring(0, 2);
	    }
	    if (order.productCategoryDetails.type) {
	        shortCategory += order.productCategoryDetails.type.substring(0, 2);
	    }
	    if (order.productCategoryDetails.color) {
	        shortCategory += order.productCategoryDetails.color.substring(0, 2);
	    }
	    if (order.productCategoryDetails.size) {
	        shortCategory += order.productCategoryDetails.size;
	    }
	    if (order.productCategoryDetails.gender) {
	        shortCategory += order.productCategoryDetails.gender.substring(0, 1);
	    }

	    document.getElementById("productCategoryDetails").value = shortCategory;
	    document.getElementById("brand").value = order.productCategoryDetails.brand;
	    document.getElementById("type").value = order.productCategoryDetails.type;
	    document.getElementById("color").value = order.productCategoryDetails.color;
	    document.getElementById("size").value = order.productCategoryDetails.size;
	    document.getElementById("gender").value = order.productCategoryDetails.gender;
	    document.getElementById("supplier").value = order.supplierName;
	    document.getElementById("ordersQuantity").value = order.ordersQuantity;
	    document.getElementById("productPrice").value = order.productPrice;

	    // deliveryDate에서 날짜 부분만 추출해서 설정
	    var formattedDeliveryDate = order.deliveryDate.substring(0, 10);
	    document.getElementById("deliveryDate").value = formattedDeliveryDate;

	    // 모달 닫기
	    var ordersModal = bootstrap.Modal.getOrCreateInstance(document.getElementById('ordersModal'));
	    ordersModal.hide();

	    checkFields(); // 필드 체크
	}


	// 폼 제출 함수
	function submitForm(formId) {
	    const ordersQuantity = parseInt(document.getElementById("ordersQuantity").value);
	    const quantity = parseInt(document.getElementById("quantity").value);
	    const errorSpan = document.getElementById("quantity-error");

	    // 통과수량이 발주수량을 초과하는지 확인
	    if (quantity > ordersQuantity) {
	        errorSpan.style.display = "inline"; // 에러 메시지 표시
	        return; // 폼 제출 중단
	    } else {
	        errorSpan.style.display = "none";  // 에러 메시지 숨김
	    }

	    document.getElementById(formId).submit();
	}

	// 폼 초기화 함수
	function resetForm() {
	    document.getElementById('registerForm').reset();

	    const receivingDateInput = document.getElementById("receivingDate");
	    const today = new Date().toISOString().split('T')[0];
	    receivingDateInput.value = today;

	    const ordersTable = document.getElementById("receivingTable");
	    ordersTable.innerHTML = '';
	    checkFields(); // 필드 초기화 후 다시 필드 체크
	}

	// 필수 입력 필드 확인 후 등록 버튼 활성화
	function checkFields() {
	    const ordersId = document.getElementById("ordersId").value;
	    const quantity = document.getElementById("quantity").value;
	    const warehouse = document.getElementById("warehouse").value;

	    // 필수 입력 값 확인 후 등록 버튼 활성화
	    if (ordersId && quantity && warehouse) {
	        document.querySelector(".content_header_registers_btn").classList.remove("disabled");
	        document.querySelector(".content_header_registers_btn").onclick = function () {
	            submitForm('registerForm');
	        };
	    } else {
	        document.querySelector(".content_header_registers_btn").classList.add("disabled");
	        document.querySelector(".content_header_registers_btn").onclick = null;
	    }
	}
	
	function loadOrdersPage(pageNum, productSearchQuery = '', supplierSearchQuery = '') {
	    var csrfToken = $('meta[name="_csrf"]').attr('content');
	    var csrfHeader = $('meta[name="_csrf_header"]').attr('content');
	    $.ajax({
	        url: '/purchase/receiving/ordersList', 
	        type: 'GET',
	        data: {
	            pageNum: pageNum,
	            pageSize: 10,
	            productName: productSearchQuery,  // 제품 검색어
	            supplierName: supplierSearchQuery  // 공급업체 검색어
	        },
	        beforeSend: function(xhr) {
	            // CSRF 토큰을 헤더에 추가
	            xhr.setRequestHeader(csrfHeader, csrfToken);
	        },
	        success: function(response) {
	            if (response.ordersList) {
	                var ordersTableBody = $('#productTable tbody');
	                ordersTableBody.empty();  // 기존 내용을 지우고

	                $.each(response.ordersList, function(index, order) {
	                    var newRow = `
	                        <tr>
	                            <td>${order.ordersId}</td>
	                            <td>${order.productId}</td>
	                            <td>${order.productName}</td>
	                            <td>${order.productCategoryDetails.brand} ${order.productCategoryDetails.type} ${order.productCategoryDetails.color} ${order.productCategoryDetails.size} ${order.productCategoryDetails.gender}</td>
	                            <td>${order.supplierName}</td>
	                            <td>${order.ordersQuantity}</td>
	                            <td>${order.productPrice}</td>
	                            <td>${order.deliveryDate.substring(0, 10)}</td>
	                            <td><button type="button" onclick="selectOrders(${order})">선택</button></td>
	                        </tr>`;
	                    ordersTableBody.append(newRow);
	                });

	                // 페이징 업데이트
	                updatePagination(response.pager);
	            }
	        },
	        error: function(xhr, status, error) {
	            console.log("상태: " + status);
	            console.log("오류: " + error);
	            console.log("응답 텍스트: " + xhr.responseText);
	        }
	    });
	}

	function updatePagination(pager) {
	    var pagination = $('#pagination');
	    pagination.empty();  // 기존 페이지 링크 삭제

	    // 이전 페이지 링크
	    if (pager.startPage > 1) {
	        pagination.append(`<a href="#" onclick="loadOrdersPage(${pager.prevPage})">[이전]</a>`);
	    }

	    // 페이지 번호 링크
	    for (var i = pager.startPage; i <= pager.endPage; i++) {
	        if (i === pager.pageNum) {
	            pagination.append(`<span>[${i}]</span>`);
	        } else {
	            pagination.append(`<a href="#" onclick="loadOrdersPage(${i})">[${i}]</a>`);
	        }
	    }

	    // 다음 페이지 링크
	    if (pager.endPage < pager.totalPage) {
	        pagination.append(`<a href="#" onclick="loadOrdersPage(${pager.nextPage})">[다음]</a>`);
	    }
	}
	$(document).ready(function() {
	    loadOrdersPage(1);  // 첫 번째 페이지 로드
	});


</script>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>

</html>
