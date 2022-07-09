<%-- 
    Document   : Login
    Created on : 10 May, 2022, 9:13:16 AM
    Author     : Admin
--%>

<%@page import="VotingSystemController.OnlinevotingDBConnection"%>
<%@page import="java.sql.*"%>
<%@page errorPage="ErrorPage.jsp" %>
<%@page errorPage="ErrorPage.jsp" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@page import="VotingSystemController.Mail"%>
<%@page import="java.util.Random"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <title>Give Vote</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

        <link href='<c:url value="/resources/css/Form_CSS.css" />' rel="stylesheet">

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/angular.js/1.8.3/angular.min.js" integrity="sha512-KZmyTq3PLx9EZl0RHShHQuXtrvdJ+m35tuOiwlcZfs/rE7NZv29ygNA8SFCkMXTnYZQK2OX0Gm2qKGfvWEtRXA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.4.5/angular.min.js"></script>

        <link href="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js">
        <link src="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>

        <link src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js">
        <link href="<c:url value="/resources/css/Votervotingdashboard_CSS.css" />" rel="stylesheet">
        <link href="<c:url value='/resources/css/Header_CSS.css' />" rel="stylesheet">

        <script src="extensions/mobile/bootstrap-table-mobile.js"></script>

    </head>
    <body onload="loadpage()">
        <%@include file="Header.jsp" %>

        <div class="container" >
            <form  class="form" method="post" action="Votingdashboard/emailverification" >
                <!--<form  class="form" action="Votingdashboard" method="post">-->

                <div class="regformheading">
                    <center><u><h3>${voterloginheading}</h3></u></center>
                </div>
                <br>
                <div class="alert alert-danger"  id="erroriddiv">
                    <h5  id="errorid">${error}</h5>
                </div>

                <div class="form-row">
                    <div class="form-group col-md-6">        
                        <label for="vidid">Voter ID</label>
                        <input type="text" class="form-control" placeholder="VoterID" name="vid" value="${r.vid}" id="vidid" readonly>
                    </div>
                    <!--                </div>
                                    <div class="form-row">-->
                    <div class="form-group col-md-6">        
                        <label for="nameid">Name</label>
                        <input type="text" class="form-control" placeholder="Name" name="name" id="nameid" value='${r.name}' readonly>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group col-md-6">        
                        <label for="dobid">Date Of Birth</label>
                        <input type="text" class="form-control" placeholder="dob" name="dob" value="${r.dob}" id="dobid" readonly>
                    </div>
                    <!--                </div>
                    
                                    <div class="form-row">-->
                    <div class="form-group col-md-6">        
                        <label for="wardnoid">Ward No.</label>
                        <input type="text" class="form-control" placeholder="wardno" name="wardno" id="wardnoid" value='${r.wardno}' readonly>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group col-md-6">        
                        <label for="wardnoid">State</label>
                        <input type="text" class="form-control" name='state' value="${r.state}" readonly>
                    </div>
                    <!--                </div>
                    
                                    <div class="form-row">-->
                    <div class="form-group col-md-6">        
                        <label for="wardnoid">City</label>
                        <input type="text" class="form-control"  name='city' value="${r.city}" id="cityid" readonly>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group col-md-6">        
                        <label for="wardnoid">Village</label>
                        <input type="text" class="form-control" name="village" value="${r.village}" id="wardnoid"  readonly>
                    </div>
                    <!--                </div>
                    
                                    <div class="form-row">-->
                    <div class="form-group col-md-6">        
                        <label for="wardnoid">Area</label>
                        <input type="text" class="form-control"  name="area" value="${r.area}" id="wardnoid" readonly>
                    </div>

                    <div class="form-group col-md-6" hidden>        
                        <label for="emailid">Email ID</label>
                        <input type="email" class="form-control" placeholder="Email id" name="email" id="emailid" required data-toggle="popover" title="Email ID" data-content="You will receive Email Verification code at the time of registration and online Voting.So enter appropriate emailid" value='${r.email}' readonly>
                    </div>
                </div>

                <sql:setDataSource driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3308/onlinevotingsystemdb" password="" user="root" var="ds" />




                <!--SELECT * FROM candidate WHERE state = 'Gujarat';-->
                <!--SELECT * FROM candidate WHERE state = 'Gujarat' and city = '${r.city}' and village = '${r.village}' and area = '${r.area}' and wardno = ${r.wardno};-->

                
                <!--perfect-->
                <!--SELECT * FROM candidate WHERE state = '${r.state}' and city = '${r.city}' and village = '${r.village}' and area = '${r.area}' and wardno = ${r.wardno};-->
                <sql:query dataSource="${ds}" var="data">

                    SELECT * FROM candidate WHERE state = '${r.state}' and city = '${r.city}';
                </sql:query>

                <br>
                <br>


                <div class="form-row">

                    <div class="table-responsive" id="votervotingdashboardtablediv" >
                        <table class="table" style="font-weight: bold;  text-align: center;">
                            <thead class="sticky-header">
                                <tr>
                                    <td>Sr No. </td>       
                                    <!--<td>VoterID</td>-->
                                    <td>Candidate Name</td>
                                    <td>Election of (Position)</td>
                                    <td>Party Name</td>
                                    <td>Party Logo</td>
                                    <!--                                    <td>State</td>
                                                                        <td>City</td>
                                                                        <td>Area</td>
                                                                        <td>Village</td>-->
                                    <td>Vote</td>
                                </tr>
                            </thead>
                            <%--<c:forEach begin="1" end="10" >--%>
                            <c:set var="srno" value="${0}" />
                            <c:forEach var="row" items="${data.rows}">
                                <tr style="font-weight: bold;">

                                    <c:set var="srno" value="${srno + 1}" />
                                    <td><c:out  value="${srno}" /></td>
                                    <!--<td><c:out value="${row.wardno}" /></td>-->
                                    <!--<td><c:out value="${row.VoterID}"></c:out></td>-->
                                    <td><c:out value="${row.candidate_name}"></c:out></td>
                                    <td><c:out value="${row.position}"></c:out></td>
                                    <td><c:out value="${row.party_name}"></c:out></td>
                                        <td>
                                        <c:out value="${row.party_logo}"></c:out>
                                        </td>
                                        <!--<td><img src="<c:url value='/resources/img/${row.party_logo}' />" class="rounded" style="width :50px ;height : 50px;border-radius: 50%;"></td>-->
                                    <%--<c:out value="${row.party_logo}" />--%>
                                    <!--<td><c:out value="${row.state}"></c:out></td>-->
                                    <!--<td><c:out value="${row.city}"></c:out></td>-->
                                    <!--<td><c:out value="${row.area}"></c:out></td>-->
                                    <!--<td><c:out value="${row.village}"></c:out></td>-->
                                        <td class="addbutton">   
                                            <button type="button" href="#modalCenter2" class="btn btn-outline-success btn-sm" data-bs-toggle="modal" id="${row.VoterID}" onclick="showCandidatedetails('${row.VoterID}', '${row.state}', '${row.candidate_name}', '${row.city}', '${row.village}', '${row.area}', '${row.wardno}', '${row.party_name}')" >Vote</button>
                                        <!--<button  type="button" href="#modalCenter"  class="btn btn-outline-danger btn-sm" data-bs-toggle="modal" id="${row.VoterID}" onclick="showCandidatedetails('${row.VoterID}', '${row.state}', '${row.candidate_name}', '${row.city}', '${row.village}', '${row.area}', ${row.wardno})" >Remove</button>-->


                                    </td>   



                                <div id="modalCenter2" class="modal fade" tabindex="-1">
                                    <div class="modal-dialog modal-dialog-centered">

                                        <div class="modal-content"  style="padding: 15px;">
                                            <div class="modal-header" style="background-color: #dc3545;color: white">
                                                <h5 class="modal-title">Confirm Vote Alert</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                            </div>

                                            <b> <h6>Are you sure, you want to vote to candidate whose details are display below :-</b></h6>
                                            <!--<form  class="form-control" style="font-weight: bold;">-->
                                            <!--<form action="removeadmin" method="post">-->
                                            <b hidden>VoterID :</b>
                                            <input class="form-control" type="text" name="candidatevid" id="cididinput" readonly style="font-weight: bold;" hidden>
                                            <b>Candidate Name :</b>
                                            <input class="form-control" type="text" name="cname" id="cidnameinput"  readonly style="font-weight: bold;">
                                            <br>
                                            <b>Party Name :</b>
                                            <input class="form-control" type="text" name="partyname" id="partynameinput"  readonly style="font-weight: bold;">
                                            <b hidden>State</b>
                                            <input class="form-control" type="text" name="cstate" id="cidstateinput"  readonly style="font-weight: bold;" hidden>
                                            <b hidden>City</b>
                                            <input class="form-control" type="text" name="ccity" id="cidcityinput"  readonly style="font-weight: bold;" hidden>
                                            <b hidden id="villagelabel">Village</b>
                                            <input class="form-control" type="text" name="cvillage" id="cidvillageinput"  readonly style="font-weight: bold;" hidden>
                                            <b id="arealabel" hidden>Area</b>
                                            <input class="form-control" type="text" name="carea" id="cidareainput"  readonly style="font-weight: bold;" hidden>
                                            <b hidden>Ward No.</b>
                                            <input class="form-control" type="number" name="cwardno" id="cidwardnoinput"  readonly style="font-weight: bold;" hidden>
                                            <div class="modal-footer">
                                                <button type="submit" class="btn btn-primary" href="#modalCenter4" data-bs-dismiss="modal" data-bs-toggle="modal">Yes</button>
                                                <!--<button href="#modalCenter2"  class="btn btn-outline-success btn-sm" data-bs-toggle="modal" id="${row.VoterID}" onclick="showCandidatedetails('${row.VoterID}', '${row.state}', '${row.candidate_name}', '${row.city}', '${row.village}', '${row.area}', '${row.wardno}')" >Vote</button>-->
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">No</button>
                                            </div>
                                            <!--</form>-->
                                        </div>
                                    </div>
                                </div>

                            </c:forEach>

                            <%--</c:forEach>--%>
                        </table>
                    </div>

                </div>

                <center>
                    <!--<button type="submit" class="btn btn-outline-primary">Login</button>-->
                </center>
            </form>

        </div>

                        <br><br><br><br>
        <!--<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>-->
    </body>

    <script>
        function loadpage()
        {

            var data = document.getElementById('errorid').innerHTML;
//            alert("data = " + data);
            if (data.length == 0)
            {
//                alert("data = " + data);
                document.getElementById('erroriddiv').style.display = "none";
                document.getElementById('errorid').style.display = "none";
            }
        }



        function setcandidatedetails(vid, state, cname, city, village, area, wardno, partyname)
        {
//                                            alert("function called = " + vid + " " + state + name);              
            document.getElementById('cididinput').value = vid;
            document.getElementById('cidnameinput').value = cname;
            document.getElementById('cidstateinput').value = state;
            document.getElementById('cidcityinput').value = city;
            document.getElementById('cidvillageinput').value = village;
            document.getElementById('cidwardnoinput').value = wardno;
            document.getElementById('cidareainput').value = area;
            document.getElementById('partynameinput').value = partyname;

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
        function showCandidatedetails(vid, state, cname, city, village, area, wardno, partyname)
        {
            setcandidatedetails(vid, state, cname, city, village, area, wardno, partyname);
        }


        function preventBack() {
            window.history.forward();
        }
        setTimeout("preventBack()", 0);
        window.onunload = function () {
            null
        };

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
