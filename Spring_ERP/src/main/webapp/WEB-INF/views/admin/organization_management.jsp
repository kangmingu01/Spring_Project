<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
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
      <c:choose>
        <c:when test="${empty resultMap.organizationList}">
          <tr>
            <td colspan="12" class="text-center">검색된 게시글이 없습니다</td>
          </tr>
        </c:when>
        <c:otherwise>
          <c:forEach var="organization" items="${resultMap.organizationList}">
            <tr>
              <td class="align-middle text-center">${organization.orgId}</td>
              <td class="align-middle text-center">${organization.orgName}</td>
              <td class="align-middle text-center">
                <c:choose>
                  <c:when test="${organization.orgType == 0}">
                    <span class="text-primary">본사</span>
                  </c:when>
                  <c:when test="${organization.orgType == 1}">
                    <span class="text-warning">매장</span>
                  </c:when>
                  <c:when test="${organization.orgType == 9}">
                    <span class="text-danger">사라짐</span>
                  </c:when>
                </c:choose>
              </td>
              <td class="align-middle text-center">${organization.address}</td>
              <td class="align-middle text-center">${organization.phoneNumber}</td>
              <td class="align-middle text-center">
                  <%-- JSTL fmt를 이용해 날짜 자름 --%>
                <fmt:formatDate value="${organization.created}" pattern="yyyy-MM-dd" />
              </td>
                <%--<td class="align-middle">
                    <c:choose>
                        <c:when test="${erpUser.gender == 1}">
                            남자
                        </c:when>
                        <c:otherwise>
                            여자
                        </c:otherwise>
                    </c:choose>

                </td>
                <td class="align-middle">${organization.created}</td>
                <td class="align-middle">${organization.joindate}</td>
                <td class="text-center align-middle">
                    <c:choose>
                        <c:when test="${organization.enabled == 0}">
                            <p class="text-danger">비활성화</p>
                        </c:when>
                        <c:otherwise>
                            <p class="text-primary">활성화</p>
                        </c:otherwise>
                    </c:choose>

                </td>
                <td class="text-center align-middle">${organization.orgId}</td>--%>
              <td>
                <button type="button" class="btn btn-secondary"
                        data-bs-toggle="modal" data-bs-target="#editUserModal"
                        data-userid="${erpUser.userid}"
                        data-name="${erpUser.name}"
                        data-phone="${erpUser.phone}"
                        data-address="${erpUser.address}"
                        data-email="${erpUser.email}"
                        data-gender="${erpUser.gender}"
                        data-birthday="${erpUser.birthday}"
                        data-joindate="${erpUser.joindate}"
                        data-enabled="${erpUser.enabled}"
                        data-orgid="${erpUser.orgId}">
                  수정
                </button>
              </td>
              <td>
                <form action="<c:url value="/admin/deleteOrg"/>" method="post">
                  <input type="hidden" name="orgId" value="${organization.orgId}">
                  <button type="submit" class="btn btn-danger"
                          <c:choose>
                            <c:when test="${organization.orgType == 0}">
                              onclick="return confirm('해당 부서[${organization.orgName}]를 정말 삭제하시겠습니까?')">삭제
                            </c:when>
                            <c:when test="${organization.orgType == 1}">
                              onclick="return confirm('해당 매장[${organization.orgName}]를 폐업 처리 하시겠습니까?')">삭제
                            </c:when>
                          </c:choose>
                  </button>
                  <sec:csrfInput/>
                </form>
              </td>
            </tr>
          </c:forEach>
        </c:otherwise>
      </c:choose>
    </table>
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
</body>
</html>
