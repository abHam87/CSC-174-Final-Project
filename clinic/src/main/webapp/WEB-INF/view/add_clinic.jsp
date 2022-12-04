<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page import="academy.learnprogramming.util.AttributeNames" %>
<html>
<head>
    <title>Add a new clinic</title>
</head>
<body>
<div align="center">
    <form:form method="POST" modelAttribute="${AttributeNames.CLINIC}">
        <table>
            <tr>
                <td><label>ClinicID (5 digits max)</label></td>
                <td>
                    <%--Limit user input to at most 5 digits for ClinicID--%>
                    <form:input maxlength="5" value="" path="clinicID"/>
                </td>
            </tr>
            <tr>
                <td><input type="submit" value="Submit"></td>
            </tr>
        </table>
    </form:form>
</div>
</body>
</html>