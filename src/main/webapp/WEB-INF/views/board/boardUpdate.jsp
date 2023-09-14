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
<jsp:include page="../compotnent/header.jsp"/>
<div class="row m-5">
    <div class="col">
        <div class="card p-4">
            <form id="update-form" method="post" enctype="multipart/form-data">
                <div class="input-group mb-3">
                    <span class="input-group-text">제목</span>
                    <input name="boardTitle" type="text" class="form-control" value="${board.boardTitle}">
                </div>
                <div class="input-group mb-3">
                    <span class="input-group-text">작성자</span>
                    <input name="boardWriter" type="text" class="form-control" value="${board.boardWriter}" readonly>
                </div>
                <div class="mb-3">
                    <label for="board-contents" class="form-label" >작성내용</label>
                    <textarea id="board-contents" name="boardContents" type="text" class="form-control">${board.boardContents}</textarea>
                </div>
                <div  class="mb-3">
                    <input type="file" class="form-control" name="boardFile" multiple>
                </div>
                <br>
                <div class="input-group mb-3">
                    <span class="input-group-text">비밀번호</span>
                    <input id="board-pass" name="boardPass" type="password" class="form-control">
                </div>
                <div class="text-end">
                    <input id="save-button" class="btn btn-primary" type="button" value="수정" onclick="update_fn(${board.boardPass})">
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
    const update_fn = (password) => {
        const updateForm = document.getElementById("update-form");
        const confirmPass = document.getElementById("board-pass");
        const title = document.getElementsByName("boardTitle")[0];
        const contents = document.getElementById("board-contents");
        if (title.value==""){
            alert("제목을 입력해주세요");
            title.focus();
        }else if(confirmPass.value != password){
            alert("비밀번호가 일치하지 않습니다.")
            confirmPass.value = "";
            confirmPass.focus();
        }else if(contents.value == ""){
            alert("글을 작성해주세요.")
            contents.focus();
        }else if(confirm("글을 저장하시겠습니까?")){
            updateForm.submit();
        }
    }
</script>
</html>