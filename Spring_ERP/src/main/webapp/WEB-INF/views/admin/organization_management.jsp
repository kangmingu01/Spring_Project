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
<main class="bg-light pb-1px">
    <div class="content d-flex justify-content-between pt-2 pb-2 ps-4 pe-4 align-items-center">
        <div class="title fw-bold">
            조직 추가
        </div>
        <div class="d-flex">
            <div class="btn text-white" onclick="resetForm()">
                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor"
                     class="bi bi-arrow-clockwise" viewBox="0 0 16 16">
                    <path fill-rule="evenodd" d="M8 3a5 5 0 1 0 4.546 2.914.5.5 0 0 1 .908-.417A6 6 0 1 1 8 2z"/>
                    <path d="M8 4.466V.534a.25.25 0 0 1 .41-.192l2.36 1.966c.12.1.12.284 0 .384L8.41 4.658A.25.25 0 0 1 8 4.466"/>
                </svg>
                <span>초기화</span>
            </div>
        </div>
    </div>

    <%-- 조직 관리 폼 --%>
    <div class="">
        <div class="m-1 p-2 border rounded bg-white">
            <form action="<c:url value="/admin/addOrganization"/>" id="orgForm" method="post">
                <div class="row mb-3">
                    <!-- 조직 ID -->
                    <div class="col-md-4">
                        <label for="orgPrefix" class="form-label">조직 ID</label>
                        <select class="form-select" id="orgPrefix" name="orgPrefix" onchange="setOrgType()">
                            <option value="DEP">부서</option>
                            <option value="STORE">매장</option>
                        </select>
                    </div>
                    <!-- 조직이름 -->
                    <div class="col-md-4">
                        <label for="orgName" class="form-label">조직 이름</label>
                        <div class="d-flex form-control-position">
                            <input type="text" class="form-control" id="orgName" name="orgName">
                        </div>
                        <div id="orgMsg" class="error">조직 이름 입력해주세요</div>
                        <div id="orgRegMsg" class="error">조직 이름은 한글로만 가능합니다.</div>
                    </div>
                    <%-- 조직 타입: 조직 이름 선택시 자동으로 값 들어감 --%>
                    <input type="hidden" name="orgType" id="orgType" value="0">

                    <!-- 주소 -->
                    <div class="col-md-4">
                        <label for="address" class="form-label">주소</label>
                        <input type="text" class="form-control" id="address" name="address">
                        <div id="addressMsg" class="error">주소를 입력해 주세요. 본사라면 [본사]라고 적어주세요</div>
                        <%-- 주소 입력 오류 메시지 --%>
                    </div>
                </div>
                <div class="row mb-3">
                    <div class="col-md-4">
                        <label for="area" class="form-label">지역</label>
                        <div class="d-flex input-group">
                            <select class="form-select" id="area" name="area">
                                <option value="02" selected>서울</option>
                                <option value="031">경기</option>
                                <option value="032">인천</option>
                                <option value="033">강원</option>
                                <option value="041">충남</option>
                                <option value="042">대전</option>
                                <option value="043">충북</option>
                                <option value="051">부산</option>
                                <option value="052">울산</option>
                                <option value="053">대구</option>
                                <option value="054">경북</option>
                                <option value="055">경남</option>
                                <option value="061">전남</option>
                                <option value="062">광주</option>
                                <option value="063">전북</option>
                                <option value="064">제주</option>
                            </select>
                        </div>
                    </div>

                    <!-- 전화번호 -->
                    <div class="col-md-4">
                        <label for="startNum" class="form-label">조직 전화번호</label>
                        <div class="input-group">
                            <input type="tel" class="form-control" id="startNum" name="startNum" value="02" readonly>
                            <input type="tel" class="form-control" id="middleNum" name="middleNum" maxlength="4"
                                   pattern="[0-9]{3,4}">
                            <input type="tel" class="form-control" id="endNum" name="endNum" maxlength="4"
                                   pattern="[0-9]{4}">
                        </div>
                        <div id="phoneMsg" class="error">전화번호를 입력해 주세요.</div>
                        <div id="phoneMiddleMsg" class="error">중간 전화번호는 3~4자리만 입력 가능합니다.</div>
                        <div id="phoneEndMsg" class="error">마지막 전화번호는 4자리만 입력 가능합니다.</div>
                    </div>
                </div>
                <div class="text-end">
                    <button type="submit" class="btn btn-primary">조직 생성</button>
                </div>
                <sec:csrfInput/>
            </form>
        </div>
    </div>
