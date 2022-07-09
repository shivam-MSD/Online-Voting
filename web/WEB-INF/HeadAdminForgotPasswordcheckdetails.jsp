<%-- 
    Document   : HeadAdminForgotPasswordcheckdetails
    Created on : 5 Jun, 2022, 4:40:21 PM
    Author     : Admin
--%>


<%--<%@page errorPage="500_ErrorPage.jsp" %>--%>
<%@page import="VotingSystemController.Mail"%>
<%@page import="java.util.Random"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <title>Admin Change Password</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

        <link href='<c:url value="/resources/css/Form_CSS.css" />' rel="stylesheet">

    </head>
    <body onload="loadpage()">
        <%@include file="Header.jsp" %>
        
        <div class="container" >
            <form  class="form" action="forgotpassword/successfullyupdated" method="post">
            <!--<form  class="form" action="successfullyupdated" method="post">-->
                <!--                <div class="regformheading">
                                    <b><center><u><h3>Admin Login</h3></u></center></b>
                                </div>-->

                <div class="regformheading">
                    <center><u><h3>${voterloginheading}</h3></u></center>
                </div>
                <br>
                <div class="alert alert-danger"  id="erroriddiv">
                    <h5  id="errorid">${error}</h5>
                </div>

                <br>

                <div class="form-row">
                    <div class="form-group col-md-12">     
                        <label for="aidid">AdminId</label>
                        <input type="text" class="form-control" placeholder="voterID" name="vid" id="vidid" required value = "${addadminmsg.aid}" readonly>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group col-md-12" >        
                        <label for="emailid">Email ID</label>
                        <input type="email" class="form-control" placeholder="Email id" name="email"value="${addadminmsg.email}" id="emailid" readonly>
                    </div>
                </div>
                    
                    <div class="form-row" hidden>
                    <div class="form-group col-md-6">        
                        <label for="passwordid">New Password</label>
                        <input type="text" class="form-control" placeholder="New Password" value="${addadminmsg.password}" name="password" id="passwordid" >
                    </div>
                    <!--</div>-->

                    <!--<div class="form-row">-->
                    <div class="form-group col-md-6">        
                        <label for="passwordid">Confirm Password</label>
                        <input type="text" class="form-control" placeholder="Confirm Password" value="${addadminmsg.password}" name="confirmpassword" id="passwordid" >
                    </div>
                </div>

                <center>
                    <div class="form-group col-md-12">        
                        <label for="OTP">Enter Email Verification Code(OTP)</label>
                        <input type="number" class="form-control col-md-2" name="OTP" id="OTPid" min="100000" max="999999"required>
                    </div>

                    <div class="form-group col-md-4" > 
                        <label for="OTP">Enter OTP</label>
                        <!--<input type="number" class="form-control" name="OTPhidden" id="OTPOTPhiddenid" readonly value="99">-->
                        <input type="number" class="form-control" name="OTPhidden" id="OTPOTPhiddenid" value="${addadminmsg.OTPhidden}" readonly >
                    </div>
                        <br>
                        <button type="submit" class="btn btn-outline-primary">Change Password</button>
                </center>
            </form>
        </div>
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
