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
  <title>입고 목록</title>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <meta name="_csrf" content="${_csrf.token}"/>
  <meta name="_csrf_header" content="${_csrf.headerName}"/>
</head>

<body>
  <div class="content">
    <!-- 헤더 부분 -->
    <div class="content_header">
      <div class="content_header_title">입고 조회</div>
      <div class="content_header_btn">
        <!-- 조회 버튼 -->
        <div class="content_header_search_btn" onclick="searchOrder()">
          <div>
           
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
              <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
            </svg>
          </div>
          <span>조회</span>
        </div>
        <!-- 초기화 버튼 -->
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

    <!-- 바디 부분 -->
    <div class="content_body">
      <!-- 입고 조회 폼 -->
      <form id="receivingForm" action="<c:url value='/purchase/receiving/list' />" method="get">
        <div class="content_body_search">
          <!-- 각종 검색 필드들 -->
          <div>
            <div>
              <label>입고번호</label>
              <input type="text" name="receivingId" id="receivingId"/>
            </div>
            <div> 
              <label>입고일자</label>
              <input type="date" name="receivingDate" id="receivingDate"/>
            </div>
            <div>
              <label>발주번호</label>
              <input type="text" name="ordersId" id="ordersId"/>
            </div>
            <div>
              <label>담당자</label>
              <input type="text" name="name" id="name"/>
            </div>
          </div>
          <div>
            <div>
              <label>제품번호</label>
              <input type="text" name="productId" id="productId"/>           
            </div>        
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
          </div>  
          <div>       
            <div>
              <label>납기일</label>
              <input type="date" name="deliveryDate" id="deliveryDate" style="text-align: left;" />
            </div>        
            <div>
              <label>창고</label>
              <select name="wareHouseId" id="wareHouse" >
                <option value="">창고 선택</option>
                <c:forEach var="warehouse" items="${warehouseList}">
                  <option value="${warehouse.warehouseId}">${warehouse.warehouseName}</option>
                </c:forEach>
              </select>
            </div>
            <!-- 발주수량을 숨겨진 필드로 저장 -->
            <input type="hidden" id="pageNum" name="pageNum" value="${pager.pageNum}">
            <input type="hidden" id="pageSize" name="pageSize" value="${pager.pageSize}">
            <input type="hidden" id="ordersQuantity" name="ordersQuantity" value="${receiving.ordersQuantity}" />
            <div>
              <label>통과수량</label>
              <input type="number" name="quantity" id="quantity" style="background-color: #f0f0f0" readonly min="0"/>
            </div>
            <div>
              <!-- 에러 메시지 -->
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
              <th>입고번호</th>
              <th>입고일자</th>
              <th>발주번호</th>
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
              <th style="color: red;">통과수량</th>
              <th style="color: red;">단가</th>
              <th style="color: red;">총액</th>
              <th style="color: red;">납기일</th>
              <th>창고</th>
              <th style="color: red;">상태</th>              
              <th>취소</th>
              <th>확정</th>
            </tr>
          </thead>
          <tbody id="orderTable" class="sty">
		    <c:forEach var="receiving" items="${receivingList}">
		        <tr>
		            <td>${receiving.receivingId}</td>
		            <td>${fn:substring(receiving.receivingDate, 0, 10)}</td>
		            <td>${receiving.ordersId}</td>
		            <td>${receiving.name}</td>
		            <td>${receiving.productId}</td>
		            <td>${receiving.productName}</td>
		            <td>${receiving.productCategoryDetails.brand}</td>
		            <td>${receiving.productCategoryDetails.type}</td>
		            <td>${receiving.productCategoryDetails.color}</td>
		            <td>${receiving.productCategoryDetails.size}</td>
		            <td>${receiving.productCategoryDetails.gender}</td>
		            <td>${receiving.supplierName}</td>
		            <td>${receiving.ordersQuantity}</td>
		            <td>${receiving.quantity}</td>
		            <td>${receiving.productPrice}</td>
		            <td>${receiving.quantity * receiving.productPrice}</td>
		            <td>${fn:substring(receiving.deliveryDate, 0, 10)}</td>
		            <td>${receiving.warehouseName}</td>
		             <td>
		                <c:choose>
		                    <c:when test="${receiving.receivingStatus == 4}">
		                        입고 완료
		                    </c:when>
		                    <c:when test="${receiving.receivingStatus == 5}">
		                        입고 확정
		                    </c:when>
		                    <c:otherwise>
		                        입고 대기
		                    </c:otherwise>
		                </c:choose>
		            </td>
		            <!-- 취소 버튼이 있는 열 -->
		            <td>
		                <c:if test="${receiving.receivingStatus == 4}">
		                    <button class="cancelButton" data-receiving-id="${receiving.receivingId}">취소</button>
		                </c:if>
		                <c:if test="${receiving.receivingStatus == 5}">
		                    <button class="cancelButton" disabled>취소</button>
		                </c:if>
		            </td>
		            <!-- 확정 버튼이 있는 열 -->
		            <td>
		                <c:if test="${receiving.receivingStatus == 4}">
		                    <button class="confirmButton" data-receiving-id="${receiving.receivingId}">확정</button>
		                </c:if>
		                <c:if test="${receiving.receivingStatus == 5}">
		                    <button class="confirmButton" disabled>확정</button>
		                </c:if>
		            </td>
		        </tr>
		    </c:forEach>
		</tbody>
        </table>

        <!-- 페이징 부분 -->
        <div style="text-align: center;">
          <!-- 이전 페이지 링크 -->
          <c:choose>
            <c:when test="${pager != null && pager.startPage > 1}">
              <a href="<c:url value='/purchase/receiving/list'/>?pageNum=${pager.prevPage}&pageSize=${pager.pageSize}">[이전]</a>
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
                  <a href="<c:url value='/purchase/receiving/list'/>?pageNum=${i}&pageSize=${pager.pageSize}">[${i}]</a>
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
              <a href="<c:url value='/purchase/receiving/list'/>?pageNum=${pager.nextPage}&pageSize=${pager.pageSize}">[다음]</a>
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
    // 취소 버튼 클릭 이벤트 추가
    $('.cancelButton').on('click', function() {
        const receivingId = $(this).data('receiving-id');
        loadReceivingDetails(receivingId);

        // 다른 취소 버튼 비활성화
        $('.cancelButton').prop('disabled', true);
        $(this).prop('disabled', false); // 현재 선택된 버튼만 활성화
    });

    // 조회 버튼 클릭 이벤트 추가
    $('.content_header_search_btn').on('click', function() {
        searchOrder();
    });

    // 초기화 버튼 클릭 이벤트 추가
    $('.content_header_reset_btn').on('click', function() {
        resetForm();
    });

 	// 통과수량이 발주수량을 초과하지 않도록 검증하는 로직 추가
    $('#quantity').on('input', function() {
        const ordersQuantity = parseInt($('#ordersQuantity').val());  // 숨겨진 발주수량 필드에서 가져옴
        let quantity = $(this).val().replace(/[^0-9]/g, ''); // 숫자가 아닌 값 제거
        $(this).val(quantity); // 숫자만 남긴 값을 다시 설정
        const errorSpan = $('#quantity-error');  // 에러 메시지 표시할 span

        // 빈 값이거나 NaN인 경우에는 에러 메시지를 숨김
        if (quantity === '' || isNaN(quantity)) {
            errorSpan.hide();  // 에러 메시지 숨김
            return;
        }

        // 음수 값 방지
        if (parseInt(quantity) < 0) {
            $(this).val(''); // 음수값 제거
            errorSpan.hide();  // 에러 메시지 숨김
            return;
        }

        // 통과수량이 발주수량을 초과하면 경고 메시지 표시 및 저장 방지
        if (parseInt(quantity) > ordersQuantity) {
            errorSpan.show();  // 에러 메시지 표시
            $(this).val('');  // 잘못된 입력값 제거
        } else {
            errorSpan.hide();  // 에러 메시지 숨김
        }
    });
});

