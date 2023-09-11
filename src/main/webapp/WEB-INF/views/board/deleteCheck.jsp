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
    <title>Title</title>
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
                <form name="delete_form" method="post">
                    <div class="input-group mb-3">
                        <span class="input-group-text">비밀번호</span>
                        <input type="password" class="form-control" name="boardPass">
                    </div>
                    <div class="text-end">
                        <input type="submit" value="삭제" class="btn btn-outline-danger">
                        <input type="button" value="취소" class="btn btn-outline-secondary" onclick="toDetail(${board.id})">
                    </div>
                </form>
            </div>
        </div>
        <hr>
        <jsp:include page="../compotnent/footer.jsp"/>
    </div>
</div>
</body>
<script>
    $(delete_form).on("submit", function(e){
        e.preventDefault();
        const deleteForm = document.getElementsByName("delete_form")[0];
        const password = document.getElementsByName("boardPass")[0];
        const id = "${board.id}";
        if(password.value != "${board.boardPass}"){
            alert("비밀번호가 틀립니다.");
            password.value="";
            password.focus();
        }else {
            deleteForm.submit(id);
        }
    });


    const toDetail = (id) => {
        location.href = "/board?id="+id;
    }
</script>
</html>
