<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-09-11
  Time: 오전 8:49
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
        <jsp:include page="compotnent/header.jsp"/>
        <div class="row m-5">
            <div class="col">
                <h1 class="text-center ">메인페이지</h1>
            </div>
        </div>
        <hr>
        <jsp:include page="compotnent/footer.jsp"/>
    </div>
</div>
</body>
</html>
