<%-- 
    Document   : Admindashboard
    Created on : 12 May, 2022, 8:06:04 PM
    Author     : Admin
--%>
<%@page import="java.util.Base64"%>
<%@page import="VotingSystemController.OnlinevotingDBConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.*"%>
<%@page import="sun.net.www.content.image.png"%>
<%@page import="java.util.Random"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title> Admin Dashboard</title>

        <link href="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js">
        <link src="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <!--<link href="<c:url value='/resources/css/Form_CSS.css' />" rel="stylesheet">-->
        <link href="<c:url value='/resources/css/AdminHeader_CSS.css' />" rel="stylesheet">
        <link href="<c:url value='/resources/css/Admindashboard_CSS.css' />" rel="stylesheet">
        <link href="<c:url value='/resources/js/AdminHeaddashboard.js' />" rel="stylesheet">

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>

    </head>


    <body onload="loadpage()">
        <%@include file="AdminHeader.jsp" %>

        <%! String stateadminid; %>

        <%! String state = "";
            String city = "";
            String aid = "";
            String loginstatus = "";%>


        <sql:setDataSource driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3308/onlinevotingsystemdb" password="" user="root" var="ds" />



        <div class="container-fluid" >

            <!--SELECT * FROM Admin WHERE city IS NULL AND state = "Gujarat" ;-->
            <sql:query dataSource="${ds}" var="data">
                SELECT * FROM Admin WHERE AdminId = '<%= stateadminid%>';
            </sql:query>

            <c:forEach var="row" items="${data.rows}">
                <c:set var="stateadminaid" value="${row.AdminId}" />
                <c:set var="stateadminname" value="${row.name}" />
                <c:set var="stateadminstate" value="${row.state}" />
                <c:set var="stateadminelectionstatus" value="${row.ElectionStatus}" />
            </c:forEach>
            <!--            <div class="adminiddisplay" id="adminaiddisplaydiv"> 
                            <center>
                                <h1 id="adminaiddisplay">
                                    <i class="fa fa-user" aria-hidden="true"></i>&nbsp;&nbsp;
            <c:out value= "${stateadminaid}" />'s Dashboard
            <c:out value="${stateadminname}" />&nbsp;&nbsp;
            State Admin of <c:out value="${stateadminstate}" />
        </h1>
    </center>
