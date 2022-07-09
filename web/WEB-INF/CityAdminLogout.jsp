<%-- 
    Document   : CityAdminLogout
    Created on : 23 May, 2022, 10:09:10 PM
    Author     : Admin
--%>


<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Login Successful</title>

        <link href="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js">
        <!-- CSS only -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link href="<c:url value='/resources/css/Form_CSS.css' />" rel="stylesheet">
        <link href="<c:url value='/resources/css/AdminHeader_CSS.css' />" rel="stylesheet">

    </head>
    <body onload="loadpage()">
        <!--<body>-->


        <%
//                    String Adminid = request.getParameter("aid");
                    session = (HttpSession) request.getSession(false);      
                    session.removeAttribute("cityadminid");
                    
        %>
        <%@include file="Header.jsp" %>
        <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
        <!--<h1>login success</h1>-->
        
    </body>

    <script>
        function loadpage()
        {
            window.open("/Subadmin/login","_self");
//            window.open("https://online-evoting.herokuapp.com/Subadmin/login","_self");
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