</main>
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
                                        <c:choose>
                                            <c:when test="${isDepartment}">
                                                <span class="text-danger">부서 폐지</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-danger">매장 폐업</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:when>
                                </c:choose>
                            </td>
                            <td class="align-middle text-center">${organization.address}</td>
                            <td class="align-middle text-center">${organization.phoneNumber}</td>
                            <td class="align-middle text-center">
                                    <%-- JSTL fmt를 이용해 날짜 자름 --%>
                                <fmt:formatDate value="${organization.created}" pattern="yyyy-MM-dd"/>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${}">
                                        <button type="button" class="btn btn-secondary"
                                                data-bs-toggle="modal" data-bs-target="#editOrgModal"
                                                data-orgId="${organization.orgId}"
                                                data-orgName="${organization.orgName}"
                                                data-orgType="${organization.orgType}"
                                                data-address="${organization.address}"
                                                data-phoneNumber="${organization.phoneNumber}"
                                                data-created="${organization.created}">
                                            수정
                                        </button>
                                    </c:when>


                                <c:otherwise>
                                    <button type="submit" class="btn btn-danger disabled">
                                        삭제
                                    </button>
                                </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <form action="<c:url value="/admin/deleteOrg"/>" method="post">
                                    <input type="hidden" name="orgId" value="${organization.orgId}">

                                            <c:choose>
                                                <c:when test="${organization.orgType == 0}">
                                    <button type="submit" class="btn btn-danger"
                                                    onclick="return confirm('해당 부서[${organization.orgName}]를 정말 삭제하시겠습니까?')">삭제
                                    </button>
                                                </c:when>
                                                <c:when test="${organization.orgType == 1}">
                                                    <button type="submit" class="btn btn-danger"
                                                    onclick="return confirm('해당 매장[${organization.orgName}]를 폐업 처리 하시겠습니까?')">삭제
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
                            </td>
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
                <form id="editOrgForm" action="<c:url value="/admin/updateUser"/>" method="post">
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

    function resetForm() {
        document.getElementById("orgForm").reset();

        /* 모든 에러 메세지 숨김 */
        $(".error").css("display", "none").css("visibility", "hidden");
        $("#orgName").removeClass("is-invalid");
        $("#middleNum").removeClass("is-invalid");
        $("#endNum").removeClass("is-invalid");
    }

    /* 부서 선택 시 orgType의 값을 자동으로 들어갈 수 있도록 하는 함수 */
    function setOrgType() {
        const orgPrefix = document.getElementById("orgPrefix").value;
        const orgType = document.getElementById("orgType");

        if (orgPrefix === "DEP") {
            orgType.value = 0;
        } else if (orgPrefix === "STORE") {
            orgType.value = 1;
        }
    }

    const areaSelect = document.getElementById('area');
    const startNumInput = document.getElementById('startNum');

    areaSelect.addEventListener('change', function () {
        startNumInput.value = areaSelect.value;
    });

    function setAreaNum() {
        const areaNum = document.getElementById("areaNum").value;
        const startNum = document.getElementById("startNum");
    }

    document.getElementById('middleNum').addEventListener('input', function () {
        if (this.value.length >= 4) {
            document.getElementById('endNum').focus();
        }
    });

    document.getElementById('endNum').addEventListener('input', function () {
        if (this.value.length > 4) {
            this.value = this.value.slice(0, 4);  // 최대 4자리로 제한
        }
    });

    /* 한글만 입력 검증 */
    const orgReg = /^[가-힣]+$/;

    $("#orgForm").submit(function (e) {
        /*e.preventDefault();*/
        /* 제출 여부 확인 */
        var submitResult = true;

        /* 모든 에러 메세지 숨김 */
        $(".error").css("display", "none").css("visibility", "hidden").removeClass("is-invalid");
        $("#orgName").removeClass("is-invalid");
        $("#address").removeClass("is-invalid");
        $("#middleNum").removeClass("is-invalid");
        $("#endNum").removeClass("is-invalid");
        if ($("#orgName").val() == "") {
            $("#orgMsg").css("display", "block").css("visibility", "visible");
            $("#orgName").addClass("is-invalid");
            submitResult = false;
        } else if (!orgReg.test($("#orgName").val())) {
            $("#orgRegMsg").css("display", "block").css("visibility", "visible");
            $("#orgName").addClass("is-invalid");
            submitResult = false;
        }

        if ($("#address").val() == "") {
            $("#addressMsg").css("display", "block").css("visibility", "visible");
            $("#address").addClass("is-invalid");
            submitResult = false;
        }

        if ($("#middleNum").val() == "" || $("#endNum").val() == "") {
            $("#phoneMsg").css("display", "block").css("visibility", "visible");
            if ($("#middleNum").val() == "") {
                $("#middleNum").addClass("is-invalid");
            }
            if ($("#endNum").val() == "") {
                $("#endNum").addClass("is-invalid");
            }
            submitResult = false;
        } else if ($("#middleNum").val().length < 3) {
            $("#phoneMiddleMsg").css("display", "block").css("visibility", "visible");
            $("#middleNum").addClass("is-invalid");
            submitResult = false;
        } else if ($("#endNum").val().length < 4) {
            $("#phoneEndMsg").css("display", "block").css("visibility", "visible");
            $("#endNum").addClass("is-invalid");
            submitResult = false;
        }

        console.log($("#orgPrefix").val());
        console.log($("#orgName").val());
        console.log($("#orgType").val());
        console.log($("#address").val());
        console.log($("#startNum").val());
        console.log($("#middleNum").val());
        console.log($("#endNum").val());
        console.log("==============================");


        return submitResult;
    });

    /* 모달창 열릴 때 값 들어갈 수 있게 */
    document.addEventListener('DOMContentLoaded', function () {
        var editOrgModal = document.getElementById('editOrgModal');

        editOrgModal.addEventListener('show.bs.modal', function (event) {
            // 버튼에서 데이터 가져오기
            var button = event.relatedTarget;
            var orgId = button.getAttribute('data-orgId');
            var orgName = button.getAttribute('data-orgName');
            var orgType = button.getAttribute('data-orgType');
            var address = button.getAttribute('data-address');
            var phoneNumber = button.getAttribute('data-phoneNumber');


            // 모달 내 입력 필드에 값을 설정
            document.getElementById('orgId_modal').value = orgId;
            document.getElementById('orgName_modal').value = orgName;
            document.getElementById('orgType_modal').value = orgType;
            document.getElementById('address_modal').value = address;
            document.getElementById('phoneNumber_modal').value = phoneNumber;

        });
    });

</script>
</body>
</html>
