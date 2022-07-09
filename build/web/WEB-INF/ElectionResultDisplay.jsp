<%-- 
    Document   : ElectionResultDisplay
    Created on : 29 May, 2022, 8:45:09 AM
    Author     : Admin
--%>

<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%--<%@page errorPage="ErrorPage.jsp" %>--%>
<%@page import="VotingSystemController.Mail"%>
<%@page import="java.util.Random"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <title>Election Result</title>

        <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.4.5/angular.min.js" ></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

        <link href='<c:url value="/resources/css/Form_CSS.css" />' rel="stylesheet">
        <link href="<c:url value='/resources/css/AdminHeader_CSS.css' />" rel="stylesheet">
        <link href="<c:url value='/resources/css/Subadmindashboard_CSS.css' />" rel="stylesheet">
        <link href="<c:url value='/resources/js/AdminHeaddashboard.js' />" rel="stylesheet">
        <link href="<c:url value='/resources/css/ElectionResult_CSS.css' />" rel="stylesheet">

    </head>
    <body onload="loadpage()">
        <%@include file="Header.jsp" %>
        
        
        <!--<br><br><br><br><br><br><br><br>-->
        
        <div class="container" >
            
        <sql:setDataSource driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3308/onlinevotingsystemdb" password="" user="root" var="ds" />

        <c:set var="srno" value="${0}" />
                    
        <c:set var="resulttype" value="${candidate.year}" />
        
        <c:if test="${candidate.year == null}" >
            <sql:query dataSource="${ds}" var="data">
                        SELECT * FROM electionresult WHERE state = '${candidate.state}' and city = '${candidate.city}' and village = '${candidate.village}' and position =  '${candidate.position}';
                    </sql:query>
        </c:if>
        
        <c:if test="${candidate.year != null}" >
            <sql:query dataSource="${ds}" var="data">
                        SELECT * FROM electionresult WHERE electionyear = '${candidate.year}'  AND state = '${candidate.state}' and city = '${candidate.city}' and village = '${candidate.village}' and position =  '${candidate.position}';
                    </sql:query>
        </c:if>
                        

                        <div id="displayresultdetailsid">
                            <h2 style="font-size:3vw;"> 
                                Election Result of ${candidate.position} of state : ${candidate.state} and city : ${candidate.city}
                                <c:if test="${candidate.village != null}" >
                                    and village : <c:out value="${candidate.village}"/>
                                </c:if>
                            </h2>
                            <h2 style="font-size:3vw;"><c:if test="${candidate.year != null}" >
                                Year :- <c:out value="${candidate.year}"/>
                            </c:if>
                        </h2>
                        </div>
                        
                    <div  class="table-responsive" id="resulttabledivid" >
                        <table class="table" style="font-weight: bold;  text-align: center;">
                            
                            <tr>
                                <td>Sr No.</td>
                                <c:if test="${candidate.year == null}" >
                                    <td>Year</td>
                                </c:if>
                                <td>Candidate Name</td>
                                <td>Party Name</td>
                                <td>Party Logo</td>
                                <td>No of Votes</td>
                                
                            </tr>
                            <c:forEach var="row" items="${data.rows}">
                                                        <tr style="font-weight: bold;">

                                                            <c:set var="srno" value="${srno+1}" />
                                                            <td><c:out value="${srno}" /></td>
                                                            
                                                            <c:if test="${candidate.year == null}" >
                                                                <td><c:out value="${row.electionyear}"/></td>
                                                            </c:if>
                                                            <td><c:out value="${row.candidate_name}"></c:out></td>
                                                            <td><c:out value="${row.party_name}"></c:out></td>
                                                            <td><c:out value="${row.party_logo}"></c:out></td>
                                                            <td><c:out value="${row.votecount}" /></td>
                                                        </tr>
                          </c:forEach>
                        </table>
    </div>
                        
    </div>
                        
    </body>
    
    <script>
            document.onkeydown = function (e) {
            if (event.keyCode == 123) {
                return false;
            }
            if (e.ctrlKey && e.shiftKey && e.keyCode == 'I'.charCodeAt(0)) {
                return false;
            }
            if (e.ctrlKey && e.shiftKey && e.keyCode == 'J'.charCodeAt(0)) {
                return false;
            }
            if (e.ctrlKey && e.keyCode == 'U'.charCodeAt(0)) {
                return false;
            }
        }
     </script>
</html>