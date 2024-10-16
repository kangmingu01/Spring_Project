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
    <title>발주 등록</title>
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
         <div class="content_header_search_btn" data-bs-toggle="modal" data-bs-target="#newModal">
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
                     <label>제품번호</label>
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
             <div>
             	<div>
                     <label>단가</label>
                     <input type="number" id=productPrice name="productPrice" readonly class="read-only-field" />
                 </div>
             </div>
         </div>
         
         <div class="content_body_search_price">
             <div>
                 <div>
                    <label>공급업체</label>
					<select id="supplier" name="supplierId" required >
					    <option value="">공급 업체 선택</option>
					    <c:forEach var="supplier" items="${supplierList}">
					        <option value="${supplier.supplierId}">${supplier.supplierName}</option>
					    </c:forEach>
					</select>
                 </div>
                 <div>
                     <label>발주수량</label>
                     <input type="number" id="ordersQuantity" name="ordersQuantity" required min="0" />
                 </div>
                 
                 <div>
                     <label>납기일</label>
                     <input type="date" id="deliveryDate" name="deliveryDate" style="text-align: left;" required />
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
		            <th style="color: red;">발주수량</th>
		            <th style="color: red;">단가</th>
		            <th style="color: red;">총액</th>
		            <th style="color: red;">납기일</th>
		        </tr>
		        </thead>
		        <tbody id="orderTable" class="sty">
		            <c:if test="${not empty newOrder}">
		                <tr>
		                    <td>${newOrder.productId}</td>
		                    <td>${newOrder.productName}</td>
		                    <td>${newOrder.productCategoryDetails.brand}</td>
		                    <td>${newOrder.productCategoryDetails.type}</td>
		                    <td>${newOrder.productCategoryDetails.color}</td>
		                    <td>${newOrder.productCategoryDetails.size}</td>
		                    <td>${newOrder.productCategoryDetails.gender}</td>
		                    <td>${newOrder.supplierName}</td>
		                    <td>${newOrder.ordersQuantity}</td>
		                    <td>${newOrder.productPrice}</td>
		                    <td>${newOrder.ordersQuantity * newOrder.productPrice}</td>
		                    <td>${fn:substring(newOrder.deliveryDate, 0, 10)}</td>
		                </tr>
		            </c:if>
		        </tbody>
		    </table>
		</div>
    </div>
