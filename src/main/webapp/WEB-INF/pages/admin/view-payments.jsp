<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="header.jsp" %>
<%@ include file="admin-navbar.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View Payments | NPL</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap');

        body {
            margin: 0;
            padding: 0;
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(to right, white 20%, #bfa2d1 80%);
            color: #2e2e2e;
        }

        .content-wrapper {
            margin-left: 250px;
            padding: 30px;
            min-height: 100vh;
            background-color: #f9f8ff;
        }

        .page-title-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .page-title {
            font-size: 26px;
            font-weight: 600;
            color: #5a2ebc;
        }

        .search-container {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .search-bar {
            padding: 8px 15px;
            font-size: 15px;
            border: 1px solid #ccc;
            border-radius: 8px;
            width: 300px;
            transition: 0.2s;
        }

        .search-bar:focus {
            border-color: #6c47d9;
            outline: none;
        }

        .pagination-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }

        .rows-per-page {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .rows-per-page label {
            font-size: 15px;
            color: #4a2fb3;
        }

        .rows-per-page select {
            padding: 6px 10px;
            font-size: 15px;
            border: 1px solid #ccc;
            border-radius: 8px;
            cursor: pointer;
        }

        .pagination {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .pagination a {
            padding: 8px 15px;
            font-size: 15px;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            background-color: #5a2ebc;
            color: white;
            text-decoration: none;
        }

        .pagination a:hover {
            background-color: #4725a1;
        }

        .pagination .disabled {
            background-color: #ccc;
            cursor: not-allowed;
        }

        .pagination span {
            font-size: 15px;
            color: #4a2fb3;
        }

        .payment-table {
            width: 100%;
            border-collapse: collapse;
            background-color: #fff;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }

        .payment-table th, .payment-table td {
            padding: 16px;
            text-align: left;
            border-bottom: 1px solid #f0f0f0;
            font-size: 15px;
        }

        .payment-table th {
            background-color: #edeaff;
            color: #4a2fb3;
            font-weight: 600;
        }

        .payment-table tr:nth-child(even) {
            background-color: #f9f8ff;
        }

        .payment-table tr:hover {
            background-color: #f3f3ff;
        }

        @media (max-width: 768px) {
            .content-wrapper {
                margin-left: 0;
                padding: 100px 15px;
            }

            .page-title-container {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }

            .search-container {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }

            .search-bar {
                width: 100%;
            }

            .pagination-container {
                flex-direction: column;
                align-items: center;
                gap: 10px;
            }

            .rows-per-page {
                justify-content: center;
            }

            .payment-table th, .payment-table td {
                font-size: 14px;
            }

            .pagination a {
                padding: 6px 12px;
                font-size: 14px;
            }

            .pagination span {
                font-size: 14px;
            }
        }
    </style>
</head>
<body>
<div class="content-wrapper">
    <div class="page-title-container">
        <div class="page-title">Payment Records</div>
        <div class="search-container">
            <form id="searchForm" action="${pageContext.request.contextPath}/admin/view-payments" method="get">
                <input type="hidden" name="page" value="1">
                <input type="hidden" name="rowsPerPage" value="${rowsPerPage}">
                <div style="display: flex; gap: 10px;">
                    <input type="text" name="search" id="searchInput" class="search-bar" placeholder="Search by ID or Status" value="${param.search}">
                    <button type="submit" style="padding: 8px 15px; font-size: 15px; border-radius: 8px; border: none; cursor: pointer; background-color: #5a2ebc; color: white;">Search</button>
                </div>
            </form>
        </div>
    </div>

    <div class="pagination-container">
        <div class="rows-per-page">
            <label for="rowsPerPage">Rows per page:</label>
            <form id="rowsPerPageForm" action="${pageContext.request.contextPath}/admin/view-payments" method="get">
                <input type="hidden" name="page" value="1">
                <input type="hidden" name="search" value="${param.search}">
                <select name="rowsPerPage" id="rowsPerPage" onchange="this.form.submit()">
                    <option value="5" ${rowsPerPage == 5 ? 'selected' : ''}>5</option>
                    <option value="10" ${rowsPerPage == 10 ? 'selected' : ''}>10</option>
                    <option value="20" ${rowsPerPage == 20 ? 'selected' : ''}>20</option>
                </select>
            </form>
        </div>
        <div class="pagination">
            <c:if test="${currentPage > 1}">
                <a href="${pageContext.request.contextPath}/admin/view-payments?page=${currentPage - 1}&rowsPerPage=${rowsPerPage}&search=${param.search}">Previous</a>
            </c:if>
            <span>Page ${currentPage} of ${totalPages}</span>
            <c:if test="${currentPage < totalPages}">
                <a href="${pageContext.request.contextPath}/admin/view-payments?page=${currentPage + 1}&rowsPerPage=${rowsPerPage}&search=${param.search}">Next</a>
            </c:if>
            <c:if test="${currentPage >= totalPages}">
                <a href="#" class="disabled">Next</a>
            </c:if>
        </div>
    </div>

    <table class="payment-table">
        <thead>
            <tr>
                <th>Payment ID</th>
                <th>Match</th>
                <th>User Name</th>
                <th>Amount (Rs.)</th>
                <th>Payment Status</th>
                <th>Payment Date</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${not empty payments}">
                    <c:forEach var="payment" items="${payments}">
                        <tr>
                            <td>${payment.paymentId}</td>
                            <td>${payment.matchDetails}</td>
                            <td>${payment.userFullName}</td>
                            <td>${payment.amount}</td>
                            <td>${payment.paymentStatus}</td>
                            <td>${payment.paymentDate}</td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr><td colspan="6">No payments found.</td></tr>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>
</div>

<script>
    // Synchronize rows per page with search form
    document.getElementById('rowsPerPage').addEventListener('change', function() {
        document.querySelector('#searchForm input[name="rowsPerPage"]').value = this.value;
        document.getElementById('rowsPerPageForm').submit();
    });

    // Focus on search bar when page loads
    window.onload = function() {
        document.getElementById('searchInput').focus();
    };
</script>