<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="academy.learnprogramming.util.Mappings" %>
<html>
<head>
    <title>Clinic data</title>

</head>
<body>
    <div align="center">
        <table border="1" cellpadding="5">
        <tr>
            <%--Sending data to URL ending in ./addClinic--%>
            <th>
                <c:url var="addClinicUrl" value="${Mappings.ADD_CLINIC}"/>
                <a href="${addClinicUrl}">Add a Clinic</a>
            </th>
        </tr>

        </table>

        <div>
            <table border="1" cellpadding="5">
                <tr>
                <caption><h2>Clinic</h2></caption>
                <tr>
                    <th>ClinicID</th>
                    <th>Phone</th>
                    <th>Street</th>
                    <th>City</th>
                    <th>State</th>
                    <th>Zip</th>
                </tr>
                <%--Iterating through each row of data within CLINIC table--%>
                <c:forEach var="clinic" items="${clinicData.items}">
                    <tr>
                        <td><c:out value="${clinic.clinicID}"/></td>
                        <td><c:out value="${clinic.phone}"/></td>
                        <td><c:out value="${clinic.street}"/></td>
                        <td><c:out value="${clinic.city}"/></td>
                        <td><c:out value="${clinic.state}"/></td>
                        <td><c:out value="${clinic.zip}"/></td>
                    </tr>
                </c:forEach>
                </tr>
            </table>
        </div>

    </div>
</body>
</html>
