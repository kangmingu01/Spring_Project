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
  <title>발주 조회</title>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <meta name="_csrf" content="${_csrf.token}"/>
  <meta name="_csrf_header" content="${_csrf.headerName}"/>
</head>

<body>
  <div class="content">
    <!-- 헤더 부분 -->
    <div class="content_header">
      <div class="content_header_title">발주 조회</div>
      <div class="content_header_btn">
        <!-- 조회 버튼 -->
        <div class="content_header_search_btn" onclick="searchOrders()">
          <div><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
            <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
          </svg></div>
          <span>조회</span>
        </div>
        <!-- 초기화 버튼 -->
        <div class="content_header_reset_btn" onclick="resetForm()">
          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-clockwise" viewBox="0 0 16 16">
            <path fill-rule="evenodd" d="M8 3a5 5 0 1 0 4.546 2.914.5.5 0 0 1 .908-.417A6 6 0 1 1 8 2z"/>
            <path d="M8 4.466V.534a.25.25 0 0 1 .41-.192l2.36 1.966c.12.1.12.284 0 .384L8.41 4.658A.25.25 0 0 1 8 4.466"/>
          </svg>
          <span>초기화</span>
        </div>
      </div>
    </div>

    <!-- 바디 부분 -->
    <div class="content_body">
      <!-- 발주 조회 폼 -->
      <form id="ordersForm" action="<c:url value='/purchase/orders/list' />" method="get">
        <div class="content_body_search">
          <div>
            <!-- 발주 검색 필드 -->
            <div>
              <label>발주번호</label>
              <input type="text" name="ordersId" id="ordersId"/>
            </div>
            <div>
              <label>발주일자</label>
              <input type="date" name="ordersDate" id="ordersDate"/>
            </div>
            <div>
              <label>담당자</label>
              <input type="text" name="name" id="userid"/>
            </div>
            <div>
              <label>제품번호</label>
              <input type="text" name="productId" id="productId"/>
            </div>
          </div>
          <div>
            <div>
              <label>제품명</label>
              <input type="text" name="productName" id="productName"/>
            </div>
            <div>
              <label>브랜드</label>
              <input type="text" name="brand" id="brand"/>
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
        <!-- 페이지 번호와 페이지 크기를 히든 필드로 추가 -->
        <input type="hidden" id="pageNum" name="pageNum" value="${pager.pageNum}">
        <input type="hidden" id="pageSize" name="pageSize" value="${pager.pageSize}">
        <!-- 기존 검색 폼의 검색 필드들을 히든 필드로 추가 -->
		<input type="hidden" name="ordersId" value="${param.ordersId}"/>
		<input type="hidden" name="ordersDate" value="${param.ordersDate}"/>
		<input type="hidden" name="name" value="${param.name}"/>
		<input type="hidden" name="productId" value="${param.productId}"/>
		<input type="hidden" name="productName" value="${param.productName}"/>
		<input type="hidden" name="brand" value="${param.brand}"/>
		<input type="hidden" name="supplierId" value="${param.supplierId}"/>
		<input type="hidden" name="ordersStatus" value="${param.ordersStatus}"/>
      </form>

      <!-- 발주 추가 정보 -->
      <div class="content_body_search_price">
        <div>
          <div>
            <label>발주수량</label>
            <input type="number" id="ordersQuantity" name="ordersQuantity" style="background-color: #f0f0f0" readonly min="0"/>
          </div>
          
          <div>
            <label>납기일</label>
            <input type="date" id="deliveryDate" name="deliveryDate" style="text-align: left; background-color: #f0f0f0" readonly/>
          </div>
        </div>
      </div>

      <!-- 발주 목록 테이블 -->
      <div class="content_body_list">
        <table>
          <thead style="font-weight: bold;">
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
              <th style="color: red;">발주수량</th>
              <th style="color: red;">단가</th>
              <th style="color: red;">총액</th>
              <th style="color: red;">납기일</th>
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
                <!-- 수정 버튼 (발주 대기 상태일 때만 활성화) -->
                <td>
                  <c:if test="${orders.ordersStatus == 1}">
                    <button class="editButton btn btn-secondary btn-sm" data-orders-id="${orders.ordersId}" 
				  style="background-color: #7987A1">수정</button>
                  </c:if>
                </td>
                <!-- 발주 확정 버튼 (발주 대기 상태일 때만 활성화) -->
                <td>
                  <c:if test="${orders.ordersStatus == 1}">
                    <form action="<c:url value='/purchase/orders/confirm'/>" method="post">
                      <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                      <input type="hidden" name="ordersId" value="${orders.ordersId}"/>
                      <input type="hidden" name="pageNum" value="${pager.pageNum}"/>
                      <input type="hidden" name="pageSize" value="${pager.pageSize}"/>
                      <button type="submit" class="btn btn-success btn-sm">확정</button>
                    </form>
                  </c:if>
                </td>
              </tr>
            </c:forEach>
          </tbody>
        </table>

        <!-- 페이징 부분 -->
        <div style="text-align: center;" class="pagination-container text-center mt-4">
          <!-- 이전 페이지 링크 -->
          <c:choose>
		    <c:when test="${pager != null && pager.startPage > 1}">
		        <a class="btn btn-primary btn-sm" style="background-color: #6571FF" href="<c:url value='/purchase/orders/list'/>?pageNum=${pager.prevPage}&pageSize=${pager.pageSize}&ordersId=${param.ordersId}&ordersDate=${param.ordersDate}&name=${param.name}&productId=${param.productId}&productName=${param.productName}&brand=${param.brand}&supplierId=${param.supplierId}&ordersStatus=${param.ordersStatus}">&laquo; 이전</a>
		    </c:when>
		    <c:otherwise>
		        <span class="btn btn-secondary disabled btn-sm" style="background-color: #6571FF">&laquo; 이전</span>
		    </c:otherwise>
		</c:choose>
		
		<!-- 페이지 번호 링크 -->
		<c:if test="${pager != null}">
		    <c:forEach var="i" begin="${pager.startPage}" end="${pager.endPage}">
		        <c:choose>
		            <c:when test="${pager.pageNum != i}">
		                <a href="<c:url value='/purchase/orders/list'/>?pageNum=${i}&pageSize=${pager.pageSize}&ordersId=${param.ordersId}&ordersDate=${param.ordersDate}&name=${param.name}&productId=${param.productId}&productName=${param.productName}&brand=${param.brand}&supplierId=${param.supplierId}&ordersStatus=${param.ordersStatus}"><span class="btn btn-outline-primary mx-1 btn-sm">${i}</span></a>
		            </c:when>
		            <c:otherwise>
		                <span class="btn btn-primary mx-1 active btn-sm" style="background-color: #6571FF">${i}</span>
		            </c:otherwise>
		        </c:choose>
		    </c:forEach>
		</c:if>
		
		<!-- 다음 페이지 링크 -->
		<c:choose>
		    <c:when test="${pager != null && pager.endPage < pager.totalPage}">
		        <a class="btn btn-primary btn-sm" style="background-color: #6571FF" href="<c:url value='/purchase/orders/list'/>?pageNum=${pager.nextPage}&pageSize=${pager.pageSize}&ordersId=${param.ordersId}&ordersDate=${param.ordersDate}&name=${param.name}&productId=${param.productId}&productName=${param.productName}&brand=${param.brand}&supplierId=${param.supplierId}&ordersStatus=${param.ordersStatus}">다음 &raquo;</a>
		    </c:when>
		    <c:otherwise>
		        <span class="btn btn-secondary disabled btn-sm" style="background-color: #6571FF">다음 &raquo;</span>
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
        // 조회할 때 페이지 번호를 1로 설정
        $('#pageNum').val(1);
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

        // 발주 정보를 해당 행에서 가져오기
        $('#ordersId').val($.trim(row.children().eq(0).text()));
        $('#ordersDate').val($.trim(row.children().eq(1).text()));
        $('#userid').val($.trim(row.children().eq(2).text()));
        $('#productId').val($.trim(row.children().eq(3).text()));
        $('#productName').val($.trim(row.children().eq(4).text()));
        $('#brand').val($.trim(row.children().eq(5).text()));
        
        // 단가는 읽기 전용으로 표시
        const productPrice = $.trim(row.children().eq(12).text()); // 단가 열
        $('#productPrice').val(productPrice).prop('readonly', true); // 단가를 읽기 전용으로 설정

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
        $('#deliveryDate').val($.trim(row.children().eq(14).text()));
        setAllFieldsReadOnly(true);
        $('#ordersQuantity, #deliveryDate').prop('readonly', false).prop('disabled', false).css('background-color', '#ffffff');

        // 버튼을 완료 상태로 변경
        button.text('완료');
        button.css('background-color', '#6571FF');
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
            pageSize: $('#pageSize').val(),
            ordersQuantity: $('#ordersQuantity').val(),
            deliveryDate: $('#deliveryDate').val()
        };

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
                // 수정 후 현재 페이지 새로고침하여 변경 사항 반영
                //alert('수정이 완료되었습니다.');
                location.reload();  // 페이지 새로 고침
            },
            error: function(xhr, status, error) {
                alert('수정 중 오류가 발생했습니다.');
            }
        });
    }

    function resetForm() {
        // 폼 필드 모두 초기화
        $('#ordersForm')[0].reset(); // 모든 입력 필드 초기화
        
        // 페이지 번호를 1로 설정
        $('#pageNum').val(1);
        
        // 첫 페이지로 리다이렉트
        window.location.href = '<c:url value="/purchase/orders/list"/>'; // 처음 페이지로 이동
    }

    
    document.getElementById("ordersQuantity").addEventListener("input", function() {
        const ordersQuantity = document.getElementById("ordersQuantity");

        // 음수 입력 방지
        if (ordersQuantity.value < 0) {
            ordersQuantity.value = 0; // 음수 입력 시 값을 0으로 고정
        }

        // 숫자가 아닌 입력 방지
        const sanitizedValue = ordersQuantity.value.replace(/[^0-9]/g, ''); // 숫자가 아닌 모든 것을 제거
        ordersQuantity.value = sanitizedValue;

        // 발주수량이 빈 값이거나 0 이하일 때 0으로 고정
        if (ordersQuantity.value === '' || parseInt(ordersQuantity.value, 10) < 0) {
            ordersQuantity.value = 0;
        }

        // 필드 검증
        checkFields(); // 필드가 모두 입력되었는지 확인하는 기존 함수 호출
    });


  </script>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
