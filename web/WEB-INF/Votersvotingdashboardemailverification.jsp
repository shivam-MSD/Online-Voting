<%-- 
    Document   : Votersvotingdashboardemailverification
    Created on : 22 May, 2022, 3:35:42 PM
    Author     : Admin
--%>

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
            <form  class="form" method="post" action="emailverification/verifying" >
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
                </div>

                    <div class="form-row" hidden>
                    <div class="form-group col-md-6">        
                        <label for="candidatenameid">Candidate Name</label>
                        <input type="text" class="form-control" name="cname" value="${r.cname}" id="candidatenameid"  readonly>
                    </div>
                    <!--                </div>
                    
                                    <div class="form-row">-->
                    <div class="form-group col-md-6">        
                        <label for="partynameid">Party Name</label>
                        <input type="text" class="form-control"  name="partyname" value="${r.partyname}" id="partynameid" readonly>
                    </div>

                    <div class="form-group col-md-6">        
                        <label for="partynameid">Candidatevid</label>
                        <input type="text" class="form-control"  name="candidatevid" value="${r.candidatevid}" id="partynameid" readonly>
                    </div>
                    <div class="form-group col-md-6">        
                        <label for="emailid">Email ID</label>
                        <input type="email" class="form-control" placeholder="Email id" name="email" id="emailid" required data-toggle="popover" title="Email ID" data-content="You will receive Email Verification code at the time of registration and online Voting.So enter appropriate emailid" value='${r.email}'>
                    </div>
                </div>

                <center>
                    <div class="form-group col-md-12">        
                        <label for="OTP">Enter Email Verification Code(OTP)</label>
                        <input type="number" class="form-control col-md-2" name="OTP" id="OTPid" min="100000" max="999999"required>
                    </div>

                    <!--<div class="form-group col-md-4" hidden="true">--> 
                    <div class="form-group col-md-4" hidden > 
                        <label for="OTP">Enter OTP</label>
                        <!--<input type="number" class="form-control" name="OTPhidden" id="OTPOTPhiddenid" readonly value="99">-->
                        <input type="number" class="form-control" name="OTPhidden" id="OTPOTPhiddenid" readonly value="${r.OTPhidden}">
                    </div>
                    <br>
                    <button type="submit" class="btn btn-outline-primary">Submit</button>
                </center>
            </form>

        </div>

        <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
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
