<%-- 
    Document   : HeadAdminloginsuccess
    Created on : 16 May, 2022, 10:14:31 PM
    Author     : Admin
--%>

<%@page import="javax.servlet.http.HttpSession"%>
<%-- 
    Document   : Adminlogin
    Created on : 12 May, 2022, 7:45:00 PM
    Author     : Admin
--%>

<%@page import="java.util.Random"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Login</title>
        
        <link href="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js">
        <!-- CSS only -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link href="<c:url value='/resources/css/Form_CSS.css' />" rel="stylesheet">
        <link href="<c:url value='/resources/css/AdminHeader_CSS.css' />" rel="stylesheet">
        
    </head>
    <body onload="loadpage()">

        <%@include file="AdminHeader.jsp" %> 
        
        <%
                    String headadminid = request.getParameter("aid");
                    session = (HttpSession) request.getSession();      
                    session.setAttribute("headadminid",headadminid );
        %>
    <script>
//        function displayError()
//        {
//
//            var data = document.getElementById('errorid').innerHTML;
//            alert("data = " + data);
//            if (data.length == 0)
//            {
//                alert("data = " + data);
//                document.getElementById('erroriddiv').style.display = "none";
//                document.getElementById('errorid').style.display = "none";
//            }
//            
//            
//        }
        function loadpage()
        {

        }
        
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
