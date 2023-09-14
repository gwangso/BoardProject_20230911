<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-09-11
  Time: 오전 9:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <title>게시판</title>

    <%-- jquery --%>
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>

    <%-- bootstrap, styleSheet --%>
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="/resources/css/style.css">

</head>
<body>
<div class="row">
    <div class="col">
        <jsp:include page="../compotnent/header.jsp"/>
        <div class="container mt-5 mb-3 ms-5" id="search-area">
            <form action="/board/list" method="get">
                <select name="type">
                    <option value="boardTitle">제목</option>
                    <option value="boardWriter">작성자</option>
                </select>
                <input type="text" name="query" placeholder="검색어를 입력하세요">
                <input type="submit" value="검색">
            </form>
        </div>
        <div class="row mb-3">
            <div class="col">
                <c:forEach items="${boardList}" var="board">
                    <div class="card p-4 mb-3 mx-5">
                        <h5><a href="/board?id=${board.id}&page=${paging.page}&query=${query}&type=${type}">제목 : ${board.boardTitle}</a></h5> <br>
                        <p>작성자 : ${board.boardWriter}</p> <br>
                        <p>조회수 : ${board.boardHits}</p> <br>
                        <p>작성일 : ${board.createdAt}</p>
                    </div>
                </c:forEach>
            </div>
        </div>
        <%-- 페이지 번호 출력 부분 --%>
        <div class="container mb-5">
            <ul class="pagination justify-content-center">
                <c:choose>
                    <%-- 현재 페이지가 1페이지면 이전 글자만 보여줌 --%>
                    <c:when test="${paging.page<=1}">
                        <li class="page-item disabled">
                            <a class="page-link">[이전]</a>
                        </li>
                    </c:when>
                    <%-- 1페이지가 아닌 경우에는 [이전]을 클릭하면 현재 페이지보다 1 작은 페이지 요청 --%>
                    <c:otherwise>
                        <li class="page-item">
                            <a class="page-link" href="/board/list?page=${paging.page-1}&query=${query}&type=${type}">[이전]</a>
                        </li>
                    </c:otherwise>
                </c:choose>

                <%--  for(int i=startPage; i<=endPage; i++)      --%>
                <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="i" step="1">
                    <c:choose>
                        <%-- 요청한 페이지에 있는 경우 현재 페이지 번호는 텍스트만 보이게 --%>
                        <c:when test="${i eq paging.page}">
                            <li class="page-item active">
                                <a class="page-link">${i}</a>
                            </li>
                        </c:when>

                        <c:otherwise>
                            <li class="page-item">
                                <a class="page-link" href="/board/list?page=${i}&query=${query}&type=${type}">${i}</a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>

                <c:choose>
                    <c:when test="${paging.page>=paging.maxPage}">
                        <li class="page-item disabled">
                            <a class="page-link">[다음]</a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="page-item">
                            <a class="page-link" href="/board/list?page=${paging.page+1}&query=${query}&type=${type}">[다음]</a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>

        <hr>
        <jsp:include page="../compotnent/footer.jsp"/>
    </div>
</div>
</body>
<script>

</script>
</html>
