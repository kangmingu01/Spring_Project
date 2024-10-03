<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%> 
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/reset.css' />">    
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/supplier.css' />">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
          crossorigin="anonymous">
    <title>공급업체</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
</head>

<body>
  <div class="content">
    <!-- 헤더 부분 -->
    <div class="content_header">
      <div class="content_header_title">공급업체</div>
      <div class="content_header_btn">
        <!-- 조회 버튼 -->
        <div class="content_header_search_btn" onclick="submitForm('searchForm')">
          <div>
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search"
              viewBox="0 0 16 16">
              <path
                d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0" />
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

    <!-- 본문 부분 -->
    <div class="content_body">
      <!-- 공급업체 검색 부분 -->
      <form id="searchForm" action="<c:url value='/purchase/supplier/search' />" method="get" class="content_body_search" style="color: black;">
        <div>
          <div>
            <label>공급업체번호</label>
            <input type="text" id="supplierId" name="supplierId" class="search-field" value="${searchMap.supplierId}" style="background-color: #e9e9e9;" readonly/>
          </div>
          <div>
            <label>이름</label>
            <input type="text" id="supplierName" name="supplierName" class="search-field" value="${searchMap.supplierName}"/>
          </div>
          <div>
            <label>연락처</label>
            <input type="text" id="supplierPhone" name="supplierPhone" class="search-field" value="${searchMap.supplierPhone}"/>
          </div>
          <div>
            <label>이메일</label>
            <input type="text" id="supplierEmail" name="supplierEmail" class="search-field" value="${searchMap.supplierEmail}"/>            
          </div>
        </div>
      </form>

      <!-- 추가사항 태그 -->
      <div class="content_body_search_plus" style="color: black;">
        <div>공급업체 등록</div>
        <div>
          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
            class="bi bi-caret-down-fill" viewBox="0 0 16 16">
            <path
              d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z" />
          </svg>
        </div>
      </div>

      <!-- 추가정보 입력 부분 -->
      <div class="content_plus">
        <form id="registerForm" class="content_body_search" style="color: black;">      
          <div>
            <div>
                <label>이름</label>
                <input type="text" id="newSupplierName" name="supplierName" required oninput="validateFields()" />                
            </div>
            <div>
              <label>연락처</label>
              <input type="text" id="newSupplierPhone" name="supplierPhone" required oninput="validateFields()" />
            </div>
            <div>
              <label>이메일</label>
              <input type="text" id="newSupplierEmail" name="supplierEmail" required oninput="validateFields()" />
            </div>
            <button type="button" id="registerButton" onclick="registerSupplier()" disabled>완료</button>
          </div>
          <div>
          	<div id="errorMessage" style="color: red; display:none; margin-top:10px;"></div> <!-- 오류 메시지 표시 --></div>            
          </div>
         </form>
      </div>

      <!-- 테이블 부분 -->
      <div class="content_body_list">
        <table class="table table-striped">
          <thead>
            <tr>
              <th>공급업체번호</th>
              <th>이름</th>
              <th>연락처</th>
              <th>이메일</th>
              <th style="width: 100px;"></th>
            </tr>
          </thead>
          <tbody id="supplierTable" class="sty">
            <c:forEach var="supplier" items="${resultMap.supplierList}">
              <tr>
                <td>${supplier.supplierId}</td>
                <td>${supplier.supplierName}</td>
                <td>${supplier.supplierPhone}</td>
                <td>${supplier.supplierEmail}</td>
                <td>
                  <button type="button" id="editButton-${supplier.supplierId}" 
                    onclick="editSupplier('${supplier.supplierId}', '${supplier.supplierName}', '${supplier.supplierPhone}', '${supplier.supplierEmail}')">수정</button>
                </td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
        <div style="text-align: center;">
		    <c:choose>
		        <c:when test="${resultMap.pager.startPage > resultMap.pager.blockSize }">
		            <a href="<c:url value='/purchase/supplier/manage'/>?pageNum=${resultMap.pager.prevPage}&pageSize=${resultMap.pager.pageSize }&column=${searchMap.column}&keyword=${searchMap.keyword}">
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
		                <a href="<c:url value='/purchase/supplier/manage'/>?pageNum=${i}&pageSize=${resultMap.pager.pageSize }&column=${searchMap.column}&keyword=${searchMap.keyword}">
		                    [${i}]
		                </a>
		            </c:when>
		            <c:otherwise>
		                [${i}]
		            </c:otherwise>
		        </c:choose>				
		    </c:forEach>
		    
		    <c:choose>
		        <c:when test="${resultMap.pager.endPage != resultMap.pager.totalPage }">
		            <a href="<c:url value='/purchase/supplier/manage'/>?pageNum=${resultMap.pager.nextPage}&pageSize=${resultMap.pager.pageSize }&column=${searchMap.column}&keyword=${searchMap.keyword}">
		                [다음]
		            </a>
		        </c:when>
		        <c:otherwise>
		            [다음]
		        </c:otherwise>
		    </c:choose>
		</div>