</div>

 <!-- 제품 목록 모달 -->
	<div class="modal fade" id="newModal" tabindex="-1" aria-labelledby="newModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered modal-dialog modal-lg">
	    	<div class="modal-content">
	      		<div class="modal-header">
	        		<h1 class="modal-title fs-5" id="newModalLabel">제품목록</h1>
	        		<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      		</div>
	      		<div class="modal-body">
			        <div class="input-group mb-3 selectSearch">
			        	<select class="modalsearch" name="modalsearch">
			      			<option value="product_category" <c:if test="${search }=='product_category' "> selected </c:if>>제품코드</option>
			      			<option value="product_name" <c:if test="${search }=='product_name' "> selected </c:if>>제품명</option>
		      			</select>
					  	<input type="text"  name="keyword" value="${ keyword}" class="form-control modalkeyword" placeholder="상품명 또는 제품코드를 입력해주세요" aria-label="Recipient's username" aria-describedby="button-addon2">
					  	<button class="btn btn-outline-secondary modalSearch_btn" type="button" id="button-addon2">검색</button>
					</div>
					<div class="product_brand_search"></div>
					<div class="modalpage"></div>
			      	<div class="modal-footer">
		        		<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
		        		<button type="button" class="btn btn-primary" id="newModal_btn">확인</button>
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
    ordersDateInput.value = today; // 발주일자 필드에 현재 날짜 설정

    // 납기일 필드의 최소값을 현재 날짜로 설정
    const deliveryDateInput = document.getElementById("deliveryDate");
    deliveryDateInput.setAttribute('min', today); // 현재 날짜 이후만 선택 가능하게 설정
    
 	// 발주수량 입력 시 숫자 및 범위 형식 입력 방지
    document.getElementById("ordersQuantity").addEventListener("input", function() {
        const ordersQuantity = document.getElementById("ordersQuantity");

        // 음수 입력 방지
        if (ordersQuantity.value < 0) {
            ordersQuantity.value = 0; // 음수 입력 시 값을 0으로 고정
        }

        // 숫자가 아닌 입력 방지 및 "0-2" 형식 방지
        // 정규식을 사용하여 숫자 이외의 값이나 잘못된 형식이 입력되지 않도록 필터링
        const sanitizedValue = ordersQuantity.value.replace(/[^0-9]/g, ''); // 숫자가 아닌 모든 것을 제거
        ordersQuantity.value = sanitizedValue;

        checkFields(); // 필드가 모두 입력되었는지 확인하는 기존 함수 호출
    });

    // 모든 필드가 입력되었는지 확인하는 함수
    function checkFields() {
        const productId = document.getElementById("productId").value; 
        const ordersQuantity = document.getElementById("ordersQuantity").value; 
        const supplier = document.getElementById("supplier").value;
        const deliveryDate = document.getElementById("deliveryDate").value; 

        // 모든 필드가 비어있지 않으면 등록 버튼 활성화
        if (productId && ordersQuantity && supplier && deliveryDate) {
            document.querySelector(".content_header_registers_btn").classList.remove("disabled"); 
            document.querySelector(".content_header_registers_btn").onclick = function() {
                submitForm('registerForm'); 
            };
        } else {
            document.querySelector(".content_header_registers_btn").classList.add("disabled"); 
            document.querySelector(".content_header_registers_btn").onclick = null;
        }
    }

    function selectProduct(code, name, brand, type, color, size, gender, price) {
        document.getElementById("productId").value = code;   
        document.getElementById("productName").value = name; 
        document.getElementById("brand").value = brand;      
        document.getElementById("type").value = type;       
        document.getElementById("color").value = color;     
        document.getElementById("size").value = size;        
        document.getElementById("gender").value = gender;   
        document.getElementById("productPrice").value = price; // 단가를 올바르게 입력

        // 모달 닫기
        var productModal = bootstrap.Modal.getOrCreateInstance(document.getElementById('productModal'));
        productModal.hide();

        // 필드가 채워진 후 등록 버튼 상태 확인
        checkFields();
    }


    // 입력 필드에 이벤트 리스너 추가 (필드 값이 변경될 때마다 등록 버튼 상태 확인)
    document.getElementById("ordersQuantity").addEventListener("input", checkFields); 
    document.getElementById("supplier").addEventListener("change", checkFields); 
    document.getElementById("deliveryDate").addEventListener("input", checkFields); 
    document.getElementById("productId").addEventListener("input", checkFields); 

    // 제품 조회 모달에서 제품 선택을 할 수 있도록 selectProduct 함수를 전역으로 노출
    window.selectProduct = selectProduct;

    // 초기 상태에서 등록 버튼 비활성화
    checkFields();
});

// 제품 목록 모달 열기 함수
function openProductModal() {
    var productModal = new bootstrap.Modal(document.getElementById('productModal'));
    productModal.show(); 
}

// 검색 버튼 클릭 시 제품 목록 모달 열기
function searchOrder() {
    openProductModal(); 
}

// 제품 목록에서 검색 필터링 함수 (제품명이나 브랜드로 필터링)
function filterProducts() {
    const searchQuery = document.getElementById("productSearch").value.toLowerCase(); 
    const productTable = document.getElementById("productTable");
    const rows = productTable.getElementsByTagName("tr");

    // 각 행을 검색어와 비교하여 필터링
    for (let i = 1; i < rows.length; i++) { // 첫 번째 행은 헤더이므로 제외
        const productName = rows[i].getElementsByTagName("td")[1].textContent.toLowerCase(); 
        const productBrand = rows[i].getElementsByTagName("td")[2].textContent.toLowerCase();

        // 제품명이나 브랜드가 검색어를 포함하면 표시, 그렇지 않으면 숨기기
        if (productName.includes(searchQuery) || productBrand.includes(searchQuery) || searchQuery === "") {
            rows[i].style.display = ""; // 조건에 맞으면 표시
        } else {
            rows[i].style.display = "none"; // 조건에 맞지 않으면 숨기기
        }
    }
}

// 폼 제출 함수
function submitForm(formId) {
    document.getElementById(formId).submit(); // 해당 폼 제출
}

// 폼 초기화 함수
function resetForm() {
    // 폼 필드 초기화
    document.getElementById('registerForm').reset();
    
    // 발주일자와 납기일의 최소 날짜를 다시 설정
    const ordersDateInput = document.getElementById("ordersDate");
    const today = new Date().toISOString().split('T')[0];
    ordersDateInput.value = today;
    
    const deliveryDateInput = document.getElementById("deliveryDate");
    deliveryDateInput.setAttribute('min', today);

    // 발주 목록 테이블 초기화
    const orderTable = document.getElementById("orderTable");
    orderTable.innerHTML = '';

    // 초기화 후 등록 버튼 상태 업데이트
    checkFields(); 
}

