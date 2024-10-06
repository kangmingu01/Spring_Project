<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/reset.css'/>">
  <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/purchase.css'/>">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
  <title>발주 목록</title>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <meta name="_csrf" content="${_csrf.token}"/>
  <meta name="_csrf_header" content="${_csrf.headerName}"/>
</head>

<body>
  <div class="content">
    <!-- 헤더부분 -->
    <div class="content_header">
      <div class="content_header_title">발주 목록</div>
      <div class="content_header_btn">
        <div class="content_header_search_btn" onclick="searchOrders()">
          <div><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
            <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
          </svg></div>
          <span>조회</span>
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
      <!-- 발주 조회 폼 -->
	<form id="ordersForm" action="<c:url value='/purchase/orders/list' />" method="get">
	    <div class="content_body_search">
	        <div>
	            <div>
	                <label>발주번호</label>
	                <input type="text" name="ordersId" id="ordersId" />
	            </div>
	            <div> 
	                <label>발주일자</label>
	                <input type="date" name="ordersDate" id="ordersDate" />
	            </div>
	            <div>
	                <label>담당자</label>
	                <input type="text" name="userid" id="userid" />
	            </div>
	            <div>
	                <label style="color: red;">제품번호</label>
	                <input type="text" name="productId" id="productId" />           
	            </div>
	        </div>
	        <div>  
	            <div>
	                <label>제품명</label>
	                <input type="text" name="productName" id="productName" />
	            </div>
	            <div>
	                <label>브랜드</label>
	                <input type="text" name="brand" id="brand" />
	            </div>       
	            <div>
	                <label>공급업체</label>
	                <select name="supplierId" id="supplier">
	                    <option value="">공급 업체 선택</option>
	                    <c:forEach var="supplier" items="${supplierList}">
	                        <option value="${supplier.supplierId}">${supplier.supplierName}</option>
	                    </c:forEach>
	                </select>
	            </div>
	            <div>
	                <label>상태</label>
	                <select name="ordersStatus" id="ordersStatus">
	                    <option value="">상태 선택</option>
	                    <option value="1">발주 대기</option> 
	                    <option value="2">발주 완료</option>                         
	                </select>           
	            </div>
	        </div>
	    </div>	    
	</form>
      
      <!-- 추가 가격 태그 -->
      <div class="content_body_search_price">
	  <div>
	    <div>
	      <label>발주수량</label>
	      <input type="number" id="ordersQuantity" name="ordersQuantity" class="disabled-field" readonly />
	    </div>
	    <div>
	      <label>단가</label>
	      <input type="number" id="productPrice" name="productPrice" class="disabled-field" readonly />
	    </div>
	    <div>
	      <label>납기일</label>
	      <input type="date" id="deliveryDate" name="deliveryDate" class="disabled-field" readonly style="text-align: left;" />
	    </div>
	  </div>
	</div>
      
      <!-- 테이블 부분 -->
      <div class="content_body_list">
        <table>
          <thead>
            <tr>
              <th>발주번호</th>
              <th>발주일자</th>
              <th>담당자</th>
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
              <th>상태</th>
              <th>수정</th>
              <th>확정</th>
            </tr>
          </thead>
          <tbody id="ordersTable" class="sty">
            <c:forEach var="orders" items="${ordersList}">
              <tr>
                <td>${orders.ordersId}</td>
                <td>${fn:substring(orders.ordersDate, 0, 10)}</td>
                <td>${orders.name}</td>
                <td>${orders.productId}</td>
                <td>${orders.productName}</td>
                <td>${orders.productCategoryDetails.brand}</td>
                <td>${orders.productCategoryDetails.type}</td>
                <td>${orders.productCategoryDetails.color}</td>
                <td>${orders.productCategoryDetails.size}</td>
                <td>${orders.productCategoryDetails.gender}</td>
                <td>${orders.supplierName}</td>
                <td>${orders.ordersQuantity}</td>
                <td>${orders.productPrice}</td>
                <td>${orders.ordersQuantity * orders.productPrice}</td>
                <td>${fn:substring(orders.deliveryDate, 0, 10)}</td>
                <td>
                  <c:choose>
                    <c:when test="${orders.ordersStatus == 1}">발주 대기</c:when>
                    <c:when test="${orders.ordersStatus == 2}">발주 완료</c:when>
                  </c:choose>
                </td>
                <td>
				  <c:if test="${orders.ordersStatus == 1}">
				    <button class="editButton" data-orders-id="${orders.ordersId}">수정</button>
				  </c:if>
				</td>
                <td>
				  <c:if test="${orders.ordersStatus == 1}">
				    <form action="<c:url value='/purchase/orders/confirm'/>" method="post">
				      <input type="hidden" name="_csrf" value="${_csrf.token}"/>
				      <input type="hidden" name="ordersId" value="${orders.ordersId}"/>
				      <input type="hidden" name="pageNum" value="${pager.pageNum}"/> <!-- 현재 페이지 번호 -->
				      <input type="hidden" name="pageSize" value="${pager.pageSize}"/> <!-- 현재 페이지 크기 -->
				      <button type="submit">확정</button>
				    </form>
				  </c:if>
				</td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
        <div style="text-align: center;">
		    <!-- 이전 페이지 링크 -->
		    <c:choose>
		        <c:when test="${pager != null && pager.startPage > 1}">
		            <a href="<c:url value='/purchase/orders/list'/>?pageNum=${pager.prevPage}&pageSize=${pager.pageSize}&column=${searchMap.column}&keyword=${searchMap.keyword}">[이전]</a>
		        </c:when>
		        <c:otherwise>
		            [이전]
		        </c:otherwise>
		    </c:choose>
		    
		    <!-- 중간 페이지 번호 링크 -->
		    <c:if test="${pager != null}">
		        <c:forEach var="i" begin="${pager.startPage}" end="${pager.endPage}">
		            <c:choose>
		                <c:when test="${pager.pageNum != i}">
		                    <a href="<c:url value='/purchase/orders/list'/>?pageNum=${i}&pageSize=${pager.pageSize}&column=${searchMap.column}&keyword=${searchMap.keyword}">[${i}]</a>
		                </c:when>
		                <c:otherwise>
		                   [${i}]
		                </c:otherwise>
		            </c:choose>				
		        </c:forEach>
		    </c:if>
		
		    <!-- 다음 페이지 링크 -->
		    <c:choose>
		        <c:when test="${pager != null && pager.endPage < pager.totalPage}">
		            <a href="<c:url value='/purchase/orders/list'/>?pageNum=${pager.nextPage}&pageSize=${pager.pageSize}&column=${searchMap.column}&keyword=${searchMap.keyword}">[다음]</a>
		        </c:when>
		        <c:otherwise>
		            [다음]
		        </c:otherwise>
		    </c:choose>
		</div>
      </div>
    </div>
  </div>

  <script>
  
