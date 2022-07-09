<%-- 
    Document   : Login
    Created on : 10 May, 2022, 9:13:16 AM
    Author     : Admin
--%>

<%@page errorPage="ErrorPage.jsp" %>
<%@page import="VotingSystemController.Mail"%>
<%@page import="java.util.Random"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <title>Login</title>

        <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.4.5/angular.min.js" ></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

        <link href='<c:url value="/resources/css/Form_CSS.css" />' rel="stylesheet">

    </head>
    <body onload="loadpage()">
        <%@include file="Header.jsp" %>

        <div class="container" >
            <form  class="form" action="login/Votingdashboard" method="post">
                <!--<form  class="form" action="Votingdashboard" method="post">-->

                <div class="regformheading">
                    <center><u><h3>${voterloginheading}</h3></u></center>
                </div>
                <br>

                <!--<div class="form-row">-->
                     <!--<center>-->
                    <div class="alert alert-danger"  id="erroriddiv">
                    <h5  id="errorid">${error}</h5>
                    </div>
                <div class="form-row">
                    <div class="form-group col-md-12">     
                        <label for="vidid">Voter ID</label>
                        <input type="text" class="form-control" placeholder="VoterID" name="vid" id="vidid" value='${r.vid}' required>
                    </div>
                </div>

                <%! String captcha; %>
                <%!

//                    public String run() {
//                        Mail m = new Mail();
//                        captcha = m.getCaptcha();
//                        m.generateAdminPassword("YPL123", "1234", "Gujarat", "vadodara", "", "shivapatel1102001@gmail.com", "shivam patel....");
//                        m.generateAdminPassword("YPL123", "1234", "Gujarat", "vadodara", "sisva", "shivapatel1102001@gmail.com", "shivam patel....");
//                        m.generateOTP("shivapatel1102001@gmail.com", "YPL123", "registration");
//                        m.generateOTP("shivapatel1102001@gmail.com", "YPL123", "voting");
//                        return captcha;
//                    }
                 %>
                 <%
                    Mail m = new Mail();
                    captcha = m.getCaptcha();
               %>
                <div class="form-row">

                    <div class="form-group col-md-12">        
                        <label for="passwordid">Password</label>
                        <input type="password" class="form-control" placeholder="Password" name="password" id="passwordid" required>
                    </div>
                </div>

                <center>
                    <div class="form-group col-md-3">        
                        <label for="captcha">Captcha</label>
                        <input type="text" class="form-control col-md-9" name="captcha" id="captchaid" placeholder="Captcha" required>
                    </div>
                </center>
                <center>
                    <b> <input type="text" class="form-group col-md-2" value="<%= captcha %>" name="captchahidden" id="captchaid" readonly style="background-color: lightgrey; font-weight: bolder">
                        <br>
                        <button type="submit" class="btn btn-outline-primary">Login</button>
                        <br>
                        <br>
                        <div class="form-group col-md-3">        
                            <a href="/Home/Voting/changepassword">Change Password?</a>
                            <!--<a href="https://online-evoting.herokuapp.com/Home/Voting/changepassword">Change Password?</a>-->
                        </div>
                        <div class="form-group col-md-3">        
                            <a href="/Home/Voting/forgotpassword">Forgot Password?</a>
                            <!--<a href="https://online-evoting.herokuapp.com/Home/Voting/forgotpassword">Forgot Password?</a>-->
                        </div>
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
