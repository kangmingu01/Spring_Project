<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="_csrf" content="${_csrf.token}" />
    <meta name="_csrf_header" content="${_csrf.headerName}" />
    <link href="<c:url value="/css/reset.css"/>" type="text/css" rel="stylesheet">
    <link href="<c:url value="/css/product.css"/>" type="text/css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <title>Document</title>
</head>
<body>
<div class="content">
    <!-- 헤더부분 -->
    <div class="content_header">
        <div class="content_header_title">상품등록</div>
        <div class="content_header_btn">
            <div>
            	<select class="form-select search" name="search"  aria-label="Default select example">
				    <option value="product_category" <c:if test="${search }=='product_category' "> </c:if>>제품코드</option>
	                <option value="product_name" <c:if test="${search }=='product_name' "> </c:if>>제품명</option>
	                <option value="warehouse_name" <c:if test="${search }=='warehouse_name' "> </c:if>>창고이름</option>
	                <option value="warehouse_location" <c:if test="${search }=='warehouse_location' "> </c:if>>창고위치</option>
				</select>
            </div>
            <div>
			  <input type="text" class="form-control keyword" name="keyword"  value="${ keyword}" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default">
            </div>
            <div class="content_header_search_btn">
                <div><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
                    <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
                </svg></div>
                <span>조회</span>
            </div>
            <div class="content_header_plus_btn">
                <div><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-plus-circle" viewBox="0 0 16 16">
                    <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16"/>
                    <path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4"/>
                </svg>
                </div>
                <span>상품등록</span>
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
            <!-- 서치 1row부분 -->
            <div>
                <div class="item_code">
                    <label>제품코드</label>
                    <input type="text" name="productCategory" class="productCategory" readonly />
                </div>
                <div>
                    <label>제품명</label>
                    <input type="text" name="productName" class="productName"/>
                </div>
                <div class="item_brand">
                    <label>브랜드</label>
                    <select name="productBrand" class="productBrand">
                    	<option  value="" disabled="disabled" selected>선택해주세요</option>
                    	<option>New Balance(뉴발란스)</option>
                    	<option>Salomon(살로몬)</option>
                    	<option>ASICS(아식스)</option>
                    	<option>Vans(반스)</option>
                    	<option>Nike(나이키)</option>
                    	<option>Adidas(아디다스)</option>
                    	<option>Discovery(디스커버리)</option>
                    	<option>Descente(데상트)</option>
                    	<option>Puma(푸마)</option>
                    	<option>Fila(휠라)</option>
                    	<option>Lacoste(라코스테)</option>
                    </select>
                    <!-- <input type="text" name="productBrand" class="productBrand"/> -->
                </div>
                <div></div>
                <div class="item_code_create">
                    <button class="imgUploadBtn">이미지파일</button>
                    <input type="file" name="fileInput" class="fileInput" style="display:none">
                </div>
            </div>
            <!-- 서치 2row 부분 -->
            <div>
                <div>
                    <label>종류</label>
                    <select class="category_item">
                        <option  value="" disabled="disabled" selected>선택해주세요</option>
                        <option>Sneakers&#40;운동화&#41;</option>
                        <option>Slippers&#40;슬리퍼&#41;</option>
                        <option>Boots&#40;부츠&#41;</option>
                        <option>sandals&#40;샌들&#41;</option>
                        <option>Dress&nbsp;shoes&#40;구두&#41;</option>
                    </select>
                </div>
                <div>
                    <label>색상</label>
                    <select class="category_color">
                    	<option  value="" disabled="disabled" selected>선택해주세요</option>
                          <option value="Red">Red(빨강)</option>
						  <option value="Blue">Blue(파랑)</option>
						  <option value="Green">Green(초록)</option>
						  <option value="Yellow">Yellow(노랑)</option>
						  <option value="black">black(검정)</option>
						  <option value="White">White(흰색)</option>
						  <option value="Orange">Orange(주황)</option>
						  <option value="Pink">Pink(분홍)</option>
						  <option value="purple">purple(보라)</option>
						  <option value="Gray">Gray(회색)</option>
                    </select>
                </div>
                <div>
                    <label>사이즈</label>
                    <select class="category_size" >
                    	<option  value="" disabled="disabled" selected>선택해주세요</option>
                        <option>220</option>
                        <option>230</option>
                        <option>240</option>
                        <option>250</option>
                        <option>260</option>
                        <option>270</option>
                        <option>280</option>
                        <option>290</option>
                    </select>
                </div>
                <div>
                    <label>성별</label>
                    <select class="category_gender">
                        <option  value="" disabled="disabled" selected>선택해주세요</option>
                        <option>Man&#40;남자&#41;</option>
                        <option>Woman&#40;여자&#41;</option>
                    </select>
                </div>
                <div class="item_code_create">
                    <button type="button" class="product_code_create">제품코드생성</button>
                </div>
            </div>
            <!-- 서치 3row 부분 -->
            <div>
                <div>
                    <label>입고가격</label>
                    <input type="number" name="productPrice" class="productPrice"/>
                </div>
                <div>
                    <label>출고가격</label>
                    <input type="number" name=deliveryPrice class="deliveryPrice"/>
                </div>
                <div></div>
                <div></div>
            </div>
        </div>
        <!-- 추가사항 태그 -->
        <div class="content_body_search_plus">
            <div>창고 등록</div>
            <div>
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-down-fill" viewBox="0 0 16 16">
                    <path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/>
                </svg>
            </div>
        </div>
        <!-- 추가 on 부분 -->
        <div class="content_plus">
            <div>
                <div>
                    <label>창고명</label>
                    <input type="text" name="warehouseName" class="warehouseName"/>
                </div>
                <div>
                    <label>위치</label>
                    <input type="text" name="iwarehouseLocation" class="warehouseLocation"/>
                </div>
                <div>
                    <label>창고용량</label>
                    <input type="text" name="warehouseVolume" class="warehouseVolume"/>
                </div>
                <div></div>
                <div class="item_code_create">
                    <button type="button" class="warehouse_create">창고등록</button>
                </div>
            </div>
            <div></div>
        </div>
        <!-- 엑셀 업로드 다운로드 부분 -->
        <div class="file_btn">
            <div>
                <div class="product_btn"><span>상품리스트</span></div>
                <div class="warehouse_btn"><span>창고리스트</span></div>
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

        </div>
        <div class="pageNumDiv"></div>
    </div>