</div>-->




            <div id="modalCenter3" class="modal fade" tabindex="-1">
                <div class="modal-dialog modal-dialog-centered">

                    <div class="modal-content"  style="padding: 15px;">
                        <div class="modal-header" style="background-color: #dc3545;color: white">
                            <h5 class="modal-title"><div id="electionprocessstatusid"></div> Process Alert</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <form class="form" action="admindashboard/startelectionprocessinstate" method="post">
                            <div class="modal-body">
                                <b> <h5 style="color: black;">Are you sure, you want to <div id="electionprocessstatuscontentid"></div> process ?</h5></b>
                                <b hidden>Adminid</b>
                                <input type="text" value="${stateadminaid}" name="aid" class="form-control" hidden>
                            </div>

                            <div class="modal-footer">
                                <button type="submit" class="btn btn-primary" data-bs-dismiss="modal" onclick="Electionprocess()">Yes</button>
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">No</button>
                            </div>
                        </form>
                    </div>

                </div>
            </div> 








            <center>
                <div class="col-sm-12" id="adminheaderaiddisplay"> 
                    <table>              
                        <tr>
                            <td>
                        <center>
                            <!--<h1 id="adminaiddisplaydiv">-->
                            <h1>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <i class="fa fa-user" aria-hidden="true"></i>&nbsp;

                                <c:out value= "${stateadminaid}" />'s Dashboard &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <%--<c:out value= "${subadminname}" />--%>

                                <!--&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-->  
                            </h1>
                            <center>
                                </td>
                                <td>
                                    <!--                                            <div class="adminlogout">
                                                                                    <form action="subadmindashboard/logout" method="post" ><button type="submit" class="btn btn-primary" id="logoutid">Log Out</button></form>
                                                                                </div> -->

                                    <h1><c:out value= "${stateadminname}" /></h1>

                                </td>
                                </tr>
                                <tr>

                                    <td>
                                        <!--                                    <div  style="width: 500px; height: 50px; background-color: white; padding: 5px; color: black;"></div>-->
                                        <!--<input type="text" id="electionstatusininput" readonly>-->
                                        <input type="text" id="hiddenelectionstatusininput" value="<c:out value= '${stateadminelectionstatus}' />" hidden>
                                <center>
                                    <div class="electionprocess">
                                        <button href="#modalCenter3"  class="btn btn-success" data-bs-toggle="modal" id="electionprocessbtnid" onclick="displaybtnname()" >Start Election</button>
                                        <!--<button class="btn btn-success" id="electionprocessbtnid" onclick="Electionprocess()" value="Start Election">Start Election</button>-->
                                    </div> 
                                </center>
                                </td>

                                <!--                                        </tr>
                                                                        <tr>-->

                                <td>
                                    <!--                                        <center>
                                                                                <div class="electionprocess">
                                                                                    <button href="#modalCenter3"  class="btn btn-success" data-bs-toggle="modal" id="electionprocessbtnid" onclick="displaybtnname()" >Start Election</button>
                                                                                    <button class="btn btn-success" id="electionprocessbtnid" onclick="Electionprocess()" value="Start Election">Start Election</button>
                                                                                </div> 
                                                                            </center>-->

                                    <div class="adminlogout">
                                        <form action="admindashboard/logout" method="post" ><button type="submit" class="btn btn-primary" id="logoutid">Log Out</button></form>
                                    </div> 
                                </td>
                                </tr>
                                </table>  
                                </div>
                            </center>

                            <div class="mainrow" style="width: 100%;">
                                <!--<div class="col-sm-2">--> 
                                <div id="col1" class="colm"> 
                                    <!--<div class="col-md-4">--> 
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <!--<div class="card border-primary mb-3" style="max-width: 80%;">-->
                                            <div class="card border-primary mb-3">
                                                <div class="card-header"><i class="fa fa-user-plus fa-6" aria-hidden="true"></i>   Add Admin</div>
                                                <div class="card-body text-primary">
                                                    <p class="card-title">You can only able to add one admin for each state not more than that.</p>
                                                    <center><button class="btn btn-outline-primary btn-sm"  id="btn1" onclick="addNewAdmin()">Add Admin</button></center>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-12">
                                            <div class="card border-success mb-3">
                                                <div class="card-header"><i class="fa fa-pencil" aria-hidden="true"></i>  Edit Admin</div>
                                                <div class="card-body text-success">
                                                    <p class="card-title">You can only edit city admin details.</p>
                                                    <center><button class="btn btn-outline-success btn-sm" id="btn2" onclick="editAdmin()">Edit Admin</button></center>
                                                </div>  
                                            </div>
                                        </div>
                                        <div class="col-sm-12">
                                            <div class="card border-danger mb-3">
                                                <div class="card-header" ><i class="fa fa-user-times" aria-hidden="true"></i>   Remove Admin</div>
                                                <div class="card-body text-danger">
                                                    <p class="card-title">If you want to change the admin then you have to remove that admin and add new admin.</p>
                                                </div>
                                                <!--<button class="btn btn-outline-danger btn-sm"  id="btn3">Remove Admin</button>-->
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!--==============================================================================================================================================================================================================================================================================================-->

                                <!--<br> <br> <br> <br>--> 
                                <!--<br> <br>--> 
                                <!--<br> <br> <br> <br> <br> <br> <br> <br> <br>-->               
                                <!--<h1>hhhhhhhhhhhhhhhhhhhhhh</h1>-->

                                <div id="col2" class="colm"> 

                                    <sql:query dataSource="${ds}" var="data">
                                        SELECT * FROM Admin WHERE city IS NOT NULL AND state = "${stateadminstate}" ;
                                    </sql:query>

                                    <div class="table-responsive" id="subadminadmintablediv">
                                        <table class="table" style="font-weight: bold;  text-align: center;">
                                            <thead class="sticky-header">
                                                <tr>
                                                    <td> </td>
                                                    <!--<td colspan="2">AdminID</td>-->
                                                    <td>AdminID</td>
                                                    <td>Name</td>
                                                    <td>Mobile No.</td>
                                                    <td>EmailID</td>
                                                    <td>State</td>
                                                    <td>City</td>
                                                    <td>Election Status</td>
                                                    <td>Remove Admin</td>
                                                </tr>
                                            </thead>
                                            <%--<c:forEach begin="1" end="10" >--%>
                                            <c:forEach var="row" items="${data.rows}">
                                                <tr style="font-weight: bold;">

                                                    <c:if test="${row.state == null}">                         
                                                        <td><i class="fa fa-user" aria-hidden="true"></i></td>
                                                            <c:set var="aid" value="${row.AdminId}" />
                                                        </c:if>

                                                    <c:if test="${row.state != null}">
                                                        <td><i class="fa fa-user-o" aria-hidden="true" ></i></i></td>
                                                    </c:if>

                                                    <td><c:out value="${row.AdminId}"></c:out></td>
                                                    <td><c:out value="${row.Name}"></c:out></td>
                                                    <td><c:out value="${row.MobileNo}"></c:out></td>
                                                    <td><c:out value="${row.Email}"></c:out></td>
                                                    <td><c:out value="${row.state}"></c:out></td>
                                                    <td><c:out value="${row.city}"></c:out></td>
                                                    <c:if test="${row.ElectionStatus == 'Not started'}">
                                                        <td style="background-color: #dc3545; color: white; "><c:out value="${row.ElectionStatus}"></c:out></td>
                                                            <td class="addbutton">
                                                                <!--<a href="#modalCenter" role="button" class="btn btn-outline-danger btn-sm" data-bs-toggle="modal" id="${row.AdminId}" onclick="showAdmindetails('${row.AdminId}', '${row.state}', '${row.Name}')" >Remove</a>-->
                                                            <button href="#modalCenter"  class="btn btn-outline-danger btn-sm" data-bs-toggle="modal" id="${row.AdminId}" onclick="showAdmindetails('${row.AdminId}', '${row.state}', '${row.Name}', '${row.city}')" >Remove</button>
                                                        </td>   
                                                    </c:if>
                                                    <c:if test="${row.ElectionStatus == 'Started'}">
                                                        <td style="background-color: #28a745; color: white;"><c:out value="${row.ElectionStatus}"></c:out></td>
                                                            <td class="addbutton">
                                                                <button href="#modalCenter"  class="btn btn-outline-danger btn-sm" data-bs-toggle="modal" id="${row.AdminId}" onclick="showAdmindetails('${row.AdminId}', '${row.state}', '${row.Name}', '${row.city}')"  disabled >Remove</button>
                                                        </td>
                                                    </c:if>

                                                <div id="modalCenter" class="modal fade" tabindex="-1">
                                                    <div class="modal-dialog modal-dialog-centered">

                                                        <div class="modal-content"  style="padding: 15px;">
                                                            <div class="modal-header" style="background-color: #dc3545;color: white">
                                                                <h5 class="modal-title">Remove Admin Alert</h5>
                                                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                                            </div>

                                                            <b> <h4>Are you sure, you want to remove Admin whose details are display below :-</b></h4>
                                                            <form action="admindashboard/removeadmin" method="post" class="form-control">
                                                                <!--<form action="removeadmin" method="post">-->
                                                                <b>AdminID :</b>
                                                                <input class="form-control" type="text" name="aid" id="aididinput" readonly>
                                                                <b>Name :</b>
                                                                <input class="form-control" type="text" name="name" id="aidnameinput"  readonly>
                                                                <b>State</b>
                                                                <input class="form-control" type="text" name="state" id="aidstateinput"  readonly>
                                                                <b>City</b>
                                                                <input class="form-control" type="text" name="city" id="aidcityinput"  readonly>
                                                                <div class="modal-footer">
                                                                    <button type="submit" class="btn btn-primary" data-bs-dismiss="modal">Yes</button>
                                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">No</button>
                                                                </div>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--</div>-->
                                                <%--</c:forEach>--%>
                                            </c:forEach>
                                        </table>
                                    </div> <!-- end of city admin table -->

                                    <!--*****************************************************************************************************************************************************************************************************-->


                                    <sql:query dataSource="${ds}" var="data">
                                        SELECT * FROM candidate WHERE state = "${stateadminstate}" and (position = 'MLA' or position = 'MP') and wardno = 0;
                                    </sql:query>

                                    <div class="table-responsive" id="subadmincandidatetablediv">
                                        <table class="table" style="font-weight: bold;  text-align: center;">
                                            <thead class="sticky-header">
                                                <tr>
                                                    <td>Sr No.</td>
                                                    <td>VoterID</td>
                                                    <td>Candidate Name</td>
                                                    <td>Election of (Position)</td>
                                                    <td>Party Name</td>
                                                    <td>Party Logo</td>
                                                    <td>State</td>
                                                    <td>City</td>
                                                    <td>Remove Candidate</td>
                                                </tr>
                                            </thead>
                                            <%--<c:forEach begin="1" end="10" >--%>
                                            <c:set var="srno" value="${0}" />
                                            <c:forEach var="row" items="${data.rows}">
                                                <tr style="font-weight: bold;">

                                                    <c:set var="srno" value="${srno + 1}" />
                                                    <td><c:out value="${srno}" /></td>
                                                    <td><c:out value="${row.VoterID}"></c:out></td>
                                                    <td><c:out value="${row.candidate_name}"></c:out></td>
                                                    <td><c:out value="${row.position}"></c:out></td>
                                                    <td><c:out value="${row.party_name}"></c:out></td>
                                                        <td>
                                                        <c:out value="${row.party_logo}"></c:out>
                                                        </td>
                                                        <!--<td><img src="<c:url value='/resources/img/${row.party_logo}' />" class="rounded" style="width :50px ;height : 50px;border-radius: 50%;"></td>-->
                                                    <%--<c:out value="${row.party_logo}" />--%>
                                                    <td><c:out value="${row.state}"></c:out></td>
                                                    <td><c:out value="${row.city}"></c:out></td>