//제품조회 클릭이벤트
$(".content_header_search_btn").click(function(){
	productDisplay();
});

//제품조회 함수
function productDisplay(pageNum=1) {
	var pageSize=10;
	var search = document.querySelector(".modalsearch").value;
	var keyword = document.querySelector(".modalkeyword").value;
	$.ajax({
		type:"get",
		url: "<c:url value="/inventory/product_list"/>", 
		//data: JSON.stringify({"pageNum":pageNum, "pageSize":pageSize}),
		data: {"pageNum":pageNum, "pageSize":pageSize, "search":search,"keyword":keyword},
		dataType: "json",  		
		success: function(result){
			//console.log(result.productList.length);
			if(result.productList.length == 0){
				var html="<table>";
				html+="<tr>";
				html+="<th>검색된 상품이 없습니다.</th>";
				html+="</tr>";
				html+="</table>";
				$(".product_brand_search").html(html);
				return;
			}
			var html="<table>";
			html+="<thead>";
			html+="<tr>";
			html+="<th>No</th>";		
			html+="<th>제품코드</th>";
			html+="<th>제품명</th>";
			html+="<th>브랜드</th>";
			html+="<th>색상</th>";
			html+="<th>사이즈</th>";
			html+="<th>종류</th>";
			html+="<th>성별</th>";
			html+="<th></th>"; 
			html+="</tr>";
			html+="</thead>";
			html+="<tbody class='sty'>";
			$(result.productList).each(function(index){
				html+="<tr>";					
				html += "<td>" + (index + 1 + (pageNum - 1) * pageSize) + "</td>"; // 수정된 부분
				html+="<td>"+this.productCategory+"</td>";
				html+="<td>"+this.productName+"</td>";
				html+="<td>"+this.productCategory+"</td>";
				html+="<td>"+this.productCategory+"</td>";
				html+="<td>"+this.productCategory+"</td>";
				html+="<td>"+this.productCategory+"</td>";
				html+="<td>"+this.productCategory+"</td>";
				html+="<td>"; 
				html+='<button type="button" class="btn btn-primary" data-bs-dismiss="modal"  onclick="addProductTitle('+this.productId+');">선택</button>'; 
				html+="</td>"
				html+="</tr>";
			});
			html+="</tbody>";
			html+="</table>";
			$(".product_brand_search").html(html);

			//페이지 번호를 출력하는 함수 호출
			modalpageNumberDisplay(result.pager);
        },
		error:function(xhr){
			alert("상품 리스트를 불러오지 못했습니다.");
		}
	});
}

//모달 페이징 처리
function modalpageNumberDisplay(pager) {
    var html = "";

    // 이전 페이지 링크
    if (pager.startPage > pager.blockSize) {
        html += "<a href='javascript:productDisplay(" + pager.prevPage + ","+pager.pageSize+");'>[이전]</a>";
    } else {
        html += "[이전]";
    }

    // 페이지 번호 링크
    for (var i = pager.startPage; i <= pager.endPage; i++) {
        if (pager.pageNum != i) {
            html += "<a href='javascript:productDisplay(" + i + ","+pager.pageSize+");'>[" + i + "]</a>";
        } else {
            html += "[" + i + "]";
        }
    }

    // 다음 페이지 링크
    if (pager.endPage != pager.totalPage) {
        html += "<a href='javascript:productDisplay(" + pager.nextPage + ","+pager.pageSize+");'>[다음]</a>";
    } else {
        html += "[다음]";
    }

    // 페이지 번호 HTML 업데이트
    $(".modalpage").html(html);
}
 
//상품정보 삽입 이벤트
function addProductTitle(productId) {
	$.ajax({
		type:"get",
		url:"<c:url value="/inventory/product_modify_view"/>/"+productId,
		dataType:"json",
		success:function(result){    			
			$(".productId").val(result.productId);
			$(".updateId").val(result.productId);
			$(".productCategory").val(result.productCategory);
			$(".updateCode").val(result.productCategory);
			$(".productName").val(result.productName);
			$(".updateName").val(result.productName);
		},
		error:function(xhr){
			alert("검색된 정보가 없습니다.")
		}
	});    	
}


</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>

</html>
