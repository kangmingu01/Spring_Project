<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%> 
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/reset.css' />">    
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/purchase.css' />">
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
       <div>
       <div></div>
          <div id="modifyerrorMessage" style="color: red; display:none; margin-top:10px;"></div> <!-- 오류 메시지 표시 -->            
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
            <button type="button" id="registerButton" onclick="registerSupplier()" disabled class="btn btn-secondary"
            style="background-color: #6571FF; font-size: 12px; width: 55px; height: 30px; margin-right: 5px;">완료</button>
          </div>
          <div>          	
          	<div id="errorMessage" style="color: red; display:none; margin-top:10px;"></div> <!-- 오류 메시지 표시 -->           
          </div>
         </form>
      </div>

      <!-- 테이블 부분 -->
      <div class="content_body_list">
        <table>
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
				  <button type="button" id="editButton-${supplier.supplierId}" class="btn btn-secondary"
				  style="background-color: #7987A1" 
				  onclick="editSupplier('${supplier.supplierId}', '${supplier.supplierName}', '${supplier.supplierPhone}', '${supplier.supplierEmail}')">
				    수정
				  </button>
				</td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
        <div style="text-align: center;" class="pagination-container text-center mt-4">
    <!-- 이전 페이지 링크 -->
    <c:choose>
        <c:when test="${resultMap.pager.startPage > resultMap.pager.blockSize}">
            <a class="btn btn-primary btn-sm" style="background-color: #6571FF" href="<c:url value='/purchase/supplier/manage'/>?pageNum=${resultMap.pager.prevPage}&pageSize=${resultMap.pager.pageSize}&supplierName=${searchMap.supplierName}&supplierPhone=${searchMap.supplierPhone}&supplierEmail=${searchMap.supplierEmail}">&laquo; 이전</a>
        </c:when>
        <c:otherwise>
            <span class="btn btn-secondary disabled btn-sm" style="background-color: #6571FF">&laquo; 이전</span>
        </c:otherwise>
    </c:choose>

    <!-- 페이지 번호 링크 반복문 -->
    <c:forEach var="i" begin="${resultMap.pager.startPage}" end="${resultMap.pager.endPage}" step="1">
        <c:choose>
            <c:when test="${resultMap.pager.pageNum != i}">
                <a href="<c:url value='/purchase/supplier/manage'/>?pageNum=${i}&pageSize=${resultMap.pager.pageSize}&supplierName=${searchMap.supplierName}&supplierPhone=${searchMap.supplierPhone}&supplierEmail=${searchMap.supplierEmail}"><span class="btn btn-outline-primary mx-1 btn-sm">${i}</span></a>
            </c:when>
            <c:otherwise>
                <span class="btn btn-primary mx-1 active btn-sm" style="background-color: #6571FF">${i}</span>
            </c:otherwise>
        </c:choose>
    </c:forEach>

    <!-- 다음 페이지 링크 -->
    <c:choose>
        <c:when test="${resultMap.pager.endPage != resultMap.pager.totalPage}">
            <a class="btn btn-primary btn-sm" style="background-color: #6571FF" href="<c:url value='/purchase/supplier/manage'/>?pageNum=${resultMap.pager.nextPage}&pageSize=${resultMap.pager.pageSize}&supplierName=${searchMap.supplierName}&supplierPhone=${searchMap.supplierPhone}&supplierEmail=${searchMap.supplierEmail}">다음 &raquo;</a>
        </c:when>
        <c:otherwise>
            <span class="btn btn-secondary disabled btn-sm" style="background-color: #6571FF">다음 &raquo;</span>
        </c:otherwise>
    </c:choose>
</div>
		</div>
		</div>
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
    $("#" + formId).submit();
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

//등록 버튼 활성화 검사
function validateFields() {
    const name = $("#newSupplierName").val().trim();
    const phone = $("#newSupplierPhone").val().trim();
    const email = $("#newSupplierEmail").val().trim();
    const registerButton = $("#registerButton");

    let isValid = true;

    // 연락처 검증: 숫자와 하이픈만 허용, 최소 10자 이상
    const phonePattern = /^[0-9-]{10,}$/;
    if (!phonePattern.test(phone)) {
        isValid = false;
    }

    // 이메일 검증: 기본 이메일 형식 체크
    const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailPattern.test(email)) {
        isValid = false;
    }

    // 모든 필드가 유효할 때만 버튼 활성화
    registerButton.prop("disabled", !isValid);
}

//수정 버튼 클릭 시 필드 채우기 및 수정 모드로 전환
function editSupplier(id, name, phone, email) {
    // 필드에 데이터 채우기
    $("#supplierId").val(id).prop("readonly", true);  // 공급업체 번호는 수정 불가
    $("#supplierName").val(name);
    $("#supplierPhone").val(phone);
    $("#supplierEmail").val(email);

    // 원래 값들을 숨겨진 필드에 저장 (이름, 연락처, 이메일)
    if (!$("#originalSupplierName").length) {
        // 숨겨진 필드가 없을 경우 동적으로 추가
        $("<input>").attr({
            type: "hidden",
            id: "originalSupplierName",
            value: name
        }).appendTo("#searchForm");
        $("<input>").attr({
            type: "hidden",
            id: "originalSupplierPhone",
            value: phone
        }).appendTo("#searchForm");
        $("<input>").attr({
            type: "hidden",
            id: "originalSupplierEmail",
            value: email
        }).appendTo("#searchForm");
    } else {
        // 숨겨진 필드가 이미 있을 경우 값 업데이트
        $("#originalSupplierName").val(name);
        $("#originalSupplierPhone").val(phone);
        $("#originalSupplierEmail").val(email);
    }

    // 현재 클릭한 수정 버튼을 완료 버튼으로 변경
    const editButton = $("#editButton-" + id);
    editButton.text("완료");
    editButton.css("background-color", "#6571FF"); 
    editButton.removeClass("btn-warning").addClass("btn-success");
    editButton.attr("id", "completeButton-" + id); // ID 변경하여 수정 완료 버튼으로 전환
    editButton.attr("onclick", "completeUpdate('" + id + "')");

    // 다른 행의 수정 버튼 비활성화
    $("button[id^='editButton-']").prop("disabled", true);
    editButton.prop("disabled", false); // 현재 수정 버튼만 활성화 유지
}

