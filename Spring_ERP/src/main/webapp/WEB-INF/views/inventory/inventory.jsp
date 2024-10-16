<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="_csrf" content="${_csrf.token}" />
  <meta name="_csrf_header" content="${_csrf.headerName}" />
  <link href="<c:url value="/css/reset.css"/>" type="text/css" rel="stylesheet">
  <link href="<c:url value="/css/inventory.css"/>" type="text/css" rel="stylesheet">
  <%--<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>--%>
  <title>Document</title>
</head>
<body>
  <div class="content">
    <!-- 헤더부분 -->
    <div class="content_header">
      <div class="content_header_title">재고현황</div>
      <div class="content_header_btn">
        <div class="content_header_search_btn" data-bs-toggle="modal" data-bs-target="#newModal">
          <div><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
            <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
          </svg></div>
          <span>제품조회</span>
        </div>
        <div class="content_header_plus_btn">
          <div><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-plus-circle" viewBox="0 0 16 16">
			  <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16"/>
			  <path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4"/>
			</svg>
		  </div>
          <span>재고등록</span>
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
          <div class="onerow">
            <div class="item_code">
              <label>제품코드</label>
              <input type="hidden" name="productId" class="productId"/>
              <input type="text"  readonly="readonly" name="productCategory" class="productCategory"/>
            </div>
            <div>
              <label>상품명</label>
              <input type="text"  readonly="readonly" name="productName" class="productName"/>
            </div>
            <div>
              <label>브랜드</label>
              <input type="text"  readonly="readonly" name="productCategory" class="productCategory"/>
            </div>
            <div class="item_brand">
              <label >종류</label>
              <input type="text" readonly="readonly" name="productCategory" class="productCategory"/>
            </div>
          </div>
          <!-- 서치 2row 부분 -->
          <div class="tworow">
            <div>
              <label>색상</label>
              <input type="text" readonly="readonly" name="productCategory" class="productCategory"/>
            </div>           
            <div>
              <label>사이즈</label>
              <input type="text"  readonly="readonly" name="productCategory" class="productCategory"/>
            </div>
            <div>
              <label>성별</label>
              <input type="text" readonly="readonly" name="productCategory" class="productCategory"/>
            </div>
          </div>
          <!-- 서치 3row 부분 -->
          <div>
            <div>
              <label>현재수량</label>
              <input type="number" class="inventoryQty"/>
            </div>
            <div>
              <label>파손수량</label>
              <input type="number" class="inventoryDamagedQty"/>
            </div>
            <div>
            	<label>창고</label>
            	<select class="inventoryWarehouseId">
            		<c:forEach var="warehouseNum" items="${warehouseNum}">
	            		<option value="${warehouseNum.warehouseId}">${warehouseNum.warehouseName }</option>            		
            		</c:forEach>
            	</select>
            </div>
            <div>
            	<label>입출고일자</label>
            	<input type="date" class="lastDate"/>
            </div>
          </div>
        </div>
        <div class="content_search_two">
        </div>
      </div>
      <!-- 추가사항 태그 -->
      <div class="content_body_search_plus">
        <div>재고 입출고 수동관리</div>
        <div>
          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-down-fill" viewBox="0 0 16 16">
            <path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/>
          </svg>
        </div>
      </div>
      <div class="content_plus"></div>
      <div class="file_btn">
      	<div>
  			<div class="product_btn"><span>재고관리</span></div>
	  		<div class="warehouse_btn"><span>품질불량관리</span></div>
	  		<div class="inventory_qty_btn"><span>재고수량관리</span></div>
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
      <div class="content_body_search_sty">
      	<div>
      		<select class="search" name="search">
      			<option value="product_category" <c:if test="${search }=='product_category' "> selected </c:if>>제품코드</option>
      			<option value="product_name" <c:if test="${search }=='product_name' "> selected </c:if>>제품명</option>
      			<option value="warehouse_name" <c:if test="${search }=='warehouse.warehouse_name' "> selected </c:if>>창고이름</option>
      		</select>
      	</div>
      	<div>
      		<input type="text" name="keyword" class="keyword" value="${ keyword}">
      	</div>
      	<div class="content_body_search_btn" >
          <div><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
            <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
          </svg></div>
          <span>검색</span>
        </div>
      </div>
      <div class="content_body_list"></div>
      <div class="pageNumDiv"></div>
    </div>
  </div>
	
	<!-- Modal -->
	<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
	  <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h1 class="modal-title fs-5" id="staticBackdropLabel">재고수정</h1>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body" id="modal_update_body">
	      	<div class="updateOne">
		      	<input type="hidden" class="updateinventoryId">
		      	<input type="hidden" class="updateId">
		        <div>
		        	<label>제품코드</label>
		        	<input type="text" class="updateCode"  readonly="readonly" />
		        </div>
		        <div>
		        	<label>상품명</label>
		        	<input type="text"  class="updateName" readonly="readonly" />
		        </div>
		        <div>
		        	<label>현재수량</label>
		        	<input type="text"  class="updateQty" />
		        </div>
		        <div>
		        	<label>창고</label>
		        	<input type="text"  class="updateWarehouse" />
		        </div>
		        <div>
		        	<label>파손수량</label>
		        	<input type="text"  class="updateDamageQty" disabled  />
		        </div>
		        <div>
		        	<label>입출고일자</label>
		        	<input type="date"  class="updateDate" />
		        </div>	      	
	      	</div>
	      	<div class="updateTwo">
		      	<div class="item_code_create">
		            <button type="button" class="product_code_create" data-bs-toggle="modal" data-bs-target="#newModal">제품조회</button>
	      		</div>
	      		<div></div>
	      	</div>
	      	<div class="updateThree"></div>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
	        <button type="button" class="btn btn-primary" data-bs-dismiss="modal"  id="update_btn">수정완료</button>
	      </div>
	    </div>
	  </div>
	</div>
	
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
  <script src="<c:url value="/js/jquery-3.7.1.min.js"/>"></script>
  <script>
 	var csrfToken = $('meta[name="_csrf"]').attr('content');
  	var csrfHeader = $('meta[name="_csrf_header"]').attr('content');
  	inventoryDisplay(pageNum=1)
 
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

    //reset
    $(".content_header_reset_btn").click(function(){
    	// 모든 input 태그를 선택하고 값 초기화
        $('input[type="text"], input[type="hidden"], input[type="number"], input[type="date"]').val('');
    });
    
    //모달창 제품 검색 이벤트
    $(".modalSearch_btn").click(function(){
    	productDisplay();
    });
    
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
    
  	//재고 등록 이벤트
    $(".content_header_plus_btn").click(function(){
    	var inventoryProductId= $(".productId").val();
    	console.log(inventoryProductId);
    	var	inventoryQty=$(".inventoryQty").val();
    	console.log(inventoryQty);
    	var	inventoryWarehouseId=$(".inventoryWarehouseId").val();
    	console.log(inventoryWarehouseId);
    	var inventoryDamagedQty=$(".inventoryDamagedQty").val();
    	console.log(inventoryDamagedQty);
    	var lastDate=$(".lastDate").val();
    		
    	
    	if(confirm("재고를 등록 하시겠습니까?")){
	        $.ajax({
	    		type:"post",
	    		url: "<c:url value="/inventory/inventory_add"/>",
	    		contentType : "application/json",
	    		data: JSON.stringify({"inventoryProductId":inventoryProductId,"inventoryQty":inventoryQty,"inventoryWarehouseId":inventoryWarehouseId,"inventoryDamagedQty":inventoryDamagedQty,"lastDate":lastDate }),
	    		dataType:"text",
	    		beforeSend: function(xhr) {
                    // CSRF 토큰을 HTTP 요청 헤더에 추가
                    xhr.setRequestHeader(csrfHeader, csrfToken);
                },
	    		success: function(){
	    			$(".content_body_list").empty();
	    			$(".pageNumDiv").empty();
	    			productDisplay();
	    			alert("성공적으로 등록되었습니다.");
	    		},
	    		error: function(xhr){
	    			alert("등록이 실패 하였습니다.");
	    		}
	    	});
        }
    });
    
    
    
    
    //################################# 수정중 .. 다른 리스트 형식 함수 호출해야함
    // 조회 버튼 클릭시  
    document.querySelector(".content_body_search_btn").addEventListener("click",function(){
	    inventoryDisplay();    		   	
    });

  //페이징 처리 관련 Object 객체를 전달받아 HTML 태그로 변환해 페이지 번호를 출력하는 함수
    function pageNumberDisplay(pager) {
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
	    $(".pageNumDiv").html(html);
	}
  
  	//재고리스트 클릭이벤트
  	$(".product_btn").click(function(){
  		inventoryDisplay();
  	})

    //재고 리스트 함수
    function inventoryDisplay(pageNum=1) {
    	var pageSize=10;
    	var search = document.querySelector(".search").value;
    	var keyword = document.querySelector(".keyword").value;
    	$.ajax({
    		type:"get",
    		url: "<c:url value="/inventory/inventory_list"/>", 
    		data: {"pageNum":pageNum, "pageSize":pageSize, "search":search,"keyword":keyword},
			dataType: "json",  		
			success: function(result){
				if(result.invenList.length == 0){
					var html="<table>";
					html+="<tr>";
					html+="<th>검색된 상품이 없습니다.</th>";
					html+="</tr>";
					html+="</table>";
					$(".content_body_list").html(html);
					return;
				}
				var html="<table>";
				html+="<thead>";
				html+="<tr>";
				html+="<th>No</th>";
				html+="<th>상품번호</th>";				
				html+="<th>제품코드</th>";
				html+="<th>제품명</th>";
				html+="<th>브랜드</th>";
				html+="<th>종류</th>";
				html+="<th>색상</th>";
				html+="<th>사이즈</th>";
				html+="<th>성별</th>";
				html+="<th>현재수량</th>";
				html+="<th>파손수량</th>";
				html+="<th>창고이름</th>";
				html+="<th>출입고일자</th>";
				html+="<th></th>"; 
				html+="</tr>";
				html+="</thead>";
				html+="<tbody class='sty'>";
				$(result.invenList).each(function(index){
					html+="<tr>";					
					html += "<td>" + (index + 1 + (pageNum - 1) * pageSize) + "</td>"; // 수정된 부분
					html+="<td>"+this.inventoryProductId+"</td>";
					html+="<td>"+this.product.productCategory+"</td>";
					html+="<td>"+this.product.productName+"</td>";
					html+="<td>"+this.warehouseName+"</td>";
					html+="<td>"+this.warehouseName+"</td>";
					html+="<td>"+this.warehouseName+"</td>";
					html+="<td>"+this.warehouseName+"</td>";
					html+="<td>"+this.warehouseName+"</td>";
					html+="<td>"+this.inventoryQty+"</td>";
					html+="<td>"+this.inventoryDamagedQty+"</td>";
					html+="<td>"+this.warehouse.warehouseName+"</td>";
					var inventoryTime=this.lastDate.split(" ");
					html+="<td>"+inventoryTime[0]+"</td>";
					html+="<td>"; 
					html+='<button type="button" class="btn btn-secondary"  data-bs-toggle="modal" data-bs-target="#staticBackdrop"  onclick="modify('+this.inventoryId+');">수정</button>'; 
					html+="<button type='button' class='btn btn-danger' onclick='remove("+this.inventoryId+","+pageNum+");'>삭제</button>"
					html+="</td>"
					html+="</tr>";
				});
				html+="</tbody>";
				html+="</table>";
				$(".content_body_list").html(html);

				//페이지 번호를 출력하는 함수 호출
				pageNumberDisplay(result.pager);
	        },
			error:function(xhr){
				alert("상품 리스트를 불러오지 못했습니다.");
			}
    	});
    }
    
    //파손 리스트 클릭이벤트
    $(".warehouse_btn").click(function(){
    	inventoryDamageDisplay();
    });
    
    //파손상품 리스트 함수
    function inventoryDamageDisplay(pageNum=1) {
    	var pageSize=10;
    	var search = document.querySelector(".search").value;
    	var keyword = document.querySelector(".keyword").value;
    	$.ajax({
    		type:"get",
    		url: "<c:url value="/inventory/inventory_damage_list"/>", 
    		data: {"pageNum":pageNum, "pageSize":pageSize, "search":search,"keyword":keyword},
			dataType: "json",  		
			success: function(result){
				if(result.invenList.length == 0){
					var html="<table>";
					html+="<tr>";
					html+="<th>검색된 상품이 없습니다.</th>";
					html+="</tr>";
					html+="</table>";
					$(".content_body_list").html(html);
					return;
				}
				var html="<table>";
				html+="<thead>";
				html+="<tr>";
				html+="<th>No</th>";
				html+="<th>상품번호</th>";				
				html+="<th>제품코드</th>";
				html+="<th>제품명</th>";
				html+="<th>브랜드</th>";
				html+="<th>종류</th>";
				html+="<th>색상</th>";
				html+="<th>사이즈</th>";
				html+="<th>성별</th>";
				html+="<th>현재수량</th>";
				html+="<th>파손수량</th>";
				html+="<th>창고이름</th>";
				html+="<th>출입고일자</th>";
				html+="<th></th>"; 
				html+="</tr>";
				html+="</thead>";
				html+="<tbody class='sty'>";
				$(result.invenList).each(function(index){
					html+="<tr>";					
					html += "<td>" + (index + 1 + (pageNum - 1) * pageSize) + "</td>"; // 수정된 부분
					html+="<td>"+this.inventoryProductId+"</td>";
					html+="<td>"+this.product.productCategory+"</td>";
					html+="<td>"+this.product.productName+"</td>";
					html+="<td>"+this.warehouseName+"</td>";
					html+="<td>"+this.warehouseName+"</td>";
					html+="<td>"+this.warehouseName+"</td>";
					html+="<td>"+this.warehouseName+"</td>";
					html+="<td>"+this.warehouseName+"</td>";
					html+="<td>"+this.inventoryQty+"</td>";
					html+="<td>"+this.inventoryDamagedQty+"</td>";
					html+="<td>"+this.warehouse.warehouseName+"</td>";
					var inventoryTime=this.lastDate.split(" ");
					html+="<td>"+inventoryTime[0]+"</td>";
					html+="<td>"; 
					html+='<button type="button" class="btn btn-secondary"  data-bs-toggle="modal" data-bs-target="#staticBackdrop"  onclick="modify('+this.inventoryId+');">수정</button>'; 
					html+="<button type='button'  class='btn btn-danger' onclick='removeDamage("+this.inventoryId+","+pageNum+");'>삭제</button>"
					html+="</td>"
					html+="</tr>";
				});
				html+="</tbody>";
				html+="</table>";
				$(".content_body_list").html(html);

				//페이지 번호를 출력하는 함수 호출
				pageNumberDisplay(result.pager);
	        },
			error:function(xhr){
				alert("상품 리스트를 불러오지 못했습니다.");
			}
    	});
    }
    
    //재고 수량 100미안 정보 함수
    //파손상품 리스트 함수
    function inventoryQtyDisplay(pageNum=1) {
    	var pageSize=10;
    	var search = document.querySelector(".search").value;
    	var keyword = document.querySelector(".keyword").value;
    	$.ajax({
    		type:"get",
    		url: "<c:url value="/inventory/inventory_qty_list"/>", 
    		data: {"pageNum":pageNum, "pageSize":pageSize, "search":search,"keyword":keyword},
			dataType: "json",  		
			success: function(result){
				if(result.invenList.length == 0){
					var html="<table>";
					html+="<tr>";
					html+="<th>검색된 상품이 없습니다.</th>";
					html+="</tr>";
					html+="</table>";
					$(".content_body_list").html(html);
					return;
				}
				var html="<table>";
				html+="<thead>";
				html+="<tr>";
				html+="<th>No</th>";
				html+="<th>상품번호</th>";				
				html+="<th>제품코드</th>";
				html+="<th>제품명</th>";
				html+="<th>브랜드</th>";
				html+="<th>종류</th>";
				html+="<th>색상</th>";
				html+="<th>사이즈</th>";
				html+="<th>성별</th>";
				html+="<th>현재수량</th>";
				html+="<th>파손수량</th>";
				html+="<th>창고이름</th>";
				html+="<th>출입고일자</th>";
				html+="<th></th>"; 
				html+="</tr>";
				html+="</thead>";
				html+="<tbody class='sty'>";
				$(result.invenList).each(function(index){
					html+="<tr>";					
					html += "<td>" + (index + 1 + (pageNum - 1) * pageSize) + "</td>";
					html+="<td>"+this.inventoryProductId+"</td>";
					html+="<td>"+this.product.productCategory+"</td>";
					html+="<td>"+this.product.productName+"</td>";
					html+="<td>"+this.warehouseName+"</td>";
					html+="<td>"+this.warehouseName+"</td>";
					html+="<td>"+this.warehouseName+"</td>";
					html+="<td>"+this.warehouseName+"</td>";
					html+="<td>"+this.warehouseName+"</td>";
					html+="<td>"+this.inventoryQty+"</td>";
					html+="<td>"+this.inventoryDamagedQty+"</td>";
					html+="<td>"+this.warehouse.warehouseName+"</td>";
					var inventoryTime=this.lastDate.split(" ");
					html+="<td>"+inventoryTime[0]+"</td>";
					html+="<td>"; 
					html+='<button type="button" class="btn btn-secondary"  data-bs-toggle="modal" data-bs-target="#staticBackdrop"  onclick="modify('+this.inventoryId+');">수정</button>'; 
					html+="<button type='button' class='btn btn-danger' onclick='removeDamage("+this.inventoryId+","+pageNum+");'>삭제</button>"
					html+="</td>"
					html+="</tr>";
				});
				html+="</tbody>";
				html+="</table>";
				$(".content_body_list").html(html);

				//페이지 번호를 출력하는 함수 호출
				pageNumberDisplay(result.pager);
	        },
			error:function(xhr){
				alert("상품 리스트를 불러오지 못했습니다.");
			}
    	});
    }
    
    //재고 수량 클릭 이벤트
    $(".inventory_qty_btn").click(function(){
    	inventoryQtyDisplay(pageNum);
    });
    
    //inventory 정보 선택 함수 (update 전)
    function modify(inventoryId){
    	$.ajax({
    		type:"get",
    		url:"<c:url value="/inventory/inventory_modify_view"/>/"+inventoryId,
    		dataType:"json",
    		success:function(result){    			
    			console.log(result);
    			$(".updateinventoryId").val(result.inventoryId);
    			$(".updateId").val(result.inventoryProductId);
    			$(".updateCode").val(result.product.productCategory);
				$(".updateName").val(result.product.productName); 
				$(".updateQty").val(result.inventoryQty); 
				$(".updateWarehouse").val(result.inventoryWarehouseId); 
				$(".updateDamageQty").val(result.inventoryDamagedQty); 
				$(".updateDate").val(result.lastDate.substring(0, 10));
				
    		},
    		error:function(xhr){
    			alert("검색된 정보가 없습니다.")
    		}
    	});
    }
    
    //inventory 수정 정보에서 제품조회 클릭 이벤트
    $(".product_code_create").click(function(){
    	// 첫 번째 모달에서 두 번째 모달 열기
        $('#newModal').modal('show');
	   	productDisplay();

	    // 두 번째 모달이 닫힐 때 첫 번째 모달이 계속 열려 있도록 설정
        $('#newModal').on('hidden.bs.modal', function () {
            $('#staticBackdrop').modal('show');
        });
    });
    
    //재고 update 클릭 이벤트
    $("#update_btn").click(function(){
    	var inventoryId = $(".updateinventoryId").val();
    	var inventoryProductId = $(".updateId").val();
		var inventoryQty = $(".updateQty").val();
		var inventoryWarehouseId = $(".updateWarehouse").val();
		var inventoryDamagedQty = $(".updateDamageQty").val();
		var lastDate =$(".updateDate").val();
		
		$.ajax({
			type:"put",
			url:"<c:url value="/inventory/inventory_modify"/>",
			contentType: "application/json",
			data: JSON.stringify({"inventoryId":inventoryId, "inventoryProductId":inventoryProductId, "inventoryQty":inventoryQty, "inventoryWarehouseId":inventoryWarehouseId, "inventoryDamagedQty":inventoryDamagedQty, "lastDate":lastDate }),
			dataType: "text",
			beforeSend: function(xhr) {
                // CSRF 토큰을 HTTP 요청 헤더에 추가
                xhr.setRequestHeader(csrfHeader, csrfToken);
            },
			success:function(result){
				if(result == "success") {
					$('input[type="text"], input[type="hidden"], input[type="number"]').val('');
					inventoryDisplay();
				}
				alert("수정완료");
			},
			error:function(xhr){
				alert("상품정보가 수정되지 않았습니다.");
			}
		});
    });
    
    
    
    //inventory 삭제 함수
    function remove(inventoryId, pageNum) {
    	if(confirm("삭제 하시겠습니까?")){
    		$.ajax({
    			type:"delete",
    			url: "<c:url value="/inventory/inventory_remove"/>/"+inventoryId,
    			dataType: "text",
    			beforeSend: function(xhr) {
                    // CSRF 토큰을 HTTP 요청 헤더에 추가
                    xhr.setRequestHeader(csrfHeader, csrfToken);
                },
    			success: function(result){
    				if(result=="success"){
    					//init();
    					//console.log(pageNum);
    					inventoryDisplay(pageNum);
    					alert("삭제 하였습니다.");
    				}
    			},
    			error:function(xhr){
    				alert("삭제하지 못하였습니다.");
    			}
    		});
    	}
    }
    
    //파손수량 삭제 함수
    function removeDamage(inventoryId,pageNum){
    	if(confirm("삭제 하시겠습니까?")){
    		$.ajax({
    			type:"delete",
    			url: "<c:url value="/inventory/inventory_remove"/>/"+inventoryId,
    			dataType: "text",
    			beforeSend: function(xhr) {
                    // CSRF 토큰을 HTTP 요청 헤더에 추가
                    xhr.setRequestHeader(csrfHeader, csrfToken);
                },
    			success: function(result){
    				if(result=="success"){
    					//init();
    					//console.log(pageNum);
    					inventoryDamageDisplay(pageNum);
    					alert("삭제 하였습니다.");
    				}
    			},
    			error:function(xhr){
    				alert("삭제하지 못하였습니다.");
    			}
    		});
    	}
    }
     
    
  </script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>