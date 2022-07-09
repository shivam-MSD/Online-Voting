<%-- 
    Document   : CityAdminDashboard
    Created on : 19 May, 2022, 4:57:31 PM
    Author     : Admin
--%>

<%-- 
    Document   : Admindashboard
    Created on : 12 May, 2022, 8:06:04 PM
    Author     : Admin
--%>

<%@page errorPage="500_ErrorPage.jsp" %>
<%@page import="java.util.Random"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Subadmin Dashboard</title>

        <link href="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js">
        <link src="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>

<!--<link href="<c:url value='/resources/css/Form_CSS.css' />" rel="stylesheet">-->
        <link href="<c:url value='/resources/css/AdminHeader_CSS.css' />" rel="stylesheet">
        <link href="<c:url value='/resources/css/Subadmindashboard_CSS.css' />" rel="stylesheet">
        <link href="<c:url value='/resources/js/AdminHeaddashboard.js' />" rel="stylesheet">


    </head>


    <body onload="loadpage()">
        <%! String state = "";
            String city = "";
            String aid = "";
            String loginstatus = "";%>


        <%! String cityadminid;%>

        <%
            response.setHeader("Cache-control", "no-cache,no-store,must-revalidate");
        %>

        <sql:setDataSource driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3308/onlinevotingsystemdb" password="" user="root" var="ds" />

        <!--SELECT * FROM Admin WHERE city IS NULL AND state IS NULL ;-->
        <sql:query dataSource="${ds}" var="data">
            SELECT * FROM Admin WHERE AdminId = '<%=  cityadminid%>';
        </sql:query>

        <c:forEach var="row" items="${data.rows}">
            <c:set var="subadminaid" value="${row.AdminId}" />
            <c:set var="subadminname" value="${row.name}" />
            <c:set var="subadminstate" value="${row.state}" />
            <c:set var="subadmincity" value="${row.city}" />
            <c:set var="subadminelectionstatus" value="${row.ElectionStatus}" />
        </c:forEach>


        <%@include file="AdminHeader.jsp" %>

        <div class="container" >
            <!--<br> <br> <br> <br> <br> <br> <br> <br> <br>-->
            <div class="row">
                <div class="col-sm-12"> 
                    <!--<div class="col-md-4">--> 
                    <div class="row">
                        <div class="col-sm-4">
                            <div class="card border-primary mb-3" style="max-width: 100%; max-height: 300px;">
                                <div class="card-header"><i class="fa fa-user-plus fa-6" aria-hidden="true"></i>   Add Candidate</div>
                                <div class="card-body text-primary">
                                    <p class="card-title">To add new admin, click on <b>Add Candidate</b> button.<br>You can only able to add one candidate per area from each election party, not more than that.</p>

                                    <!--<div class="cardimgid"><img src="<c:url value='/resources/img/addcandidate.jpg' />" ></div>-->
                                    <c:if test="${subadminelectionstatus == 'Started'}">
                                        <center><button class="btn btn-outline-primary btn-sm"  id="btn1" onclick="addNewCityCandidate()" disabled>Add Candidate</button></center>
                                        </c:if>
                                        <c:if test="${subadminelectionstatus == 'Not started'}">
                                        <center><button class="btn btn-outline-primary btn-sm"  id="btn1" onclick="addNewCityCandidate()">Add Candidate</button></center>
                                        </c:if>

                                </div>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="card border-success mb-3" style="max-width: 100%;">
                                <div class="card-header"><i class="fa fa-pencil" aria-hidden="true"></i>  Edit Candidate</div>
                                <div class="card-body text-success">
                                    <p class="card-title">To edit admin details, click on <b>Edit Candidate</b> button.<br>You can only edit candidate of particular area of city.<br><br></p>

                                    <c:if test="${subadminelectionstatus == 'Started'}">
                                        <center><button class="btn btn-outline-success btn-sm" id="btn2" onclick="editCityCandidate()" disabled>Edit Candidate</button></center>
                                        </c:if>
                                        <c:if test="${subadminelectionstatus == 'Not started'}">
                                        <center><button class="btn btn-outline-success btn-sm" id="btn2" onclick="editCityCandidate()">Edit Candidate</button></center>
                                        </c:if>

                                </div>  
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="card border-danger mb-3" style=" max-width: 100%;">
                                <div class="card-header"><i class="fa fa-user-times" aria-hidden="true"></i>   Remove Candidate</div>
                                <div class="card-body text-danger">
                                    <p class="card-title">You can only able to remove Candidate if the election process in not in progress.<br><br>If you want to change the Candidate then you have to remove that Candidate and add new Candidate.<br></p>

                                </div>

                            </div>
                        </div>
                    </div>

                    <br> <br> <br> <br>

                    <!--============================================================================================================================================================================-->

                    <sql:setDataSource driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3308/onlinevotingsystemdb" password="" user="root" var="ds" />

                    <!--SELECT * FROM Admin WHERE city IS NULL AND state IS NULL ;-->
                    <sql:query dataSource="${ds}" var="data">
                        SELECT * FROM Admin WHERE AdminId = '<%=  cityadminid%>';
                    </sql:query>

                    <c:forEach var="row" items="${data.rows}">
                        <c:set var="subadminaid" value="${row.AdminId}" />
                        <c:set var="subadminname" value="${row.name}" />
                        <c:set var="subadminstate" value="${row.state}" />
                        <c:set var="subadmincity" value="${row.city}" />
                        <c:set var="subadminelectionstatus" value="${row.ElectionStatus}" />
                    </c:forEach>

                    <div class="col-sm-12" id="subadminheaderaiddisplay"> 
                        <center>

                            <!--                            <table>-->
                            <!--<tr>-->



                            <div id="modalCenter3" class="modal fade" tabindex="-1">
                                <div class="modal-dialog modal-dialog-centered">

                                    <div class="modal-content"  style="padding: 15px;">
                                        <div class="modal-header" style="background-color: #dc3545;color: white">
                                            <h5 class="modal-title"><div id="electionprocessstatusid"></div> Process Alert</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                        </div>
                                        <form class="form" action="subadmindashboard/startelectionprocessincity" method="post">
                                            <div class="modal-body">
                                                <b> <h5 style="color: black;">Are you sure, you want to <div id="electionprocessstatuscontentid"></div> process ?</h5></b>
                                                <b hidden>Adminid</b>
                                                <input type="text" value="${subadminaid}" name="aid" class="form-control" hidden>
                                            </div>

                                            <div class="modal-footer">
                                                <button type="submit" class="btn btn-primary" data-bs-dismiss="modal" onclick="Electionprocess()">Yes</button>
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">No</button>
                                            </div>
                                        </form>
                                    </div>

                                </div>
                            </div>








                            <table>              
                                <tr>
                                    <td>
                                <center>
                                    <h1 id="adminheaderaiddisplay">
                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        <i class="fa fa-user" aria-hidden="true"></i>&nbsp;

                                        <c:out value= "${subadminaid}" />'s Dashboard &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        <%--<c:out value= "${subadminname}" />--%>

                                        <!--&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-->  
                                    </h1>
                                    <center>
                                        </td>
                                        <td>
                                            <!--                                            <div class="adminlogout">
                                                                                            <form action="subadmindashboard/logout" method="post" ><button type="submit" class="btn btn-primary" id="logoutid">Log Out</button></form>
                                                                                        </div> -->

                                            <h1><c:out value= "${subadminname}" /></h1>

                                        </td>
                                        </tr>
                                        <tr>

                                            <td>
                                                <!--                                    <div  style="width: 500px; height: 50px; background-color: white; padding: 5px; color: black;"></div>-->
                                                <!--<input type="text" id="electionstatusininput" readonly>-->
                                                <input type="text" id="hiddenelectionstatusininput" value="<c:out value= '${subadminelectionstatus}' />" hidden>
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
                                                <form action="subadmindashboard/logout" method="post" ><button type="submit" class="btn btn-primary" id="logoutid">Log Out</button></form>
                                            </div> 
                                        </td>
                                        </tr>
                                        </table>
                                    </center>
                                    </div>

                                    <!--SELECT * FROM candidate WHERE state = "Gujarat" and city = "vadodara" and (position = 'Mayor' or position = 'Sarpanch') order by wardno asc;-->
                                    <sql:query dataSource="${ds}" var="data">
                                        SELECT * FROM candidate WHERE state = "${subadminstate}" and city = "${subadmincity}" and (position = 'Mayor' or position = 'Sarpanch') order by wardno asc;
                                    </sql:query>

                                    <div class="table-responsive" id="subadmincandidatetablediv">
                                        <table class="table" style="font-weight: bold;  text-align: center;">
                                            <thead class="sticky-header">
                                                <tr>
                                                    <td>Ward No.</td>
                                                    <td>VoterID</td>
                                                    <td>Candidate Name</td>
                                                    <td>Election of (Position)</td>
                                                    <td>Party Name</td>
                                                    <td>Party Logo</td>
                                                    <td>State</td>
                                                    <td>City</td>
                                                    <td>Area</td>
                                                    <td>Village</td>
                                                    <td>Remove Candidate</td>
                                                </tr>
                                            </thead>
                                            <%--<c:forEach begin="1" end="10" >--%>
                                            <c:set var="srno" value="${0}" />
                                            <c:forEach var="row" items="${data.rows}">
                                                <tr style="font-weight: bold;">

                                                    <%--<c:set var="srno" value="${srno + 1}" />--%>
                                                    <td><c:out value="${row.wardno}" /></td>
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
                                                    <td><c:out value="${row.area}"></c:out></td>
                                                    <td><c:out value="${row.village}"></c:out></td>
                                                    <td class="addbutton">
                                                        <c:if test="${subadminelectionstatus == 'Started'}">
                                                            <button href="#modalCenter2"  class="btn btn-outline-danger btn-sm" data-backdrop='static' data-keyboard='false' data-bs-toggle="modal" id="${row.VoterID}" onclick="showCandidatedetails('${row.VoterID}', '${row.state}', '${row.candidate_name}', '${row.city}', '${row.village}', '${row.area}', ${row.wardno})" disabled>Remove</button>
                                                        </c:if>
                                                        <c:if test="${subadminelectionstatus == 'Not started'}">
                                                            <button href="#modalCenter2"  class="btn btn-outline-danger btn-sm" data-backdrop='static' data-keyboard='false' data-bs-toggle="modal" id="${row.VoterID}" onclick="showCandidatedetails('${row.VoterID}', '${row.state}', '${row.candidate_name}', '${row.city}', '${row.village}', '${row.area}', ${row.wardno})" >Remove</button>
                                                        </c:if>
                                                    </td>



                                                <div id="modalCenter2" class="modal fade" tabindex="-1" data-keyboard="false" data-backdrop="static" >
                                                    <div class="modal-dialog modal-dialog-centered">

                                                        <div class="modal-content"  style="padding: 15px;">
                                                            <div class="modal-header" style="background-color: #dc3545;color: white">
                                                                <h5 class="modal-title">Remove Candidate Alert</h5>
                                                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                                            </div>

                                                            <b> <h6>Are you sure, you want to remove candidate whose details are display below :-</b></h6>
                                                            <form action="subadmindashboard/removecitycandidate" method="post" class="form-control" style="font-weight: bold;">
                                                                <!--<form action="removeadmin" method="post">-->
                                                                <b>VoterID :</b>
                                                                <input class="form-control" type="text" name="vid" id="cididinput" readonly style="font-weight: bold;">
                                                                <b>Candidate Name :</b>
                                                                <input class="form-control" type="text" name="cname" id="cidnameinput"  readonly style="font-weight: bold;">
                                                                <b>State</b>
                                                                <input class="form-control" type="text" name="state" id="cidstateinput"  readonly style="font-weight: bold;">
                                                                <b>City</b>
                                                                <input class="form-control" type="text" name="city" id="cidcityinput"  readonly style="font-weight: bold;">
                                                                <b id="villagelabel">Village</b>
                                                                <input class="form-control" type="text" name="state" id="cidvillageinput"  readonly style="font-weight: bold;">
                                                                <b id="arealabel">Area</b>
                                                                <input class="form-control" type="text" name="area" id="cidareainput"  readonly style="font-weight: bold;">
                                                                <b>Ward No.</b>
                                                                <input class="form-control" type="number" name="wardno" id="cidwardnoinput"  readonly style="font-weight: bold;">
                                                                <div class="modal-footer">
                                                                    <button type="submit" class="btn btn-primary" data-bs-dismiss="modal" onclick="">Yes</button>
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


                                        function  displaybtnname()
                                        {
                                            var electionstatus = document.getElementById("electionprocessstatusid");

                                            var displaystatusincontent = document.getElementById("electionprocessstatuscontentid");
                                            var btntext = document.getElementById("electionprocessbtnid");
//                                                    alert("btn value = " + btntext.innerHTML);
                                            electionstatus.innerHTML = btntext.innerHTML;
                                            displaystatusincontent.innerHTML = btntext.innerHTML;
                                        }


