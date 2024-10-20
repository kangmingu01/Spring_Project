<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!-- partial:partials/_sidebar.html -->
<nav class="sidebar">
    <div class="sidebar-header">
        <a href="<c:url value="/"/>" class="text-decoration-none sidebar-brand">KREAM</a>
        <div class="sidebar-toggler">
            <span></span>
            <span></span>
            <span></span>
        </div>
    </div>
    <div class="sidebar-body">
        <ul class="nav" id="sidebarNav">
            <li class="nav-item nav-category">Main</li>
            <li class="nav-item">
                <a href="<c:url value="/main"/>" class="nav-link">
                    <i class="link-icon" data-feather="box"></i>
                    <span class="link-title">대시보드</span>
                </a>
            </li>
            <li class="nav-item nav-category">apps</li>

            <%-- 관리자 부분 --%>
            <li class="nav-item">
                <a
                        class="nav-link"
                        data-bs-toggle="collapse"
                        href="#adminSidebar"
                        role="button"
                        aria-expanded="false"
                        aria-controls="adminSidebar"
                >
                    <%--<i class="link-icon" data-feather="mail"></i>--%>
                    <i class="fa-solid fa-shield-halved link-icon" style="color: #000000;"></i>
                    <span class="link-title">관리</span>
                    <i class="link-arrow" data-feather="chevron-down"></i>
                </a>
                <div class="collapse" data-bs-parent="#sidebarNav" id="adminSidebar">
                    <ul class="nav sub-menu">
                        <li class="nav-item">
                            <a href="<c:url value="/admin/user"/>" class="nav-link">유저 관리</a>
                        </li>
                        <li class="nav-item">
                            <a href="<c:url value="/admin/auth"/>" class="nav-link">권한 관리</a>
                        </li>
                        <li class="nav-item">
                            <a href="<c:url value="/admin/organization"/>" class="nav-link">부서/매장 관리</a>
                        </li>
                    </ul>
                </div>
            </li>
            <%--
            <%-- 구매팀 부분 --%>
            <li class="nav-item">
                <a
                        class="nav-link"
                        data-bs-toggle="collapse"
                        href="#orderingSidebar"
                        role="button"
                        aria-expanded="false"
                        aria-controls="orderingSidebar">
                    <i class="fa-solid fa-sack-dollar link-icon" style="color: #000000;"></i>
                    <span class="link-title">구매팀</span>
                    <i class="link-arrow" data-feather="chevron-down"></i>
                </a>
                <div class="collapse" data-bs-parent="#sidebarNav" id="orderingSidebar">
                    <ul class="nav sub-menu">
                        <li class="nav-item">
                            <a href="<c:url value="/purchase/supplier/manage"/>" class="nav-link">공급업체 관리</a>
                        </li>
                        <li class="nav-item">
                            <a href="<c:url value="/purchase/orders/register"/>" class="nav-link">발주 등록</a>
                        </li>
                        <li class="nav-item">
                            <a href="<c:url value="/purchase/orders/list"/>" class="nav-link">발주 관리</a>
                        </li>
                        <li class="nav-item">
                            <a href="<c:url value="/purchase/receiving/register"/>" class="nav-link">입고 등록</a>
                        </li>
                        <li class="nav-item">
                            <a href="<c:url value="/purchase/receiving/list"/>" class="nav-link">입고 관리</a>
                        </li>
                    </ul>
                </div>
            </li>

            <%-- 재고팀 부분 --%>
            <li class="nav-item">
                <a
                        class="nav-link"
                        data-bs-toggle="collapse"
                        href="#inventorySidebar"
                        role="button"
                        aria-expanded="false"
                        aria-controls="inventorySidebar">
                    <i class="fa-solid fa-cube link-icon" style="color: #000000;"></i>
                    <span class="link-title">재고팀</span>
                    <i class="link-arrow" data-feather="chevron-down"></i>
                </a>
                <div class="collapse" data-bs-parent="#sidebarNav" id="inventorySidebar">
                    <ul class="nav sub-menu">
                        <li class="nav-item">
                            <a href="<c:url value="/inventory/register"/>" class="nav-link">상품/창고 등록</a>
                        </li>
                        <li class="nav-item">
                            <a href="<c:url value="/inventory/list"/>" class="nav-link">재고 관리</a>
                        </li>
                        <li class="nav-item">
                            <a href="<c:url value="/inventory/history"/>" class="nav-link">출입고 관리</a>
                        </li>
                    </ul>
                </div>
            </li>
        </ul>
    </div>
</nav>