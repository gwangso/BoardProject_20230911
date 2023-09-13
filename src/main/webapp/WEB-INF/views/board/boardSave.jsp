<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-09-11
  Time: 오전 9:05
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
<jsp:include page="../compotnent/header.jsp"/>
<div class="row m-5">
    <div class="col">
        <div class="card p-4">
            <form id="save-form" method="post" enctype="multipart/form-data">
                <div class="input-group mb-3">
                    <span class="input-group-text">제목</span>
                    <input name="boardTitle" type="text" class="form-control">
                </div>
                <div class="input-group mb-3">
                    <span class="input-group-text">작성자</span>
                    <input name="boardWriter" type="text" class="form-control">
                </div>
                <div class="input-group mb-3">
                    <span class="input-group-text">비밀번호</span>
                    <input name="boardPass" type="password" class="form-control">
                </div>
                <br>
                <div class="mb-3">
                    <label for="board-contents" class="form-label" >작성내용</label>
                    <textarea id="board-contents" name="boardContents" type="text" class="form-control"></textarea>
                </div>
                <div  class="mb-3">
                    <input type="file" class="btn btn-secondary" name="boardFile" multiple>
                </div>
                <div class="text-end">
                    <input id="save-button" class="btn btn-primary" type="button" value="저장" onclick="save_fn()">
                    <input type="reset" class="btn btn-secondary" value="취소">
                </div>
            </form>
        </div>
    </div>
</div>
<hr>
<jsp:include page="../compotnent/footer.jsp"/>
</body>

<script>
    const save_fn = () => {
        const saveForm = document.getElementById("save-form");
        if(confirm("글을 저장하시겠습니까?")){
            saveForm.submit();
        }
    }
</script>
</html>
