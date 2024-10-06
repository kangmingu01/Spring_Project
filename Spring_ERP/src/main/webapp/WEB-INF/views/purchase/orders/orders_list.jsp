<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/reset.css'/>">
  <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/purchase.css'/>">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
  <title>발주 목록</title>
  <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>  
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
       <form id="ordersForm">
      <div class="content_body_search">
        <div>
          <div>
            <label>발주번호</label>
            <input type="text" id="ordersId" />
          </div>
          <div> 
            <label>발주일자</label>
            <input type="date" id="ordersDate" />
          </div>
          <div>
            <label>담당자</label>
            <input type="text" id="userid" />
          </div>
          <div>
            <label style="color: red;">제품번호</label>
            <input type="text" name="productId" class="result" id="productId" />           
          </div>
        </div>
        <div>  
          <div>
            <label>제품명</label>
            <input type="text" id="productName" />
          </div>
          <div>
            <label>브랜드</label>
            <input type="text" id="brand" />
          </div>       
          <div>
            <label>공급업체</label>
            <select id="supplier">
              <option value="">공급 업체 선택</option>
              <c:forEach var="supplier" items="${supplierList}">
                <option value="${supplier.supplierId}">${supplier.supplierName}</option>
              </c:forEach>
            </select>
          </div>
          <div>
            <label>상태</label>
            <select id="ordersStatus">
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
            <input type="number" id="ordersQuantity" />
          </div>
          <div>
            <label>단가</label>
            <input type="number" id="unitPrice"  />
          </div>
          <div>
            <label>납기일</label>
            <input type="date" id="dueDate" style="text-align: left;"/>
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
                    <button onclick="editOrders('${orders.ordersId}')">수정</button>
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
    // 수정 버튼 클릭 시 해당 데이터를 폼에 채워 넣기
    function editOrders(ordersId) {
      const orders = window.orders.find(o => o.ordersId === ordersId);

      // 수정 불가 필드 설정
      document.getElementById("ordersId").value = orders.ordersId;
      document.getElementById("ordersId").readOnly = true;
      document.getElementById("productId").value = orders.productId;
      document.getElementById("productId").readOnly = true;
      document.getElementById("ordersDate").value = orders.ordersDate;
      document.getElementById("ordersDate").readOnly = true;
      document.getElementById("userid").value = orders.userid;
      document.getElementById("userid").readOnly = true;
      document.getElementById("productName").value = orders.productName;
      document.getElementById("productName").readOnly = true;
      document.getElementById("brand").value = orders.productCategoryDetails.brand;
      document.getElementById("brand").readOnly = true;
      document.getElementById("supplier").value = orders.supplierName;
      document.getElementById("supplier").disabled = true;
      document.getElementById("ordersStatus").value = orders.ordersStatus;
      document.getElementById("ordersStatus").disabled = true;

      // 수정 가능 항목
      document.getElementById("ordersQuantity").value = orders.ordersQuantity;
      document.getElementById("unitPrice").value = orders.productPrice;
      document.getElementById("dueDate").value = orders.deliveryDate;

      // 수정 버튼을 완료 버튼으로 변경
      document.querySelector(`#editButton_${ordersId}`).innerText = "완료";
      document.querySelector(`#editButton_${ordersId}`).setAttribute("onclick", `saveOrders('${ordersId}')`);
    }

    // 수정 완료 후 저장하는 함수
    function saveOrders(ordersId) {
      // 업데이트된 값 저장
      const updatedOrders = window.orders.find(o => o.ordersId === ordersId);
      updatedOrders.ordersQuantity = parseInt(document.getElementById("ordersQuantity").value);
      updatedOrders.productPrice = parseInt(document.getElementById("unitPrice").value);
      updatedOrders.deliveryDate = document.getElementById("dueDate").value;

      // 수정된 데이터 테이블에 반영 (서버에서 새로고침 없이 적용할 수 있도록 하려면 Ajax 사용 고려)
      loadOrdersTable(window.orders);
    }

    // 발주 검색 함수
    function searchOrders() {
      const searchNumber = document.getElementById("ordersId").value.toLowerCase();
      const searchProductName = document.getElementById("productName").value.toLowerCase();
      const searchUserid = document.getElementById("userid").value.toLowerCase();
      const searchSupplier = document.getElementById("supplier").value.toLowerCase();

      const filteredOrders = window.orders.filter(orders => {
        return (
          (searchNumber === '' || orders.ordersId.toLowerCase().includes(searchNumber)) &&
          (searchProductName === '' || orders.productName.toLowerCase().includes(searchProductName)) &&
          (searchUserid === '' || orders.userid.toLowerCase().includes(searchUserid)) &&
          (searchSupplier === '' || orders.supplierName.toLowerCase().includes(searchSupplier))
        );
      });

      loadOrdersTable(filteredOrders);
    }

    function resetForm() {
        document.getElementById('ordersForm').reset();
    }
  </script>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>

</html>