</div>


	<div class="backgroundmodal">
		<div class="updatemodal">
			<div class="updatemodal_title">상품수정</div>
			<div class="updateOne">
				<input type="hidden" class="updateId">
                <div>
                    <label>제품코드</label>
                    <input type="text" class="form-control updateCode"  aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default" readonly="readonly">
                </div>
                <div>
                    <label>제품명</label>
                    <input type="text" class="form-control updateName"  aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default">
                 
                </div>
                <div>
                    <label>입고가격</label>
                    <input type="number" class="form-control updatePrice"  aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default">
           
                </div>
                <div>
                    <label>출고가격</label>
                    <input type="number" class="form-control updateDelivery"  aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default">
          
            	</div>
			</div>
			<div class="buttonSty">
				<button type="button" class="btn btn-secondary updateClose">닫기</button>
				<button type="button" class="btn btn-primary" id="update_btn">수정완료</button>
			</div>
		</div>
	</div>

	<div class="backgroundmodalTwo">
		<div class="updatemodal">
			<div class="updatemodal_title">창고수정</div>
			<div class="updateOne">
				<input type="hidden" class="warehouseUpdateId">
                <div>
                    <label>창고이름</label>
                    <input type="text" class="form-control warehouseUpdateCode"  aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default">
        
                </div>
                <div>
                    <label>창고위치</label>
                    <input type="text" class="form-control warehouseUpdateLocation"  aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default">
 
                </div>
                <div>
                    <label>창고용량</label>
                    <input type="text" class="form-control warehouseUpdateCapacity"  aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default">
      
                </div>
			</div>
			<div class="buttonSty">
				<button type="button" class="btn btn-secondary updateClose">닫기</button>
				<button type="button" class="btn btn-primary" id="warehouseUpdate_btn">수정완료</button>
			</div>
		</div>
	</div>

