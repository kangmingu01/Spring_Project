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
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <title>발주 목록</title>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <meta name="_csrf" content="${_csrf.token}"/>
  <meta name="_csrf_header" content="${_csrf.headerName}"/>
</head>

<body>
  <div class="content">
    <!-- 헤더 부분 -->
    <div class="content_header">
      <div class="content_header_title">점주주문 </div>
      <div class="content_header_btn">

        <!-- 초기화 버튼 -->
        <div class="content_header_reset_btn" onclick="resetForm()">
          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-clockwise" viewBox="0 0 16 16">
            <path fill-rule="evenodd" d="M8 3a5 5 0 1 0 4.546 2.914.5.5 0 0 1 .908-.417A6 6 0 1 1 8 2z"/>
            <path d="M8 4.466V.534a.25.25 0 0 1 .41-.192l2.36 1.966c.12.1.12.284 0 .384L8.41 4.658A.25.25 0 0 1 8 4.466"/>
          </svg>
          <span>초기화</span>
        </div>
           <!-- 검색  버튼 -->
        <div class="content_header_search_btn" onclick="searchOrders()">
          <div><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
            <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
          </svg></div>
          <span>검색</span>
        </div>
      </div>
    </div>

    <!-- 바디 부분 -->
    <div class="content_body">
 
	<form id="ordersForm" action="<c:url value='/request/requestproduct' />" method="get">
        <div class="content_body_search">
        
          <div>
            <div>
              <label>제품명</label>
              <input type="text" name="productName" id="productName" onkeypress="return handleEnter(event)"/>
            </div>
     <!--        <div>
              <label>브랜드</label>
              <input type="text" name="brand" id="brand" onkeypress="return handleEnter(event)"/>
            </div> -->
           
          </div>
        </div>

        <!-- 페이지 번호와 페이지 크기를 히든 필드로 추가 -->
        <input type="hidden" id="pageNum" name="pageNum" value="${pager.pageNum}">
        <input type="hidden" id="pageSize" name="pageSize" value="${pager.pageSize}">
      </form>
  
 
 
 
  <div class="content_body_list">
 <form action="<c:url value='/request/insertSalesRequest' />" method="post">
        <table border="1">
            <thead>
                <tr>
      
                    <th>Product ID</th>
                    <th>Product Category</th>
                    <th>Product Name</th>
					
                    <th>Delivery Price</th>
                       <th>Select</th>
                </tr>
            </thead>
            <tbody  id="ordersTable" class="sty">
                <c:forEach var="product" items="${productList}">
                    <tr>
                       
                        <td>${product.productId}</td>
                        <td>${product.productCategory}</td>
                        <td>${product.productName}</td>
            
                        <td>${product.deliveryPrice}</td>
		                 <td>
			                  <input type="hidden" name="ordersId" value="${orders.ordersId}"/>
			                  <input type="hidden" name="pageNum" value="${pager.pageNum}"/>
			                  <input type="hidden" name="pageSize" value="${pager.pageSize}"/>
			            </td>
                		 <td>  
                         <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                         <input type="checkbox" name="productIds" value="${product.productId}">
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        
        <input type="submit" value="Submit Selected Products">
    </form>
     

        <!-- 페이징 부분 -->
        <div style="text-align: center;">
          <!-- 이전 페이지 링크 -->
          <c:choose>
            <c:when test="${pager != null && pager.startPage > 1}">
              <a href="<c:url value='/request/requestproduct' />?pageNum=${pager.prevPage}&pageSize=${pager.pageSize}">[이전]</a>
            </c:when>
            <c:otherwise>
              [이전]
            </c:otherwise>
          </c:choose>
          
          <!-- 페이지 번호 링크 -->
          <c:if test="${pager != null}">
            <c:forEach var="i" begin="${pager.startPage}" end="${pager.endPage}">
              <c:choose>
                <c:when test="${pager.pageNum != i}">
                  <a href="<c:url value='/request/requestproduct' />?pageNum=${i}&pageSize=${pager.pageSize}">[${i}]</a>
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
              <a href="<c:url value='/request/requestproduct' />?pageNum=${pager.nextPage}&pageSize=${pager.pageSize}">[다음]</a>
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
    $(document).ready(function() {
      // 모든 수정 버튼에 클릭 이벤트 추가
      $('.editButton').on('click', function() {
        const ordersId = $(this).data('orders-id');
        editOrders($(this), ordersId);
      });

      // 조회 버튼 클릭 이벤트 추가
      $('.content_header_search_btn').on('click', function() {
        searchOrders();
      });

      // 초기화 버튼 클릭 이벤트 추가
      $('.content_header_reset_btn').on('click', function() {
        resetForm();
      });
    });

    // 발주 조회 폼 제출
    function searchOrders() {
      $('#ordersForm').submit();
    }

    // 모든 필드를 읽기 전용으로 설정하는 함수
    function setAllFieldsReadOnly(readOnly) {
      const fields = [
        '#ordersId', '#ordersDate', '#userid', 
        '#productId', '#productName', '#brand', 
        '#supplier', '#ordersStatus', '#ordersQuantity', 
        '#productPrice', '#deliveryDate'
      ];

      fields.forEach(fieldId => {
        const field = $(fieldId);

        if (field.length) {
          if (field.prop('tagName') === 'SELECT') {
            field.prop('disabled', readOnly);
          } else {
            field.prop('readonly', readOnly);
          }

          if (readOnly) {
            field.css('background-color', '#f0f0f0');
          } else {
            field.css('background-color', '');
          }
        }
      });
    }

    // 발주 수정 버튼 클릭 시 실행되는 함수
    function editOrders(button, ordersId) {
      // 수정 버튼 비활성화 처리
      $('.editButton').prop('disabled', true);
      button.prop('disabled', false);

      // 각 필드에 값을 채우기
      const row = button.closest('tr');

      if (!row.length) {
        alert('해당 행을 찾을 수 없습니다.');
        return;
      }

      $('#ordersId').val($.trim(row.children().eq(0).text()));
      $('#ordersDate').val($.trim(row.children().eq(1).text()));
      $('#userid').val($.trim(row.children().eq(2).text()));
      $('#productId').val($.trim(row.children().eq(3).text()));
      $('#productName').val($.trim(row.children().eq(4).text()));
      $('#brand').val($.trim(row.children().eq(5).text()));

      // 공급업체와 발주 상태 설정
      const supplierName = $.trim(row.children().eq(10).text());
      $('#supplier option').each(function() {
        if ($(this).text() === supplierName) {
          $(this).prop('selected', true);
        }
      });

      const orderStatusText = $.trim(row.children().eq(15).text());
      $('#ordersStatus option').each(function() {
        if ($(this).text() === orderStatusText) {
          $(this).prop('selected', true);
        }
      });

      // 수정 가능한 필드만 활성화
      $('#ordersQuantity').val($.trim(row.children().eq(11).text()));
      $('#productPrice').val($.trim(row.children().eq(12).text()));
      $('#deliveryDate').val($.trim(row.children().eq(14).text()));
      setAllFieldsReadOnly(true);
      $('#ordersQuantity, #productPrice, #deliveryDate').prop('readonly', false).prop('disabled', false).css('background-color', '#ffffff');

      // 버튼을 완료 상태로 변경
      button.text('완료');
      button.off('click').on('click', function() {
        saveOrderChanges(ordersId);
      });
    }

    // 발주 수정 내용을 서버에 저장
    function saveOrderChanges(ordersId) {
      const token = $("meta[name='_csrf']").attr("content");
      const header = $("meta[name='_csrf_header']").attr("content");

      // 수정된 값 가져오기
      const data = {
        ordersId: ordersId,
        pageNum: $('#pageNum').val(),
        pageSize: $('#pageSize').val()
      };

      const ordersQuantity = $('#ordersQuantity').val();
      if (ordersQuantity) {
        data.ordersQuantity = ordersQuantity;
      }

      const productPrice = $('#productPrice').val();
      if (productPrice) {
        data.productPrice = productPrice;
      }

      const deliveryDate = $('#deliveryDate').val();
      if (deliveryDate) {
        data.deliveryDate = deliveryDate;
      }

      // 서버에 수정 요청 보내기
      $.ajax({
        url: '<c:url value="/purchase/orders/modify"/>',
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(data),
        beforeSend: function(xhr) {
          xhr.setRequestHeader(header, token); 
        },
        success: function(response) {
          window.location.href = '<c:url value="/purchase/orders/list"/>' + '?pageNum=' + data.pageNum + '&pageSize=' + data.pageSize;
        },
        error: function(xhr, status, error) {
          alert('수정 중 오류가 발생했습니다.');
        }
      });
    }

 // 엔터키 입력 시 검색 기능 호출
    function handleEnter(event) {
      if (event.keyCode === 13) {
        searchOrders();
        return false; // 엔터키 입력 후 폼 제출 방지
      }
      return true;
    }

    // 검색 버튼 클릭 시 발주 조회 폼 제출
    function searchOrders() {
      $('#ordersForm').submit();
    }

    // 폼을 초기화하고 전체 목록 조회
    function resetForm() {
      $('#ordersForm')[0].reset();
      $('#ordersForm').attr('action', '<c:url value="/request/requestproduct"/>').attr('method', 'get').submit();
      $('.editButton').prop('disabled', false);
    }

  </script>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>





