<%-- 
    Document   : EditSubAdmin
    Created on : 17 May, 2022, 9:55:50 PM
    Author     : Admin
--%>

<%-- 
    Document   : EditAdmin
    Created on : 15 May, 2022, 7:54:54 AM
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
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <title>Edit Admin</title>

        <!-- CSS only -->

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/angular.js/1.8.3/angular.min.js" integrity="sha512-KZmyTq3PLx9EZl0RHShHQuXtrvdJ+m35tuOiwlcZfs/rE7NZv29ygNA8SFCkMXTnYZQK2OX0Gm2qKGfvWEtRXA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.4.5/angular.min.js"></script>
        <link src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js">
        <link href="<c:url value="/resources/css/Form_CSS.css" />" rel="stylesheet">
        <link href="<c:url value="/resources/css/AddNewAdmin_CSS.css" />" rel="stylesheet">
        <link href="<c:url value='/resources/css/AdminHeader_CSS.css' />" rel="stylesheet">

    </head>

    <body id="bodyid" onload="loadpage()">

        <%! String stateadminid; %>

        <%! String state = "";
            String city = "";
            String aid = "";
            String loginstatus = "";%>
        <%@include file="AdminHeader.jsp" %>
        <div class="container">

            <form  class="form" action="" method="post" style="background-image: url('evote1.jpg')">

                <div class="regformheading">
                    <center><u><h3>${formheader}</h3></u></center>
                </div>
                <br>
                <div class="alert alert-danger"  id="erroriddiv">
                    <h5  id="errorid">${error}</h5>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-12">        
                        <label for="aidid">Admin Id</label>
                        <input type="text" class="form-control" placeholder="AdminID" name="aid" id="aidid" required value='${addadminmsg.aid}' >
                    </div>
                    <div class="form-group col-md-12" >        
                        <label for="vidid">Voter ID</label>
                        <input type="text" class="form-control" placeholder="VoterID" name="vid" id="vidid"  value='${addadminmsg.vid}' required>
                    </div>
                </div>
                <center>
                    <button type="submit" class="btn btn-outline-primary" id="nextid">Next</button>
                </center>
            </form>
        </div>    
    </body>

    <script>
        function loadpage()
        {
//            alert("loadpage");
        <%
            session = (HttpSession) request.getSession(false);
            stateadminid = (String) session.getAttribute("stateadminid");
            if (stateadminid == null) {
//                                                    RequestDispatcher rd = request.getRequestDispatcher("AllAdminlogin.jsp");
//                                                    rd.forward(request, response); 
        %>
            window.open("/Admin/login", "_self");
//            window.open("https://online-evoting.herokuapp.com/Admin/login", "_self");
        <%
            }


        %>
        <%                                                    response.setHeader("Cache-control", "no-cache,no-store,must-revalidate");
        %>
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
