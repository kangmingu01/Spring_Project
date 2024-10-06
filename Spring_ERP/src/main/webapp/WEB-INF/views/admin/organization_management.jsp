<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
  <title>organization</title>
  <style>
    .content {
      background-color: #6571ff;
      color: white;
    }

    .title {
      font-size: 18px;
    }

    .content > button:hover {
      background-color: #7782f8;
    }

    .error {
      color: red;
      display: none;
      visibility: hidden;
      height: 1.2em;
    }

    .is-invalid {
      border-color: red;
    <%-- 오류 발생 시 테두리 색상 --%> animation: shake 0.5s;
    <%-- 흔들림 애니메이션 --%>
    }

    @keyframes shake {
      0% {
        transform: translateX(0);
      }
      25% {
        transform: translateX(-5px);
      }
      50% {
        transform: translateX(5px);
      }
      75% {
        transform: translateX(-5px);
      }
      100% {
        transform: translateX(0);
      }
    }

    th, td {
      font-weight: 500;
    }


    .disabled {
      transition: background-color 0.5s ease, color 0.3s ease;
      background-color: #6c757d;
      color: white;
    }
  </style>

  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>


<section>
  <div class="content d-md-flex justify-content-between pt-2 pb-2 ps-4 pe-4 align-items-center">
    <div class="title fw-bold">
      조직(부서/매장) 관리 테이블
    </div>

    <form id="searchForm">
      <div class="row g-2 align-items-center">
        <div class="col-4">
          <select name="column" class="form-select">
            <option value="org_name" selected>조직 이름</option>
            <option value="org_id">조직 ID</option>
            <option value="address">주소</option>
          </select>
        </div>
        <div class="col-5">
          <input type="text" class="form-control" name="keyword" placeholder="검색어를 입력하세요">
        </div>
        <div class="col-3 d-flex justify-content-end">
          <button type="button" id="searchButton" class="btn btn-primary text-white d-flex align-items-center">
            <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor"
                 class="bi bi-search" viewBox="0 0 16 16">
              <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
            </svg>
            <span class="ms-2 text-nowrap">조회</span>
          </button>
        </div>
      </div>
      <sec:csrfInput/>
    </form>

  </div>
  <div style="overflow-x: auto">
    <%-- 값 넘어오는지 테스트 --%>
    <%--<c:out value="${resultMap.organizationList}"/>--%>
    <%-- 유저 정보를 볼 수 있는 테이블 --%>
    <table class="table table-striped table-hover">
      <thead>
      <tr>
        <th scope="col" class="text-center fs-6">조직 ID</th>
        <th scope="col" class="text-center fs-6">조직 이름</th>
        <th scope="col" class="text-center fs-6">조직 유형</th>
        <th scope="col" class="text-center fs-6">주소</th>
        <th scope="col" class="text-center fs-6">전화번호</th>
        <th scope="col" class="text-center fs-6">생성일</th>
        <th scope="col"></th>
        <th scope="col"></th>
      </tr>
      </thead>
      <tbody id="organizationList"></tbody>
    </table>
  </div>
  <div id="pagination-container" class="pagination-container text-center mt-4"></div>
</section>

<script>
  $(document).ready(function() {
    // 초기 페이지 로딩 (GET 요청 사용)
    loadInitialOrganizationList({
      "pageNum": 1,
      "pageSize": 10,
      "orgType": 0
    });

    // 검색 버튼 클릭 시 AJAX 호출 (POST 요청 사용)
    $('#searchButton').click(function() {
      var formData = $('#searchForm').serializeArray();
      var params = {
        "pageNum": 1,
        "pageSize": 10
      };

      // 폼 데이터를 params 객체에 추가
      $.each(formData, function() {
        params[this.name] = this.value;
      });

      // 검색 결과 로드 (POST 방식)
      searchOrganizationList(params);
    });
  });

  // 초기 데이터 로드 (GET 방식)
  function loadInitialOrganizationList(params) {
    $.ajax({
      url: '/api/organization/list', // GET 방식으로 데이터를 가져오기 위한 엔드포인트
      type: 'GET',
      data: params,
      dataType: 'json',
      success: function(result) {
        renderOrganizationList(result);
      },
      error: function(error) {
        console.error('데이터를 불러오는 중 오류가 발생했습니다.', error);
      }
    });
  }

  // 검색을 위한 데이터 로드 (POST 방식)
  function searchOrganizationList(params) {
    $.ajax({
      url: '/api/organization/list', // 검색을 위한 엔드포인트
      type: 'POST',
      data: params,
      dataType: 'json',
      success: function(result) {
        renderOrganizationList(result);
      },
      error: function(error) {
        console.error('데이터를 불러오는 중 오류가 발생했습니다.', error);
      }
    });
  }

  // 조직 목록을 렌더링하는 함수
  function renderOrganizationList(result) {
    var html = '';

    // 검색 결과 처리
    if (result.organizationList.length === 0) {
      html += '<tr><td colspan="8" class="text-center">검색된 게시글이 없습니다</td></tr>';
    } else {
      $(result.organizationList).each(function() {
        let orgTypeHtml = '';

        if (this.orgType === 0) {
          orgTypeHtml = '<span class="text-primary">본사</span>';
        } else if (this.orgType === 1) {
          orgTypeHtml = '<span class="text-warning">매장</span>';
        } else if (this.orgType === 9) {
          orgTypeHtml = '<span class="text-danger">사라짐</span>';
        }

        // JavaScript 형식으로 날짜 쪼갬
        let createdDate = new Date(this.created);
        let formattedDate = isNaN(createdDate) ? '' : createdDate.toISOString().split('T')[0];

        html += '<tr>';
        html += '<td class="align-middle text-center">' + this.orgId + '</td>';
        html += '<td class="align-middle text-center">' + this.orgName + '</td>';
        html += '<td class="align-middle text-center">' + orgTypeHtml + '</td>';
        html += '<td class="align-middle text-center">' + (this.address || '') + '</td>';
        html += '<td class="align-middle text-center">' + this.phoneNumber + '</td>';
        html += '<td class="align-middle text-center">' + formattedDate + '</td>';
        html += '<td class="align-middle text-center">' +
                '<button type="button" class="btn btn-secondary" ' +
                'data-bs-toggle="modal" data-bs-target="#editUserModal" ' +
                'data-userid="' + this.orgId + '" ' +
                'data-name="' + this.orgName + '" ' +
                'data-phone="' + this.phoneNumber + '" ' +
                'data-address="' + this.address + '">' +
                '수정' +
                '</button>' +
                '</td>';

        let deleteConfirmHtml = '';
        if (this.orgType === 0) {
          deleteConfirmHtml = '정말로 해당 부서[' + this.orgName + ']를 삭제하시겠습니까?';
        } else if (this.orgType === 1) {
          deleteConfirmHtml = '정말로 해당 매장[' + this.orgName + ']을 폐업처리 하시겠습니까?';
        }

        html += '<td class="align-middle text-center">' +
                '<form action="/admin/deleteOrg" method="post" onsubmit="return confirm(\'' + deleteConfirmHtml + '\')">' +
                '<input type="hidden" name="orgId" value="' + this.orgId + '">' +
                '<button type="submit" class="btn btn-danger">삭제</button>' +
                '<input type="hidden" name="_csrf" value="' + csrfToken + '">' +
                '</form>' +
                '</td>';
        html += '</tr>';
      });
    }
    $("#organizationList").html(html);
  }
</script>
</body>
</html>
