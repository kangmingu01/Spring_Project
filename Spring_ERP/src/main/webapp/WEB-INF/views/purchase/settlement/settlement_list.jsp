<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <title>구매정산</title>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <meta name="_csrf" content="${_csrf.token}"/>
  <meta name="_csrf_header" content="${_csrf.headerName}"/>
</head>
<body>
  <div class="content">
    <!-- 헤더부분 -->
    <div class="content_header">
      <div class="content_header_title">구매정산</div>
      <div class="content_header_btn">
        <div class="content_header_search_btn" onclick="searchOrder()">
          <div><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
            <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
          </svg></div>
          <span>조회</span>
        </div>        
        <div class="content_header_reset_btn" onclick="resetForm()">
          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-clockwise" viewBox="0 0 16 16">
            <path fill-rule="evenodd"
              d="M8 3a5 5 0 1 0 4.546 2.914.5.5 0 0 1 .908-.417A6 6 0 1 1 8 2z" />
            <path
              d="M8 4.466V.534a.25.25 0 0 1 .41-.192l2.36 1.966c.12.1.12.284 0 .384L8.41 4.658A.25.25 0 0 1 8 4.466" />
          </svg>
          <span>초기화</span>
        </div>
      </div>
    </div>

    <div class="content_body">
    <!-- 검색 필드 -->
    <form id="settlementForm" action="<c:url value='/purchase/settlement/list' />" method="get">
      <div class="content_body_search">
        <div>
          <div>
            <label>정산번호</label>
            <input type="text" id="settlementId" name="settlementId" />
          </div>
          <div> 
            <label>정산일자</label>
            <input type="date" id="settlementDate" name="settlementDate"/>
          </div>
          <div>
            <label>입고번호</label>
            <input type="text" id="receivingId" name="receivingId"/>
          </div>
          <div>
            <label>담당자</label>
            <input type="text" id="userid" name="name"/>
          </div>
        </div>
        <div> 
          <div>
            <label>제품번호</label>
            <input type="text" name="productId" id="productId" />           
          </div>        
          <div>
            <label>제품명</label>
            <input type="text" id="productName" name="productName" />
          </div>
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
            <label>상태</label>
            <select id="settlementStatus" name="settlementStatus">
              <option value="">상태 선택</option>
              <option value="4">정산 대기</option> 
              <option value="6">정산 완료</option>                         
            </select>           
          </div>
        </div>    
      </div>
      <!-- 페이지 번호와 페이지 크기를 히든 필드로 추가 -->
      <input type="hidden" id="pageNum" name="pageNum" value="${pager.pageNum}">
      <input type="hidden" id="pageSize" name="pageSize" value="${pager.pageSize}">
    </form>
   
  <!-- 정산 목록 테이블 -->
  <div class="content_body_list">
    <form id="completeForm" action="<c:url value='/purchase/settlement/complete'/>" method="post">
      <input type="hidden" name="_csrf" value="${_csrf.token}"/>
      <table>
        <thead>
          <tr>
            <th>정산번호</th>
            <th>정산일자</th>
            <th>입고번호</th>
            <th>담당자</th>
            <th>제품번호</th>
            <th>제품명</th>
            <th>공급업체</th>
            <th>통과수량</th>
            <th>단가</th>
            <th>총액</th>
            <th>상태</th>              
            <th>완료</th>
          </tr>
        </thead>
        <tbody id="settlementTable" class="sty">
           <c:forEach var="receiving" items="${settlementList}">
            <tr>
              <td>${receiving.settlementId}</td>
              <td>${fn:substring(receiving.settlementDate, 0, 10)}</td>
              <td>${receiving.receivingId}</td>
              <td>${receiving.name}</td>
              <td>${receiving.productId}</td>
              <td>${receiving.productName}</td>
              <td>${receiving.supplierName}</td>
              <td>${receiving.quantity}</td>
              <td>${receiving.productPrice}</td>
              <td>${receiving.quantity * receiving.productPrice}</td>
              <td>
                <c:choose>
                  <c:when test="${receiving.settlementStatus == 4}">정산 대기</c:when>
                  <c:when test="${receiving.settlementStatus == 6}">정산 완료</c:when>
                </c:choose>
              </td>
              <!-- 정산 확정 버튼 (정산 대기 상태일 때만 활성화) -->
              <td>
                <c:if test="${receiving.settlementStatus == 4}">
                  <button type="submit" name="settlementId" value="${receiving.settlementId}">완료</button>
                </c:if>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </form>
  </div>

  <script>
    $(document).ready(function() {
      // 조회 버튼 클릭 이벤트 추가
      $('.content_header_search_btn').on('click', function() {
        searchOrder();
      });

      // 초기화 버튼 클릭 이벤트 추가
      $('.content_header_reset_btn').on('click', function() {
        resetFields(); // 폼 초기화
        searchOrder(); // 초기화 후 전체 목록 조회
      });
    });

    // 검색된 정산 목록을 보여주기
    function searchOrder() {
      $('#settlementForm').submit(); // 폼 전송 (검색 또는 전체 조회)
    }

 	// 폼을 초기화하고 전체 목록 조회
    function resetFields() {
    $('#settlementForm')[0].reset(); // 전체 폼 초기화
    $('#settlementStatus').val('');  // 상태 필드 초기화
    searchOrder(); // 전체 목록 조회
	}
 	
  </script>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
