<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-09-11
  Time: 오전 9:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>게시판</title>

    <%-- jquery --%>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

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
                <c:if test="${board.fileAttached == 1}">
                    <div id="image" class="card p-4 text-center">
                        <c:forEach items="${boardFileList}" var="boardFile">
                            <span>
                                <img src="${pageContext.request.contextPath}/upload/${boardFile.storedFileName}"
                                     alt="" width="200" height="200">
                            </span>
                        </c:forEach>
                    </div>
                </c:if>
                <div id="footer" class="text-end my-3">
                    <button class="btn btn-outline-primary" onclick="broad_list()">목록</button>
                    <button class="btn btn-outline-warning" onclick="broad_update(${board.id})">수정</button>
                    <button class="btn btn-outline-danger" onclick="broad_delete(${board.id})">삭제</button>
                </div>
                <div id="pass-check" class="" style="display: none">
                    <div class="input-group mb-3">
                        <span class="input-group-text">비밀번호</span>
                        <input id="board-pass" type="password" class="form-control" name="boardPass">
                    </div>
                    <div class="text-end">
                        <input type="submit" value="삭제" class="btn btn-outline-danger" onclick="pass_check()">
                        <input type="button" value="취소" class="btn btn-outline-secondary" onclick="close_pass_check()">
                    </div>
                </div>
                <hr>
                <div id="comment-write-area" class="card p-4 mb-4">
                    <label for="comment-contents" class="form-label ms-5">댓글</label>
                    <div class="input-group mb-3">
                        <span class="input-group-text">작성자</span>
                        <input type="text" class="form-control" id="comment-writer" placeholder="작성자 입력">
                    </div>
                    <div class="input-group mb-3">
                        <textarea type="text" class="form-control" id="comment-contents" placeholder="내용 입력"></textarea>
                    </div>
                    <div class="text-end">
                        <button class="btn btn-outline-success" onclick="comment_write()" style="width: 100px">댓글작성</button>
                    </div>
                </div>
                <div id="comment-list-area">
                    <c:choose>
                    <c:when test="${commentList} == null">
                        <h3 class="text-center">작성된 뎃글이 없습니다.</h3>
                    </c:when>
                    <c:otherwise>
                        <table id="comment-list" class="table">
                            <tr class="table-dark">
                                <th>작성자</th>
                                <th>내용</th>
                                <th>작성시간</th>
                            </tr>
                            <c:forEach items="${commentList}" var="comment">
                                <tr>
                                    <td>${comment.commentWriter}</td>
                                    <td>${comment.commentContents}</td>
                                    <td>${comment.createdAt}</td>
                                </tr>
                            </c:forEach>
                        </table>
                    </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
        <hr>
        <jsp:include page="../compotnent/footer.jsp"/>
    </div>
</div>
</body>
<script>
    const broad_list = () => {
        const page = '${page}';
        location.href = "/board/list?page="+page;
    }

    const broad_update = (id) => {
        location.href = "/board/update?id=" + id;
    }

    const broad_delete = (id) => {
        const passCheck = document.getElementById("pass-check");
        passCheck.style.display = "block";
    }

    const close_pass_check = () => {
        const passCheck = document.getElementById("pass-check");
        passCheck.style.display = "none";

    }

    const pass_check = () => {
        const inputPass = document.getElementById("board-pass").value;
        const pass = '${board.boardPass}';
        const id = '${board.id}';
        if (inputPass == pass) {
            if(confirm("정말로 삭제하시겠습니까?")){
                location.href = "/board/delete?id="+id;
            }
        }else {
            alert("비밀번호 불일치!")
        }
    }

    const comment_write = () => {
        const commentWriter = document.getElementById("comment-writer").value;
        const commentContents = document.querySelector("#comment-contents").value;
        const boardId = '${board.id}';
        const result = document.getElementById("comment-list-area");
        $.ajax({
            type: "post",
            url: "/comment/save",
            data: {
                commentWriter: commentWriter,
                commentContents: commentContents,
                boardId: boardId
            },
            success: function (res) {
                console.log("리턴값: ", res);
                let output =    "<table id=\"comment-list\" class=\"table\">\n" +
                    "    <tr class=\"table-dark\">\n" +
                    "        <th>작성자</th>\n" +
                    "        <th>내용</th>\n" +
                    "        <th>작성시간</th>\n" +
                    "    </tr>\n";
                for(let i in res) {
                    output += "    <tr>\n";
                    output += "        <td>" + res[i].commentWriter + "</td>\n";
                    output += "        <td>" + res[i].commentContents + "</td>\n";
                    output += "        <td>" + res[i].createdAt + "</td>\n";
                    output += "    </tr>\n";
                }
                output += "</table>";
                result.innerHTML = output;
                document.getElementById("comment-writer").value = "";
                document.getElementById("comment-contents").value = "";
            },
            error: function () {
                console.log("댓글 작성 실패");
            }
        });
    }
</script>
</html>