//                                        function Electionprocess()
//                                        {
//
//                                            var btnclassname = document.getElementById("electionprocessbtnid");
////                                            alert("colour = " + btnclassname.className);
//                                            if (btnclassname.className === "btn btn-success")
//                                            {
////                                                alert("green");
//                                                btnclassname.className = "btn btn-danger";
//                                                btnclassname.value = "Stop Election";
//                                                btnclassname.innerHTML = "Stop Election";
//
//
//                                            } else if (btnclassname.className === "btn btn-danger")
//                                            {
////                                                alert("red");
//                                                btnclassname.className = "btn btn-primary";
//                                                btnclassname.value = "Reset Election";
//                                                btnclassname.innerHTML = "Reset Election";
//                                            } else if (btnclassname.className === "btn btn-primary")
//                                            {
////                                                alert("blue");
//                                                btnclassname.className = "btn btn-success";
//                                                btnclassname.value = "Start Election";
//                                                btnclassname.innerHTML = "Start Election";
//                                            }
//
//                                        }

                                        function addNewCityCandidate()
                                        {
                                            window.open("/Subadmin/login/subadmindashboard/addcitycandidate", "_self");
//                                            window.open("https://online-evoting.herokuapp.com/Subadmin/login/subadmindashboard/addcitycandidate", "_self");
                                        }
                                        function editCityCandidate()
                                        {
                                            window.open("/Subadmin/login/subadmindashboard/editcitycandidate", "_self");
//                                            window.open("https://online-evoting.herokuapp.com/Subadmin/login/subadmindashboard/editcitycandidate", "_self");
                                        }

                                        function setcandidatedetails(vid, state, cname, city, village, area, wardno)
                                        {
                                            //                                                                                            alert("function called = " + aid + " " + state + name);              
                                            document.getElementById('cididinput').value = vid;
                                            document.getElementById('cidnameinput').value = cname;
                                            document.getElementById('cidstateinput').value = state;
                                            document.getElementById('cidcityinput').value = city;
                                            document.getElementById('cidvillageinput').value = village;
                                            document.getElementById('cidwardnoinput').value = wardno;
                                            document.getElementById('cidareainput').value = area;

                                            if (village === "")
                                            {
                                                document.getElementById('cidvillageinput').style.display = "none";
                                                document.getElementById('villagelabel').style.display = "none";
                                            } else if (area === "")
                                            {
                                                document.getElementById('cidareainput').style.display = "none";
                                                document.getElementById('arealabel').style.display = "none";
                                            }

                                        }
                                        function showCandidatedetails(vid, state, cname, city, village, area, wardno)
                                        {
//                                            alert(vid + "-" + state + "-" + cname + "-" +  city + "-" +  village + "-" +  area + "-" +  wardno);
                                            setcandidatedetails(vid, state, cname, city, village, area, wardno);
                                        }

                                        function loadpage()
                                        {
                                        <%
                                            session = (HttpSession) request.getSession(false);
                                            cityadminid = (String) session.getAttribute("cityadminid");
                                            if (cityadminid == null) {
//                                                    RequestDispatcher rd = request.getRequestDispatcher("AllAdminlogin.jsp");
//                                                    rd.forward(request, response); 
                                        %>
                                            window.open("/Subadmin/login", "_self");
//                                            window.open("https://online-evoting.herokuapp.com/Subadmin/login", "_self");
                                        <%
                                            }


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
