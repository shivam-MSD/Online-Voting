<%-- 
    Document   : Admindashboard
    Created on : 12 May, 2022, 8:06:04 PM
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
        <title>Admin Head Dashboard</title>

        <link href="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js">
        <link src="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <!--<link href="<c:url value='/resources/css/Form_CSS.css' />" rel="stylesheet">-->
        <link href="<c:url value='/resources/css/AdminHeader_CSS.css' />" rel="stylesheet">
        <link href="<c:url value='/resources/css/AdminHeaddashboard_CSS.css' />" rel="stylesheet">
        <link href="<c:url value='/resources/js/AdminHeaddashboard.js' />" rel="stylesheet">

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>

    </head>


    <body onload="loadpage()">
        <%! String state = "";
            String city = "";
            String aid = "";
            String loginstatus = "";%>

        <%! String headadminid;%>
        <%@include file="AdminHeader.jsp" %>

        <div class="container" >
            <!--<br> <br> <br> <br> <br> <br> <br> <br> <br>-->
            <div class="row">
                <div class="col-sm-12"> 
                    <!--<div class="col-md-4">--> 
                    <div class="row">
                        <div class="col-sm-4">
                            <div class="card border-primary mb-3" style="max-width: 100%; max-height: 300px;">
                                <div class="card-header"><i class="fa fa-user-plus fa-6" aria-hidden="true"></i>   Add Admin</div>
                                <div class="card-body text-primary">
                                    <p class="card-title">To add new admin, click on <b>Add admin</b> button.<br>You can only able to add one admin for each state not more than that.</p>

                                    <!--<div class="cardimgid"><img src="<c:url value='/resources/img/addcandidate.jpg' />" ></div>-->
                                    <center><button class="btn btn-outline-primary btn-sm"  id="btn1" onclick="addNewAdmin()">Add Admin</button></center>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="card border-success mb-3" style="max-width: 100%;;">
                                <div class="card-header"><i class="fa fa-pencil" aria-hidden="true"></i>  Edit Admin</div>
                                <div class="card-body text-success">
                                    <p class="card-title">To edit admin details, click on <b>Edit admin</b> button.You can only edit state admin details.<br><br></p>
                                    <!--<div class="cardimgid"><img src="<c:url value='/resources/img/updatecandidate2.png' />" ></div>-->

                                    <center><button class="btn btn-outline-success btn-sm" id="btn2" onclick="editAdmin()">Edit Admin</button></center>
                                </div>  
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="card border-danger mb-3" style=" max-width: 100%;">
                                <div class="card-header"><i class="fa fa-user-times" aria-hidden="true"></i>   Remove Admin</div>
                                <div class="card-body text-danger">
                                    <p class="card-title">You can only able to remove admin if the election process in not in progress.<br>If you want to change the admin then you have to remove that admin and add new admin.<br></p>
                                    <!--<div class="cardimgid"><img src="<c:url value='/resources/img/removecandidate.jpg' />" ></div>-->
                                    <!--<button class="btn btn-outline-danger btn-sm"  id="btn3">Remove Admin</button>-->
                                </div>
                                <!--<button class="btn btn-outline-danger btn-sm"  id="btn3">Remove Admin</button>-->
                            </div>
                        </div>
                    </div>

                    <!--<div class="col-sm-9">-->

                    <br> <br> <br> <br>
                    <!--<br> <br>--> 
                    <!--<br> <br> <br> <br> <br> <br> <br> <br> <br>-->               
                    <!--<h1>hhhhhhhhhhhhhhhhhhhhhh</h1>-->
                    <!--============================================================================================================================================================================-->
                    <sql:setDataSource driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3308/onlinevotingsystemdb" password="" user="root" var="ds" />

                    <!--SELECT * FROM Admin WHERE city IS NULL AND state IS NULL ;-->
                    <sql:query dataSource="${ds}" var="data">

                        SELECT * FROM Admin WHERE AdminId = '<%= headadminid%>';
                    </sql:query>

                    <c:forEach var="row" items="${data.rows}">
                        <c:set var="adminheadaid" value="${row.AdminId}" />
                        <c:set var="adminheadname" value="${row.name}" />
                    </c:forEach>

                        <center>
                    <div class="col-sm-12" id="adminheaderaiddisplaydiv" >
                        <table class="responsive"  id="adminheaderaiddisplay">
                            <tr>
                                <td>
                                    <center>
                                        <h1>
                                            <i class="fa fa-user" aria-hidden="true"></i>&nbsp;&nbsp;
                                            <c:out value= "${adminheadaid}" />'s Dashboard&nbsp;&nbsp;
                                            <c:out value="${adminheadname}" /> &nbsp;&nbsp;
                                        </h1>
                                    </center>
                            </td>
                            <td>
                                <div class="adminlogout">
                                    <form action="adminheaddashboard/logout" method="post" ><button type="submit" class="btn btn-primary" id="logoutid">Log Out</button></form>
                                </div>
                            </td>
                            <tr>
                        </table>
                    </div>
                </center>
                    <sql:query dataSource="${ds}" var="data">
                        SELECT * FROM Admin WHERE city IS NULL AND state IS NOT NULL ;
                    </sql:query>

                    <div class="table-responsive" id="adminheadtable">
                        <!--<div class="table-area" id="adminheadtable" id="adminheadtable">-->
                        <table class="table" style="font-weight: bold;  text-align: center;">
                            <!--<table class="responsive-table table" style="font-weight: bold;  text-align: center;">-->
                            <thead>
                                <tr>
                                    <td> </td>
                                    <td>AdminID</td>
                                    <td>Name</td>
                                    <td>Mobile No.</td>
                                    <td>EmailID</td>
                                    <td>State</td>
                                    <td>Election Status</td>
                                    <td>Remove Admin</td>
                                </tr>
                            </thead>
                            <%--<c:forEach begin="1" end="10" >--%>
                            <c:forEach var="row" items="${data.rows}">
                                <tr style="font-weight: bold;">

                                    <c:if test="${row.state == null}">                         
                                        <td><h3><i class="fa fa-user" aria-hidden="true"></i></h3></td>
                                                <c:set var="aid" value="${row.AdminId}" />
                                            </c:if>

                                    <c:if test="${row.state != null}">
                                        <td><h3><i class="fa fa-user-o" aria-hidden="true" ></i></h3></td>
                                            </c:if>

                                    <td><c:out value="${row.AdminId}"></c:out></td>
                                    <td><c:out value="${row.Name}"></c:out></td>
                                    <td><c:out value="${row.MobileNo}"></c:out></td>
                                    <td><c:out value="${row.Email}"></c:out></td>
                                    <td><c:out value="${row.state}"></c:out></td>
                                    <c:if test="${row.ElectionStatus == 'Not started'}">
                                        <td style="background-color: #dc3545; color: white; "><c:out value="${row.ElectionStatus}"></c:out></td>
                                            <td class="addbutton">
                                                <!--<a href="#modalCenter" role="button" class="btn btn-outline-danger btn-sm" data-bs-toggle="modal" id="${row.AdminId}" onclick="showAdmindetails('${row.AdminId}', '${row.state}', '${row.Name}')" >Remove</a>-->
                                            <button href="#modalCenter"  class="btn btn-outline-danger btn-sm" data-bs-toggle="modal" id="${row.AdminId}" onclick="showAdmindetails('${row.AdminId}', '${row.state}', '${row.Name}')" >Remove</button>
                                        </td>   
                                    </c:if>
                                    <c:if test="${row.ElectionStatus == 'Started'}">
                                        <td style="background-color: #28a745; color: white; "><c:out value="${row.ElectionStatus}"></c:out></td>
                                            <td class="addbutton">
                                                <button href="#modalCenter"  class="btn btn-outline-danger btn-sm" data-bs-toggle="modal" id="${row.AdminId}" onclick="showAdmindetails('${row.AdminId}', '${row.state}', '${row.Name}')" disabled >Remove</button>
                                        </td>
                                    </c:if>

                                    <!--                                        <td class="addbutton">
                                                                                <a href="#modalCenter" role="button" class="btn btn-outline-danger btn-sm" data-bs-toggle="modal" id="${row.AdminId}" onclick="showAdmindetails('${row.AdminId}', '${row.state}', '${row.Name}')" >Remove</a>
                                                                            </td>     -->

                                <div id="modalCenter" class="modal fade" tabindex="-1">
                                    <div class="modal-dialog modal-dialog-centered">
                                        <div class="modal-content"  style="padding: 15px;">
                                            <div class="modal-header" style="background-color: #dc3545;color: white">
                                                <h5 class="modal-title">Remove Admin Alert</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                            </div>

                                            <b> <h4>Are you sure, you want to remove Admin whose details are display below :-</b></h4>
                                            <form action="adminheaddashboard/removeadmin" method="post" class="form-control">
                                                <!--<form action="removeadmin" method="post">-->
                                                <b>AdminID :</b>
                                                <input class="form-control" type="text" name="aid" id="aididinput" readonly>
                                                <b>Name :</b>
                                                <input class="form-control" type="text" name="name" id="aidnameinput"  readonly>
                                                <b>State</b>
                                                <input class="form-control" type="text" name="state" id="aidstateinput"  readonly>
                                                <div class="modal-footer">
                                                    <button type="submit" class="btn btn-primary">Yes</button>
                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">No</button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                            <%--</c:forEach>--%>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </body>

    <script>
        function addNewAdmin()
        {
            window.open("/HeadAdmin/login/adminheaddashboard/addadmin", "_self");
//            window.open("https://online-evoting.herokuapp.com/HeadAdmin/login/adminheaddashboard/addadmin", "_self");
        }
        function editAdmin()
        {
            window.open("/HeadAdmin/login/adminheaddashboard/editadmin", "_self");
//            window.open("https://online-evoting.herokuapp.com/HeadAdmin/login/adminheaddashboard/editadmin", "_self");
        }

        function setadmindetails(aid, state, name, city)
        {
//                                                                                            alert("function called = " + aid + " " + state + name);              
            document.getElementById('aididinput').value = aid;
            document.getElementById('aidnameinput').value = name;
            document.getElementById('aidstateinput').value = state;
            document.getElementById('aidcityinput').value = city;

        }
        function showAdmindetails(aid, state, name, city)
        {
//                                                                                            alert("showAdmindetails = " + aid + " " + state+ " " + name + " " + city);
            setadmindetails(aid, state, name, city);
//                                                                                            alert("aid = " + document.getElementById('aidid').textContent);
        }

        function loadpage()
        {
        <%
                session = (HttpSession) request.getSession(false);
                headadminid = (String) session.getAttribute("headadminid");
                if (headadminid == null) {
        %>
            window.open("/HeadAdmin/login", "_self");
//            window.open("https://online-evoting.herokuapp.com/HeadAdmin/login", "_self");
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
