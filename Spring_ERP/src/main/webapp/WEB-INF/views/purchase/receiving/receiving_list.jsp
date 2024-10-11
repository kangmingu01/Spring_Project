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
          <div><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
            <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
          </svg></div>
          <span>조회</span>
        </div>
        <!-- 초기화 버튼 -->
        <div class="content_header_reset_btn" onclick="resetFields()">
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
      <!-- 발주 조회 폼 -->
      <form id="receivingForm" action="<c:url value='/purchase/receiving/list' />" method="get">
        <div class="content_body_search">
          <div>
            <!-- 입고 검색 필드 -->
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
            <div>
              <label>상태</label>
              <select name="receivingStatus" id="receivingStatus">
                <option value="">상태 선택</option>
                <option value="2">입고 대기</option> 
                <option value="4">입고 완료</option>                         
              </select>           
            </div>
            <input type="hidden" id="pageNum" name="pageNum" value="${pager.pageNum}">
        	<input type="hidden" id="pageSize" name="pageSize" value="${pager.pageSize}">
            <div>
              <label>통과수량</label>
              <input type="number" name="quantity" id="quantity" style="background-color: #f0f0f0" readonly/>
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
              <th>상태</th>              
              <th>수정</th>
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
				    <c:when test="${orders.ordersStatus == 2}">입고 대기</c:when> 
				    <c:when test="${receiving.receivingStatus == 4}">입고 완료</c:when> 
				  </c:choose>
				</td>
                <!-- 수정 버튼 (입고 대기 상태일 때만 활성화) -->
                <td>
                  <c:if test="${orders.ordersStatus == 2}">
                    <button class="editButton" data-receiving-id="${receiving.receivingId}">수정</button>
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
      // 수정 버튼 클릭 이벤트 추가
      $('.editButton').on('click', function() {
        const receivingId = $(this).data('receiving-id');
        editReceiving(receivingId);
      });

      // 조회 버튼 클릭 이벤트 추가
      $('.content_header_search_btn').on('click', function() {
        searchOrder();
      });

      // 초기화 버튼 클릭 이벤트 추가
      $('.content_header_reset_btn').on('click', function() {
        resetFields();
      });
    });

    // 입고 조회 폼 제출
    function searchOrder() {
      $('#receivingForm').submit();
    }

    // 수정 버튼 클릭 시 실행되는 함수
    function editReceiving(receivingId) {
      // 수정 버튼 비활성화 처리
      $('.editButton').prop('disabled', true);

      // 선택한 행의 데이터를 가져오기 위해 해당 행을 탐색
      const row = $(`button[data-receiving-id="${receivingId}"]`).closest('tr');

      if (!row.length) {
        alert('해당 행을 찾을 수 없습니다.');
        return;
      }

      // 각 필드에 값을 채우기
      $('#receivingId').val($.trim(row.children().eq(0).text()));
      $('#receivingDate').val($.trim(row.children().eq(1).text()));
      $('#ordersId').val($.trim(row.children().eq(2).text()));
      $('#name').val($.trim(row.children().eq(3).text()));
      $('#productId').val($.trim(row.children().eq(4).text()));
      $('#productName').val($.trim(row.children().eq(5).text()));
      $('#brand').val($.trim(row.children().eq(6).text()));

      // 공급업체 설정
      const supplierName = $.trim(row.children().eq(10).text());
      $('#supplier option').each(function() {
        if ($(this).text() === supplierName) {
          $(this).prop('selected', true);
        }
      });

      // 상태 설정
      const receivingStatusText = $.trim(row.children().eq(18).text());
      $('#receivingStatus option').each(function() {
        if ($(this).text() === receivingStatusText) {
          $(this).prop('selected', true);
        }
      });

      // 통과수량 설정
      $('#quantity').val($.trim(row.children().eq(13).text()));

      // 수정 가능한 필드만 활성화
      $('#quantity').prop('readonly', false).prop('disabled', false).css('background-color', '#ffffff');

      // 버튼을 완료 상태로 변경
      const button = $(`button[data-receiving-id="${receivingId}"]`);
      button.text('완료');
      button.off('click').on('click', function() {
        saveReceivingChanges(receivingId);
      });
    }

    // 수정 내용을 서버에 저장
    function saveReceivingChanges(receivingId) {
      const token = $("meta[name='_csrf']").attr("content");
      const header = $("meta[name='_csrf_header']").attr("content");

      // 수정된 값 가져오기
      const data = {
        receivingId: receivingId,
        quantity: $('#quantity').val()
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
          alert('수정되었습니다.');
          location.reload(); // 수정 후 페이지 새로고침
        },
        error: function(xhr, status, error) {
          alert('수정 중 오류가 발생했습니다.');
        }
      });
    }

    // 필드를 초기화하고 다시 검색 가능하게 설정
    function resetFields() {
      $('#receivingForm')[0].reset();
      location.reload(); // 페이지 새로고침하여 리스트 초기화
    }
  </script>


  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