// 입고 정보 로드 및 필드에 값 채우기
function loadReceivingDetails(receivingId) {
    const row = $('tr').has('button[data-receiving-id="' + receivingId + '"]');

    if (!row.length) {
        alert('해당 입고 항목을 찾을 수 없습니다.');
        return;
    }

    // 행의 데이터를 각 필드에 채우기
    $('#receivingId').val($.trim(row.children().eq(0).text()));
    $('#receivingDate').val($.trim(row.children().eq(1).text()));
    $('#ordersId').val($.trim(row.children().eq(2).text()));
    $('#name').val($.trim(row.children().eq(3).text()));
    $('#productId').val($.trim(row.children().eq(4).text()));
    $('#productName').val($.trim(row.children().eq(5).text()));
    $('#brand').val($.trim(row.children().eq(6).text()));
    $('#ordersQuantity').val($.trim(row.children().eq(12).text())); // 발주수량 필드에 값 채움
    $('#quantity').val($.trim(row.children().eq(13).text()));

    // 공급업체 설정
    const supplierName = $.trim(row.children().eq(11).text());
    $('#supplier option').each(function() {
        if ($(this).text() === supplierName) {
            $(this).prop('selected', true);
        }
    });

    // 창고 설정
    const warehouseName = $.trim(row.children().eq(17).text());
    $('#wareHouse option').each(function() {
        if ($(this).text() === warehouseName) {
            $(this).prop('selected', true);
        }
    });

    // 수량은 수정 가능하게 하고 나머지 필드는 비활성화
    setAllFieldsReadOnly(true);
    $('#quantity').prop('readonly', false).prop('disabled', false).css('background-color', '#ffffff');

    // 완료 버튼으로 변경
    $('.cancelButton').text('완료').off('click').on('click', function() {
        saveReceivingChanges(receivingId);
    });

    // 다른 행의 취소 버튼 비활성화
    $('button.cancelButton').each(function() {
        if ($(this).data('receiving-id') !== receivingId) {
            $(this).prop('disabled', true);
        }
    });
}