<script>
    var csrfToken = $('meta[name="_csrf"]').attr('content');
    var csrfHeader = $('meta[name="_csrf_header"]').attr('content');
    productDisplay();


    //이미지 파일 클릭
    document.querySelector(".imgUploadBtn").addEventListener("click",function(){
        document.querySelector(".fileInput").click();
    });


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

    //제품등록 text 초기화 함수
    function init(){
        document.querySelector(".productName").value="";
        document.querySelector(".productBrand").value="";
        document.querySelector(".productPrice").value="";
        document.querySelector(".deliveryPrice").value="";
        document.querySelector(".productCategory").value="";
        document.querySelector(".category_item").value="";
        document.querySelector(".category_color").value="";
        document.querySelector(".category_size").value="";
        document.querySelector(".category_gender").value="";
        document.querySelector(".warehouseName").value="";
        document.querySelector(".warehouseVolume").value="";
        document.querySelector(".warehouseLocation").value="";
		document.querySelector(".keyword").value="";
    }
    //초기화 클릭 이벤트
    document.querySelector(".content_header_reset_btn").addEventListener("click",function(){
        init();
    });

    //제품코드 자동 완성 함수
    function codeCreate(){
        var brand=document.querySelector('.productBrand').value.slice(0, 2);
        var item=document.querySelector('.category_item').value.slice(0, 2);
        var color=document.querySelector('.category_color').value.slice(0, 2);
        var size=document.querySelector('.category_size').value;
        var gender=document.querySelector('.category_gender').value.charAt(0);
        var result =brand+item+color+size+gender;

        document.querySelector('.productCategory').value = result;
    }
    
    $(".productCategory").click(function(){
    	alert("제품코드생성 버튼으로 등록 해주세요.");
    });

    //제품코드 클릭 이벤트
    document.querySelector(".product_code_create").addEventListener("click",function(){
        codeCreate();
    });

    //상품등록 이벤트
    document.querySelector(".content_header_plus_btn").addEventListener("click",function(){
        var productName=document.querySelector(".productName").value;
        var brand=document.querySelector(".productBrand").value;
        var productPrice=document.querySelector(".productPrice").value;
        var deliveryPrice=document.querySelector(".deliveryPrice").value;
        var productCategory=document.querySelector(".productCategory").value;
        var item=document.querySelector(".category_item").value;
        var color=document.querySelector(".category_color").value;
        var size=document.querySelector(".category_size").value;
        var gender=document.querySelector(".category_gender").value;

        if(productName==""){
            alert("상품명을 입력해 주세요.");
            return;
        }
        if(brand==""){
            alert("브랜드를 입력해 주세요.");
            return;
        }
        if(item==""){
            alert("종류를 입력해 주세요.");
            return;
        }
        if(color==""){
            alert("색상을 입력해 주세요.");
            return;
        }
        if(size==""){
            alert("사이즈를 입력해 주세요.");
            return;
        }
        if(gender==""){
            alert("성별을 입력해 주세요.");
            return;
        }
        if(productCategory=="" ){
            alert("제품코드를 확인해 주세요.");
            return;
        }
        if (productCategory.length < 10) {
            alert("제품코드는 10자 이상이어야 합니다.");
            return;
        }
        if(productPrice==""){
            alert("입고가격을 입력해 주세요.");
            return;
        }
        if(deliveryPrice==""){
            alert("출고가격을 입력해 주세요.");
            return;
        }

        if(confirm("상품을 등록 하시겠습니까?")){
            $.ajax({
                type:"post",
                url: "<c:url value="/inventory/product_add"/>",
                contentType : "application/json",
                data: JSON.stringify({"productCategory":productCategory,"productName":productName,"productPrice":productPrice,"deliveryPrice":deliveryPrice }),
                dataType:"text",
                beforeSend: function(xhr) {
                    // CSRF 토큰을 HTTP 요청 헤더에 추가
                    xhr.setRequestHeader(csrfHeader, csrfToken);
                },
                success: function(){
                    init();
                    $(".content_body_list").empty();
                    $(".pageNumDiv").empty();
                    productDisplay();
                    alert("상품이 성공적으로 등록되었습니다.");
                },
                error: function(xhr){
                    alert("현재 상품은 등록 되어있습니다.");
                }
            });
        }
    });



    //창고등록 이벤트 ajax
    $(".warehouse_create").click(function(){
        var warehouseName=$(".warehouseName").val();
        var warehouseLocation=$(".warehouseLocation").val();
        var warehouseCapacity=$(".warehouseVolume").val();

        if(warehouseName==""){
            alert("창고명을 입력해 주세요.");
            return;
        }
        if(warehouseLocation==""){
            alert("창고 위치를 입력해 주세요.");
            return;
        }
        if(warehouseCapacity==""){
            alert("창고 용량을 입력해 주세요.");
            return;
        }
        if(confirm("창고를 등록 하시겠습니까?")){
            $.ajax({
                type:"post",
                url: "<c:url value="/inventory/warehouse_add"/>",
                contentType : "application/json",
                data: JSON.stringify({"warehouseName":warehouseName,"warehouseLocation":warehouseLocation,"warehouseCapacity":warehouseCapacity }),
                dataType:"text",
                beforeSend: function(xhr) {
                    // CSRF 토큰을 HTTP 요청 헤더에 추가
                    xhr.setRequestHeader(csrfHeader, csrfToken);
                },
                success: function(){
                    init();
                    $(".content_body_list").empty();
                    $(".pageNumDiv").empty();
                    warehouseDisplay();
                    alert("창고가 성공적으로 등록되었습니다.");
                },
                error: function(xhr){
                    alert("창고 등록이 실패 하였습니다.");
                }
            });
        }
    });

    //창고 리스트 이벤트 ajax
    function warehouseDisplay(pageNum=1){
        var pageSize=10;
        var search = document.querySelector(".search").value;
        var keyword = document.querySelector(".keyword").value;
        $.ajax({
            type:"get",
            url: "<c:url value="/inventory/warehouse_list"/>",
            data: {"pageNum":pageNum, "pageSize":pageSize, "search":search,"keyword":keyword},
            dataType: "json",
            success: function(result){
                //console.log(result.warehouseList);
                if(result.warehouseList.length == 0){
                    var html="<table>";
                    html+="<tr>";
                    html+="<th>검색된 창고가 없습니다.</th>";
                    html+="</tr>";
                    html+="</table>";
                    $(".content_body_list").html(html);
                    return;
                }
                var html="<table>";
                html+="<thead>";
                html+="<tr>";
                html+="<th>No</th>";
                html+="<th>창고번호</th>";
                html+="<th>창고이름</th>";
                html+="<th>창고위치</th>";
                html+="<th>창고용량</th>";
                html+="<th></th>";
                html+="</tr>";
                html+="</thead>";
                html+="<tbody class='sty'>";
                $(result.warehouseList).each(function(index){
                    html+="<tr>";
                    html+="<td>"+(index + 1) +"</td>";
                    html+="<td>"+this.warehouseId+"</td>";
                    html+="<td>"+this.warehouseName+"</td>";
                    html+="<td>"+this.warehouseLocation+"</td>";
                    html+="<td>"+this.warehouseCapacity+"</td>";
                    html+="<td>";
                    html+='<button type="button" class="btn btn-secondary"  onclick="modifyhouse('+this.warehouseId+');">수정</button>'
                    html+="<button type='button' class='btn btn-danger' onclick='warehouseremove("+this.warehouseId+");'>삭제</button>"
                    html+="</td>"
                    html+="</tr>";
                });
                html+="</tbody>";
                html+="</table>";
                $(".content_body_list").html(html);

                pageNumberDisplay(result.pager);
            },
            error:function(xhr){
                alert("창고 리스트를 불러오지 못했습니다.");
            }
        });
    }

    //창고 리스트 클릭이벤트
    $(".warehouse_btn").click(function(){
        $(".content_body_list").empty();
        warehouseDisplay();
    });

    //창고정보 선택 함수(update 전)
    function modifyhouse(warehouseId) {
    	var back =document.querySelector(".backgroundmodalTwo");
        back.classList.add("on"); // "on" 클래스가 없으면 추가
    	console.log(back);
        $.ajax({
            type:"get",
            url:"<c:url value="/inventory/warehouse_modify_view"/>/"+warehouseId,
            dataType:"json",
            success:function(result){
                $(".warehouseUpdateId").val(result.warehouseId);
                $(".warehouseUpdateCode").val(result.warehouseName);
                $(".warehouseUpdateLocation").val(result.warehouseLocation);
                $(".warehouseUpdateCapacity").val(result.warehouseCapacity);
            },
            error:function(xhr){
                alert("검색된 정보가 없습니다.")
            }
        });
    }
    
  	//창고 수정 모달창 끄기
    $(".updateClose").click(function(){
    	var back =document.querySelector(".backgroundmodalTwo");
        back.classList.remove("on"); // "on" 클래스가 없으면 추가
    });

    //창고모달 변수 초기화
    function modalwarehouseinit(){
        $(".warehouseUpdateId").val("");
        $(".warehouseUpdateCode").val("");
        $(".warehouseUpdateLocation").val("");
        $(".warehouseUpdateCapacity").val("");
    }


    //창고정보 update 버튼 클릭이벤트
    $("#warehouseUpdate_btn").click(function(){
        var warehouseId=$(".warehouseUpdateId").val();
        var warehouseName=$(".warehouseUpdateCode").val();
        var warehouseLocation=$(".warehouseUpdateLocation").val();
        var warehouseCapacity=$(".warehouseUpdateCapacity").val();

        $.ajax({
            type:"put",
            url:"<c:url value="/inventory/warehouse_modify"/>",
            contentType: "application/json",
            data: JSON.stringify({"warehouseId":warehouseId, "warehouseName":warehouseName,"warehouseLocation":warehouseLocation, "warehouseCapacity":warehouseCapacity}),
            dataType: "text",
            beforeSend: function(xhr) {
                // CSRF 토큰을 HTTP 요청 헤더에 추가
                xhr.setRequestHeader(csrfHeader, csrfToken);
            },
            success:function(result){
                if(result == "success") {
                    modalwarehouseinit();
                    var back =document.querySelector(".backgroundmodalTwo");
   				 	back.classList.remove("on"); // "on" 클래스가 없으면 추가
                    warehouseDisplay();
                    // 모달 창 닫기
                    alert("수정이 완료 되었습니다.");
                }
            },
            error:function(xhr){
                alert("상품정보가 수정되지 않았습니다.");
            }
        });

    });

    //창고 리스트 삭제 함수
    function warehouseremove(warehouseId){
        if(confirm("삭제 하시겠습니까?")){
            $.ajax({
                type:"delete",
                url: "<c:url value="/inventory/warehouse_remove"/>/"+warehouseId,
                dataType: "text",
                beforeSend: function(xhr) {
                    // CSRF 토큰을 HTTP 요청 헤더에 추가
                    xhr.setRequestHeader(csrfHeader, csrfToken);
                },
                success: function(result){
                    if(result=="success"){
                        init();
                        warehouseDisplay();
                        alert("삭제 하였습니다.");
                    }
                },
                error:function(xhr){
                    alert("현재 창고는 사용중이기 때문에 삭제 할 수 없습니다.");
                }
            });
        }
    }
    // 조회 버튼 클릭시
    document.querySelector(".content_header_search_btn").addEventListener("click",function(){
        if(document.querySelector(".search").value=="product_category" || document.querySelector(".search").value=="product_name"){
            productDisplay();
            init();
        }else{
            warehouseDisplay();
            init();
        }
    });
    
 	// 상품리스트 함수 ajax
	function productDisplay(pageNum = 1) {
	    var pageSize = 10;
	    var search = document.querySelector(".search").value;
	    var keyword = document.querySelector(".keyword").value;
	
	    $.ajax({
	        type: "get",
	        url: "<c:url value='/inventory/product_list'/>",
	        data: { "pageNum": pageNum, "pageSize": pageSize, "search": search, "keyword": keyword },
	        dataType: "json",
	        success: function(result) {
	            if (result.productList.length == 0) {
	                var html = "<table>";
	                html += "<tr>";
	                html += "<th>검색된 상품이 없습니다.</th>";
	                html += "</tr>";
	                html += "</table>";
	                $(".content_body_list").html(html);
	                return;
	            }
	            var html = "<table>";
	            html += "<thead>";
	            html += "<tr>";
	            html += "<th>No</th>";			
	            html += "<th>제품코드</th>";
	            html += "<th>제품명</th>";
	            html += "<th>브랜드</th>";
	            html += "<th>종류</th>";
	            html += "<th>색상</th>";
	            html += "<th>사이즈</th>";
	            html += "<th>성별</th>";
	            html += "<th>입고가격</th>";
	            html += "<th>출고가격</th>";
	            html += "<th></th>"; 
	            html += "</tr>";
	            html += "</thead>";
	            html += "<tbody class='sty'>";
	
	            var remainingRequests = result.productList.length; // 남은 요청 수
	
	            $(result.productList).each(function(index) {
	                var Category = this.productCategory; // productCategory 값을 저장
	                var ProductItem = this; // ProductItem을 참조
	
	                // 변환된 productCategory를 요청하는 AJAX 호출
	                $.ajax({
	                    type: "get",
	                    url: "<c:url value='/inventory/ProductconvertCategory'/>",
	                    data: { "categoryCode": Category },
	                    dataType: "json",
	                    success: function(convertedCategory) {
	                    	
	                        html += "<tr>";					
	                        html += "<td>" + (index + 1 + (pageNum - 1) * pageSize) + "</td>"; // 수정된 부분
	                        html += "<td>" + ProductItem.productCategory + "</td>";
	                        html += "<td>" + ProductItem.productName + "</td>";
	                        html += "<td>" + convertedCategory.brand + "</td>";
	                        html += "<td>" + convertedCategory.item + "</td>";
	                        html += "<td>" + convertedCategory.color + "</td>";
	                        html += "<td>" + convertedCategory.size + "</td>";
	                        html += "<td>" + convertedCategory.gender + "</td>";
	                        html += "<td>" + ProductItem.productPrice + "</td>";
	                        html += "<td>" + ProductItem.deliveryPrice + "</td>";
	                        html += "<td>"; 
	                        html += '<button type="button" class="btn btn-primary" onclick="modify(' + ProductItem.productId + ');">수정</button>'; 
	                        html += "<button type='button' class='btn btn-danger' onclick='remove(" + ProductItem.productId + "," + pageNum + ");'>삭제</button>";
	                        html += "</td>";
	                        html += "</tr>";
	
	                        remainingRequests--; // 요청 수 감소
	                        if (remainingRequests === 0) {
	                            html += "</tbody></table>";
	                            $(".content_body_list").html(html);
	                        }
	                    },
	                    error: function(xhr) {
	                        alert("카테고리 적용 실패");
	                        remainingRequests--; // 실패한 경우에도 요청 수 감소
	                        if (remainingRequests === 0) {
	                            html += "</tbody></table>";
	                            $(".content_body_list").html(html);
	                        }
	                    }
	                });
	            });
	
	            // 페이지 번호를 출력하는 함수 호출
	            pageNumberDisplay(result.pager);
	        },
	        error: function(xhr) {
	            alert("상품 리스트를 불러오지 못했습니다.");
	        }
	    });
	}
    
    
    //페이징 처리 관련 Object 객체를 전달받아 HTML 태그로 변환해 페이지 번호를 출력하는 함수
    function pageNumberDisplay(pager) {
        var html = "";

     // 이전 페이지 링크
	    if (pager.startPage > pager.blockSize) {
	        html += "<a class='btn btn-primary btn-sm' style='background-color: #6571FF; margin-right: 5px;' href='javascript:productDisplay(" + pager.prevPage + ","+pager.pageSize+");'>&laquo; 이전</a>";
	    } else {
	        html += "<span class='btn btn-secondary disabled btn-sm' style='background-color: #6571FF; margin-right: 5px;'>&laquo; 이전</span>";
	    }
	
	    // 페이지 번호 링크
	    for (var i = pager.startPage; i <= pager.endPage; i++) {
	        if (pager.pageNum != i) {
	            html += "<a class='btn btn-outline-primary mx-1 btn-sm' href='javascript:productDisplay(" + i + ","+pager.pageSize+");'>" + i + "</a>";
	        } else {
	            html += "<span class='btn btn-primary mx-1 active btn-sm' style='background-color: #6571FF;'>" + i + "</span>";
	        }
	    }
	
	    // 다음 페이지 링크
	    if (pager.endPage != pager.totalPage) {
	        html += "<a class='btn btn-primary btn-sm' style='background-color: #6571FF; margin-left: 5px;' href='javascript:productDisplay(" + pager.nextPage + ","+pager.pageSize+");'>다음 &raquo;</a>";
	    } else {
	        html += "<span class='btn btn-secondary disabled btn-sm' style='background-color: #6571FF; margin-left: 5px;'>다음 &raquo;</span>";
	    }

        // 페이지 번호 HTML 업데이트
        $(".pageNumDiv").html(html);
    }

    // 상품리스트 클릭이벤트
    $(".product_btn").click(function(){
        $(".content_body_list").empty();
        productDisplay();
    });


    //상품정보 선택 함수(update 전)
    function modify(productId) {
    	//모달창 생성
    	var back =document.querySelector(".backgroundmodal");
        back.classList.add("on"); // "on" 클래스가 없으면 추가
    	
        $.ajax({
            type:"get",
            url:"<c:url value="/inventory/product_modify_view"/>/"+productId,
            dataType:"json",
            success:function(result){
                console.log(result);
                $(".updateId").val(result.productId);
                $(".updateCode").val(result.productCategory);
                $(".updateName").val(result.productName);
                $(".updatePrice").val(result.productPrice);
                $(".updateDelivery").val(result.deliveryPrice);
            },
            error:function(xhr){
                alert("검색된 정보가 없습니다.")
            }
        });
    }
    
    //수정 모달창 끄기
    $(".updateClose").click(function(){
    	var back =document.querySelector(".backgroundmodal");
        back.classList.remove("on"); // "on" 클래스가 없으면 추가
    });

    //모달 상품정보 초기화 함수
    function modalinit(){
        $(".updateId").val("");
        $(".updateCode").val("");
        $(".updateName").val("");
        $(".updatePrice").val("");
        $(".updateDelivery").val("");
    }

    //상품정보 update 클릭 이벤트
    $("#update_btn").click(function(){
        var productId = $(".updateId").val();
        var productCategory = $(".updateCode").val();
        var productName = $(".updateName").val();
        var productPrice = $(".updatePrice").val();
        var deliveryPrice =$(".updateDelivery").val();

        $.ajax({
            type:"put",
            url:"<c:url value="/inventory/product_modify"/>",
            contentType: "application/json",
            data: JSON.stringify({"productId":productId, "productCategory":productCategory, "productName":productName, "productPrice":productPrice, "deliveryPrice":deliveryPrice}),
            dataType: "text",
            beforeSend: function(xhr) {
                // CSRF 토큰을 HTTP 요청 헤더에 추가
                xhr.setRequestHeader(csrfHeader, csrfToken);
            },
            beforeSend: function(xhr) {
                // CSRF 토큰 추가
                xhr.setRequestHeader(csrfHeader, csrfToken);
            },
            success:function(result){
                if(result == "success") {
                    var back =document.querySelector(".backgroundmodal");
   				 	back.classList.remove("on"); // "on" 클래스가 없으면 추가
                    modalinit();
                    productDisplay();
                    // 모달 창 닫기
                }
                alert("수정완료");
            },
            error:function(xhr){
                alert("상품정보가 수정되지 않았습니다.");
            }
        });
    });

    //상품 삭제 함수
    function remove(productId, pageNum) {
        if(confirm("삭제 하시겠습니까?")){
            $.ajax({
                type:"delete",
                url: "<c:url value="/inventory/product_remove"/>/"+productId,
                dataType: "text",
                beforeSend: function(xhr) {
                    // CSRF 토큰을 HTTP 요청 헤더에 추가
                    xhr.setRequestHeader(csrfHeader, csrfToken);
                },
                success: function(result){
                    if(result=="success"){
                        init();
                        //console.log(pageNum);
                        productDisplay(pageNum);
                        alert("삭제 하였습니다.");
                    }
                },
                error:function(xhr){
                    alert("이 제품은 재고창고에 존재하므로 삭제하지 못하였습니다.");
                }
            });
        }
    }

</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>