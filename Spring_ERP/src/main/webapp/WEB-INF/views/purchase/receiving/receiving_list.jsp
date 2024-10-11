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
    <option value="" <c:if test="${empty searchMap.receivingStatus}">selected</c:if>>상태 선택</option>
    <option value="2" <c:if test="${searchMap.receivingStatus == '2'}">selected</c:if>>입고 대기</option>
    <option value="4" <c:if test="${searchMap.receivingStatus == '4'}">selected</c:if>>입고 완료</option>
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
                                        <c:when test="${receiving.ordersStatus == 2 && receiving.receivingStatus != 4}">
                                            입고 대기
                                        </c:when>
                                        <c:when test="${receiving.receivingStatus == 4}">
                                            입고 완료
                                        </c:when>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:if test="${receiving.ordersStatus == 2 && receiving.receivingStatus != 4}">
                                        <button class="editButton" data-orders-id="${receiving.ordersId}">수정</button>
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
                const ordersId = $(this).data('orders-id');
                loadOrderDetails(ordersId);
            });
        });

        function loadOrderDetails(ordersId) {
            // 수정 로직 구현
        }

        function searchOrder() {
            $('#receivingForm').submit();
        }

        function resetForm() {
            $('#receivingForm')[0].reset();
            $('#receivingForm').submit();
        }
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
