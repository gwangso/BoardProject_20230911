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
        <div class="row m-5">
            <div class="col">
                <c:forEach items="${boardList}" var="board">
                    <div class="card p-4 mb-3">
                        <h5><a href="/board?id=${board.id}">제목 : ${board.boardTitle}</a></h5> <br>
                        <p>작성자 : ${board.boardWriter}</p> <br>
                        <p>조회수 : ${board.boardHits}</p> <br>
                        <p>작성일 : ${board.createAt}</p>
                    </div>
                </c:forEach>
            </div>
        </div>
        <hr>
        <jsp:include page="../compotnent/footer.jsp"/>
    </div>
</div>
</body>
</html>
