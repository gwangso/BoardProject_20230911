<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-09-11
  Time: 오전 9:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
                <div id="title" class="row m3-5">
                    <h3 class="ms-3 mb-4"><b>${board.boardTitle}</b></h3>
                    <div class="col-6">
                        <p>작성자 : ${board.boardWriter}</p>
                    </div>
                    <div class="col-6">
                        <p class="text-end">${board.createAt}</p>
                    </div>
                </div>
                <hr>
                <div id="contents" class="my-4">
                    <p>${board.boardContents}</p>
                </div>
                <div id="footer" class="text-end">
                    <button class="btn btn-outline-primary" onclick="update_fn(${board.id})">수정</button>
                    <button class="btn btn-outline-danger" onclick="delete_fn(${board.id})">삭제</button>
                </div>
            </div>
        </div>
        <hr>
        <jsp:include page="../compotnent/footer.jsp"/>
    </div>
</div>
</body>
<script>
    const update_fn = (id) => {
        location.href = "/board/update?id="+id;
    }

    const delete_fn = (id) => {
        location.href = "/board/delete?id="+id;
    }

</script>
</html>