// 수정 완료 버튼 클릭 시
function completeUpdate(id) {
    const currentName = $('#supplierName').val().trim();
    const currentPhone = $('#supplierPhone').val().trim();
    const currentEmail = $('#supplierEmail').val().trim();

    const originalName = $('#originalSupplierName').val().trim();
    const originalPhone = $('#originalSupplierPhone').val().trim();
    const originalEmail = $('#originalSupplierEmail').val().trim();

    // 모든 값이 동일하면 수정 요청을 하지 않음
    if (currentName === originalName && currentPhone === originalPhone && currentEmail === originalEmail) {
    	$("#modifyerrorMessage").text("수정된 내용이 없습니다.").show();
        return;
    }

    // 이름이 변경된 경우에만 중복 확인
    if (currentName !== originalName) {
        $.ajax({
            url: "<c:url value='/purchase/supplier/checkName' />",
            method: "GET",
            data: { supplierName: currentName },
            success: function(response) {
                if (response.exists) {
                    // 이름이 중복되면 에러 메시지 출력하고 수정 취소
                    $("#modifyerrorMessage").text("이미 존재하는 공급업체 이름입니다.").show();
                } else {
                    // 이름이 중복되지 않으면 수정 요청 진행
                    modifySupplier(id);
                }
            },
            error: function() {
                $("#modifyerrorMessage").text("이름 중복 확인 중 오류가 발생했습니다.").show();
            }
        });
    } else {
        // 이름이 변경되지 않았다면 중복 검사 없이 바로 수정
        modifySupplier(id);
    }
}

// 실제 수정 요청 함수
// 수정 요청 함수도 CSRF 토큰을 설정
function modifySupplier(id) {
    $.ajax({
        url: "<c:url value='/purchase/supplier/modify' />",
        method: 'POST',
        data: {
            supplierId: id,
            supplierName: $('#supplierName').val(),
            supplierPhone: $('#supplierPhone').val(),
            supplierEmail: $('#supplierEmail').val(),
            pageNum: $("#pageNum").val(), // 현재 페이지 번호를 보냄
            pageSize: $("#pageSize").val(), // 페이지 사이즈를 보냄
            column: $("#column").val(), // 검색 컬럼을 보냄
            keyword: $("#keyword").val() // 검색 키워드를 보냄
        },
        beforeSend: function(xhr) {
            // CSRF 토큰을 헤더에 추가
            xhr.setRequestHeader($('meta[name="_csrf_header"]').attr('content'), $('meta[name="_csrf"]').attr('content'));
        },
        success: function() {
            // 수정 완료 후 현재 페이지를 리로드하여 목록을 갱신
            location.reload();
        },
        error: function(xhr) {
            $("#modifyerrorMessage").text("등록 중 오류가 발생했습니다: " + xhr.responseText).show();
        }
    });
}


// 초기화 버튼 클릭 시 필드 초기화 및 전체 목록 조회
function resetForm() {
    // 검색 필드 초기화
    $(".search-field").each(function() {
        $(this).val('');
    });

    // 전체 목록 조회 위해 검색 폼 제출
    submitForm("searchForm");

    // 수정 모드 초기화
    $("button[id^='editButton-']").prop("disabled", false); // 모든 수정 버튼 다시 활성화
    $("#registerButton").text("완료");
    $("#registerButton").prop("disabled", true);
    $("#registerButton").off('click').attr("onclick", "registerSupplier()");
}

//공급업체 등록 함수
function registerSupplier() {
    // 등록할 정보 가져오기
    const supplierName = $("#newSupplierName").val().trim();
    const supplierPhone = $("#newSupplierPhone").val().trim();
    const supplierEmail = $("#newSupplierEmail").val().trim();

    // 서버에 등록 요청
    $.ajax({
        url: "<c:url value='/purchase/supplier/register' />",
        method: "POST",
        contentType: "application/json",
        data: JSON.stringify({
            supplierName: supplierName,
            supplierPhone: supplierPhone,
            supplierEmail: supplierEmail
        }),
        beforeSend: function(xhr) {
            // CSRF 토큰을 헤더에 추가
            xhr.setRequestHeader($('meta[name="_csrf_header"]').attr('content'), $('meta[name="_csrf"]').attr('content'));
        },
        success: function(response) {
            // 등록 성공 시 테이블 갱신 및 폼 초기화          
            resetForm(); // 필드 초기화 및 목록 갱신
            fetchUpdatedSuppliers(); // 갱신된 목록을 가져옴
        },
        error: function(xhr) {
            $("#errorMessage").text("등록 중 오류가 발생했습니다: " + xhr.responseText).show();
        }
    });
}

</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
</body>
</html>
