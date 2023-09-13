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
                <div id="footer" class="text-end">
                    <button class="btn btn-outline-primary" onclick="broad_list()">목록</button>
                    <button class="btn btn-outline-warning" onclick="broad_update(${board.id})">수정</button>
                    <button class="btn btn-outline-danger" onclick="broad_delete(${board.id})">삭제</button>
                </div>
                <div id="comment-write-area">
                    <input type="text" id="comment-writer" placeholder="작성자 입력">
                    <input type="text" id="comment-contents" placeholder="내용 입력">
                    <button onclick="comment_write()">댓글작성</button>
                </div>
                <div id="comment-list-area">
                    <c:choose>
                    <c:when test="${commentList} == null">
                        <h3 class="text-center">작성된 뎃글이 없습니다.</h3>
                    </c:when>
                    <c:otherwise>
                        <table id="comment-list">
                            <tr>
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
        location.href = "/board/list";
    }

    const broad_update = (id) => {
        location.href = "/board/update?id=" + id;
    }

    const broad_delete = (id) => {
        location.href = "/board/delete?id=" + id;
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
                let output =    "<table id=\"comment-list\">\n" +
                    "    <tr>\n" +
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