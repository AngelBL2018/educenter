<%@ taglib prefix="spring" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: expert
  Date: 3/11/18
  Time: 4:00 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<a href="/logout">Logout</a>
<div style="width: 1000px;height: 300px;background-color: brown">

    <div style="width: 45%; height: 300px;background-color: brown; float: left;margin-right: 10px">
        <h1>Change my details</h1>

        <spring:form action="/changeMyDetails" modelAttribute="user" method="get">


            <input name="email" type="text" placeholder="Please input email"><br>
            <input name="password" type="text" placeholder="Please input password"><br>

            <input type="submit" value="Change">

        </spring:form>


    </div>


    <div style="width: 45%; height: 300px;background-color: brown; float: left">
        <h1>My List of Subjects</h1>
        <spring:form action="/student" method="get">
            <select name="subjectId">
                <c:forEach items="${subjectList}" var="subjectItem">
                    <option value="${subjectItem.id}">${subjectItem.name}-> ${subjectItem.lecturer}</option>
                </c:forEach>
            </select>


            <input type="submit" value="Show students">
        </spring:form>

    </div>


</div>
<hr>

<div style="width: 1000px; height: 300px;background-color: brown">


    <div style="width: 45%; height: 300px;background-color: brown; float: left">
        <c:if test="${studentList != null}">
            <spring:form action="/student" method="get">

                <select name="EachstudentDetails">
                    <c:forEach items="${studentList}" var="studentItem">
                        <option value="${studentItem.id}">${studentItem.name} ${studentItem.surname}-->${studentItem.email}</option>
                    </c:forEach>
                </select>
                <c:if test="${lastSubjectId != null}">
                    <input type="hidden" name="lastSubjectId" value="${lastSubjectId}">
                </c:if>
                <input type="submit" value="Show details">
            </spring:form>
        </c:if>
    </div>


    <div style="width: 45%; height: 300px;background-color: brown; float: left">
        <c:if test="${userDetail != null}">
            Name:  ${userDetail.name}<br>
            Surname:  ${userDetail.surname}<br>
            Email:  ${userDetail.email}

        </c:if>

    </div>


</div>


</body>
</html>
