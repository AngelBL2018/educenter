<%@ taglib prefix="spring" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<a href="/logout">Logout</a>

<div style="width: 1000px; height: 300px ">


    <div style="width: 45%;height: 300px; float: left; background-color: cornflowerblue; margin-right: 10px">

        <h1>Add Subject</h1><br>
        <spring:form modelAttribute="subject" action="/addSubject" method="post">
            <spring:label path="name">Name</spring:label><br>
            <spring:input path="name" type="text"/><br>
            <spring:label path="duration">Duration</spring:label><br>
            <spring:input path="duration" type="text"/><br>
            <spring:label path="price">Price</spring:label><br>
            <spring:input path="price" type="text"/><br>
            <spring:label path="lecturer">lecturer</spring:label><br>
            <spring:input path="lecturer" type="text"/><br>
            <input type="submit" value="Add subject">
        </spring:form>


    </div>


    <div style="width: 45%;height: 300px; float: left;background-color: cornflowerblue">

        <h1>Add Student</h1><br>


        <spring:form modelAttribute="user" action="/addStudent" method="post">
            <spring:input path="name" type="text" placeholder="Please input name"/><br>
            <spring:input path="surname" type="text" placeholder="Please input surname"/><br>
            <spring:input path="email" type="text" placeholder="Please input email"/><br>
            <spring:input path="password" type="text" placeholder="Please input password"/><br>

            <input type="submit" value="signUp">
        </spring:form>


    </div>


</div>
<br>
<br>

<div style="width: 1000px; height: 300px ">


    <div style="width: 45%;height: 800px; float: left; background-color: cornflowerblue; margin-right: 10px">

        <h1>Delete Subject </h1><br>
        <form action="/deleteSubject" method="get">

            <select name="subject">
                <c:forEach items="${subjectList}" var="subjectItem">
                    <option value="${subjectItem.id}">${subjectItem.name}-> ${subjectItem.lecturer}</option>
                </c:forEach>
            </select>
            <input type="submit" value="Delete">

        </form>

        <hr>
        <h1>Change Subject Details </h1>

        <spring:form action="/changeSubjectDetails" modelAttribute="subject" method="get">

            <select name="subject">
                <c:forEach items="${subjectList}" var="subjectItem">
                    <option value="${subjectItem.id}">${subjectItem.name}-> ${subjectItem.lecturer}</option>
                </c:forEach>
            </select><br>
            <input name="price" type="text" placeholder="Please input price"><br>
            <input name="duration" type="text" placeholder="Please input duration"><br>
            <input name="lecturer" type="text" placeholder="Please input lecturer Name"><br>


            <input type="submit" value="Change">

        </spring:form>


    </div>


    <div style="width: 45%;height: 800px; float: left; background-color: cornflowerblue; margin-right: 10px">

        <h1>Delete Student</h1><br>
        <form action="/deleteStudent" method="get">

            <select name="student">
                <c:forEach items="${studentList}" var="studentItem">
                    <option value="${studentItem.id}">${studentItem.name} ${studentItem.surname}-->${studentItem.email}</option>
                </c:forEach>
            </select>
            <input type="submit" value="Delete">

        </form>

        <hr>
        <h1>Change Student Details </h1>

        <spring:form action="/changeStudentDetails" modelAttribute="user" method="get">

            <select name="student">
                <c:forEach items="${studentList}" var="studentItem">
                    <option value="${studentItem.id}">${studentItem.name} ${studentItem.surname}-->${studentItem.email}</option>
                </c:forEach>
            </select><br>
            <input name="email" type="text" placeholder="Please input email"><br>
            <input name="password" type="text" placeholder="Please input password"><br>

            <input type="submit" value="Change">

        </spring:form>
        <hr>


        <h1>Add Student subject </h1><br>


        <spring:form action="/addStudentSubject" method="get">

            <select name="student">
                <c:forEach items="${studentList}" var="studentItem">
                    <option value="${studentItem.id}">${studentItem.name} ${studentItem.surname}-->${studentItem.email}</option>
                </c:forEach>
            </select><br>


            <select name="subject">
                <c:forEach items="${subjectList}" var="subjectItem">
                    <option value="${subjectItem.id}">${subjectItem.name}-> ${subjectItem.lecturer}</option>
                </c:forEach>
            </select><br>

            <input type="submit" value="Add">

        </spring:form>


        <hr>
        <h1>Delete Student's subject </h1><br>


        <spring:form action="/manager" method="get">

            <select name="student">
                <c:if test="${userFirst != null}">
                    <option value="${userFirst.id}">${userFirst.name} ${userFirst.surname}-->${userFirst.email}</option>
                </c:if>
                <c:forEach items="${studentList}" var="studentItem">
                    <option value="${studentItem.id}">${studentItem.name} ${studentItem.surname}-->${studentItem.email}</option>
                </c:forEach>
            </select>
            <c:if test="${userId != null}">
                <input type="hidden" name="userId" , value="${userId}">
            </c:if>
            <input type="submit" value="OK">
        </spring:form>


        <spring:form action="/deleteSubjectFromStudentAtLast" method="get">


            <select name="subject">
                <option value=""></option>

                <c:if test="${userSubject != null}">

                    <c:forEach items="${userSubject}" var="subjectItem">
                        <option value="${subjectItem.id}">${subjectItem.name}-> ${subjectItem.lecturer}</option>
                    </c:forEach>

                </c:if>
            </select><br>
            <c:if test="${userId != null}">
                <input type="hidden" name="userId" value="${userId}">
            </c:if>
            <input type="submit" value="Delete">


        </spring:form>


    </div>
</div>


</body>
</html>