<script type="text/javascript">
$(document).ajaxSend(function(event, xhr) {
    xhr.setRequestHeader($('meta[name="_csrf_header"]').attr('content'), $('meta[name="_csrf"]').attr('content'));
});

// 추가정보 클릭 시 열고 닫기 기능 구현
document.querySelector('.content_body_search_plus').addEventListener('click', function () {
    const plusSection = document.querySelector('.content_plus');
    this.classList.toggle('on');
    plusSection.classList.toggle('on');
});

// 조회 버튼 클릭 시 폼 제출
function submitForm(formId) {
    const form = $("#" + formId);
    
    // 검색 폼이 비어 있을 경우 초기화
    if (formId === 'searchForm') {
        form.find("input").each(function() {
            if ($(this).val().trim() === "") {
                $(this).val('');
            }
        });
    }
    
    form.submit(); // 검색 폼 제출
}

// 초기화 버튼 클릭 시 필드 초기화 및 전체 목록 조회
function resetForm() {
    // 검색 필드 초기화
    $(".search-field").each(function() {
        $(this).val('');
    });

    // 전체 목록 조회 위해 검색 폼 제출
    submitForm("searchForm");
}

// 공급업체 이름 중복 확인 (등록 시)
$("#newSupplierName").on("input", function() {
    validateName();
});

// 공급업체 이름 중복 확인 함수
function validateName() {
    const supplierName = $("#newSupplierName").val().trim();
    if (supplierName === "") {
        $("#errorMessage").text("").hide();
        $("#registerButton").prop("disabled", true);
        return;
    }

    $.ajax({
        url: "<c:url value='/purchase/supplier/checkName' />",
        method: "GET",
        data: { supplierName: supplierName },
        success: function(response) {
            if (response.exists) {
                $("#errorMessage").text("이미 존재하는 공급업체 이름입니다.").show();
                $("#registerButton").prop("disabled", true);
            } else {
                $("#errorMessage").hide();
                validateFields();  // 다른 필드의 유효성을 검사하여 버튼 활성화 여부 결정
            }
        },
        error: function() {
            $("#errorMessage").text("이름 중복 확인 중 오류가 발생했습니다.").show();
            $("#registerButton").prop("disabled", true);
        }
    });
}

// 등록 버튼 활성화 검사
function validateFields() {
    const name = $("#newSupplierName").val().trim();
    const phone = $("#newSupplierPhone").val().trim();
    const email = $("#newSupplierEmail").val().trim();
    const registerButton = $("#registerButton");

    let isValid = true;

    // 연락처 검증
    const phonePattern = /^[0-9-]{10,}$/;
    if (!phonePattern.test(phone)) {
        isValid = false;
    }

    // 이메일 검증
    const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailPattern.test(email)) {
        isValid = false;
    }

    // 모든 필드가 유효할 때만 버튼 활성화
    registerButton.prop("disabled", !isValid);
}

// 수정 버튼 클릭 시 해당 행의 데이터를 입력 필드에 채우기
function editSupplier(id, name, phone, email) {
    $("#supplierId").val(id).prop("readonly", true);
    $("#supplierName").val(name);
    $("#supplierPhone").val(phone);
    $("#supplierEmail").val(email);

    // 버튼 상태 변경
    $("#registerButton").text("완료");
    $("#registerButton").attr("onclick", "completeUpdate('" + id + "')");
    $("#registerButton").prop("disabled", false);
}

// 수정 완료 버튼 클릭 시
function completeUpdate(id) {
    $.ajax({
        url: "<c:url value='/purchase/supplier/modify' />",
        method: 'POST',
        data: {
            supplierId: id,
            supplierName: $('#supplierName').val(),
            supplierPhone: $('#supplierPhone').val(),
            supplierEmail: $('#supplierEmail').val()
        },
        success: function() {
            alert('수정이 완료되었습니다.');
            resetForm(); // 수정 후 필드 초기화 및 테이블 갱신
        },
        error: function(xhr) {
            alert('수정 중 오류가 발생했습니다: ' + xhr.responseText);
        }
    });
}

// 공급업체 등록 
function registerSupplier() {
    $.ajax({
        url: "<c:url value='/purchase/supplier/register' />",
        method: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({
            supplierName: $("#newSupplierName").val(),
            supplierPhone: $("#newSupplierPhone").val(),
            supplierEmail: $("#newSupplierEmail").val()
        }),
        success: function() {
            $("#errorMessage").hide();     
            resetForm(); // 등록 후 필드 초기화 및 테이블 갱신
        },
        error: function(xhr) {
            $("#errorMessage").text(xhr.responseText).show();
        }
    });
}
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
</body>
</html>



<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
</body>
</html>
