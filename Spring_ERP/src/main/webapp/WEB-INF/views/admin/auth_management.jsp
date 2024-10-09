<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>ErpAuth</title>
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
</head>
<body>

<section>
  <div class="content d-md-flex justify-content-between pt-2 pb-2 ps-4 pe-4 align-items-center">
    <div class="title fw-bold">
      조직(부서/매장) 관리 테이블
    </div>

    <form action="<c:url value='/admin/organization'/>" method="post">
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
          <button type="submit" class="btn btn-primary text-white d-flex align-items-center">
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
    <c:out value="${resultMap.erpAuthList}"/>
    <%-- 유저 정보를 볼 수 있는 테이블 --%>
    <table class="table table-striped table-hover">
      <thead>
      <tr>
        <th scope="col" class="text-center fs-6">조직 ID</th>
        <th scope="col" class="text-center fs-6">조직 이름</th>
        <th scope="col" class="text-center fs-6">조직 유형</th>

        <th scope="col"></th>
        <th scope="col"></th>
      </tr>
      </thead>
      <c:choose>
        <c:when test="${empty resultMap.erpAuthList}">
          <tr>
            <td colspan="12" class="text-center">검색된 게시글이 없습니다</td>
          </tr>
        </c:when>
        <c:otherwise>
          <c:forEach var="erpAuth" items="${resultMap.erpAuthList}">
            <tr>
              <td class="align-middle text-center">${erpAuth.userid}</td>
              <td class="align-middle text-center">${erpAuth.auth}</td>
              <td class="align-middle text-center">${erpAuth.orgId}</td>
              <%--<td>
                <c:choose>
                  <c:when test="${erpAuth.orgType == 0 || erpAuth.orgType == 1}">
                    <button type="button" class="btn btn-secondary"
                            data-bs-toggle="modal" data-bs-target="#editOrgModal"
                            data-orgId="${erpAuth.orgId}"
                            data-orgName="${erpAuth.orgName}"
                            data-orgType="${erpAuth.orgType}"
                            data-address="${erpAuth.address}"
                            data-phoneNumber="${erpAuth.phoneNumber}"
                            data-created="${erpAuth.created}">
                      수정
                    </button>
                  </c:when>


                  <c:otherwise>
                    <button type="submit" class="btn btn-secondary disabled">
                      수정
                    </button>
                  </c:otherwise>
                </c:choose>
              </td>
              <td>
                <form action="<c:url value="/admin/deleteOrg"/>" method="post">
                  <input type="hidden" name="orgId" value="${erpAuth.orgId}">

                  <c:choose>
                    <c:when test="${erpAuth.orgType == 0}">
                      <button type="submit" class="btn btn-danger"
                              onclick="return confirm('해당 부서[${erpAuth.orgName}]를 정말 삭제하시겠습니까?')">삭제
                      </button>
                    </c:when>
                    <c:when test="${erpAuth.orgType == 1}">
                      <button type="submit" class="btn btn-danger"
                              onclick="return confirm('해당 매장[${erpAuth.orgName}]를 폐업 처리 하시겠습니까?')">삭제
                      </button>
                    </c:when>
                    <c:otherwise>
                      <button type="submit" class="btn btn-danger disabled">
                        삭제
                      </button>
                    </c:otherwise>
                  </c:choose>

                  <sec:csrfInput/>
                </form>
              </td>--%>
            </tr>
          </c:forEach>
        </c:otherwise>
      </c:choose>
    </table>
  </div>
  <!-- 모달 -->
  <div class="modal fade" id="editOrgModal" tabindex="-1" aria-labelledby="editOrgModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="editOrgModalLabel">조직 정보 수정</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <form id="editOrgForm" action="<c:url value="/admin/updateOrg"/>" method="post">
          <div class="modal-body">
            <div class="mb-3">
              <label for="orgName_modal" class="form-label">조직 이름</label>
              <input type="text" class="form-control" id="orgName_modal" name="orgName">
            </div>
            <div class="mb-3">
              <label for="orgId_modal" class="form-label">조직 ID</label>
              <input type="text" class="form-control" id="orgId_modal" name="orgId" disabled>
            </div>

            <div class="mb-3">
              <label for="orgType_modal" class="form-label">조직 유형</label>
              <select class="form-select" id="orgType_modal" name="orgType" disabled>
                <option value="0">부서</option>
                <option value="1">매장</option>
                <option value="9">부서 폐지/폐업</option>
              </select>
            </div>
            <div class="mb-3">
              <label for="address_modal" class="form-label">주소</label>
              <input type="text" class="form-control" id="address_modal" name="address">
            </div>
            <div class="mb-3">
              <label for="phoneNumber_modal" class="form-label">조직 전화번호</label>
              <input type="text" class="form-control" id="phoneNumber_modal" name="phoneNumber" disabled>
            </div>
            <sec:csrfInput/>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
            <button type="submit" class="btn btn-primary" onclick="submitEditForm()">저장</button>
          </div>
        </form>
      </div>
    </div>
  </div>
  <div class="pagination-container text-center mt-4">
    <c:choose>
      <c:when test="${resultMap.pager.pageNum > 1}">
        <a class="btn btn-primary"
           href="<c:url value='/admin/organization'/>?pageNum=${resultMap.pager.pageNum - 1}&pageSize=${resultMap.pager.pageSize}&column=${searchMap.column}&keyword=${searchMap.keyword}">
          &laquo; 이전
        </a>
      </c:when>
      <c:otherwise>
      <span class="btn btn-secondary disabled">
        &laquo; 이전
      </span>
      </c:otherwise>
    </c:choose>

    <c:forEach var="i" begin="${resultMap.pager.startPage}" end="${resultMap.pager.endPage}" step="1">
      <c:choose>
        <c:when test="${resultMap.pager.pageNum == i}">
        <span class="btn btn-primary mx-1 active">
            ${i}
        </span>
        </c:when>
        <c:otherwise>
          <a class="btn btn-outline-primary mx-1"
             href="<c:url value='/admin/organization'/>?pageNum=${i}&pageSize=${resultMap.pager.pageSize}&column=${searchMap.column}&keyword=${searchMap.keyword}">
              ${i}
          </a>
        </c:otherwise>
      </c:choose>
    </c:forEach>

    <c:choose>
      <c:when test="${resultMap.pager.pageNum < resultMap.pager.totalPage}">
        <a class="btn btn-primary"
           href="<c:url value='/admin/organization'/>?pageNum=${resultMap.pager.pageNum + 1}&pageSize=${resultMap.pager.pageSize}&column=${searchMap.column}&keyword=${searchMap.keyword}">
          다음 &raquo;
        </a>
      </c:when>
      <c:otherwise>
      <span class="btn btn-secondary disabled">
        다음 &raquo;
      </span>
      </c:otherwise>
    </c:choose>
  </div>
</section>
<script src="<c:url value="/js/jquery-3.7.1.min.js"/>"></script>
<script>

</script>

</body>
</html>