// 통과 수량 저장 로직
function saveReceivingChanges(receivingId) {
    const ordersQuantity = parseInt($('#ordersQuantity').val());
    const quantity = parseInt($('#quantity').val());

    // 수량 검증 - 통과수량이 발주수량을 초과하면 저장 중단
    if (quantity > ordersQuantity || isNaN(quantity)) {
        alert('통과 수량이 발주 수량을 초과할 수 없으며, 유효한 숫자를 입력해야 합니다.');
        return;  // 저장하지 않음
    }

    const token = $("meta[name='_csrf']").attr("content");
    const header = $("meta[name='_csrf_header']").attr("content");

    // 수정된 값 가져오기
    const data = {
        receivingId: receivingId,
        pageNum: $('#pageNum').val(),
        pageSize: $('#pageSize').val(),
        quantity: quantity,  // 통과 수량 수정 가능
        receivingStatus: 4   // 입고 완료 상태로 업데이트
    };

    // 서버에 수정 요청 보내기
    $.ajax({
        url: '<c:url value="/purchase/receiving/modify"/>',
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(data),
        beforeSend: function(xhr) {
            xhr.setRequestHeader(header, token);
        },
        success: function(response) {
            alert('수정이 완료되었습니다.');
            window.location.href = '<c:url value="/purchase/receiving/list"/>' + '?pageNum=' + data.pageNum + '&pageSize=' + data.pageSize;
        },
        error: function(xhr, status, error) {
            console.error('AJAX 요청 중 오류:', xhr, status, error);
            alert('수정 중 오류가 발생했습니다.');
        }
    });
}

// 폼 초기화 및 첫 페이지로 이동
function resetForm() {
    $('#receivingForm')[0].reset();
    window.location.href = '<c:url value="/purchase/receiving/list"/>';
}

// 모든 필드를 읽기 전용으로 설정하는 함수
function setAllFieldsReadOnly(readOnly) {
    const fields = [
        '#receivingId', '#receivingDate', '#ordersId', 
        '#name', '#productId', '#productName', '#brand', 
        '#supplier', '#wareHouse', '#deliveryDate'
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

// 입고 조회 폼 제출
function searchOrder() {
    $('#receivingForm').submit();
}

$(document).ready(function() {
    // 확정 버튼 클릭 이벤트 추가
    $('.confirmButton').on('click', function() {
        const receivingId = $(this).data('receiving-id');
        const token = $("meta[name='_csrf']").attr("content");
        const header = $("meta[name='_csrf_header']").attr("content");

        // 서버로 상태 변경 요청
        $.ajax({
            url: '<c:url value="/purchase/receiving/confirm"/>',
            type: 'POST',
            data: { receivingId: receivingId },
            beforeSend: function(xhr) {
                xhr.setRequestHeader(header, token);
            },
            success: function(response) {
                alert('입고 확정 되었습니다.');

                // 상태 변경 후 버튼 비활성화 처리 (각각의 버튼을 비활성화)
                const row = $('button[data-receiving-id="' + receivingId + '"]').closest('tr');
                
                // 취소 버튼 비활성화
                row.find('.cancelButton').prop('disabled', true);
                
                // 확정 버튼 비활성화
                row.find('.confirmButton').prop('disabled', true);
                
                // 상태를 '입고 확정'으로 업데이트 (해당 열에 상태 표시)
                row.find('td').eq(18).text('입고 확정');
            },
            error: function(xhr, status, error) {
                console.error('AJAX 요청 중 오류:', xhr, status, error);
                alert('상태 변경 중 오류가 발생했습니다.');
            }
        });
    });
});



</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
