<%@ taglib prefix="spring" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

<div style="width: 1000px; height: 300px ">

    <h1>Login</h1><br>

    <div style="width: 45%;height: 300px; float: left; background-color: cornflowerblue; margin-right: 10px">
        <spring:form modelAttribute="user" action="#" method="post">
            <spring:input path="email" type="text" placeholder="Please input email"/><br>
            <spring:input path="password" type="password" placeholder="Please input password"/><br>
            <input type="submit" value="login">
        </spring:form>


    </div>


</div>


</body>
</html>