<!--                                                        <td class="addbutton">   
                                                            <button href="#modalCenter2"  class="btn btn-outline-danger btn-sm" data-bs-toggle="modal" id="${row.VoterID}" onclick="showCandidatedetails('${row.VoterID}', '${row.state}', '${row.candidate_name}', '${row.city}')" >Remove</button>
                                                    </td> -->
                                                    
                                                    <td class="addbutton">
                                                        <c:if test="${stateadminelectionstatus == 'Started'}">
                                                            <button href="#modalCenter2"  class="btn btn-outline-danger btn-sm" data-bs-toggle="modal" id="${row.VoterID}" onclick="showCandidatedetails('${row.VoterID}', '${row.state}', '${row.candidate_name}', '${row.city}')"  disabled>Remove</button>
                                                        </c:if>
                                                        <c:if test="${stateadminelectionstatus == 'Not started'}">
                                                            <button href="#modalCenter2"  class="btn btn-outline-danger btn-sm" data-bs-toggle="modal" id="${row.VoterID}" onclick="showCandidatedetails('${row.VoterID}', '${row.state}', '${row.candidate_name}', '${row.city}')" >Remove</button>
                                                        </c:if>
                                                    </td>



                                                <div id="modalCenter2" class="modal fade" tabindex="-1">
                                                    <div class="modal-dialog modal-dialog-centered">

                                                        <div class="modal-content"  style="padding: 15px;">
                                                            <div class="modal-header" style="background-color: #dc3545;color: white">
                                                                <h5 class="modal-title">Remove Candidate Alert</h5>
                                                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                                            </div>

                                                            <b> <h4>Are you sure, you want to remove candidate whose details are display below :-</b></h4>
                                                            <form action="admindashboard/removecandidate" method="post" class="form-control">
                                                                <!--<form action="removeadmin" method="post">-->
                                                                <b>VoterID :</b>
                                                                <input class="form-control" type="text" name="vid" id="cididinput" readonly>
                                                                <b>Candidate Name :</b>
                                                                <input class="form-control" type="text" name="cname" id="cidnameinput"  readonly>
                                                                <b>State</b>
                                                                <input class="form-control" type="text" name="state" id="cidstateinput"  readonly>
                                                                <b>City</b>
                                                                <input class="form-control" type="text" name="city" id="cidcityinput"  readonly>
                                                                <div class="modal-footer">
                                                                    <button type="submit" class="btn btn-primary" data-bs-dismiss="modal">Yes</button>
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
                                    <!-- end of city admin table -->


                                </div> <!--  // 2nd col div ends  -->
                                <!--==============================================================================================================================================================================================================================================================================================-->

                                <!--<div class="col-sm-2">-->
                                <div id="col3" class="colm">

                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="card border-primary mb-3">
                                                <div class="card-header" style="font-weight: bold"><i class="fa fa-user-plus fa-6" aria-hidden="true"></i>   Add Candidate</div>
                                                <div class="card-body text-primary">
                                                    <p class="card-title" >You can only able to add one admin for each state not more than that.</p>
                                                    <center><button class="btn btn-outline-primary btn-sm"  id="btn1" onclick="addNewCandidate()">Add Candidate</button></center>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-12">
                                            <div class="card border-success mb-3">
                                                <div class="card-header" style="font-weight: bold"><i class="fa fa-pencil" aria-hidden="true"></i>  Edit Candidate</div>
                                                <div class="card-body text-success">
                                                    <p class="card-title" >You can only edit candidate details of your city.</p>

                                                    <center><button class="btn btn-outline-success btn-sm" id="btn2" onclick="editCandidate()">Edit Candidate</button></center>
                                                </div>  
                                            </div>
                                        </div>
                                        <div class="col-sm-12">
                                            <div class="card border-danger mb-3">
                                                <div class="card-header"><i class="fa fa-user-times" aria-hidden="true"></i>   Candidate</div>
                                                <div class="card-body text-danger">
                                                    <p class="card-title" style="font-weight: normal">If you want to change the Candidate then you have to remove that Candidate and add new Candidate.<br></p>

                                                    <!--<button class="btn btn-outline-danger btn-sm"  id="btn3">Remove Admin</button>-->
                                                </div>
                                                <!--<button class="btn btn-outline-danger btn-sm"  id="btn3">Remove Admin</button>-->
                                            </div>
                                        </div>
                                    </div>
                                </div> <!--  // 3rd col div ends  -->
                            </div>  <!-- row div ends -->
                            </div>
                            </body>

                            <script>

                                function  displaybtnname()
                                {
                                    var electionstatus = document.getElementById("electionprocessstatusid");

                                    var displaystatusincontent = document.getElementById("electionprocessstatuscontentid");
                                    var btntext = document.getElementById("electionprocessbtnid");
                                    //                                                    alert("btn value = " + btntext.innerHTML);
                                    electionstatus.innerHTML = btntext.innerHTML;
                                    displaystatusincontent.innerHTML = btntext.innerHTML;
                                }

                                function addNewAdmin()
                                {
                                    window.open("/Admin/login/admindashboard/addsubadmin", "_self");
//                                    window.open("https://online-evoting.herokuapp.com/Admin/login/admindashboard/addsubadmin", "_self");
                                }
                                function editAdmin()
                                {
                                    window.open("/Admin/login/admindashboard/editsubadmin", "_self");
//                                    window.open("https://online-evoting.herokuapp.com/Admin/login/admindashboard/editsubadmin", "_self");
                                }

                                function addNewCandidate()
                                {
                                    window.open("/Admin/login/admindashboard/addcandidate", "_self");
//                                    window.open("https://online-evoting.herokuapp.com/Admin/login/admindashboard/addcandidate", "_self");
                                }
                                function editCandidate()
                                {
                                    window.open("/Admin/login/admindashboard/editcandidate", "_self");
//                                    window.open("https://online-evoting.herokuapp.com/Admin/login/admindashboard/editcandidate", "_self");
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

                                function setcandidatedetails(vid, state, cname, city)
                                {
                                    //                                                                                            alert("function called = " + aid + " " + state + name);              
                                    document.getElementById('cididinput').value = vid;
                                    document.getElementById('cidnameinput').value = cname;
                                    document.getElementById('cidstateinput').value = state;
                                    document.getElementById('cidcityinput').value = city;

                                }
                                function showCandidatedetails(vid, state, cname, city)
                                {
                                    setcandidatedetails(vid, state, cname, city);
                                }
                                //                                                                                      

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
//                                    window.open("https://online-evoting.herokuapp.com/Admin/login", "_self");
                                <%
                                    }


                                %>
                                <%                                                    response.setHeader("Cache-control", "no-cache,no-store,must-revalidate");
                                %>

                                            var btnclassname = document.getElementById("electionprocessbtnid");
                                            var electionstatusofadmininput = document.getElementById("hiddenelectionstatusininput");


                                            if (electionstatusofadmininput.value === 'Not started')
                                            {
                                                btnclassname.className = "btn btn-success";
                                                btnclassname.value = "Start Election";
                                                btnclassname.innerHTML = "Start Election";
                                            } else if (electionstatusofadmininput.value === 'Started')
                                            {
                                                btnclassname.className = "btn btn-danger";
                                                btnclassname.value = "Stop Election";
                                                btnclassname.innerHTML = "Stop Election";
                                            }
                                }


                                //                        SELECT * FROM Admin WHERE city IS NULL AND state IS NOT NULL ;
                                //                        SELECT * FROM Admin WHERE city IS NULL ;




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