function searchOrders() {
   // 폼 데이터 가져오기
   const form = document.getElementById('ordersForm');
   
   // 서버로 GET 요청을 보내도록 폼 제출
   form.submit();
}

document.addEventListener('DOMContentLoaded', function() {
    // 모든 수정 버튼에 클릭 이벤트 추가
    document.querySelectorAll('.editButton').forEach(button => {
        button.addEventListener('click', function() {
            const ordersId = button.getAttribute('data-orders-id');
            editOrders(ordersId);
        });
    });
});

function editOrders(ordersId) {
    // 각 필드에 값을 채우기
    const row = document.querySelector(`button[data-orders-id='${ordersId}']`).closest('tr');

    if (!row) {
        alert("해당 행을 찾을 수 없습니다.");
        return;
    }

    // 조회 가능한 필드 설정
    document.getElementById('ordersId').value = row.children[0].innerText.trim();
    document.getElementById('ordersDate').value = row.children[1].innerText.trim();
    document.getElementById('userid').value = row.children[2].innerText.trim();
    document.getElementById('productId').value = row.children[3].innerText.trim();
    document.getElementById('productName').value = row.children[4].innerText.trim();
    document.getElementById('brand').value = row.children[5].innerText.trim();
    document.getElementById('supplier').value = row.children[10].getAttribute('data-supplier-id');

    // 수정 가능한 필드 설정
    document.getElementById('ordersQuantity').value = row.children[11].innerText.trim();
    document.getElementById('productPrice').value = row.children[12].innerText.trim();
    document.getElementById('deliveryDate').value = row.children[14].innerText.trim();

    // 발주수량, 단가, 납기일 필드 수정 가능하게 설정
    document.getElementById('ordersQuantity').readOnly = false;
    document.getElementById('productPrice').readOnly = false;
    document.getElementById('deliveryDate').readOnly = false;

    // 완료 버튼으로 변경 후 클릭 이벤트 설정
    button.innerText = "완료";
    button.removeEventListener('click', editOrders);
    button.addEventListener('click', function() {
        saveOrderChanges(ordersId);
    });
}

function saveOrderChanges(ordersId) {
    // 수정된 값 가져오기
    const ordersQuantity = document.getElementById('ordersQuantity').value;
    const productPrice = document.getElementById('productPrice').value;
    const deliveryDate = document.getElementById('deliveryDate').value;

    // 서버에 수정 요청 보내기
    $.ajax({
        url: "<c:url value='/purchase/orders/modify'/>",
        type: "POST",
        data: {
            ordersId: ordersId,
            ordersQuantity: ordersQuantity,
            productPrice: productPrice,
            deliveryDate: deliveryDate,
            _csrf: $('meta[name="_csrf"]').attr('content')
        },
        success: function(response) {
            // 수정이 완료되면 페이지를 다시 로드하여 업데이트된 발주 목록을 보여줌
            alert('수정이 완료되었습니다.');
            window.location.reload();
        },
        error: function(xhr, status, error) {
            alert('수정 중 오류가 발생했습니다.');
        }
    });
}


function resetForm() {
    // 폼 데이터 초기화
    document.getElementById('ordersForm').reset();
    
    // 전체 목록 조회를 위해 폼을 제출
    const form = document.getElementById('ordersForm');
    form.action = "<c:url value='/purchase/orders/list'/>";
    form.method = "get";
    form.submit();
}
</script>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>

</html>
