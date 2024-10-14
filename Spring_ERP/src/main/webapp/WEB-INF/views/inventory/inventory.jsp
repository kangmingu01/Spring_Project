<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="<c:url value="/css/reset.css"/>" type="text/css" rel="stylesheet">
  <link href="<c:url value="/css/inventory.css"/>" type="text/css" rel="stylesheet">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
  <title>Document</title>
</head>
<body>
  <div class="content">
    <!-- 헤더부분 -->
    <div class="content_header">
      <div class="content_header_title">재고현황</div>
      <div class="content_header_btn">
        <div class="content_header_search_btn">
          <div><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
            <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
          </svg></div>
          <span>조회</span>
        </div>
        <div class="content_header_reset_btn">
          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-clockwise" viewBox="0 0 16 16">
            <path fill-rule="evenodd" d="M8 3a5 5 0 1 0 4.546 2.914.5.5 0 0 1 .908-.417A6 6 0 1 1 8 2z"/>
            <path d="M8 4.466V.534a.25.25 0 0 1 .41-.192l2.36 1.966c.12.1.12.284 0 .384L8.41 4.658A.25.25 0 0 1 8 4.466"/>
          </svg>
          <span>초기화</span>
        </div>
      </div>
    </div>
    <!-- 바디부분 -->
    <div class="content_body">
      <!-- 서치 태그 -->
      <div class="content_body_search">
        <div class="content_search_one">
          <div>
            <div class="item_code">
              <label>제품코드</label>
              <select class="inv_item" name="column">
              	<option value="" disabled selected>현재 등록된 상품코드</option>
              	<c:forEach var="product" items="${productCode}">
	                <option value="${product.productCategory }">${product.productCategory }</option>
              	</c:forEach>
              </select>
              <!-- <input type="text" name="productNum" class="productNum" readonly /> -->
            </div>
            <div>
              <label>제품명</label>
              <select class="inv_item" name="column">
              	<option value="" disabled selected>현재 등록된 상품명</option>
              	<c:forEach var="product" items="${productCode}">
	                <option value="${product.productName }">${product.productName }</option>
              	</c:forEach>
              </select>
            </div>
            <div>
              <label>입출고일자</label>
              <input type="text"/>
            </div>
            <div class="item_brand">
              <label >브랜드</label>
              <input type="text"/>
            </div>
           
          </div>
          <!-- 서치 2row 부분 -->
          <div>
            <div>
              <label>종류</label>
              <select>
                <option></option>
              </select>
            </div>
            <div>
              <label>색상</label>
              <select>
                <option></option>
              </select>
            </div>
            <div>
              <label>사이즈</label>
              <select>
                <option></option>
              </select>
            </div>
            <div>
              <label>성별</label>
              <select>
                <option></option>
              </select>
            </div>
            <div class="item_code_create">
              <button>제품코드생성</button>
            </div>
          </div>
          <!-- 서치 3row 부분 -->
          <div>
            <div>
              <label>현재수량</label>
              <input type="number"/>
            </div>
            <div>
              <label>파손수량</label>
              <input type="number"/>
            </div>
            <div>
            	<label>창고</label>
            	<input type="text"/>
            </div>
            <div></div>
            <div></div>
          </div>
        </div>
        <div class="content_search_two">


        </div>
      </div>
      <!-- 추가사항 태그 -->
      <div class="content_body_search_plus">
        <div>추가정보</div>
        <div>
          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-down-fill" viewBox="0 0 16 16">
            <path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/>
          </svg>
        </div>
      </div>
      <div class="content_plus"></div>
      <!-- 가격 태그 -->
      <div class="content_body_search_price">
        <div>
          <div>
            <label>가격</label>
            <input type="text"/>
          </div>
          <div>
            <label>부가세</label>
            <input type="text"/>
          </div>
          <div>
            <label>총액</label>
            <input type="text"/>
          </div>
        </div>
        <div></div>
      </div>
      <div class="file_btn">
      	<div>
  			<div class="product_btn"><span>재고리스트</span></div>
	  		<div class="warehouse_btn"><span>입출고현황</span></div>
      	</div>
      	<div>
	        <div class="upload_btn">
	          <div>
	            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-upload" viewBox="0 0 16 16">
	              <path d="M.5 9.9a.5.5 0 0 1 .5.5v2.5a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1v-2.5a.5.5 0 0 1 1 0v2.5a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2v-2.5a.5.5 0 0 1 .5-.5"/>
	              <path d="M7.646 1.146a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1-.708.708L8.5 2.707V11.5a.5.5 0 0 1-1 0V2.707L5.354 4.854a.5.5 0 1 1-.708-.708z"/>
	            </svg>
	            <span>UPLOAD</span>
	          </div>
	        </div>
	        <div class="excel_btn">
	          <div>
	            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-download" viewBox="0 0 16 16">
	              <path d="M.5 9.9a.5.5 0 0 1 .5.5v2.5a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1v-2.5a.5.5 0 0 1 1 0v2.5a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2v-2.5a.5.5 0 0 1 .5-.5"/>
	              <path d="M7.646 11.854a.5.5 0 0 0 .708 0l3-3a.5.5 0 0 0-.708-.708L8.5 10.293V1.5a.5.5 0 0 0-1 0v8.793L5.354 8.146a.5.5 0 1 0-.708.708z"/>
	            </svg>
	            <span>EXCEL</span>
	          </div>
	        </div>      	
      	</div>
      </div>
      <!-- 테이블 부분 -->
      <div class="content_body_list">
        <table>
          <thead>
              <tr>
                  <th>제품코드</th>
                  <th>제품명</th>
                  <th>브랜드</th>
                  <th>색상</th>
                  <th>사이즈</th>
                  <th>종류</th>
                  <th>성별</th>
                  <th>수량</th>
                  <th>가격</th>
                  <th style="width: 100px;"></th>
              </tr>
          </thead>
          <tbody class="sty">
          <c:choose>
          	<c:when test="${empty resultMap.invenList }">
          		<tr>
          			<td colspan="10">검색된 리스트가 없습니다.</td>
          		</tr>
          	</c:when>
          	<c:otherwise>
          		<c:forEach var="inven"  items="${resultMap.invenList }">
	              <tr>
	                  <td>${inven.product.productCategory}</td>  <!-- 수정된 부분 -->
        			  <td>${inven.inventoryProductId}</td>
      				  <td>${inven.product.productName}</td>     <!-- 수정된 부분 -->
	                  <td>Black</td>
	                  <td>270</td>
	                  <td>운동화</td>
	                  <td>남자</td>
	                  <td>10</td>
	                  <td>1,500,000원</td>
	                  <td><button>수정</button><button>삭제</button></td>
	              </tr>          		
          		</c:forEach>
          	</c:otherwise>
         </c:choose>
          </tbody>
        </table>
        <div style="text-align: center;">
			<c:choose>
				<c:when test="${resultMap.pager.startPage > resultMap.pager.blockSize }">
					<a href="<c:url value="/inventory/list"/>?pageNum=${resultMap.pager.prevPage}&pageSize=${resultMap.pager.pageSize }&column=${searchMap.column}&keyword=${searchMap.keyword}">
						[이전]
					</a>
				</c:when>
				<c:otherwise>
					[이전]
				</c:otherwise>
			</c:choose>
				
			<c:forEach var="i" begin="${resultMap.pager.startPage }" end="${resultMap.pager.endPage }" step="1">
				<c:choose>
					<c:when test="${resultMap.pager.pageNum != i }">
						<a href="<c:url value="/inventory/list"/>?pageNum=${i}&pageSize=${resultMap.pager.pageSize }&column=${searchMap.column}&keyword=${searchMap.keyword}">
							[${i }]
						</a>
					</c:when>
					<c:otherwise>
						[${i }]
					</c:otherwise>
				</c:choose>				
			</c:forEach>
			
			<c:choose>
				<c:when test="${resultMap.pager.endPage != resultMap.pager.totalPage }">
					<a href="<c:url value="/inventory/list"/>?pageNum=${resultMap.pager.nextPage}&pageSize=${resultMap.pager.pageSize }&column=${searchMap.column}&keyword=${searchMap.keyword}">
						[다음]
					</a>
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
    // 추가 정보 클릭 이벤트
    var plusBtn=document.querySelector(".content_body_search_plus");
    var plusContent=document.querySelector(".content_plus");
    plusBtn.addEventListener("click",function(){
      if(plusBtn.className=="content_body_search_plus"){
        plusBtn.classList.add("on");
        plusContent.classList.add("on");
      }else{
        plusBtn.classList.remove("on");
        plusContent.classList.remove("on");
      }
    });
  </script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>